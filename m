From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.12-rc4] driver model wakeup support
Date: Sun, 8 May 2005 17:24:09 -0700
Message-ID: <200505081724.09468.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_p2qfCHQBNys3jFo"
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_p2qfCHQBNys3jFo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is a refresh of a patch I sent before.  I suspect it'd be
appropriate to merge this, given the agreement I thought I
heard last time I posted it.

Follow-on patches would update other subsystems to use this:

  * USB, replacing existing HCD support, when activating
    configurations that support remote wakeup, and when
    deciding whether to activate remote wakeup for a device
    as it's being suspended;

  * ACPI, since there's a table flagging devices that can
    support wakeup, and that info is basically invisible
    to the drivers for those devices (unless the device
    also supports PCI PM);

  * Networking, where I suspect the "ethtool" commands to
    set wake-on-LAN should update the "may_wakeup" bit

  * ... and surely more; this after all only affects the
    policy applying to a device wakeup, it doesn't do
    anything to have wakeup actually work on the hardware.

The main thing I dislike about this patch is that it always
creates the sysfs attribute, even for devices for which it's
meaningful.  That should be fixable by just adding the
attributes one-at-a-time. 

- Dave


--Boundary-00=_p2qfCHQBNys3jFo
Content-Type: text/x-diff;
  charset="us-ascii";
  name="wake-0423.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="wake-0423.patch"

This is a refresh of an earlier patch to add "wakeup" support to
to the PM-core model:

  * struct device_pm_info has two bits that are initialized as
    part of setting up the enclosing struct device:
      - "can_wakeup", reflecting system hardware capabilities
      - "may_wakeup", the policy setting (when CONFIG_PM)

  * there's a writeable sysfs "wakeup" file, with one of three values:
      - "enabled", when the policy is to allow wakeup 
      - "disabled", when the policy is not to allow it
      - "" (empty string), when the hardware doesn't support wakeup

  * this patch includes support to initialize these bits for devices
    that support PCI PM.

