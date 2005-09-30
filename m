From: Alan Stern <stern@rowland.harvard.edu>
Subject: [RFC 1/3] Runtime PM support for named power states
Date: Fri, 30 Sep 2005 16:16:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509301614340.4470-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============023841877540776935=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============023841877540776935==
Content-Type: TEXT/PLAIN; charset=US-ASCII

This patch adds support for named power states to the PM core.  The new 
runtime states exist in an uneasy truce with the old FREEZE and SUSPEND 
system states.

Alan Stern



Index: usb-2.6/Documentation/power/devices.txt
===================================================================
--- usb-2.6.orig/Documentation/power/devices.txt
+++ usb-2.6/Documentation/power/devices.txt
@@ -1,4 +1,3 @@
-
 Device Power Management
 
 
@@ -80,25 +79,51 @@ used, and can offer significant power sa
 In each device's directory, there is a 'power' directory, which
 contains at least a 'state' file. Reading from this file displays what
 power state the device is currently in. Writing to this file initiates
-a transition to the specified power state, which must be a decimal in
-the range 1-3, inclusive; or 0 for 'On'.
+a transition to the specified power state.
 
-The PM core will call the ->suspend() method in the bus_type object
-that the device belongs to if the specified state is not 0, or
-->resume() if it is. 
+There are two separate runtime interfaces available.  The first is
+kept for backward compatibility, and the second is recommended for
+drivers that are runtime-PM-aware.
+
+With the first interface, the new state can be given as a decimal
+number in the range 1-3, or 0 for 'On'. The PM core will call the
+->suspend() method in the bus_type object that the device belongs to
+if the specified state is not 0, or ->resume() if it is. The state
+number will be passed to the ->suspend() method as the .event field of
+a pm_message_t.
 
 Nothing will happen if the specified state is the same state the
-device is currently in. 
+device is currently in. If the device is already in a low-power
+state, and the specified state is another, but different, low-power
+state, the ->resume() method will first be called to power the device
+back on, then ->suspend() will be called again with the new state.
+
+With the second interface, drivers will define an array of supported
+states for each device. Each entry in the array is merely a character
+string. For example, a PCI device might support ["D0", "D1", "D3hot"].
+The first entry in the array must be the default or full-power state.
+Writing the name of one of these entries to the 'state' file initiates
+a transition to the specified state. The .event field will be set to
+PM_EVENT_RUNTIME and the .name field will contain a pointer to the array
+entry.
+
+In addition, drivers will indicate a particular state array entry
+which will correspond to the generic name "suspend". Thus the user
+will be able to type "echo suspend >/sys/.../power/state" and this
+will cause the device to enter the driver-chosen suspend state. Also,
+"on" will always be accepted as an alias for the first entry in the
+array. Note that if the state array has less than two entries it
+indicates that the device does not support runtime power management.
 
-If the device is already in a low-power state, and the specified state
-is another, but different, low-power state, the ->resume() method will
-first be called to power the device back on, then ->suspend() will be
-called again with the new state. 
-
-The driver is responsible for saving the working state of the device
-and putting it into the low-power state specified. If this was
-successful, it returns 0, and the device's power_state field is
-updated. 
+Nothing will happen if the specified state is the same state the
+device is currently in. If the device is already in a different
+low-power state from the one requested by the user, the ->resume()
+method will _not_ be called first.
+
+With both interfaces, the driver is responsible for saving the working
+state of the device and putting it into the low-power state
+specified. If this was successful, it returns 0, and the device's
+power_state field is updated.
 
 The driver must take care to know whether or not it is able to
 properly resume the device, including all step of reinitialization
@@ -115,114 +140,22 @@ return -EAGAIN (as it would during a sys
 transition),  but it will _not_ be called again, and the transaction
 will fail.
 
