# -*- coding: utf-8 -*-
class ListViewController < UITableViewController
  ONCE_READ_COUNT = 20

  def viewDidLoad
    super

    self.navigationItem.title = "平家物語"
    @contents = NSArray.alloc.init
    @contents = self.createContents
    @total = @contents.count
    @page = 1

    # インディケーター
    @indicator = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleWhiteLarge)
    @indicator.color = UIColor.darkGrayColor
    @indicator.hidesWhenStopped = true
    @indicator.stopAnimating
  end

  def didReceiveMemoryWarning
    super.didReceiveMemoryWarning
  end

  def createContents
    data = NSMutableArray.array

    i = 0
    while i < 20
      data.addObject("祗園精舎の鐘の声、")
      data.addObject("諸行無常の響きあり。")
      data.addObject("娑羅双樹の花の色、")
      data.addObject("盛者必衰の理をあらは（わ）す。")
      data.addObject("おごれる人も久しからず、")
      data.addObject("唯春の夜の夢のごとし。")
      data.addObject("たけき者も遂にはほろびぬ、")
      data.addObject("偏に風の前の塵に同じ。")
      i += 1
    end
    return data.copy
  end

  # 表示セルの一番下まできたら次のONCE_READ_COUNT件数取得
  def scrollViewDidScroll(scrollView)
    if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height))
      if @indicator.isAnimating
        return
      end
      if @total > (@page*ONCE_READ_COUNT)
        self.startIndicator
        self.performSelector("reloadMoreData", withObject:nil, afterDelay:0.1)
      end
    end
  end

  def reloadMoreData
    @page += 1
    self.tableView.reloadData
    self.endIndicator
  end

  def startIndicator
    @indicator.startAnimating
    # footerFrame = self.tableView.tableFooterView.frame
    # footerFrame.size.height += 10.0

    @indicator.frame.size.height += 10.0
    self.tableView.setTableFooterView(@indicator)
  end

  def endIndicator
    @indicator.stopAnimating
    @indicator.removeFromSuperview
    # self.tableView.tableFooterView(nil)
  end

  def numberOfSectionsInTableView(tableView)
    # Return the number of sections.
    return 1
  end
  def tableView(tableView, numberOfRowsInSection:section)
    # Return the number of rows in the section.
    return @page*ONCE_READ_COUNT
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier('cell') || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:'cell')
    # Configure the cell...
    cell.textLabel.text = @contents.objectAtIndex(indexPath.row)
    return cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    # Navigation logic may go here. Create and push another view controller.
     # Pass the selected object to the new view controller.
    self.tableView.deselectRowAtIndexPath(indexPath, animated=true)
  end
end
