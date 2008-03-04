From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] doc/power: move power-related files to
	Documentation/power/
Date: Tue, 4 Mar 2008 13:48:37 -0800
Message-ID: <20080304134837.dcfed6dd.randy.dunlap__5829.34547351233$1204667556$gmane$org@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, cbou@mail.ru, dwmw2@infradead.org, len.brown@intel.com
List-Id: linux-pm@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Move power-related files to Documentation/power/.

Move 00-INDEX entries to power/00-INDEX (and add entry for
pm_qos_interface.txt).

Update references to moved filenames.

Fix some trailing whitespace.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/00-INDEX                     |    4 =

 Documentation/kernel-parameters.txt        |    2 =

 Documentation/pm.txt                       |  257 -------------------
 Documentation/pm_qos_interface.txt         |   59 ----
 Documentation/power/00-INDEX               |    6 =

 Documentation/power/pm.txt                 |  257 +++++++++++++++++++
 Documentation/power/pm_qos_interface.txt   |   59 ++++
 Documentation/power/power_supply_class.txt |  169 ++++++++++++
 Documentation/power_supply_class.txt       |  169 ------------
 arch/x86/Kconfig                           |    2 =

 kernel/power/Kconfig                       |    2 =

 11 files changed, 494 insertions(+), 492 deletions(-)

--- linux-2.6.25-rc3-git6.orig/Documentation/00-INDEX
+++ linux-2.6.25-rc3-git6/Documentation/00-INDEX
@@ -303,12 +303,8 @@ pcmcia/
 	- info on the Linux PCMCIA driver.
 pi-futex.txt
 	- documentation on lightweight PI-futexes.
-pm.txt
-	- info on Linux power management support.
 pnp.txt
 	- Linux Plug and Play documentation.
-power_supply_class.txt
-	- Tells userspace about battery, UPS, AC or DC power supply properties
 power/
 	- directory with info on Linux PCI power management.
 powerpc/
--- linux-2.6.25-rc3-git6.orig/Documentation/power/00-INDEX
+++ linux-2.6.25-rc3-git6/Documentation/power/00-INDEX
@@ -14,6 +14,12 @@ notifiers.txt
 	- Registering suspend notifiers in device drivers
 pci.txt
 	- How the PCI Subsystem Does Power Management
