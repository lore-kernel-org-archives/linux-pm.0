From: Alan Stern <stern@rowland.harvard.edu>
Subject: [RFC 2/3] Runtime PM support for named power states
Date: Fri, 30 Sep 2005 16:27:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509301616200.4470-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============81600442364226222=="
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

--===============81600442364226222==
Content-Type: TEXT/PLAIN; charset=US-ASCII

This patch adds support for named power states to the PCI core and to the 
PCI USB host controller drivers.  Although the PCI power states will be 
displayed okay for other types of PCI devices, using them for state 
changes won't work -- so don't try it!

Note also that a bug in the EHCI driver will prevent you from suspending
it again immediately after resuming.  ehci_pci_resume calls ehci_run,
which sets hcd->state to HC_STATE_RUNNING, thereby making
usb_hcd_pci_suspend think the root hub is running when it isn't (or at
least, it shouldn't be).

Alan Stern



Index: usb-2.6/drivers/pci/probe.c
===================================================================
--- usb-2.6.orig/drivers/pci/probe.c
+++ usb-2.6/drivers/pci/probe.c
@@ -22,6 +22,54 @@ EXPORT_SYMBOL(pci_root_buses);
 
 LIST_HEAD(pci_devices);
 
+const char pci_name_D0[] = "D0";
+const char pci_name_D1[] = "D1";
+const char pci_name_D2[] = "D2";
+const char pci_name_D3[] = "D3";
+EXPORT_SYMBOL_GPL(pci_name_D0);
+EXPORT_SYMBOL_GPL(pci_name_D1);
+EXPORT_SYMBOL_GPL(pci_name_D2);
+EXPORT_SYMBOL_GPL(pci_name_D3);
+
+
+/**
+ * pci_name_to_state - pointer-based state name to state conversion
+ * @name: state name pointer to convert
+ *
+ * Note: The name string itself is not examined, only the pointer value.
+ * Hence @name must point to one of the four canonical strings above.
+ */
+pci_power_t pci_name_to_state(const char *name)
+{
+	if (name == pci_name_D0)
+		return PCI_D0;
+	else if (name == pci_name_D1)
+		return PCI_D1;
+	else if (name == pci_name_D2)
+		return PCI_D2;
+	else if (name == pci_name_D3)
+		return PCI_D3hot;
+	return PCI_POWER_ERROR;
+}
+EXPORT_SYMBOL_GPL(pci_name_to_state);
+
+/**
+ * pci_state_to_name -- return a static name string for a power state
+ * @state: power state to convert
+ */
+const char *pci_state_to_name(pci_power_t state)
+{
+	static const char *(names[]) = {
+		pci_name_D0, pci_name_D1, pci_name_D2,
+		"D3hot", "D3cold", "Unknown"};
+	int i = (int __force) state;
+
+	if (i < 0 || i >= sizeof(names) / sizeof(names[0]))
+		return "Error";
+	return names[i];
+}
+EXPORT_SYMBOL_GPL(pci_state_to_name);
+
 #ifdef HAVE_PCI_LEGACY
 /**
  * pci_create_legacy_files - create legacy I/O port and memory files
@@ -577,6 +625,42 @@ static void pci_read_irq(struct pci_dev 
 }
 
 /**
+ * pci_setup_device_pm - fill in the PM information of a device
+ * @dev: the device structure to fill
+ *
+ * Initialize the wakeup capability flag and the list of supported states.
+ */
+static void pci_setup_device_pm(struct pci_dev * dev)
+{
+	int pm;
+	u16 pmc;
+	int i = 0;
+
+	dev->states[i] = pci_name_D0;
+
+	/* PCI PM capable devices may be able to issue PME# (wakeup) */
+	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (pm) {
+		pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
+		if (pmc & PCI_PM_CAP_PME_MASK)
+			device_init_wakeup(&dev->dev, 1);
+
+		/* REVISIT: if (pm & PCI_PM_CAP_PME_D3cold) then
+		 * pci pm spec 1.2, section 3.2.4 says we should
+		 * init PCI_PM_CTRL_PME_{STATUS,ENABLE} ...
+		 */
+
+		if (pmc & PCI_PM_CAP_D1)
+			dev->states[++i] = pci_name_D1;
+		if (pmc & PCI_PM_CAP_D2)
+			dev->states[++i] = pci_name_D2;
+		dev->states[++i] = pci_name_D3;
+	}
+	dev->dev.power.suspend_name = dev->states[i];
+	dev->dev.power.states = dev->states;
+}
+
+/**
  * pci_setup_device - fill in class and map information of a device
  * @dev: the device structure to fill
  *
@@ -589,7 +673,6 @@ static void pci_read_irq(struct pci_dev 
 static int pci_setup_device(struct pci_dev * dev)
 {
 	u32 class;
-	u16 pm;
 
 	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
 		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
@@ -617,19 +700,7 @@ static int pci_setup_device(struct pci_d
 		pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
 		pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
 		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
-
-		/* PCI PM capable devices may be able to issue PME# (wakeup) */
-		pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-		if (pm) {
-			pci_read_config_word(dev, pm + PCI_PM_PMC, &pm);
-			if (pm & PCI_PM_CAP_PME_MASK)
-				device_init_wakeup(&dev->dev, 1);
-
-			/* REVISIT: if (pm & PCI_PM_CAP_PME_D3cold) then
-			 * pci pm spec 1.2, section 3.2.4 says we should
-			 * init PCI_PM_CTRL_PME_{STATUS,ENABLE} ...
-			 */
-		}
+		pci_setup_device_pm(dev);
 		break;
 
 	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
