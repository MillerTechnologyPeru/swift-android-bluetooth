
/// generated by: genswift.java 'java/lang|java/util|java/sql' 'Sources' '../java' ///

/// interface com.johnholdsworth.swiftbindings.SwiftBluetoothScannerBinding$Listener ///

package org.swiftjava.com_johnholdsworth;

@SuppressWarnings("JniMissingFunction")
public class SwiftBluetoothScannerBinding_ListenerProxy implements com.johnholdsworth.swiftbindings.SwiftBluetoothScannerBinding.Listener {

    // address of proxy object
    long __swiftObject;

    SwiftBluetoothScannerBinding_ListenerProxy( long __swiftObject ) {
        this.__swiftObject = __swiftObject;
    }

    /// public abstract void com.johnholdsworth.swiftbindings.SwiftActivityBinding$Listener.viewDidLoad()

    public native void __viewDidLoad( long __swiftObject );

    public void viewDidLoad() {
        __viewDidLoad( __swiftObject  );
    }

    public native void __finalize( long __swiftObject );

    public void finalize() {
        __finalize( __swiftObject );
    }

}