+pm.txt
+	- info on Linux power management support.
+pm_qos_interface.txt
+	- info on Linux PM Quality of Service interface
+power_supply_class.txt
+	- Tells userspace about battery, UPS, AC or DC power supply properties
 s2ram.txt
 	- How to get suspend to ram working (and debug it when it isn't)
 states.txt
--- linux-2.6.25-rc3-git6.orig/Documentation/pm.txt
+++ /dev/null
@@ -1,257 +0,0 @@
-               Linux Power Management Support
-
-This document briefly describes how to use power management with your
-Linux system and how to add power management support to Linux drivers.
-
-APM or ACPI?
-------------
-If you have a relatively recent x86 mobile, desktop, or server system,
-odds are it supports either Advanced Power Management (APM) or
-Advanced Configuration and Power Interface (ACPI).  ACPI is the newer
-of the two technologies and puts power management in the hands of the
-operating system, allowing for more intelligent power management than
-is possible with BIOS controlled APM.
-
-The best way to determine which, if either, your system supports is to
-build a kernel with both ACPI and APM enabled (as of 2.3.x ACPI is
-enabled by default).  If a working ACPI implementation is found, the
-ACPI driver will override and disable APM, otherwise the APM driver
-will be used.
-
-No, sorry, you cannot have both ACPI and APM enabled and running at
-once.  Some people with broken ACPI or broken APM implementations
-would like to use both to get a full set of working features, but you
-simply cannot mix and match the two.  Only one power management
-interface can be in control of the machine at once.  Think about it..
-
-User-space Daemons
-------------------
-Both APM and ACPI rely on user-space daemons, apmd and acpid
-respectively, to be completely functional.  Obtain both of these
-daemons from your Linux distribution or from the Internet (see below)
-and be sure that they are started sometime in the system boot process.
-Go ahead and start both.  If ACPI or APM is not available on your
-system the associated daemon will exit gracefully.
-
-  apmd:   http://worldvisions.ca/~apenwarr/apmd/
-  acpid:  http://acpid.sf.net/
-
-Driver Interface -- OBSOLETE, DO NOT USE!
-----------------*************************
-
-Note: pm_register(), pm_access(), pm_dev_idle() and friends are
-obsolete. Please do not use them. Instead you should properly hook
-your driver into the driver model, and use its suspend()/resume()
-callbacks to do this kind of stuff.
-
-If you are writing a new driver or maintaining an old driver, it
-should include power management support.  Without power management
-support, a single driver may prevent a system with power management
-capabilities from ever being able to suspend (safely).
-
-Overview:
-1) Register each instance of a device with "pm_register"
-2) Call "pm_access" before accessing the hardware.
-   (this will ensure that the hardware is awake and ready)
-3) Your "pm_callback" is called before going into a
-   suspend state (ACPI D1-D3) or after resuming (ACPI D0)
-   from a suspend.
-4) Call "pm_dev_idle" when the device is not being used
-   (optional but will improve device idle detection)
-5) When unloaded, unregister the device with "pm_unregister"
-
-/*
- * Description: Register a device with the power-management subsystem
- *
- * Parameters:
- *   type - device type (PCI device, system device, ...)
- *   id - instance number or unique identifier
- *   cback - request handler callback (suspend, resume, ...)
- *
- * Returns: Registered PM device or NULL on error
- *
- * Examples:
- *   dev =3D pm_register(PM_SYS_DEV, PM_SYS_VGA, vga_callback);
- *
- *   struct pci_dev *pci_dev =3D pci_find_dev(...);
- *   dev =3D pm_register(PM_PCI_DEV, PM_PCI_ID(pci_dev), callback);
- */
-struct pm_dev *pm_register(pm_dev_t type, unsigned long id, pm_callback cb=
ack);
-
-/*
- * Description: Unregister a device with the power management subsystem
- *
- * Parameters:
- *   dev - PM device previously returned from pm_register
- */
-void pm_unregister(struct pm_dev *dev);
-
-/*
- * Description: Unregister all devices with a matching callback function
- *
- * Parameters:
- *   cback - previously registered request callback
- *
- * Notes: Provided for easier porting from old APM interface
- */
-void pm_unregister_all(pm_callback cback);
-
-/*
- * Power management request callback
- *
- * Parameters:
- *   dev - PM device previously returned from pm_register
- *   rqst - request type
- *   data - data, if any, associated with the request
- *
- * Returns: 0 if the request is successful
- *          EINVAL if the request is not supported
- *          EBUSY if the device is now busy and cannot handle the request
- *          ENOMEM if the device was unable to handle the request due to m=
emory
- *          =

- * Details: The device request callback will be called before the
- *          device/system enters a suspend state (ACPI D1-D3) or
- *          or after the device/system resumes from suspend (ACPI D0).
- *          For PM_SUSPEND, the ACPI D-state being entered is passed
- *          as the "data" argument to the callback.  The device
- *          driver should save (PM_SUSPEND) or restore (PM_RESUME)
- *          device context when the request callback is called.
- *
- *          Once a driver returns 0 (success) from a suspend
- *          request, it should not process any further requests or
- *          access the device hardware until a call to "pm_access" is made.
- */
-typedef int (*pm_callback)(struct pm_dev *dev, pm_request_t rqst, void *da=
ta);
-
-Driver Details
---------------
-This is just a quick Q&A as a stopgap until a real driver writers'
-power management guide is available.
-
-Q: When is a device suspended?
-
-Devices can be suspended based on direct user request (eg. laptop lid
-closes), system power policy (eg.  sleep after 30 minutes of console
-inactivity), or device power policy (eg. power down device after 5
-minutes of inactivity)
-
-Q: Must a driver honor a suspend request?
-
-No, a driver can return -EBUSY from a suspend request and this
-will stop the system from suspending.  When a suspend request
-fails, all suspended devices are resumed and the system continues
-to run.  Suspend can be retried at a later time.
-
-Q: Can the driver block suspend/resume requests?
-
-Yes, a driver can delay its return from a suspend or resume
-request until the device is ready to handle requests.  It
-is advantageous to return as quickly as possible from a
-request as suspend/resume are done serially.
-
-Q: What context is a suspend/resume initiated from?
-
-A suspend or resume is initiated from a kernel thread context.
-It is safe to block, allocate memory, initiate requests
-or anything else you can do within the kernel.
-
-Q: Will requests continue to arrive after a suspend?
-
-Possibly.  It is the driver's responsibility to queue(*),
-fail, or drop any requests that arrive after returning
-success to a suspend request.  It is important that the
-driver not access its device until after it receives
-a resume request as the device's bus may no longer
-be active.
-
-(*) If a driver queues requests for processing after
-    resume be aware that the device, network, etc.
-    might be in a different state than at suspend time.
-    It's probably better to drop requests unless
-    the driver is a storage device.
-
-Q: Do I have to manage bus-specific power management registers
-
-No.  It is the responsibility of the bus driver to manage
-PCI, USB, etc. power management registers.  The bus driver
-or the power management subsystem will also enable any
-wake-on functionality that the device has.
-
-Q: So, really, what do I need to do to support suspend/resume?
-
-You need to save any device context that would
-be lost if the device was powered off and then restore
-it at resume time.  When ACPI is active, there are
-three levels of device suspend states; D1, D2, and D3.
-(The suspend state is passed as the "data" argument
-to the device callback.)  With D3, the device is powered
-off and loses all context, D1 and D2 are shallower power
-states and require less device context to be saved.  To
-play it safe, just save everything at suspend and restore
-everything at resume.
-
-Q: Where do I store device context for suspend?
-
-Anywhere in memory, kmalloc a buffer or store it
-in the device descriptor.  You are guaranteed that the
-contents of memory will be restored and accessible
-before resume, even when the system suspends to disk.
-
-Q: What do I need to do for ACPI vs. APM vs. etc?
-
-Drivers need not be aware of the specific power management
-technology that is active.  They just need to be aware
-of when the overlying power management system requests
-that they suspend or resume.
-
-Q: What about device dependencies?
-
-When a driver registers a device, the power management
-subsystem uses the information provided to build a
-tree of device dependencies (eg. USB device X is on
-USB controller Y which is on PCI bus Z)  When power
-management wants to suspend a device, it first sends
-a suspend request to its driver, then the bus driver,
-and so on up to the system bus.  Device resumes
-proceed in the opposite direction.
-
-Q: Who do I contact for additional information about
-   enabling power management for my specific driver/device?
-
-ACPI Development mailing list: linux-acpi@vger.kernel.org
-
-System Interface -- OBSOLETE, DO NOT USE!
-----------------*************************
-If you are providing new power management support to Linux (ie.
-adding support for something like APM or ACPI), you should
-communicate with drivers through the existing generic power
-management interface.
-
-/*
- * Send a request to all devices
- *
- * Parameters:
- *   rqst - request type
- *   data - data, if any, associated with the request
- *
- * Returns: 0 if the request is successful
- *          See "pm_callback" return for errors
- *
- * Details: Walk list of registered devices and call pm_send
- *          for each until complete or an error is encountered.
- *          If an error is encountered for a suspend request,
- *          return all devices to the state they were in before
- *          the suspend request.
- */
-int pm_send_all(pm_request_t rqst, void *data);
-
-/*
- * Find a matching device
- *
- * Parameters:
- *   type - device type (PCI device, system device, or 0 to match all devi=
ces)
- *   from - previous match or NULL to start from the beginning
- *
- * Returns: Matching device or NULL if none found
- */
-struct pm_dev *pm_find(pm_dev_t type, struct pm_dev *from);
--- /dev/null
+++ linux-2.6.25-rc3-git6/Documentation/power/pm.txt
@@ -0,0 +1,257 @@
+               Linux Power Management Support
+
+This document briefly describes how to use power management with your
+Linux system and how to add power management support to Linux drivers.
+
+APM or ACPI?
+------------
+If you have a relatively recent x86 mobile, desktop, or server system,
+odds are it supports either Advanced Power Management (APM) or
+Advanced Configuration and Power Interface (ACPI).  ACPI is the newer
+of the two technologies and puts power management in the hands of the
+operating system, allowing for more intelligent power management than
+is possible with BIOS controlled APM.
+
+The best way to determine which, if either, your system supports is to
+build a kernel with both ACPI and APM enabled (as of 2.3.x ACPI is
+enabled by default).  If a working ACPI implementation is found, the
+ACPI driver will override and disable APM, otherwise the APM driver
+will be used.
+
+No, sorry, you cannot have both ACPI and APM enabled and running at
+once.  Some people with broken ACPI or broken APM implementations
+would like to use both to get a full set of working features, but you
+simply cannot mix and match the two.  Only one power management
+interface can be in control of the machine at once.  Think about it..
+
+User-space Daemons
+------------------
+Both APM and ACPI rely on user-space daemons, apmd and acpid
+respectively, to be completely functional.  Obtain both of these
+daemons from your Linux distribution or from the Internet (see below)
+and be sure that they are started sometime in the system boot process.
+Go ahead and start both.  If ACPI or APM is not available on your
+system the associated daemon will exit gracefully.
+
+  apmd:   http://worldvisions.ca/~apenwarr/apmd/
+  acpid:  http://acpid.sf.net/
+
+Driver Interface -- OBSOLETE, DO NOT USE!
+----------------*************************
+
+Note: pm_register(), pm_access(), pm_dev_idle() and friends are
+obsolete. Please do not use them. Instead you should properly hook
+your driver into the driver model, and use its suspend()/resume()
+callbacks to do this kind of stuff.
+
+If you are writing a new driver or maintaining an old driver, it
+should include power management support.  Without power management
+support, a single driver may prevent a system with power management
+capabilities from ever being able to suspend (safely).
+
+Overview:
+1) Register each instance of a device with "pm_register"
+2) Call "pm_access" before accessing the hardware.
+   (this will ensure that the hardware is awake and ready)
+3) Your "pm_callback" is called before going into a
+   suspend state (ACPI D1-D3) or after resuming (ACPI D0)
+   from a suspend.
+4) Call "pm_dev_idle" when the device is not being used
+   (optional but will improve device idle detection)
+5) When unloaded, unregister the device with "pm_unregister"
+
+/*
+ * Description: Register a device with the power-management subsystem
+ *
+ * Parameters:
+ *   type - device type (PCI device, system device, ...)
+ *   id - instance number or unique identifier
+ *   cback - request handler callback (suspend, resume, ...)
+ *
+ * Returns: Registered PM device or NULL on error
+ *
+ * Examples:
+ *   dev =3D pm_register(PM_SYS_DEV, PM_SYS_VGA, vga_callback);
+ *
+ *   struct pci_dev *pci_dev =3D pci_find_dev(...);
+ *   dev =3D pm_register(PM_PCI_DEV, PM_PCI_ID(pci_dev), callback);
+ */
+struct pm_dev *pm_register(pm_dev_t type, unsigned long id, pm_callback cb=
ack);
+
+/*
+ * Description: Unregister a device with the power management subsystem
+ *
+ * Parameters:
+ *   dev - PM device previously returned from pm_register
+ */
+void pm_unregister(struct pm_dev *dev);
+
+/*
+ * Description: Unregister all devices with a matching callback function
+ *
+ * Parameters:
+ *   cback - previously registered request callback
+ *
+ * Notes: Provided for easier porting from old APM interface
+ */
+void pm_unregister_all(pm_callback cback);
+
+/*
+ * Power management request callback
+ *
+ * Parameters:
+ *   dev - PM device previously returned from pm_register
+ *   rqst - request type
+ *   data - data, if any, associated with the request
+ *
+ * Returns: 0 if the request is successful
+ *          EINVAL if the request is not supported
+ *          EBUSY if the device is now busy and cannot handle the request
+ *          ENOMEM if the device was unable to handle the request due to m=
emory
+ *
+ * Details: The device request callback will be called before the
+ *          device/system enters a suspend state (ACPI D1-D3) or
+ *          or after the device/system resumes from suspend (ACPI D0).
+ *          For PM_SUSPEND, the ACPI D-state being entered is passed
+ *          as the "data" argument to the callback.  The device
+ *          driver should save (PM_SUSPEND) or restore (PM_RESUME)
+ *          device context when the request callback is called.
+ *
+ *          Once a driver returns 0 (success) from a suspend
+ *          request, it should not process any further requests or
+ *          access the device hardware until a call to "pm_access" is made.
+ */
+typedef int (*pm_callback)(struct pm_dev *dev, pm_request_t rqst, void *da=
ta);
+
+Driver Details
+--------------
+This is just a quick Q&A as a stopgap until a real driver writers'
+power management guide is available.
+
+Q: When is a device suspended?
+
+Devices can be suspended based on direct user request (eg. laptop lid
+closes), system power policy (eg.  sleep after 30 minutes of console
+inactivity), or device power policy (eg. power down device after 5
+minutes of inactivity)
+
+Q: Must a driver honor a suspend request?
+
+No, a driver can return -EBUSY from a suspend request and this
+will stop the system from suspending.  When a suspend request
+fails, all suspended devices are resumed and the system continues
+to run.  Suspend can be retried at a later time.
+
+Q: Can the driver block suspend/resume requests?
+
+Yes, a driver can delay its return from a suspend or resume
+request until the device is ready to handle requests.  It
+is advantageous to return as quickly as possible from a
+request as suspend/resume are done serially.
+
+Q: What context is a suspend/resume initiated from?
+
+A suspend or resume is initiated from a kernel thread context.
+It is safe to block, allocate memory, initiate requests
+or anything else you can do within the kernel.
+
+Q: Will requests continue to arrive after a suspend?
+
+Possibly.  It is the driver's responsibility to queue(*),
+fail, or drop any requests that arrive after returning
+success to a suspend request.  It is important that the
+driver not access its device until after it receives
+a resume request as the device's bus may no longer
+be active.
+
+(*) If a driver queues requests for processing after
+    resume be aware that the device, network, etc.
+    might be in a different state than at suspend time.
+    It's probably better to drop requests unless
+    the driver is a storage device.
+
+Q: Do I have to manage bus-specific power management registers
+
+No.  It is the responsibility of the bus driver to manage
+PCI, USB, etc. power management registers.  The bus driver
+or the power management subsystem will also enable any
+wake-on functionality that the device has.
+
+Q: So, really, what do I need to do to support suspend/resume?
+
+You need to save any device context that would
+be lost if the device was powered off and then restore
+it at resume time.  When ACPI is active, there are
+three levels of device suspend states; D1, D2, and D3.
+(The suspend state is passed as the "data" argument
+to the device callback.)  With D3, the device is powered
+off and loses all context, D1 and D2 are shallower power
+states and require less device context to be saved.  To
+play it safe, just save everything at suspend and restore
+everything at resume.
+
+Q: Where do I store device context for suspend?
+
+Anywhere in memory, kmalloc a buffer or store it
+in the device descriptor.  You are guaranteed that the
+contents of memory will be restored and accessible
+before resume, even when the system suspends to disk.
+
+Q: What do I need to do for ACPI vs. APM vs. etc?
+
+Drivers need not be aware of the specific power management
+technology that is active.  They just need to be aware
+of when the overlying power management system requests
+that they suspend or resume.
+
+Q: What about device dependencies?
+
+When a driver registers a device, the power management
+subsystem uses the information provided to build a
+tree of device dependencies (eg. USB device X is on
+USB controller Y which is on PCI bus Z)  When power
+management wants to suspend a device, it first sends
+a suspend request to its driver, then the bus driver,
+and so on up to the system bus.  Device resumes
+proceed in the opposite direction.
+
+Q: Who do I contact for additional information about
+   enabling power management for my specific driver/device?
+
+ACPI Development mailing list: linux-acpi@vger.kernel.org
+
+System Interface -- OBSOLETE, DO NOT USE!
+----------------*************************
+If you are providing new power management support to Linux (ie.
+adding support for something like APM or ACPI), you should
+communicate with drivers through the existing generic power
+management interface.
+
+/*
+ * Send a request to all devices
+ *
+ * Parameters:
+ *   rqst - request type
+ *   data - data, if any, associated with the request
+ *
+ * Returns: 0 if the request is successful
+ *          See "pm_callback" return for errors
+ *
+ * Details: Walk list of registered devices and call pm_send
+ *          for each until complete or an error is encountered.
+ *          If an error is encountered for a suspend request,
+ *          return all devices to the state they were in before
+ *          the suspend request.
+ */
+int pm_send_all(pm_request_t rqst, void *data);
+
+/*
+ * Find a matching device
+ *
+ * Parameters:
+ *   type - device type (PCI device, system device, or 0 to match all devi=
ces)
+ *   from - previous match or NULL to start from the beginning
+ *
+ * Returns: Matching device or NULL if none found
+ */
+struct pm_dev *pm_find(pm_dev_t type, struct pm_dev *from);
--- linux-2.6.25-rc3-git6.orig/Documentation/pm_qos_interface.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-PM quality of Service interface.
-
-This interface provides a kernel and user mode interface for registering
-performance expectations by drivers, subsystems and user space application=
s on
-one of the parameters.
-
-Currently we have {cpu_dma_latency, network_latency, network_throughput} a=
s the
-initial set of pm_qos parameters.
-
-The infrastructure exposes multiple misc device nodes one per implemented
-parameter.  The set of parameters implement is defined by pm_qos_power_ini=
t()
-and pm_qos_params.h.  This is done because having the available parameters
-being runtime configurable or changeable from a driver was seen as too eas=
y to
-abuse.
-
-For each parameter a list of performance requirements is maintained along =
with
-an aggregated target value.  The aggregated target value is updated with
-changes to the requirement list or elements of the list.  Typically the
-aggregated target value is simply the max or min of the requirement values=
 held
