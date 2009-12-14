From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM: Calling Device runtime PM callbacks?
Date: Mon, 14 Dec 2009 01:03:23 +0100
Message-ID: <200912140103.23415.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912131348300.2857-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912131348300.2857-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 13 December 2009, Alan Stern wrote:
> On Sun, 13 Dec 2009, Rafael J. Wysocki wrote:
> 
> > On Sunday 13 December 2009, Alan Stern wrote:
> > > On Sun, 13 Dec 2009, Rafael J. Wysocki wrote:
> > > 
> > > > On Sunday 13 December 2009, Mahalingam, Nithish wrote:
> > > > > Hi Rafael,
> > > > > 
> > > > > I was wondering why PM Runtime Core cannot call the device PM callbacks when 
> > > > > its device's bus does not support runtime PM (if such a scenario is valid)?
> > > > 
> > > > The assumption was it wouldn't be necessary, but the approach can be extended
> > > > to device types and device classes.
> > > > 
> > > > > Regards,	
> > > > > Nithish Mahalingam
> > > > > P.S. Alan, Not sure if you are askin the a similar question in the 
> > > > > "System sleep vs. runtime PM" mail thread.
> > > > 
> > > > I guess so.
> > > 
> > > Yes.  I mistakenly used the wrong words, but I meant the device type
> > > and device class.
> > 
> > So, I guess we need something like device_suspend() and device_resume()
> > for run-time PM, but we also will need to update the documentation.
> 
> Yes.
> 
> > I'll try to prepare a patch for that, unless you already have one ready or
> > in the works.
> 
> I don't.  Go on ahead.

There you go (untested for now).

->runtime_idle() is still only called for the device's bus type, because
otherwise it will be hard to determine the right ordering of the bus type,
device type and device class callbacks.

Comments welcome. :-)

Rafael

---
 Documentation/power/runtime_pm.txt |  204 ++++++++++++++++++++-----------------
 drivers/base/power/runtime.c       |  110 ++++++++++++++++---
 2 files changed, 201 insertions(+), 113 deletions(-)