It would be preferable to not have the attribute for devices that aren't
wired with wakeup support, but that'd involve extra sysfs magic.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- g26.orig/drivers/base/core.c	2005-05-07 08:27:18.000000000 -0700
+++ g26/drivers/base/core.c	2005-05-08 17:04:27.000000000 -0700
@@ -210,6 +210,7 @@
 {
 	kobj_set_kset_s(dev, devices_subsys);
 	kobject_init(&dev->kobj);
+	device_init_wakeup(dev, 0);
 	INIT_LIST_HEAD(&dev->node);
 	INIT_LIST_HEAD(&dev->children);
 	INIT_LIST_HEAD(&dev->driver_list);
--- g26.orig/drivers/base/power/sysfs.c	2005-05-07 08:27:18.000000000 -0700
+++ g26/drivers/base/power/sysfs.c	2005-05-08 17:04:27.000000000 -0700
@@ -48,8 +48,75 @@
 static DEVICE_ATTR(state, 0644, state_show, state_store);
 
 
+/*
+ *	wakeup - Report/change current wakeup option for device
+ *
+ *	Some devices support "wakeup" events, which are hardware signals
+ *	used to activate devices from suspended or low power states.  Such
+ *	devices have one of two wakeup options:  "enabled" to issue the
+ *	events, otherwise "disabled".  The value is effective at the next
+ *	system or device power state change.  (Devices that don't support
+ *	wakeup events have no value for this option.)
+ *
+ *	Familiar examples of devices that can issue wakeup events include
+ *	keyboards and mice (both PS2 and USB styles), power buttons, modems,
+ *	"Wake-On-LAN" Ethernet links, GPIO lines, and more.  Some events
+ *	will wake the entire system from a suspend state; others may just
+ *	wake up the device (if the system as a whole is already active).
+ *	Some wakeup events use normal IRQ lines; other use special out
+ *	of band signaling.
+ *
+ *	It is the responsibility of device drivers to enable (or disable)
+ *	wakeup signaling as part of changing system or device power states,
+ *	respecting the policy choice provided through the driver model.
+ *
+ *	Devices may not be able to generate wakeup events from all power
+ *	states.  Also, the events may be ignored in some configurations;
+ *	for example, they might need help from other devices that aren't
+ *	active, or which may have wakeup disabled.  Some drivers rely on
+ *	wakeup events internally, unless they are disabled; this lets them
+ *	keep their hardware in low power modes whenever they're unused,
+ *	even without entering a system-wide sleep state.
+ */
+
+static const char enabled[] = "enabled";
+static const char disabled[] = "disabled";
+
+static ssize_t wake_show(struct device * dev, char * buf)
+{
+	return sprintf(buf, "%s\n", device_can_wakeup(dev)
+		? (device_may_wakeup(dev) ? enabled : disabled)
+		: "");
+}
+
+static ssize_t wake_store(struct device * dev, const char * buf, size_t n)
+{
+	char *cp;
+	int len = n;
+
+	if (!device_can_wakeup(dev))
+		return -EINVAL;
+
+	cp = memchr(buf, '\n', n);
+	if (cp)
+		len = cp - buf;
+	if (len == sizeof enabled - 1
+			&& strncmp(buf, enabled, sizeof enabled - 1) == 0)
+		device_set_wakeup_enable(dev, 1);
+	else if (len == sizeof disabled - 1
+			&& strncmp(buf, disabled, sizeof disabled - 1) == 0)
+		device_set_wakeup_enable(dev, 0);
+	else
+		return -EINVAL;
+	return n;
+}
+
+static DEVICE_ATTR(wakeup, 0644, wake_show, wake_store);
+
+
 static struct attribute * power_attrs[] = {
 	&dev_attr_state.attr,
+	&dev_attr_wakeup.attr,
 	NULL,
 };
 static struct attribute_group pm_attr_group = {
--- g26.orig/drivers/pci/pci.c	2005-05-07 08:27:44.000000000 -0700
+++ g26/drivers/pci/pci.c	2005-05-08 17:04:27.000000000 -0700
@@ -466,6 +466,10 @@
 	if (!pm) 
 		return enable ? -EIO : 0; 
 
+	/* don't enable unless policy set through driver core allows it */
+	if (!device_may_wakeup(&dev->dev) && enable)
+		return -EROFS;
+
 	/* Check device's ability to generate PME# */
 	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
 
--- g26.orig/drivers/pci/probe.c	2005-05-07 08:27:44.000000000 -0700
+++ g26/drivers/pci/probe.c	2005-05-08 17:04:27.000000000 -0700
@@ -544,6 +544,7 @@
 static int pci_setup_device(struct pci_dev * dev)
 {
 	u32 class;
+	u16 pm;
 
 	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
 		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
@@ -603,6 +604,14 @@
 		dev->class = PCI_CLASS_NOT_DEFINED;
 	}
 
+	/* with PCI PM capability, it can maybe issue PME# */
+	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (pm) {
+		pci_read_config_word(dev, pm + PCI_PM_PMC, &pm);
+		if (pm & PCI_PM_CAP_PME)
+			device_init_wakeup(&dev->dev, 1);
+	}
+
 	/* We found a fine healthy device, go go go... */
 	return 0;
 }
@@ -722,11 +731,11 @@
 	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
 	   set this higher, assuming the system even supports it.  */
 	dev->dma_mask = 0xffffffff;
+	device_initialize(&dev->dev);
 	if (pci_setup_device(dev) < 0) {
 		kfree(dev);
 		return NULL;
 	}
-	device_initialize(&dev->dev);
 	dev->dev.release = pci_release_dev;
 	pci_dev_get(dev);
 
--- g26.orig/include/linux/pm.h	2005-05-07 08:28:20.000000000 -0700
+++ g26/include/linux/pm.h	2005-05-08 17:04:27.000000000 -0700
@@ -211,7 +211,9 @@
 
 struct dev_pm_info {
 	pm_message_t		power_state;
+	unsigned		can_wakeup:1;
 #ifdef	CONFIG_PM
+	unsigned		should_wakeup:1;
 	pm_message_t		prev_state;
 	void			* saved_state;
 	atomic_t		pm_users;
@@ -227,6 +229,22 @@
 extern void device_power_up(void);
 extern void device_resume(void);
 
+/* wakeup changes take effect on device's next pm state change */
+#define device_init_wakeup(dev,val) \
+	((dev)->power.can_wakeup = !!(val),((dev)->power.should_wakeup = 0))
+#define device_can_wakeup(dev) \
+	((dev)->power.can_wakeup)
+
+#ifdef CONFIG_PM
+#define device_set_wakeup_enable(dev,val) \
+	((dev)->power.should_wakeup = (dev)->power.can_wakeup ? !!(val) : 0)
+#define device_may_wakeup(dev) \
+	(device_can_wakeup(dev) && (dev)->power.should_wakeup)
+
+#else /* !CONFIG_PM */
+#define device_set_wakeup_enable(dev,val)	do()while(0)
+#define device_may_wakeup(dev)			(0)
+#endif
 
 #endif /* __KERNEL__ */
 

--Boundary-00=_p2qfCHQBNys3jFo
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_p2qfCHQBNys3jFo--