-in the parameter list elements.
-
-From kernel mode the use of this interface is simple:
-pm_qos_add_requirement(param_id, name, target_value):
-Will insert a named element in the list for that identified PM_QOS paramet=
er
-with the target value.  Upon change to this list the new target is recompu=
ted
-and any registered notifiers are called only if the target value is now
-different.
-
-pm_qos_update_requirement(param_id, name, new_target_value):
-Will search the list identified by the param_id for the named list element=
 and
-then update its target value, calling the notification tree if the aggrega=
ted
-target is changed.  with that name is already registered.
-
-pm_qos_remove_requirement(param_id, name):
-Will search the identified list for the named element and remove it, after
-removal it will update the aggregate target and call the notification tree=
 if
-the target was changed as a result of removing the named requirement.
-
-
-From user mode:
-Only processes can register a pm_qos requirement.  To provide for automatic
-cleanup for process the interface requires the process to register its
-parameter requirements in the following way:
-
-To register the default pm_qos target for the specific parameter, the proc=
ess
-must open one of /dev/[cpu_dma_latency, network_latency, network_throughpu=
t]
-
-As long as the device node is held open that process has a registered
-requirement on the parameter.  The name of the requirement is "process_<PI=
D>"
-derived from the current->pid from within the open system call.
-
-To change the requested target value the process needs to write a s32 valu=
e to
-the open device node.  This translates to a pm_qos_update_requirement call.
-
-To remove the user mode request for a target value simply close the device
-node.
-
-
-
--- /dev/null
+++ linux-2.6.25-rc3-git6/Documentation/power/pm_qos_interface.txt
@@ -0,0 +1,59 @@
+PM quality of Service interface.
+
+This interface provides a kernel and user mode interface for registering
+performance expectations by drivers, subsystems and user space application=
s on
+one of the parameters.
+
+Currently we have {cpu_dma_latency, network_latency, network_throughput} a=
s the
+initial set of pm_qos parameters.
+
+The infrastructure exposes multiple misc device nodes one per implemented
+parameter.  The set of parameters implement is defined by pm_qos_power_ini=
t()
+and pm_qos_params.h.  This is done because having the available parameters
+being runtime configurable or changeable from a driver was seen as too eas=
y to
+abuse.
+
+For each parameter a list of performance requirements is maintained along =
with
+an aggregated target value.  The aggregated target value is updated with
+changes to the requirement list or elements of the list.  Typically the
+aggregated target value is simply the max or min of the requirement values=
 held
