From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.13-rc5] driver model wakeup support
Date: Tue, 2 Aug 2005 15:26:11 -0700
Message-ID: <200508021526.12073.david-b@pacbell.net>
References: <200505081724.09468.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EM/7Cku9a0REOhu"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505081724.09468.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_EM/7Cku9a0REOhu
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's a refresh of my driver model wakeup patch.  Two
changes from last time:

  - It sets up USB too, not just PCI.  So keyboards and hubs,
    plus a few network adapters, will have these attributes.

  - Only devices that are known to have wakeup capabilities
    have the attribute.   So "find /sys/devices -name wakeup"
    returns only "interesting" devices.

At this time, wakeup mechanisms need to be explicitly enabled
in userspace code; so this is in a sense a policy setting API
affecting runtime (and suspend-to-ram time) device-specific PM.

There will be some usbcore changes to follow this, assuming
this gets on the 2.6.14 train ... replacing current kluges.

Please merge...

- Dave


--Boundary-00=_EM/7Cku9a0REOhu
Content-Type: text/x-diff;
  charset="us-ascii";
  name="wake-0423.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="wake-0423.patch"

This is a refresh of an earlier patch to add "wakeup" support to
to the PM-core model:

  * "struct device_pm_info" has two bits that are initialized as
    part of setting up the enclosing struct device:
      - "can_wakeup", reflecting hardware capabilities
      - "may_wakeup", the policy setting (when CONFIG_PM)

  * There's a writeable sysfs "wakeup" file, with one of two values:
      - "enabled", when the policy is to allow wakeup 
      - "disabled", when the policy is not to allow it
    The file is nonexistent when the device doesn't support wakeup.

  * this patch includes support to initialize these bits for devices
    that support PCI PM, or USB configurations handle remote wakeup.

