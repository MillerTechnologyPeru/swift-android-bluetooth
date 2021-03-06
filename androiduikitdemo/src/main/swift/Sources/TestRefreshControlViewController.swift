//
//  TestRefreshControlViewController.swift
//  androiduikittarget
//
//  Created by Marco Estrella on 9/14/18.
//

import Foundation


#if os(iOS)
import UIKit
#else
import Android
import AndroidUIKit
#endif

final class TestRefreshControlViewController: UITableViewController {
    
    private let cellReuseIdentifier = "Cell"
    
    var data: [Data] = [
        Data(type: "type 1", array: ["item 1","item 2","item 3","item 4","item 5"]),
        Data(type: "type 2", array: ["item 1","item 2","item 3","item 4","item 5","item 5","item 5","item 5","item 5"]),
        Data(type: "type 3", array: ["item 1","item 2","item 5","item 5","item 5","item 5","item 5","item 5"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set title
        self.title = "Test UIRefreshControl"
        
        // setup table view
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
        
        let refreshControl = UIRefreshControl()
        
        let actionRefresh: () -> () = {
            
            #if os(Android) || os(macOS)
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "I'm refreshing, :)", duration: AndroidToast.Dutation.short).show()
            #endif
            
            let delay = DispatchTime.now() + .seconds(3)
            
            DispatchQueue.global(qos: .background).asyncAfter(deadline: delay) {
                #if os(Android)
                UIApplication.shared.androidActivity.runOnMainThread { [weak self] in
                    
                    refreshControl.endRefreshing()
                }
                #endif
            }
        }
        
        #if os(Android) || os(macOS)
        refreshControl.addTarget(action: actionRefresh, for: UIControlEvents.touchDown)
        #endif
        
        self.refreshControl = refreshControl
        
        /*let delay = DispatchTime.now() + .seconds(10)
        DispatchQueue.global(qos: .background).asyncAfter(deadline: delay) {
            
            UIApplication.shared.androidActivity.runOnMainThread { [weak self] in
                
                self?.refreshControl = nil
            }
        }*/
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        #if os(Android) || os(macOS)
        let peripheralViewLayoutId = UIApplication.shared.androidActivity.getIdentifier(name: "list_header", type: "layout")
        
        let layoutInflarer = Android.View.LayoutInflater.from(context: UIApplication.shared.androidActivity)
        
        let itemView = layoutInflarer.inflate(resource: Android.R.Layout(rawValue: peripheralViewLayoutId), root: nil, attachToRoot: false)
        
        let tvHeaderId = UIApplication.shared.androidActivity.getIdentifier(name: "tvHeader", type: "id")
        
        guard let tvHeaderObject = itemView.findViewById(tvHeaderId)
            else { fatalError("No view for \(tvHeaderId)") }
        
        let tvHeader = Android.Widget.TextView(casting: tvHeaderObject)
        
        tvHeader?.text = data[section].type
        
        let uiView = UIView.init(androidViewChild: itemView)
        
        uiView.androidView.layoutParams = Android.Widget.FrameLayout.FLayoutParams(width: Android.Widget.FrameLayout.FLayoutParams.MATCH_PARENT, height: Android.Widget.FrameLayout.FLayoutParams.WRAP_CONTENT)
        
        return uiView
        #else
        return nil
        #endif
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data[section].array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        #if os(Android) || os(macOS)
        let layoutName = "list_item"
        
        if cell.layoutName != layoutName {
            cell.inflateAndroidLayout(layoutName)
        }
        
        let itemView = cell.androidView
        
        let tvItemId = UIApplication.shared.androidActivity.getIdentifier(name: "tvItem", type: "id")
        
        guard let tvItemObject = itemView.findViewById(tvItemId)
            else { fatalError("No view for \(tvItemId)") }
        
        let tvItem = Android.Widget.TextView(casting: tvItemObject)
        
        let item = data[indexPath.section].array[indexPath.row]
        
        tvItem?.text = item
        #endif
        
        return cell
    }
    
    
}

struct Data {
    
    let type: String
    let array: [String]
}