+in the parameter list elements.
+
+From kernel mode the use of this interface is simple:
+pm_qos_add_requirement(param_id, name, target_value):
+Will insert a named element in the list for that identified PM_QOS paramet=
er
+with the target value.  Upon change to this list the new target is recompu=
ted
+and any registered notifiers are called only if the target value is now
+different.
+
+pm_qos_update_requirement(param_id, name, new_target_value):
+Will search the list identified by the param_id for the named list element=
 and
+then update its target value, calling the notification tree if the aggrega=
ted
+target is changed.  with that name is already registered.
+
+pm_qos_remove_requirement(param_id, name):
+Will search the identified list for the named element and remove it, after
+removal it will update the aggregate target and call the notification tree=
 if
+the target was changed as a result of removing the named requirement.
+
+
+From user mode:
+Only processes can register a pm_qos requirement.  To provide for automatic
+cleanup for process the interface requires the process to register its
+parameter requirements in the following way:
+
+To register the default pm_qos target for the specific parameter, the proc=
ess
+must open one of /dev/[cpu_dma_latency, network_latency, network_throughpu=
t]
+
+As long as the device node is held open that process has a registered
+requirement on the parameter.  The name of the requirement is "process_<PI=
D>"
+derived from the current->pid from within the open system call.
+
+To change the requested target value the process needs to write a s32 valu=
e to
+the open device node.  This translates to a pm_qos_update_requirement call.
+
+To remove the user mode request for a target value simply close the device
+node.
+
+
+
--- /dev/null
+++ linux-2.6.25-rc3-git6/Documentation/power/power_supply_class.txt
@@ -0,0 +1,169 @@
+Linux power supply class
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Synopsis
+~~~~~~~~
+Power supply class used to represent battery, UPS, AC or DC power supply
+properties to user-space.
+
+It defines core set of attributes, which should be applicable to (almost)
+every power supply out there. Attributes are available via sysfs and uevent
+interfaces.
+
+Each attribute has well defined meaning, up to unit of measure used. While
+the attributes provided are believed to be universally applicable to any
+power supply, specific monitoring hardware may not be able to provide them
+all, so any of them may be skipped.
+
+Power supply class is extensible, and allows to define drivers own attribu=
tes.
+The core attribute set is subject to the standard Linux evolution (i.e.
+if it will be found that some attribute is applicable to many power supply
+types or their drivers, it can be added to the core set).
+
+It also integrates with LED framework, for the purpose of providing
+typically expected feedback of battery charging/fully charged status and
+AC/USB power supply online status. (Note that specific details of the
+indication (including whether to use it at all) are fully controllable by
+user and/or specific machine defaults, per design principles of LED
+framework).
+
+
+Attributes/properties
+~~~~~~~~~~~~~~~~~~~~~
+Power supply class has predefined set of attributes, this eliminates code
+duplication across drivers. Power supply class insist on reusing its
+predefined attributes *and* their units.
+
+So, userspace gets predictable set of attributes and their units for any
+kind of power supply, and can process/present them to a user in consistent
+manner. Results for different power supplies and machines are also directly
+comparable.
+
+See drivers/power/ds2760_battery.c and drivers/power/pda_power.c for the
+example how to declare and handle attributes.
+
+
+Units
+~~~~~
+Quoting include/linux/power_supply.h:
+
+  All voltages, currents, charges, energies, time and temperatures in =B5V,
+  =B5A, =B5Ah, =B5Wh, seconds and tenths of degree Celsius unless otherwise
+  stated. It's driver's job to convert its raw values to units in which
+  this class operates.
+
+
+Attributes/properties detailed
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+~ ~ ~ ~ ~ ~ ~  Charge/Energy/Capacity - how to not confuse  ~ ~ ~ ~ ~ ~ ~
+~                                                                       ~
+~ Because both "charge" (=B5Ah) and "energy" (=B5Wh) represents "capacity"=
  ~