Thing of it as providing one policy control knob affecting a driver.
In the future there may be others, with the overall device specific
policy satisfying several constraints defined from userspace.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- g26.orig/include/linux/pm.h	2005-08-02 07:58:25.000000000 -0700
+++ g26/include/linux/pm.h	2005-08-02 07:58:27.000000000 -0700
@@ -213,7 +213,9 @@ typedef u32 __bitwise pm_message_t;
 
 struct dev_pm_info {
 	pm_message_t		power_state;
+	unsigned		can_wakeup:1;
 #ifdef	CONFIG_PM
+	unsigned		should_wakeup:1;
 	pm_message_t		prev_state;
 	void			* saved_state;
 	atomic_t		pm_users;
@@ -228,13 +230,30 @@ extern int device_power_down(pm_message_
 extern void device_power_up(void);
 extern void device_resume(void);
 
+/* wakeup changes take effect on device's next pm state change */
+#define device_init_wakeup(dev,val) \
+	((dev)->power.can_wakeup = !!(val),((dev)->power.should_wakeup = 0))
+#define device_can_wakeup(dev) \
+	((dev)->power.can_wakeup)
+
 #ifdef CONFIG_PM
 extern int device_suspend(pm_message_t state);
-#else
+
+#define device_set_wakeup_enable(dev,val) \
+	((dev)->power.should_wakeup = (dev)->power.can_wakeup ? !!(val) : 0)
+#define device_may_wakeup(dev) \
+	(device_can_wakeup(dev) && (dev)->power.should_wakeup)
+
+#else /* !CONFIG_PM */
+
 static inline int device_suspend(pm_message_t state)
 {
 	return 0;
 }
+
+#define device_set_wakeup_enable(dev,val)	do{}while(0)
+#define device_may_wakeup(dev)			(0)
+
 #endif
 
 #endif /* __KERNEL__ */
--- g26.orig/drivers/base/core.c	2005-08-02 07:58:25.000000000 -0700
+++ g26/drivers/base/core.c	2005-08-02 07:58:27.000000000 -0700
@@ -207,6 +207,7 @@ void device_initialize(struct device *de
 {
 	kobj_set_kset_s(dev, devices_subsys);
 	kobject_init(&dev->kobj);
+	device_init_wakeup(dev, 0);
 	klist_init(&dev->klist_children);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	init_MUTEX(&dev->sem);
--- g26.orig/drivers/base/power/sysfs.c	2005-08-02 07:58:25.000000000 -0700
+++ g26/drivers/base/power/sysfs.c	2005-08-02 07:58:27.000000000 -0700
@@ -48,6 +48,75 @@ static ssize_t state_store(struct device
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
+ *	respecting the policy choices provided through the driver model.
+ *
+ *	Devices may not be able to generate wakeup events from all power
+ *	states.  Also, the events may be ignored in some configurations;
+ *	for example, they might need help from other devices that aren't
+ *	active, or which may have wakeup disabled.  Some drivers rely on
+ *	wakeup events internally (unless they are disabled), keeping
+ *	their hardware in low power modes whenever they're unused.  This
+ *	saves runtime power, without requiring system-wide sleep states.
+ */
+
+static const char enabled[] = "enabled";
+static const char disabled[] = "disabled";
+
+static ssize_t
+wake_show(struct device * dev, struct device_attribute *attr, char * buf)
+{
+	return sprintf(buf, "%s\n", device_can_wakeup(dev)
+		? (device_may_wakeup(dev) ? enabled : disabled)
+		: "");
+}
+
+static ssize_t
+wake_store(struct device * dev, struct device_attribute *attr,
+	const char * buf, size_t n)
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
 	NULL,
@@ -57,12 +126,29 @@ static struct attribute_group pm_attr_gr
 	.attrs	= power_attrs,
 };
 
+static struct attribute *wake_attrs[] = {
+	&dev_attr_state.attr,
+	/* same as "power" ... but adds "wakeup" */
+	&dev_attr_wakeup.attr,
+	NULL,
+};
+static struct attribute_group wake_attr_group = {
+	.name	= "power",
+	.attrs	= wake_attrs,
+};
+
 int dpm_sysfs_add(struct device * dev)
 {
-	return sysfs_create_group(&dev->kobj, &pm_attr_group);
+	if (device_can_wakeup(dev))
+		return sysfs_create_group(&dev->kobj, &wake_attr_group);
+	else
+		return sysfs_create_group(&dev->kobj, &pm_attr_group);
 }
 
 void dpm_sysfs_remove(struct device * dev)
 {
-	sysfs_remove_group(&dev->kobj, &pm_attr_group);
+	if (device_can_wakeup(dev))
+		sysfs_remove_group(&dev->kobj, &wake_attr_group);
+	else
+		sysfs_remove_group(&dev->kobj, &pm_attr_group);
 }
--- g26.orig/drivers/pci/pci.c	2005-08-02 07:58:25.000000000 -0700
+++ g26/drivers/pci/pci.c	2005-08-02 07:58:27.000000000 -0700
@@ -476,6 +476,10 @@ int pci_enable_wake(struct pci_dev *dev,
 	if (!pm) 
 		return enable ? -EIO : 0; 
 
+	/* don't enable unless policy set through driver core allows it */
+	if (!device_may_wakeup(&dev->dev) && enable)
+		return -EROFS;
+
 	/* Check device's ability to generate PME# */
 	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
 
--- g26.orig/drivers/pci/probe.c	2005-08-02 07:58:25.000000000 -0700
+++ g26/drivers/pci/probe.c	2005-08-02 07:58:27.000000000 -0700
@@ -571,6 +571,7 @@ static void pci_read_irq(struct pci_dev 
 static int pci_setup_device(struct pci_dev * dev)
 {
 	u32 class;
+	u16 pm;
 
 	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
 		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
@@ -630,6 +631,14 @@ static int pci_setup_device(struct pci_d
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
@@ -749,11 +758,11 @@ pci_scan_device(struct pci_bus *bus, int
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
 
--- g26.orig/drivers/usb/core/message.c	2005-08-02 07:58:25.000000000 -0700
+++ g26/drivers/usb/core/message.c	2005-08-02 07:58:27.000000000 -0700
@@ -1398,6 +1398,8 @@ free_interfaces:
 				 dev->bus->busnum, dev->devpath,
 				 configuration,
 				 alt->desc.bInterfaceNumber);
+			if (cp->desc.bmAttributes & USB_CONFIG_ATT_WAKEUP)
+				device_init_wakeup(&intf->dev, 1);
 		}
 		kfree(new_interfaces);
 

--Boundary-00=_EM/7Cku9a0REOhu
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_EM/7Cku9a0REOhu--