Index: linux-2.6/drivers/base/power/runtime.c
===================================================================
--- linux-2.6.orig/drivers/base/power/runtime.c
+++ linux-2.6/drivers/base/power/runtime.c
@@ -111,6 +111,45 @@ int pm_runtime_idle(struct device *dev)
 EXPORT_SYMBOL_GPL(pm_runtime_idle);
 
 /**
+ * device_runtime_suspend - Execute "runtime suspend" callbacks for a device.
+ * @dev: Device to handle.
+ * @error_ptr: Place to store error values returned by the callbacks.
+ */
+static int device_runtime_suspend(struct device *dev, int *error_ptr)
+{
+	int error = -ENOSYS;
+
+	down(&dev->sem);
+
+	if (dev->class && dev->class->pm && dev->class->pm->runtime_suspend) {
+		error = dev->class->pm->runtime_suspend(dev);
+		suspend_report_result(dev->class->pm->runtime_suspend, error);
+		*error_ptr = error;
+		if (error)
+			goto out;
+	}
+
+	if (dev->type && dev->type->pm && dev->type->pm->runtime_suspend) {
+		error = dev->type->pm->runtime_suspend(dev);
+		suspend_report_result(dev->type->pm->runtime_suspend, error);
+		*error_ptr = error;
+		if (error)
+			goto out;
+	}
+
+	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend) {
+		error = dev->bus->pm->runtime_suspend(dev);
+		suspend_report_result(dev->bus->pm->runtime_suspend, error);
+		*error_ptr = error;
+	}
+
+ out:
+	up(&dev->sem);
+
+	return error;
+}
+
+/**
  * __pm_runtime_suspend - Carry out run-time suspend of given device.
  * @dev: Device to suspend.
  * @from_wq: If set, the function has been called via pm_wq.
@@ -127,7 +166,7 @@ int __pm_runtime_suspend(struct device *
 {
 	struct device *parent = NULL;
 	bool notify = false;
-	int retval = 0;
+	int error, retval = 0;
 
 	dev_dbg(dev, "__pm_runtime_suspend()%s!\n",
 		from_wq ? " from workqueue" : "");
@@ -186,17 +225,13 @@ int __pm_runtime_suspend(struct device *
 
 	dev->power.runtime_status = RPM_SUSPENDING;
 	dev->power.deferred_resume = false;
+	error = dev->power.runtime_error;
+	spin_unlock_irq(&dev->power.lock);
 
-	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->bus->pm->runtime_suspend(dev);
+	retval = device_runtime_suspend(dev, &error);
 
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else {
-		retval = -ENOSYS;
-	}
+	spin_lock_irq(&dev->power.lock);
+	dev->power.runtime_error = error;
 
 	if (retval) {
 		dev->power.runtime_status = RPM_ACTIVE;
@@ -256,6 +291,45 @@ int pm_runtime_suspend(struct device *de
 EXPORT_SYMBOL_GPL(pm_runtime_suspend);
 
 /**
+ * device_runtime_resume - Execute "runtime resume" callbacks for given device.
+ * @dev: Device to handle.
+ * @error_ptr: Place to store error values returned by the callbacks.
+ */
+static int device_runtime_resume(struct device *dev, int *error_ptr)
+{
+	int error = -ENOSYS;
+
+	down(&dev->sem);
+
+	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume) {
+		error = dev->bus->pm->runtime_resume(dev);
+		suspend_report_result(dev->bus->pm->runtime_resume, error);
+		*error_ptr = error;
+		if (error)
+			goto out;
+	}
+
+	if (dev->type && dev->type->pm && dev->type->pm->runtime_resume) {
+		error = dev->type->pm->runtime_resume(dev);
+		suspend_report_result(dev->type->pm->runtime_resume, error);
+		*error_ptr = error;
+		if (error)
+			goto out;
+	}
+
+	if (dev->class && dev->class->pm && dev->class->pm->runtime_resume) {
+		error = dev->class->pm->runtime_resume(dev);
+		suspend_report_result(dev->class->pm->runtime_resume, error);
+		*error_ptr = error;
+	}
+
+ out:
+	up(&dev->sem);
+
+	return error;
+}
+
+/**
  * __pm_runtime_resume - Carry out run-time resume of given device.
  * @dev: Device to resume.
  * @from_wq: If set, the function has been called via pm_wq.
@@ -272,7 +346,7 @@ int __pm_runtime_resume(struct device *d
 	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
 	struct device *parent = NULL;
-	int retval = 0;
+	int error, retval = 0;
 
 	dev_dbg(dev, "__pm_runtime_resume()%s!\n",
 		from_wq ? " from workqueue" : "");
@@ -351,17 +425,13 @@ int __pm_runtime_resume(struct device *d
 	}
 
 	dev->power.runtime_status = RPM_RESUMING;
+	error = dev->power.runtime_error;
+	spin_unlock_irq(&dev->power.lock);
 
-	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->bus->pm->runtime_resume(dev);
+	retval = device_runtime_resume(dev, &error);
 
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else {
-		retval = -ENOSYS;
-	}
+	spin_lock_irq(&dev->power.lock);
+	dev->power.runtime_error = error;
 
 	if (retval) {
 		dev->power.runtime_status = RPM_SUSPENDED;
Index: linux-2.6/Documentation/power/runtime_pm.txt
===================================================================
--- linux-2.6.orig/Documentation/power/runtime_pm.txt
+++ linux-2.6/Documentation/power/runtime_pm.txt
@@ -42,62 +42,79 @@ struct dev_pm_ops {
 	...
 };
 
-The ->runtime_suspend() callback is executed by the PM core for the bus type of
-the device being suspended.  The bus type's callback is then _entirely_
-_responsible_ for handling the device as appropriate, which may, but need not
-include executing the device driver's own ->runtime_suspend() callback (from the
-PM core's point of view it is not necessary to implement a ->runtime_suspend()
-callback in a device driver as long as the bus type's ->runtime_suspend() knows
-what to do to handle the device).
-
-  * Once the bus type's ->runtime_suspend() callback has completed successfully
-    for given device, the PM core regards the device as suspended, which need
-    not mean that the device has been put into a low power state.  It is
-    supposed to mean, however, that the device will not process data and will
-    not communicate with the CPU(s) and RAM until its bus type's
-    ->runtime_resume() callback is executed for it.  The run-time PM status of
-    a device after successful execution of its bus type's ->runtime_suspend()
-    callback is 'suspended'.
-
-  * If the bus type's ->runtime_suspend() callback returns -EBUSY or -EAGAIN,
-    the device's run-time PM status is supposed to be 'active', which means that
-    the device _must_ be fully operational afterwards.
-
-  * If the bus type's ->runtime_suspend() callback returns an error code
-    different from -EBUSY or -EAGAIN, the PM core regards this as a fatal
-    error and will refuse to run the helper functions described in Section 4
-    for the device, until the status of it is directly set either to 'active'
-    or to 'suspended' (the PM core provides special helper functions for this
-    purpose).
+The ->runtime_suspend() callback is executed by the PM core for the bus type,
+device type and device class of the device being suspended.  The bus type,
+device type and device class callbacks are then _entirely_ _responsible_ for
+handling the device as appropriate, which may, but need not include executing
+the device driver's own ->runtime_suspend() callback (from the PM core's point
+of view it is not necessary to implement a ->runtime_suspend() callback in a
+device driver as long as the bus type, device type and device class
+->runtime_suspend() know what to do to handle the device).
+
+  * Once all of the bus type, device type and device class ->runtime_suspend()
+    callbacks defined for given device have completed successfully, the PM core
+    regards the device as suspended, which need not mean that the device has
+    been put into a low power state.  It is supposed to mean, however, that the
+    device will not process data and will not communicate with the CPU(s) and
+    RAM, until the bus type, device type and device class ->runtime_resume()
+    callbacks are executed for it.  The run-time PM status of a device after
+    successful execution of the bus type, device type and device class
+    ->runtime_suspend() callbacks is 'suspended'.
+
+  * If the device class ->runtime_suspend() callback returns error code for
+    given device, the bus type and device type ->runtime_suspend() callbacks
+    will not be executed for it.  In turn, if the device type callback returns
+    error code for the device, the bus type callback will not be executed for
+    it.
+
+  * If the bus type, device type or device class ->runtime_suspend() callback
+    returns -EBUSY or -EAGAIN, the device's run-time PM status is supposed to be
+    'active', which means that the device _must_ be fully operational
+    afterwards.
+
+  * If the bus type, device type or device class ->runtime_suspend() callback
+    returns error code different from -EBUSY or -EAGAIN, the PM core regards
+    this as a fatal error and will refuse to run the helper functions described
+    in Section 4 for the device, until the status of it is directly set either
+    to 'active' or to 'suspended' (the PM core provides special helper functions
+    for this purpose).
 
 In particular, if the driver requires remote wakeup capability for proper
 functioning and device_run_wake() returns 'false' for the device, then
 ->runtime_suspend() should return -EBUSY.  On the other hand, if
 device_run_wake() returns 'true' for the device and the device is put
-into a low power state during the execution of its bus type's
-->runtime_suspend(), it is expected that remote wake-up (i.e. hardware mechanism
-allowing the device to request a change of its power state, such as PCI PME)
-will be enabled for the device.  Generally, remote wake-up should be enabled
-for all input devices put into a low power state at run time.
-
-The ->runtime_resume() callback is executed by the PM core for the bus type of
-the device being woken up.  The bus type's callback is then _entirely_
-_responsible_ for handling the device as appropriate, which may, but need not
-include executing the device driver's own ->runtime_resume() callback (from the
-PM core's point of view it is not necessary to implement a ->runtime_resume()
-callback in a device driver as long as the bus type's ->runtime_resume() knows
-what to do to handle the device).
-
-  * Once the bus type's ->runtime_resume() callback has completed successfully,
-    the PM core regards the device as fully operational, which means that the
-    device _must_ be able to complete I/O operations as needed.  The run-time
-    PM status of the device is then 'active'.
-
-  * If the bus type's ->runtime_resume() callback returns an error code, the PM
-    core regards this as a fatal error and will refuse to run the helper
-    functions described in Section 4 for the device, until its status is
-    directly set either to 'active' or to 'suspended' (the PM core provides
-    special helper functions for this purpose).
+into a low power state during the execution of its bus type, device type or
+device class ->runtime_suspend(), it is expected that remote wake-up (i.e.
+hardware mechanism allowing the device to request a change of its power state,
+such as PCI PME) will be enabled for the device.  Generally, remote wake-up
+should be enabled for all input devices put into a low power state at run time.
+
+The ->runtime_resume() callback is executed by the PM core for the bus type,
+device type and device class of the device being woken up.  The bus type, device
+type and device class callbacks are then _entirely_ _responsible_ for handling
+the device as appropriate, which may, but need not include executing the device
+driver's own ->runtime_resume() callback (from the PM core's point of view it is
+not necessary to implement a ->runtime_resume() callback in a device driver as
+long as the bus type, device type and device class ->runtime_resume() callbacks
+know what to do to handle the device).
+
+  * Once the bus type, device type and device class ->runtime_resume() callbacks
+    defined for the device have completed successfully, the PM core regards the
+    device as fully operational, which means that the device _must_ be able to
+    complete I/O operations as needed.  The run-time PM status of the device is
+    then 'active'.
+
+  * If the bus type ->runtime_resume() callback returns error code for given
+    device, the device type and device class ->runtime_resume() callbacks will
+    not be executed for it.  In turn, if the device type ->runtime_resume()
+    callback returns error code for the device, the device class callback will
+    not be executed for it.
+
+  * If the bus type, device type or device class ->runtime_resume() callback
+    returns error code, the PM core regards this as a fatal error and will
+    refuse to run the helper functions described in Section 4 for the device,
+    until its status is directly set either to 'active' or to 'suspended' (the
+    PM core provides special helper functions for this purpose).
 
 The ->runtime_idle() callback is executed by the PM core for the bus type of
 given device whenever the device appears to be idle, which is indicated to the
@@ -118,29 +135,28 @@ request for the device in that case.  Th
 ignored by the PM core.
 
 The helper functions provided by the PM core, described in Section 4, guarantee
-that the following constraints are met with respect to the bus type's run-time
-PM callbacks:
+that the following constraints are met with respect to the bus type, device type
+and device class run-time PM callbacks:
 
-(1) The callbacks are mutually exclusive (e.g. it is forbidden to execute
-    ->runtime_suspend() in parallel with ->runtime_resume() or with another
-    instance of ->runtime_suspend() for the same device) with the exception that
-    ->runtime_suspend() or ->runtime_resume() can be executed in parallel with
-    ->runtime_idle() (although ->runtime_idle() will not be started while any
-    of the other callbacks is being executed for the same device).
+(1) The idle, suspend and resume callbacks are mutually exclusive (e.g. it is
+    forbidden to execute ->runtime_suspend() in parallel with ->runtime_resume()
+    or with another instance of ->runtime_suspend() for the same device) with
+    the exception that ->runtime_suspend() or ->runtime_resume() can be executed
+    in parallel with ->runtime_idle() (although ->runtime_idle() will not be
+    started while any of the other callbacks is being executed for the same
+    device).
 
 (2) ->runtime_idle() and ->runtime_suspend() can only be executed for 'active'
     devices (i.e. the PM core will only execute ->runtime_idle() or
-    ->runtime_suspend() for the devices the run-time PM status of which is
-    'active').
+    ->runtime_suspend() for the devices whose run-time PM status is 'active').
 
 (3) ->runtime_idle() and ->runtime_suspend() can only be executed for a device
-    the usage counter of which is equal to zero _and_ either the counter of
-    'active' children of which is equal to zero, or the 'power.ignore_children'
-    flag of which is set.
+    whose usage counter is equal to zero _and_ either the counter of 'active'
+    children is equal to zero, or the 'power.ignore_children' flag is set.
 
 (4) ->runtime_resume() can only be executed for 'suspended' devices  (i.e. the
-    PM core will only execute ->runtime_resume() for the devices the run-time
-    PM status of which is 'suspended').
+    PM core will only execute ->runtime_resume() for the devices whose run-time
+    PM status is 'suspended').
 
 Additionally, the helper functions provided by the PM core obey the following
 rules:
@@ -243,17 +259,18 @@ drivers/base/power/runtime.c and include
       is already being executed
 
   int pm_runtime_suspend(struct device *dev);
-    - execute ->runtime_suspend() for the device's bus type; returns 0 on
-      success, 1 if the device's run-time PM status was already 'suspended', or
-      error code on failure, where -EAGAIN or -EBUSY means it is safe to attempt
-      to suspend the device again in future
+    - execute ->runtime_suspend() for the device class, device type and bus
+      type of dev in this order; returns 0 on success, 1 if the device's
+      run-time PM status was already 'suspended', or error code on failure,
+      where -EAGAIN or -EBUSY means it is safe to attempt to suspend the device
+      again in future
 
   int pm_runtime_resume(struct device *dev);
-    - execute ->runtime_resume() for the device's bus type; returns 0 on
-      success, 1 if the device's run-time PM status was already 'active' or
-      error code on failure, where -EAGAIN means it may be safe to attempt to
-      resume the device again in future, but 'power.runtime_error' should be
-      checked additionally
+    - execute ->runtime_resume() for the bus type, device type and device class
+      of dev in this order; returns 0 on success, 1 if the device's run-time PM
+      status was already 'active' or error code on failure, where -EAGAIN means
+      it may be safe to attempt to resume the device again in future, but
+      'power.runtime_error' should be checked additionally
 
   int pm_request_idle(struct device *dev);
     - submit a request to execute ->runtime_idle() for the device's bus type
@@ -261,20 +278,20 @@ drivers/base/power/runtime.c and include
       or error code if the request has not been queued up
 
   int pm_schedule_suspend(struct device *dev, unsigned int delay);
-    - schedule the execution of ->runtime_suspend() for the device's bus type
-      in future, where 'delay' is the time to wait before queuing up a suspend
-      work item in pm_wq, in milliseconds (if 'delay' is zero, the work item is
-      queued up immediately); returns 0 on success, 1 if the device's PM
-      run-time status was already 'suspended', or error code if the request
-      hasn't been scheduled (or queued up if 'delay' is 0); if the execution of
-      ->runtime_suspend() is already scheduled and not yet expired, the new
-      value of 'delay' will be used as the time to wait
+    - schedule the execution of ->runtime_suspend() for the device class, device
+      type and bus type of dev in future, where 'delay' is the time to wait
+      before queuing up a suspend work item in pm_wq, in milliseconds (if
+      'delay' is zero, the work item is queued up immediately); returns 0 on
+      success, 1 if the device's PM run-time status was already 'suspended', or
+      error code if the request hasn't been scheduled (or queued up if 'delay'
+      is 0); if the execution of ->runtime_suspend() is already scheduled and
+      not yet expired, the new value of 'delay' will be used as the time to wait
 
   int pm_request_resume(struct device *dev);
-    - submit a request to execute ->runtime_resume() for the device's bus type
-      (the request is represented by a work item in pm_wq); returns 0 on
-      success, 1 if the device's run-time PM status was already 'active', or
-      error code if the request hasn't been queued up
+    - submit a request to execute ->runtime_resume() for the bus type, device
+      type and device class of dev (the request is represented by a work item in
+      pm_wq); returns 0 on success, 1 if the device's run-time PM status was
+      already 'active', or error code if the request hasn't been queued up
 
   void pm_runtime_get_noresume(struct device *dev);
     - increment the device's usage counter
@@ -303,12 +320,13 @@ drivers/base/power/runtime.c and include
       run-time PM callbacks described in Section 2
 
   int pm_runtime_disable(struct device *dev);
-    - prevent the run-time PM helper functions from running the device bus
-      type's run-time PM callbacks, make sure that all of the pending run-time
-      PM operations on the device are either completed or canceled; returns
-      1 if there was a resume request pending and it was necessary to execute
-      ->runtime_resume() for the device's bus type to satisfy that request,
-      otherwise 0 is returned
+    - prevent the run-time PM helper functions from running the device's bus
+      type, device type and device class run-time PM callbacks, make sure that
+      all of the pending run-time PM operations on the device are either
+      completed or canceled; returns 1 if there was a resume request pending and
+      it was necessary to execute ->runtime_resume() for the bus type, device
+      type and device class of dev to satisfy that request, otherwise 0 is
+      returned
 
   void pm_suspend_ignore_children(struct device *dev, bool enable);
     - set/unset the power.ignore_children flag of the device