+~ of battery, this class distinguish these terms. Don't mix them!       ~
+~                                                                       ~
+~ CHARGE_* attributes represents capacity in =B5Ah only.                  ~
+~ ENERGY_* attributes represents capacity in =B5Wh only.                  ~
+~ CAPACITY attribute represents capacity in *percents*, from 0 to 100.  ~
+~                                                                       ~
+~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
+
+Postfixes:
+_AVG - *hardware* averaged value, use it if your hardware is really able to
+report averaged values.
+_NOW - momentary/instantaneous values.
+
+STATUS - this attribute represents operating status (charging, full,
+discharging (i.e. powering a load), etc.). This corresponds to
+BATTERY_STATUS_* values, as defined in battery.h.
+
+HEALTH - represents health of the battery, values corresponds to
+POWER_SUPPLY_HEALTH_*, defined in battery.h.
+
+VOLTAGE_MAX_DESIGN, VOLTAGE_MIN_DESIGN - design values for maximal and
+minimal power supply voltages. Maximal/minimal means values of voltages
+when battery considered "full"/"empty" at normal conditions. Yes, there is
+no direct relation between voltage and battery capacity, but some dumb
+batteries use voltage for very approximated calculation of capacity.
+Battery driver also can use this attribute just to inform userspace
+about maximal and minimal voltage thresholds of a given battery.
+
+VOLTAGE_MAX, VOLTAGE_MIN - same as _DESIGN voltage values except that
+these ones should be used if hardware could only guess (measure and
+retain) the thresholds of a given power supply.
+
+CHARGE_FULL_DESIGN, CHARGE_EMPTY_DESIGN - design charge values, when
+battery considered full/empty.
+
+ENERGY_FULL_DESIGN, ENERGY_EMPTY_DESIGN - same as above but for energy.
+
+CHARGE_FULL, CHARGE_EMPTY - These attributes means "last remembered value
+of charge when battery became full/empty". It also could mean "value of
+charge when battery considered full/empty at given conditions (temperature,
+age)". I.e. these attributes represents real thresholds, not design values.
+
+ENERGY_FULL, ENERGY_EMPTY - same as above but for energy.
+
+CAPACITY - capacity in percents.
+
+TEMP - temperature of the power supply.
+TEMP_AMBIENT - ambient temperature.
+
+TIME_TO_EMPTY - seconds left for battery to be considered empty (i.e.
+while battery powers a load)
+TIME_TO_FULL - seconds left for battery to be considered full (i.e.
+while battery is charging)
+
+
+Battery <-> external power supply interaction
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Often power supplies are acting as supplies and supplicants at the same
+time. Batteries are good example. So, batteries usually care if they're
+externally powered or not.
+
+For that case, power supply class implements notification mechanism for
+batteries.
+
+External power supply (AC) lists supplicants (batteries) names in
+"supplied_to" struct member, and each power_supply_changed() call
+issued by external power supply will notify supplicants via
+external_power_changed callback.
+
+
+QA
+~~
+Q: Where is POWER_SUPPLY_PROP_XYZ attribute?
+A: If you cannot find attribute suitable for your driver needs, feel free
+   to add it and send patch along with your driver.
+
+   The attributes available currently are the ones currently provided by t=
he
+   drivers written.
+
+   Good candidates to add in future: model/part#, cycle_time, manufacturer,
+   etc.
+
+
+Q: I have some very specific attribute (e.g. battery color), should I add
+   this attribute to standard ones?
+A: Most likely, no. Such attribute can be placed in the driver itself, if
+   it is useful. Of course, if the attribute in question applicable to
+   large set of batteries, provided by many drivers, and/or comes from
+   some general battery specification/standard, it may be a candidate to
+   be added to the core attribute set.
+
+
+Q: Suppose, my battery monitoring chip/firmware does not provides capacity
+   in percents, but provides charge_{now,full,empty}. Should I calculate
+   percentage capacity manually, inside the driver, and register CAPACITY
+   attribute? The same question about time_to_empty/time_to_full.
+A: Most likely, no. This class is designed to export properties which are
+   directly measurable by the specific hardware available.
+
+   Inferring not available properties using some heuristics or mathematical
+   model is not subject of work for a battery driver. Such functionality
+   should be factored out, and in fact, apm_power, the driver to serve
+   legacy APM API on top of power supply class, uses a simple heuristic of
+   approximating remaining battery capacity based on its charge, current,
+   voltage and so on. But full-fledged battery model is likely not subject
+   for kernel at all, as it would require floating point calculation to de=
al
+   with things like differential equations and Kalman filters. This is
+   better be handled by batteryd/libbattery, yet to be written.
--- linux-2.6.25-rc3-git6.orig/Documentation/power_supply_class.txt
+++ /dev/null
@@ -1,169 +0,0 @@
-Linux power supply class
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Synopsis
-~~~~~~~~
-Power supply class used to represent battery, UPS, AC or DC power supply
-properties to user-space.
-
-It defines core set of attributes, which should be applicable to (almost)
-every power supply out there. Attributes are available via sysfs and uevent
-interfaces.
-
-Each attribute has well defined meaning, up to unit of measure used. While
-the attributes provided are believed to be universally applicable to any
-power supply, specific monitoring hardware may not be able to provide them
-all, so any of them may be skipped.
-
-Power supply class is extensible, and allows to define drivers own attribu=
tes.
-The core attribute set is subject to the standard Linux evolution (i.e.
-if it will be found that some attribute is applicable to many power supply
-types or their drivers, it can be added to the core set).
-
-It also integrates with LED framework, for the purpose of providing
-typically expected feedback of battery charging/fully charged status and
-AC/USB power supply online status. (Note that specific details of the
-indication (including whether to use it at all) are fully controllable by
-user and/or specific machine defaults, per design principles of LED
-framework).
-
-
-Attributes/properties
-~~~~~~~~~~~~~~~~~~~~~
-Power supply class has predefined set of attributes, this eliminates code
-duplication across drivers. Power supply class insist on reusing its
-predefined attributes *and* their units.
-
-So, userspace gets predictable set of attributes and their units for any
-kind of power supply, and can process/present them to a user in consistent
-manner. Results for different power supplies and machines are also directly
-comparable.
-
-See drivers/power/ds2760_battery.c and drivers/power/pda_power.c for the
-example how to declare and handle attributes.
-
-
-Units
-~~~~~
-Quoting include/linux/power_supply.h:
-
-  All voltages, currents, charges, energies, time and temperatures in =B5V,
-  =B5A, =B5Ah, =B5Wh, seconds and tenths of degree Celsius unless otherwise
-  stated. It's driver's job to convert its raw values to units in which
-  this class operates.
-
-
-Attributes/properties detailed
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-~ ~ ~ ~ ~ ~ ~  Charge/Energy/Capacity - how to not confuse  ~ ~ ~ ~ ~ ~ ~
-~                                                                       ~
-~ Because both "charge" (=B5Ah) and "energy" (=B5Wh) represents "capacity"=
  ~
