//
//  PagedHorizontalView.swift
//  PagedHorizontalView
//
//  Created by mohamede1945 on 6/20/15.
//  Copyright (c) 2015 Varaw. All rights reserved.
//

import UIKit

/**
Represents a horizontal scoller view that makes its collection view cells full screen
and can optionally wire UIPageControl and a previous and next UIButtons.

It doesn't affect the appearance of the controls and doesn't implement the collection view data source
to keep full flexibility while doing the repeated work for a horizontal scroller.

@author mohamede1945

@version 1.0
*/
public class PagedHorizontalView: UIView {

    /// Represents the page control property.
    @IBOutlet public weak var pageControl: UIPageControl? {
        didSet {
            pageControl?.addTarget(self, action: "pageChanged:", forControlEvents: .ValueChanged)
        }
    }

    /// Represents the next button property.
    @IBOutlet public weak var nextButton: UIButton? {
        didSet {
            nextButton?.addTarget(self, action: "goToNextPage:", forControlEvents: .TouchUpInside)
        }
    }

    /// Represents the previous button property.
    @IBOutlet public weak var previousButton: UIButton? {
        didSet {
            previousButton?.addTarget(self, action: "goToPreviousPage:", forControlEvents: .TouchUpInside)
        }
    }

    /// Represents the collection view property.
    @IBOutlet public weak var collectionView: UICollectionView! {
        didSet {
            assert(collectionView.collectionViewLayout is UICollectionViewFlowLayout,
                "collectionViewLayout should be of type 'UICollectionViewFlowLayout'")
            let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            flowLayout.scrollDirection = .Horizontal
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0

            collectionView.pagingEnabled = true
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.delegate = self
        }
    }

    /// whether or not dragging has ended
    private var endDragging = false

    /// the current page
    public dynamic var currentIndex: Int = 0 {
        didSet {
            updateAccessoryViews()
        }
    }

    /**
    Currnet page changed.

    :param: sender the page control of the action.
    */
    @IBAction public func pageChanged(sender: UIPageControl) {
        moveToPage(sender.currentPage, animated: true)
    }

    /**
    Go to next page.

    :param: sender The sender of the action parameter.
    */
    @IBAction public func goToNextPage(sender: AnyObject) {
        moveToPage(currentIndex + 1, animated: true)
    }

    /**
    Go to previous page.

    :param: sender The sender of the action parameter.
    */
    @IBAction public func goToPreviousPage(sender: AnyObject) {
        moveToPage(currentIndex - 1, animated: true)
    }

    /**
    Move to a specific page.

    :param: page     The page parameter.
    :param: animated The animated parameter to control whether the transition should be animated or not.
    */
    public func moveToPage(page: Int, animated: Bool) {
        // outside the range
        if page < 0 || page >= collectionView.numberOfItemsInSection(0) {
            return
        }

        currentIndex = page
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: currentIndex, inSection: 0),
            atScrollPosition: .Left, animated: animated)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        collectionView.performBatchUpdates(nil, completion: nil)
        moveToPage(currentIndex, animated: false)
    }

    /**
    Update accessory views (i.e. UIPageControl, UIButtons).
    */
    func updateAccessoryViews() {
        pageControl?.numberOfPages = collectionView.numberOfItemsInSection(0)
        pageControl?.currentPage = currentIndex
        nextButton?.enabled = currentIndex < collectionView.numberOfItemsInSection(0) - 1
        previousButton?.enabled = currentIndex > 0
    }
}


extension PagedHorizontalView : UICollectionViewDelegateFlowLayout {

    /**
    size of the collection view

    :param: collectionView the collection view
    :param: collectionViewLayout the collection view flow layout
    :param: indexPath the index path
    */
    public func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return collectionView.bounds.size
    }

    /**
    scroll view did end dragging

    :param: scrollView the scroll view
    :param: decelerate wether the view is decelerating or not.
    */
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            endScrolling(scrollView)
        } else {
            endDragging = true
        }
    }

    /**
    Scroll view did end decelerating
    */
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if endDragging {
            endDragging = false
            endScrolling(scrollView)
        }
    }

    /**
    end scrolling
    */
    private func endScrolling(scrollView: UIScrollView) {
        let width = scrollView.bounds.width
        let page = (scrollView.contentOffset.x + (0.5 * width)) / width
        currentIndex = Int(page)
    }
}