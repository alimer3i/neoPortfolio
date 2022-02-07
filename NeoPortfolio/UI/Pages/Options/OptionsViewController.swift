//
//  OptionsViewController.swift
//  NeoPortfolio
//
//  Created by Ali Merhie on 2/5/22.
//

import UIKit

class OptionsViewController: BaseViewController<OptionsVM> {
    
    override class var pageStoryBoard: AppStoryboard {
        get { return .Options }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet private weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    let cellIdentifier = "OptionCollectionViewCell"
    private var indexOfCellBeforeDragging = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        title = "Goal Status"
        tittleLabel.text = "Our Recommendations"
        descLabel.text = "In order for you to get back on trackand achieve your goal, we recommend following one of these options. Select an option to see it's impact on your financial path on the chart."
        continueButton.setTitle("Continue", for: .normal)
        viewModel.pageDidLoad()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureCollectionViewLayoutItemSize()
    }
    

    override func bindToViewModel() {
        super.bindToViewModel()
        
        // Setup for reloadTableViewClosure
        viewModel.reloadCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.isOptionSelected.bind { [weak self] isSelected in
            if let strongSelf = self {
                strongSelf.continueButton.isEnabled = isSelected
                strongSelf.continueButton.backgroundColor = isSelected ? .primaryBlue : .gray
                strongSelf.continueButton.setTitleColor(isSelected ? .white : .black, for: .normal)
            }
        }
        viewModel.numberOfPages.bind {[weak self] number in
            if let strongSelf = self {
                strongSelf.pageControl.numberOfPages = number
            }
        }
        viewModel.navigateToEducation = {[weak self] portfolio in
            if let strongSelf = self {
               let vc = EducationViewController.pushVC(mainView: strongSelf)
                vc.viewModel.selectedPortfolio = portfolio
            }
        }
    }
    @IBAction func continueClicked(_ sender: Any) {
        viewModel.continueClicked()
    }
    
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = false
        collectionViewLayout.minimumLineSpacing = 0

        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func calculateSectionInset() -> CGFloat {
        let deviceIsIpad = UIDevice.current.userInterfaceIdiom == .pad
        let deviceOrientationIsLandscape = UIDevice.current.orientation.isLandscape
        let cellBodyViewIsExpended = deviceIsIpad || deviceOrientationIsLandscape
        let cellBodyWidth: CGFloat = 236 + (cellBodyViewIsExpended ? 174 : 0)
        
        let buttonWidth: CGFloat = 50
        
        let inset = (collectionViewLayout.collectionView!.frame.width - cellBodyWidth + buttonWidth) / 4
        return inset
    }
    
    private func configureCollectionViewLayoutItemSize() {
        let inset: CGFloat = calculateSectionInset() // This inset calculation is some magic so the next and the previous cells will peek from the sides. Don't worry about it
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        collectionViewLayout.itemSize = CGSize(width: collectionView!.frame.size.width - inset * 2, height: collectionView!.frame.size.height)
//        collectionViewLayout.prepare()
//        collectionViewLayout.invalidateLayout()
    }
    
    private func indexOfMajorCell() -> Int {
        let itemWidth = collectionViewLayout.itemSize.width
        let proportionalOffset = collectionViewLayout.collectionView!.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(viewModel.numberOfItems - 1, index))
        return safeIndex
    }
    private var collectionViewCurrentPage: Int {
        let pageWidth =  collectionView.frame.width
        var currentPage = Float(collectionView.contentOffset.x / pageWidth)
        let itemsCount = viewModel.numberOfItems
        
        if fmodf(currentPage, 1) != 0 {
            currentPage = currentPage + 1
        }
        
        if itemsCount > 0 && Int(currentPage) >= itemsCount {
            return itemsCount - 1
        }
        return Int(currentPage)
    }
}

extension OptionsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! OptionCollectionViewCell
        
        viewModel.configure(cell: cell, at: indexPath)
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension OptionsViewController: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let pageNumber = indexOfMajorCell()
        indexOfCellBeforeDragging = pageNumber
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = collectionViewCurrentPage
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = collectionViewCurrentPage
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Stop scrollView sliding:
        targetContentOffset.pointee = scrollView.contentOffset
        
        // calculate where scrollView should snap to:
        let indexOfMajorCell = self.indexOfMajorCell()
        
        // calculate conditions:
        let swipeVelocityThreshold: CGFloat = 0.5 // after some trail and error
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < viewModel.numberOfItems && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        
        if didUseSwipeToSkipCell {
            
            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = collectionViewLayout.itemSize.width * CGFloat(snapToIndex)
            
            // Damping equal 1 => no oscillations => decay animation:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            // This is a much better way to scroll to a cell:
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
//extension OptionsViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        return collectionView.bounds.size
//        return CGSize(width: (0.8 * collectionView.bounds.size.width), height:  collectionView.bounds.size.height)
//    }
//
//}