Index: usb-2.6/include/linux/pci.h
===================================================================
--- usb-2.6.orig/include/linux/pci.h
+++ usb-2.6/include/linux/pci.h
@@ -78,6 +78,14 @@ typedef int __bitwise pci_power_t;
 #define PCI_UNKNOWN	((pci_power_t __force) 5)
 #define PCI_POWER_ERROR	((pci_power_t __force) -1)
 
+extern const char pci_name_D0[];
+extern const char pci_name_D1[];
+extern const char pci_name_D2[];
+extern const char pci_name_D3[];
+
+extern pci_power_t pci_name_to_state(const char *name);
+extern const char *pci_state_to_name(pci_power_t state);
+
 /*
  * The pci_dev structure is used to describe PCI devices.
  */
@@ -109,6 +117,7 @@ struct pci_dev {
 	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
+	const char	*(states[5]);	/* Names for supported states */
 
 	struct	device	dev;		/* Generic device interface */
 
Index: usb-2.6/drivers/usb/core/hcd-pci.c
===================================================================
--- usb-2.6.orig/drivers/usb/core/hcd-pci.c
+++ usb-2.6/drivers/usb/core/hcd-pci.c
@@ -196,6 +196,7 @@ int usb_hcd_pci_suspend (struct pci_dev 
 	struct usb_hcd		*hcd;
 	int			retval = 0;
 	int			has_pci_pm;
+	pci_power_t		level = PCI_D3hot;
 
 	hcd = pci_get_drvdata(dev);
 
@@ -261,19 +262,23 @@ int usb_hcd_pci_suspend (struct pci_dev 
 		 * PCI_D3 (but not PCI_D1 or PCI_D2) is allowed to reset
 		 * some device state (e.g. as part of clock reinit).
 		 */
-		retval = pci_set_power_state (dev, PCI_D3hot);
+		if (message.event == PM_EVENT_RUNTIME)
+			level = pci_name_to_state (message.name);
+		retval = pci_set_power_state (dev, level);
 		if (retval == 0) {
-			dev_dbg (hcd->self.controller, "--> PCI D3\n");
+			dev_dbg (hcd->self.controller, "--> PCI %s\n",
+					pci_state_to_name (level));
 
 			/* Ignore these return values.  We rely on pci code to
 			 * reject requests the hardware can't implement, rather
 			 * than coding the same thing.
 			 */
+			/* FIXME: Do we want these for runtime PM? */
 			(void) pci_enable_wake (dev, PCI_D3hot, hcd->remote_wakeup);
 			(void) pci_enable_wake (dev, PCI_D3cold, hcd->remote_wakeup);
 		} else {
-			dev_dbg (&dev->dev, "PCI D3 suspend fail, %d\n",
-					retval);
+			dev_dbg (&dev->dev, "PCI %s suspend fail, %d\n",
+					pci_state_to_name (level), retval);
 			(void) usb_hcd_pci_resume (dev);
 		}
 


--===============81600442364226222==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============81600442364226222==--