-There is currently no way to know what states a device or driver
-supports a priori. This will change in the future. 
-
-pm_message_t meaning
-
-pm_message_t has two fields. event ("major"), and flags.  If driver
-does not know event code, it aborts the request, returning error. Some
-drivers may need to deal with special cases based on the actual type
-of suspend operation being done at the system level. This is why
-there are flags.
-
-Event codes are:
-
-ON -- no need to do anything except special cases like broken
-HW.
-
-# NOTIFICATION -- pretty much same as ON?
-
-FREEZE -- stop DMA and interrupts, and be prepared to reinit HW from
-scratch. That probably means stop accepting upstream requests, the
-actual policy of what to do with them beeing specific to a given
-driver. It's acceptable for a network driver to just drop packets
-while a block driver is expected to block the queue so no request is
-lost. (Use IDE as an example on how to do that). FREEZE requires no
-power state change, and it's expected for drivers to be able to
-quickly transition back to operating state.
-
-SUSPEND -- like FREEZE, but also put hardware into low-power state. If
-there's need to distinguish several levels of sleep, additional flag
-is probably best way to do that.
-
-Transitions are only from a resumed state to a suspended state, never
-between 2 suspended states. (ON -> FREEZE or ON -> SUSPEND can happen,
-FREEZE -> SUSPEND or SUSPEND -> FREEZE can not).
-
-All events are:
-
-[NOTE NOTE NOTE: If you are driver author, you should not care; you
-should only look at event, and ignore flags.]
-
-#Prepare for suspend -- userland is still running but we are going to
-#enter suspend state. This gives drivers chance to load firmware from
-#disk and store it in memory, or do other activities taht require
-#operating userland, ability to kmalloc GFP_KERNEL, etc... All of these
-#are forbiden once the suspend dance is started.. event = ON, flags =
-#PREPARE_TO_SUSPEND
-
-Apm standby -- prepare for APM event. Quiesce devices to make life
-easier for APM BIOS. event = FREEZE, flags = APM_STANDBY
-
-Apm suspend -- same as APM_STANDBY, but it we should probably avoid
-spinning down disks. event = FREEZE, flags = APM_SUSPEND
-
-System halt, reboot -- quiesce devices to make life easier for BIOS. event
-= FREEZE, flags = SYSTEM_HALT or SYSTEM_REBOOT
-
-System shutdown -- at least disks need to be spun down, or data may be
-lost. Quiesce devices, just to make life easier for BIOS. event =
-FREEZE, flags = SYSTEM_SHUTDOWN
-
-Kexec    -- turn off DMAs and put hardware into some state where new
-kernel can take over. event = FREEZE, flags = KEXEC
-
-Powerdown at end of swsusp -- very similar to SYSTEM_SHUTDOWN, except wake
-may need to be enabled on some devices. This actually has at least 3
-subtypes, system can reboot, enter S4 and enter S5 at the end of
-swsusp. event = FREEZE, flags = SWSUSP and one of SYSTEM_REBOOT,
-SYSTEM_SHUTDOWN, SYSTEM_S4
-
-Suspend to ram  -- put devices into low power state. event = SUSPEND,
-flags = SUSPEND_TO_RAM
-
-Freeze for swsusp snapshot -- stop DMA and interrupts. No need to put
-devices into low power mode, but you must be able to reinitialize
-device from scratch in resume method. This has two flavors, its done
-once on suspending kernel, once on resuming kernel. event = FREEZE,
-flags = DURING_SUSPEND or DURING_RESUME
-
-Device detach requested from /sys -- deinitialize device; proably same as
-SYSTEM_SHUTDOWN, I do not understand this one too much. probably event
-= FREEZE, flags = DEV_DETACH.
-
-#These are not really events sent:
-#
-#System fully on -- device is working normally; this is probably never
-#passed to suspend() method... event = ON, flags = 0
-#
-#Ready after resume -- userland is now running, again. Time to free any
-#memory you ate during prepare to suspend... event = ON, flags =
-#READY_AFTER_RESUME
-#
-
-
 pm_message_t meaning
 
