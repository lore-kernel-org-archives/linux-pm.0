From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] PM / core: Clean up kerneldoc comments in pm.h
Date: Mon, 19 Dec 2016 21:41:36 +0100
Message-ID: <1911017.rLT2ETnnI6@aspire.rjw.lan>
References: <1812473.IRtThzhzgn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1812473.IRtThzhzgn@aspire.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux Documentation <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Refresh the struct dev_pm_ops kerneldoc comment, so that it looks
better and is more readable after processing by Sphinx, and drop
the kerneldoc marker from the "PM_EVENT_ messages" comment which
is not a proper kerneldoc and causes Sphinx to generate confusing
mess.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm.h |   98 +++++++++++++++++++++++++----------------------------
 1 file changed, 48 insertions(+), 50 deletions(-)

Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -64,24 +64,7 @@ typedef struct pm_message {
 } pm_message_t;
 
 /**
- * struct dev_pm_ops - device PM callbacks
- *
- * Several device power state transitions are externally visible, affecting
- * the state of pending I/O queues and (for drivers that touch hardware)
- * interrupts, wakeups, DMA, and other hardware state.  There may also be
- * internal transitions to various low-power modes which are transparent
- * to the rest of the driver stack (such as a driver that's ON gating off
- * clocks which are not in active use).
- *
- * The externally visible transitions are handled with the help of callbacks
- * included in this structure in such a way that two levels of callbacks are
- * involved.  First, the PM core executes callbacks provided by PM domains,
- * device types, classes and bus types.  They are the subsystem-level callbacks
- * supposed to execute callbacks provided by device drivers, although they may
- * choose not to do that.  If the driver callbacks are executed, they have to
- * collaborate with the subsystem-level callbacks to achieve the goals
- * appropriate for the given system transition, given transition phase and the
- * subsystem the device belongs to.
+ * struct dev_pm_ops - device PM callbacks.
  *
  * @prepare: The principal role of this callback is to prevent new children of
  *	the device from being registered after it has returned (the driver's
@@ -240,34 +223,6 @@ typedef struct pm_message {
  *	driver's interrupt handler, which is guaranteed not to run while
  *	@restore_noirq() is being executed.  Analogous to @resume_noirq().
  *
- * All of the above callbacks, except for @complete(), return error codes.
- * However, the error codes returned by the resume operations, @resume(),
- * @thaw(), @restore(), @resume_noirq(), @thaw_noirq(), and @restore_noirq(), do
- * not cause the PM core to abort the resume transition during which they are
- * returned.  The error codes returned in those cases are only printed by the PM
- * core to the system logs for debugging purposes.  Still, it is recommended
- * that drivers only return error codes from their resume methods in case of an
- * unrecoverable failure (i.e. when the device being handled refuses to resume
- * and becomes unusable) to allow us to modify the PM core in the future, so
- * that it can avoid attempting to handle devices that failed to resume and
- * their children.
- *
- * It is allowed to unregister devices while the above callbacks are being
- * executed.  However, a callback routine must NOT try to unregister the device
- * it was called for, although it may unregister children of that device (for
- * example, if it detects that a child was unplugged while the system was
- * asleep).
- *
- * Refer to Documentation/power/admin-guide/devices.rst for more information about the role
- * of the above callbacks in the system suspend process.
- *
- * There also are callbacks related to runtime power management of devices.
- * Again, these callbacks are executed by the PM core only for subsystems
- * (PM domains, device types, classes and bus types) and the subsystem-level
- * callbacks are supposed to invoke the driver callbacks.  Moreover, the exact
- * actions to be performed by a device driver's callbacks generally depend on
- * the platform and subsystem the device belongs to.
- *
  * @runtime_suspend: Prepare the device for a condition in which it won't be
  *	able to communicate with the CPU(s) and RAM due to power management.
  *	This need not mean that the device should be put into a low-power state.
@@ -287,11 +242,54 @@ typedef struct pm_message {
  *	Check these conditions, and return 0 if it's appropriate to let the PM
  *	core queue a suspend request for the device.
  *
- * Refer to Documentation/power/runtime_pm.txt for more information about the
- * role of the above callbacks in device runtime power management.
+ * Several device power state transitions are externally visible, affecting
+ * the state of pending I/O queues and (for drivers that touch hardware)
+ * interrupts, wakeups, DMA, and other hardware state.  There may also be
+ * internal transitions to various low-power modes which are transparent
+ * to the rest of the driver stack (such as a driver that's ON gating off
+ * clocks which are not in active use).
+ *
+ * The externally visible transitions are handled with the help of callbacks
+ * included in this structure in such a way that, typically, two levels of
+ * callbacks are involved.  First, the PM core executes callbacks provided by PM
+ * domains, device types, classes and bus types.  They are the subsystem-level
+ * callbacks expected to execute callbacks provided by device drivers, although
+ * they may choose not to do that.  If the driver callbacks are executed, they
+ * have to collaborate with the subsystem-level callbacks to achieve the goals
+ * appropriate for the given system transition, given transition phase and the
+ * subsystem the device belongs to.
+ *
+ * All of the above callbacks, except for @complete(), return error codes.
+ * However, the error codes returned by @resume(), @thaw(), @restore(),
+ * @resume_noirq(), @thaw_noirq(), and @restore_noirq(), do not cause the PM
+ * core to abort the resume transition during which they are returned.  The
+ * error codes returned in those cases are only printed to the system logs for
+ * debugging purposes.  Still, it is recommended that drivers only return error
+ * codes from their resume methods in case of an unrecoverable failure (i.e.
+ * when the device being handled refuses to resume and becomes unusable) to
+ * allow the PM core to be modified in the future, so that it can avoid
+ * attempting to handle devices that failed to resume and their children.
  *
+ * It is allowed to unregister devices while the above callbacks are being
+ * executed.  However, a callback routine MUST NOT try to unregister the device
+ * it was called for, although it may unregister children of that device (for
+ * example, if it detects that a child was unplugged while the system was
+ * asleep).
+ *
+ * Refer to Documentation/power/devices.txt for more information about the role
+ * of the above callbacks in the system suspend process.
+ *
+ * There also are callbacks related to runtime power management of devices.
+ * Again, as a rule these callbacks are executed by the PM core for subsystems
+ * (PM domains, device types, classes and bus types) and the subsystem-level
+ * callbacks are expected to invoke the driver callbacks.  Moreover, the exact
+ * actions to be performed by a device driver's callbacks generally depend on
+ * the platform and subsystem the device belongs to.
+ *
+ * Refer to Documentation/power/runtime_pm.txt for more information about the
+ * role of the @runtime_suspend(), @runtime_resume() and @runtime_idle()
+ * callbacks in device runtime power management.
  */
-
 struct dev_pm_ops {
 	int (*prepare)(struct device *dev);
 	void (*complete)(struct device *dev);
@@ -391,7 +389,7 @@ const struct dev_pm_ops name = { \
 	SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 }
 
-/**
+/*
  * PM_EVENT_ messages
  *
  * The following PM_EVENT_ messages are defined for the internal use of the PM