-~ of battery, this class distinguish these terms. Don't mix them!       ~
-~                                                                       ~
-~ CHARGE_* attributes represents capacity in =B5Ah only.                  ~
-~ ENERGY_* attributes represents capacity in =B5Wh only.                  ~
-~ CAPACITY attribute represents capacity in *percents*, from 0 to 100.  ~
-~                                                                       ~
-~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-
-Postfixes:
-_AVG - *hardware* averaged value, use it if your hardware is really able to
-report averaged values.
-_NOW - momentary/instantaneous values.
-
-STATUS - this attribute represents operating status (charging, full,
-discharging (i.e. powering a load), etc.). This corresponds to
-BATTERY_STATUS_* values, as defined in battery.h.
-
-HEALTH - represents health of the battery, values corresponds to
-POWER_SUPPLY_HEALTH_*, defined in battery.h.
-
-VOLTAGE_MAX_DESIGN, VOLTAGE_MIN_DESIGN - design values for maximal and
-minimal power supply voltages. Maximal/minimal means values of voltages
-when battery considered "full"/"empty" at normal conditions. Yes, there is
-no direct relation between voltage and battery capacity, but some dumb
-batteries use voltage for very approximated calculation of capacity.
-Battery driver also can use this attribute just to inform userspace
-about maximal and minimal voltage thresholds of a given battery.
-
-VOLTAGE_MAX, VOLTAGE_MIN - same as _DESIGN voltage values except that
-these ones should be used if hardware could only guess (measure and
-retain) the thresholds of a given power supply.
-
-CHARGE_FULL_DESIGN, CHARGE_EMPTY_DESIGN - design charge values, when
-battery considered full/empty.
-
-ENERGY_FULL_DESIGN, ENERGY_EMPTY_DESIGN - same as above but for energy.
-
-CHARGE_FULL, CHARGE_EMPTY - These attributes means "last remembered value
-of charge when battery became full/empty". It also could mean "value of
-charge when battery considered full/empty at given conditions (temperature,
-age)". I.e. these attributes represents real thresholds, not design values.
-
-ENERGY_FULL, ENERGY_EMPTY - same as above but for energy.
-
-CAPACITY - capacity in percents.
-
-TEMP - temperature of the power supply.
-TEMP_AMBIENT - ambient temperature.
-
-TIME_TO_EMPTY - seconds left for battery to be considered empty (i.e.
-while battery powers a load)
-TIME_TO_FULL - seconds left for battery to be considered full (i.e.
-while battery is charging)
-
-
-Battery <-> external power supply interaction
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-Often power supplies are acting as supplies and supplicants at the same
-time. Batteries are good example. So, batteries usually care if they're
-externally powered or not.
-
-For that case, power supply class implements notification mechanism for
-batteries.
-
-External power supply (AC) lists supplicants (batteries) names in
-"supplied_to" struct member, and each power_supply_changed() call
-issued by external power supply will notify supplicants via
-external_power_changed callback.
-
-
-QA
-~~
-Q: Where is POWER_SUPPLY_PROP_XYZ attribute?
-A: If you cannot find attribute suitable for your driver needs, feel free
-   to add it and send patch along with your driver.
-
-   The attributes available currently are the ones currently provided by t=
he
-   drivers written.
-
-   Good candidates to add in future: model/part#, cycle_time, manufacturer,
-   etc.
-
-
-Q: I have some very specific attribute (e.g. battery color), should I add
-   this attribute to standard ones?
-A: Most likely, no. Such attribute can be placed in the driver itself, if
-   it is useful. Of course, if the attribute in question applicable to
-   large set of batteries, provided by many drivers, and/or comes from
-   some general battery specification/standard, it may be a candidate to
-   be added to the core attribute set.
-
-
-Q: Suppose, my battery monitoring chip/firmware does not provides capacity
-   in percents, but provides charge_{now,full,empty}. Should I calculate
-   percentage capacity manually, inside the driver, and register CAPACITY
-   attribute? The same question about time_to_empty/time_to_full.
-A: Most likely, no. This class is designed to export properties which are
-   directly measurable by the specific hardware available.
-
-   Inferring not available properties using some heuristics or mathematical
-   model is not subject of work for a battery driver. Such functionality
-   should be factored out, and in fact, apm_power, the driver to serve
-   legacy APM API on top of power supply class, uses a simple heuristic of
-   approximating remaining battery capacity based on its charge, current,
-   voltage and so on. But full-fledged battery model is likely not subject
-   for kernel at all, as it would require floating point calculation to de=
al
-   with things like differential equations and Kalman filters. This is
-   better be handled by batteryd/libbattery, yet to be written.
--- linux-2.6.25-rc3-git6.orig/arch/x86/Kconfig
+++ linux-2.6.25-rc3-git6/arch/x86/Kconfig
@@ -1261,7 +1261,7 @@ menuconfig APM
 	  machines with more than one CPU.
 =

 	  In order to use APM, you will need supporting software. For location
-	  and more information, read <file:Documentation/pm.txt> and the
+	  and more information, read <file:Documentation/power/pm.txt> and the
 	  Battery Powered Linux mini-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.
 =

--- linux-2.6.25-rc3-git6.orig/kernel/power/Kconfig
+++ linux-2.6.25-rc3-git6/kernel/power/Kconfig
@@ -190,7 +190,7 @@ config APM_EMULATION
 	  notification of APM "events" (e.g. battery status change).
 =

 	  In order to use APM, you will need supporting software. For location
-	  and more information, read <file:Documentation/pm.txt> and the
+	  and more information, read <file:Documentation/power/pm.txt> and the
 	  Battery Powered Linux mini-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.
 =

--- linux-2.6.25-rc3-git6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6.25-rc3-git6/Documentation/kernel-parameters.txt
@@ -138,7 +138,7 @@ and is between 256 and 4096 characters. =

 			strict -- Be less tolerant of platforms that are not
 				strictly ACPI specification compliant.
 =

-			See also Documentation/pm.txt, pci=3Dnoacpi
+			See also Documentation/power/pm.txt, pci=3Dnoacpi
 =

 	acpi_apic_instance=3D	[ACPI, IOAPIC]
 			Format: <int>