-pm_message_t has two fields. event ("major"), and flags.  If driver
-does not know event code, it aborts the request, returning error. Some
-drivers may need to deal with special cases based on the actual type
-of suspend operation being done at the system level. This is why
-there are flags.
+pm_message_t has two fields: .event ("major") and .name.  In the future
+a third field, .flags, may be added. If a driver does not know the
+.event code, it aborts the request, returning an error. Some drivers
+may need to deal with special cases based on the actual type of
+suspend operation being done at the system level. This is why there
+is .flags. At present the .name field is used only for RUNTIME events;
+perhaps later it will take on the role currently planned for .flags in
+system power events.
 
 Event codes are:
 
 ON -- no need to do anything except special cases like broken
 HW.
 
-# NOTIFICATION -- pretty much same as ON?
-
 FREEZE -- stop DMA and interrupts, and be prepared to reinit HW from
 scratch. That probably means stop accepting upstream requests, the
 actual policy of what to do with them being specific to a given
@@ -236,6 +169,9 @@ SUSPEND -- like FREEZE, but also put har
 there's need to distinguish several levels of sleep, additional flag
 is probably best way to do that.
 
+RUNTIME -- like SUSPEND, but with a pointer to the desired state array
+entry passed in the .name field.
+
 Transitions are only from a resumed state to a suspended state, never
 between 2 suspended states. (ON -> FREEZE or ON -> SUSPEND can happen,
 FREEZE -> SUSPEND or SUSPEND -> FREEZE can not).
@@ -243,7 +179,7 @@ FREEZE -> SUSPEND or SUSPEND -> FREEZE c
 All events are:
 
 [NOTE NOTE NOTE: If you are driver author, you should not care; you
-should only look at event, and ignore flags.]
+should only look at event and name, and ignore flags.]
 
 #Prepare for suspend -- userland is still running but we are going to
 #enter suspend state. This gives drivers chance to load firmware from
@@ -283,9 +219,12 @@ device from scratch in resume method. Th
 once on suspending kernel, once on resuming kernel. event = FREEZE,
 flags = DURING_SUSPEND or DURING_RESUME
 
-Device detach requested from /sys -- deinitialize device; proably same as
-SYSTEM_SHUTDOWN, I do not understand this one too much. probably event
-= FREEZE, flags = DEV_DETACH.
+User-specified state written to sysfs -- go to the requested state, if
+possible. Drivers may need to check first that all the device's
+children have already been suspended. Drivers should also notify the
+device's parent's driver about the state change, using a bus- or
+driver-specific mechanism. event = RUNTIME, name = state array entry
+value.
 
 #These are not really events sent:
 #
Index: usb-2.6/include/linux/pm.h
===================================================================
--- usb-2.6.orig/include/linux/pm.h
+++ usb-2.6/include/linux/pm.h
@@ -188,13 +188,14 @@ struct device;
 
 typedef struct pm_message {
 	int event;
+	const char *name;
 } pm_message_t;
 
 /*
- * There are 4 important states driver can be in:
- * ON     -- driver is working
+ * There are 3 important "system" states devices can be in:
+ * ON     -- device is working
  * FREEZE -- stop operations and apply whatever policy is applicable to a
- *           suspended driver of that class, freeze queues for block like IDE
+ *           suspended device of that class, freeze queues for block like IDE
  *           does, drop packets for ethernet, etc... stop DMA engine too etc...
  *           so a consistent image can be saved; but do not power any hardware
  *           down.
@@ -202,16 +203,17 @@ typedef struct pm_message {
  *           possible. Roughly pci D3.
  *
  * Unfortunately, current drivers only recognize numeric values 0 (ON) and 3
- * (SUSPEND).  We'll need to fix the drivers. So yes, putting 3 to all different
- * defines is intentional, and will go away as soon as drivers are fixed.  Also
- * note that typedef is neccessary, we'll probably want to switch to
- *   typedef struct pm_message_t { int event; int flags; } pm_message_t
- * or something similar soon.
+ * (SUSPEND).  We'll need to fix the drivers.
+ *
+ * For runtime-PM-aware drivers, the PM_EVENT_RUNTIME value signifies a
+ * state change caused by the user writing to a sysfs attribute.  The
+ * requested target state is stored in the .name field.
  */
 
 #define PM_EVENT_ON 0
 #define PM_EVENT_FREEZE 1
-#define PM_EVENT_SUSPEND 2
+#define PM_EVENT_SUSPEND 3
+#define PM_EVENT_RUNTIME 4
 
 #define PMSG_FREEZE	((struct pm_message){ .event = PM_EVENT_FREEZE, })
 #define PMSG_SUSPEND	((struct pm_message){ .event = PM_EVENT_SUSPEND, })
@@ -219,6 +221,8 @@ typedef struct pm_message {
 
 struct dev_pm_info {
 	pm_message_t		power_state;
+	const char		* suspend_name;
+	const char		** states;
 	unsigned		can_wakeup:1;
 #ifdef	CONFIG_PM
 	unsigned		should_wakeup:1;
@@ -229,6 +233,28 @@ struct dev_pm_info {
 #endif
 };
 
+/*
+ * The .states field above points to a null-terminated array of names of
+ * states supported by the device.  States are identified by pointers to
+ * names.  Two common state name strings are exported by the PM core:
+ * "on" and "suspend"; drivers should use these strings when possible.
+ *
+ * The first entry in the .states array stands for the default, full-power
+ * state.  If its name isn't "on", the PM core will accept "on" as an
+ * alias for this state.  Other entries refer to various low-power states.
+ *
+ * The .suspend_name field also acts as an alias; it should point to one
+ * of the name strings in the states array if the array doesn't already
+ * include a "suspend" entry.  This mechanism gives the user an easy way
+ * to tell a device to go into its default low-power state.
+ *
+ * If .power_state.event is PM_EVENT_RUNTIME, then .power_state.name
+ * should point to the name string for the current state.
+ *
+ * If .states is NULL or if the array has fewer than two entries, then the
+ * device does not support runtime PM with named states.
+ */
+
 extern void device_pm_set_parent(struct device * dev, struct device * parent);
 
 extern int device_power_down(pm_message_t state);
@@ -243,6 +269,9 @@ extern int device_suspend(pm_message_t s
 #define device_may_wakeup(dev) \
 	(device_can_wakeup(dev) && (dev)->power.should_wakeup)
 
+extern const char pm_name_ON[];
+extern const char pm_name_SUSPEND[];
+
 #else /* !CONFIG_PM */
 
 static inline int device_suspend(pm_message_t state)
@@ -253,6 +282,9 @@ static inline int device_suspend(pm_mess
 #define device_set_wakeup_enable(dev,val)	do{}while(0)
 #define device_may_wakeup(dev)			(0)
 
+#define pm_name_ON		NULL
+#define pm_name_SUSPEND		NULL
+
 #endif
 
 /* changes to device_may_wakeup take effect on the next pm state change.
Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -53,7 +53,7 @@ int dpm_runtime_suspend(struct device * 
 	if (dev->power.power_state.event == state.event)
 		goto Done;
 
-	if (dev->power.power_state.event)
+	if (state.event < PM_EVENT_RUNTIME && dev->power.power_state.event)
 		runtime_resume(dev);
 
 	if (!(error = suspend_device(dev, state)))
Index: usb-2.6/drivers/base/power/sysfs.c
===================================================================
--- usb-2.6.orig/drivers/base/power/sysfs.c
+++ usb-2.6/drivers/base/power/sysfs.c
@@ -3,12 +3,21 @@
  */
 
 #include <linux/device.h>
+#include <linux/string.h>
 #include "power.h"
 
+const char pm_name_ON[] = "on";
+const char pm_name_SUSPEND[] = "suspend";
+EXPORT_SYMBOL_GPL(pm_name_ON);
+EXPORT_SYMBOL_GPL(pm_name_SUSPEND);
+
 
 /**
  *	state - Control current power state of device
  *
+ *	For drivers that do not support runtime PM with named states,
+ *	only the next two paragraphs apply.
+ *
  *	show() returns the current power state of the device. '0' indicates
  *	the device is on. Other values (1-3) indicate the device is in a low
  *	power state.
@@ -22,26 +31,104 @@
  *	If the device is in a low-power state, and a different low-power state
  *	is requested, the device is first resumed, then suspended into the new
  *	low-power state.
+ *
+ *	For drivers that do support runtime PM with named states, the
+ *	remaining text applies.
+ *
+ *	show() displays a list of states supported by the device, one per
+ *	line.  The name "on" also appears as an alias on the first line if
+ *	that's not what the name is already.  The name "suspend" appears
+ *	as an alias on the appropriate line, as defined by the driver.
+ *	The line corresponding to the current state is marked with a "*".
+ *
+ *	For backward compatibility state() will accept an integer value
+ *	between 0-3, as above.  Otherwise it will accept only one of the
+ *	supported state names or aliases (case-insensitive).  If the name
+ *	is the first entry in the states array then ->resume() is called;
+ *	otherwise ->suspend() is called with an event of PM_EVENT_RUNTIME
+ *	and the specified name pointer.  No attempt is made to call
+ *	->resume() first if the device is already in a different low-power
+ *	state.
  */
 
-static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
+static ssize_t state_show(struct device * dev, struct device_attribute *attr,
+		char * buf)
 {
-	return sprintf(buf, "%u\n", dev->power.power_state.event);
+	const char *current_name = NULL;
+	char *buf_save;
+	int first;
+	const char **pname;
+
+	/* Does the driver support named states?  And do we know the name
+	 * of the current state? */
+	if (dev->power.states) {
+		if (dev->power.power_state.event == PM_EVENT_RUNTIME)
+			current_name = dev->power.power_state.name;
+		else if (dev->power.power_state.event == PM_EVENT_ON)
+			current_name = dev->power.states[0];
+	}
+	if (!current_name)
+		return sprintf(buf, "%u\n", dev->power.power_state.event);
+
+	buf_save = buf;
+	first = 1;
+	for (pname = dev->power.states; *pname; ++pname) {
+		buf += sprintf(buf, "%s", *pname);
+		if (first && strcmp(*pname, pm_name_ON) != 0)
+			buf += sprintf(buf, " %s", pm_name_ON);
+		if (!first && *pname == dev->power.suspend_name &&
+				strcmp(*pname, pm_name_SUSPEND) != 0)
+			buf += sprintf(buf, " %s", pm_name_SUSPEND);
+		if (*pname == current_name)
+			buf += sprintf(buf, " *");
+		first = 0;
+		*buf++ = '\n';
+	}
+	return buf - buf_save;
 }
 
-static ssize_t state_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t n)
+static ssize_t state_store(struct device * dev, struct device_attribute *attr,
+		const char * buf, size_t n)
 {
 	pm_message_t state;
 	char * rest;
 	int error = 0;
+	int n2;
+	const char **pname;
 
 	state.event = simple_strtoul(buf, &rest, 10);
-	if (*rest)
-		return -EINVAL;
-	if (state.event)
-		error = dpm_runtime_suspend(dev, state);
-	else
-		dpm_runtime_resume(dev);
+	state.name = NULL;
+	if ((!*rest || *rest == '\n') && state.event < PM_EVENT_RUNTIME) {
+		if (state.event)
+			error = dpm_runtime_suspend(dev, state);
+		else
+			dpm_runtime_resume(dev);
+
+	} else {
+		n2 = n;
+		if (n > 0 && buf[n-1] == '\n')
+			--n2;
+		for (pname = dev->power.states; *pname; ++pname) {
+			if (strnicmp(buf, *pname, n2) == 0 && !(*pname)[n2])
+				break;
+		}
+		if (*pname)
+			;
+		else if (n2 == 2 && strnicmp(buf, pm_name_ON, n2) == 0)
+			pname = &dev->power.states[0];
+		else if (dev->power.suspend_name && n2 == 7 &&
+				strnicmp(buf, pm_name_SUSPEND, n2) == 0)
+			pname = &dev->power.suspend_name;
+		else
+			return -EINVAL;
+
+		state.event = PM_EVENT_RUNTIME;
+		state.name = *pname;
+		if (pname != &dev->power.states[0])
+			error = dpm_runtime_suspend(dev, state);
+		else
+			dpm_runtime_resume(dev);
+	}
 	return error ? error : n;
 }
 


--===============023841877540776935==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============023841877540776935==--
