From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH update] ACPI / PM: Allow PCI root
	bridges to wake up the system
Date: Wed, 2 Sep 2009 00:41:57 +0200
Message-ID: <200909020041.57754.rjw__45960.8177691281$1251844958$gmane$org@sisk.pl>
References: <200908300041.14541.rjw@sisk.pl>
	<20090901132547.GA13084@srcf.ucam.org>
	<200909012103.19761.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909012103.19761.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 01 September 2009, Rafael J. Wysocki wrote:
> On Tuesday 01 September 2009, Matthew Garrett wrote:
> > On Mon, Aug 31, 2009 at 11:24:20PM +0200, Rafael J. Wysocki wrote:
> > 
> > > Updated patch is appended, but there's a problem with it.  Namely, when the
> > > root bridge GPE is shared with other devices, those devices are also enabled
> > > to wake up and they may be kind of "interesting" (on one of my test boxes they
> > > include the ethernet and audio adapters).  I'm not sure what to do about that.
> > 
> > Perhaps only enable it if a child device is enabled?
> 
> Well, the problem is that we have to enable the devices that share the GPE to
> wake up together, but the child device we _really_ want to wake-up need not
> be any of them.
> 
> Also, the child device may be enabled to wake up after we've run the "glue"
> code.
> 
> Well, perhaps it's better to rework pci_enable_wake() so that it, if the device
> doesn't have an ACPI handle and is not PCIe, it will go and enable the root
> bridge to wake up as well?
> 
> I wonder what about the bridges between the desired wake-up device and the
> root bridge.  I guess they also should be enabled to wake-up, so that they can
> forward the PME# in case the system is designed this way.

Below is a prototype of what I was thinking of, although I'm not sure if that's
enough.

Comments welcome.

Rafael

---
 drivers/pci/pci.c   |  134 +++++++++++++++++++++++++++++++---------------------
 include/linux/pci.h |    7 ++
 2 files changed, 87 insertions(+), 54 deletions(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1198,71 +1198,100 @@ void pci_pme_active(struct pci_dev *dev,
 }
 
 /**
- * pci_enable_wake - enable PCI device as wakeup event source
- * @dev: PCI device affected
- * @state: PCI state from which device will issue wakeup events
- * @enable: True to enable event generation; false to disable
- *
- * This enables the device as a wakeup event source, or disables it.
- * When such events involves platform-specific hooks, those hooks are
- * called automatically by this routine.
+ * pci_enable_wakeup - Enable given device to wake up the system.
+ * @dev: Device to become a wake-up event source.
  *
- * Devices with legacy power management (no standard PCI PM capabilities)
- * always require such platform hooks.
+ * If the device itself has no platform support for wake-up, we go to it's
+ * parent bridge and try to enable it to wake up the system and so on,
+ * recursively, up to the root bridge.
  *
- * RETURN VALUE:
- * 0 is returned on success
- * -EINVAL is returned if device is not supposed to wake up the system
- * Error code depending on the platform is returned if both the platform and
- * the native mechanism fail to enable the generation of wake-up events
+ * According to "PCI System Architecture" 4th ed. by Tom Shanley & Don Anderson
+ * we should be doing PME# wake enable followed by ACPI wake enable.  To disable
+ * wake-up we call the platform first, for symmetry.
  */
-int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable)
+static int pci_enable_wakeup(struct pci_dev *dev)
 {
-	int error = 0;
-	bool pme_done = false;
-
-	if (enable && !device_may_wakeup(&dev->dev))
+	if (!device_may_wakeup(&dev->dev))
 		return -EINVAL;
 
-	/*
-	 * According to "PCI System Architecture" 4th ed. by Tom Shanley & Don
-	 * Anderson we should be doing PME# wake enable followed by ACPI wake
-	 * enable.  To disable wake-up we call the platform first, for symmetry.
-	 */
+	dev_info(&dev->dev, "PCI: enabling wake-up.\n");
+
+	if (atomic_add_return(1, &dev->wakeup_count) != 1)
+		return 0;
+
+	pci_pme_active(dev, true);
+	if (platform_pci_can_wakeup(dev))
+		platform_pci_sleep_wake(dev, true);
+	else if (!dev->is_pcie && dev->bus && dev->bus->self)
+		pci_enable_wakeup(dev->bus->self);
+
+
+	return 0;
+}
+
+/**
+ * pci_disable_wakeup - Disable given device from waking up the system.
+ * @dev: Device to handle.
+ *
+ * If the device itself has no platform support for wake-up, we go to it's
+ * parent bridge and try to disable it from waking up the system and so on,
+ * recursively, up to the root bridge.
+ */
+static int pci_disable_wakeup(struct pci_dev *dev)
+{
+	int count;
+
+	if (!device_may_wakeup(&dev->dev))
+		return -EINVAL;
 
-	if (!enable && platform_pci_can_wakeup(dev))
-		error = platform_pci_sleep_wake(dev, false);
+	dev_info(&dev->dev, "PCI: disabling wake-up.\n");
 
-	if (!enable || pci_pme_capable(dev, state)) {
-		pci_pme_active(dev, enable);
-		pme_done = true;
+	count = atomic_add_return(-1, &dev->wakeup_count);
+	if (count < 0) {
+		dev_err(&dev->dev, "unbalanced %s!\n", __func__);
+		return -EALREADY;
+	} else if (count > 0) {
+		return 0;
 	}
 
-	if (enable && platform_pci_can_wakeup(dev))
-		error = platform_pci_sleep_wake(dev, true);
+	if (platform_pci_can_wakeup(dev)) {
+		platform_pci_sleep_wake(dev, false);
+		pci_pme_active(dev, false);
+	} else {
+		pci_pme_active(dev, false);
+		if (!dev->is_pcie && dev->bus && dev->bus->self)
+			pci_disable_wakeup(dev->bus->self);
+	}
 
-	return pme_done ? 0 : error;
+	return 0;
 }
 
 /**
- * pci_wake_from_d3 - enable/disable device to wake up from D3_hot or D3_cold
- * @dev: PCI device to prepare
- * @enable: True to enable wake-up event generation; false to disable
+ * pci_enable_wake - Enable PCI device as wake-up event source.
+ * @dev: PCI device affected.
+ * @state: Ignored.
+ * @enable: True to enable wake-up event generation; false to disable.
+ *
+ * Enable the device as a wake-up event source or disable it, depending on the
+ * value of @enable.  The generation of such events may require us to set up the
+ * platform appropriately, which involves executing some platform-specific
+ * hooks.  If they are needed, they will be called automatically.
  *
- * Many drivers want the device to wake up the system from D3_hot or D3_cold
- * and this function allows them to set that up cleanly - pci_enable_wake()
- * should not be called twice in a row to enable wake-up due to PCI PM vs ACPI
- * ordering constraints.
+ * Devices with legacy power management (no standard PCI PM capabilities) always
+ * require such platform hooks.
  *
- * This function only returns error code if the device is not capable of
- * generating PME# from both D3_hot and D3_cold, and the platform is unable to
- * enable wake-up power for it.
+ * RETURN VALUE:
+ * 0 is returned on success.
+ * -EINVAL is returned if the device is not supposed to wake up the system.
+ * -EALREADY is returned on an attempt to disable a device that is not enabled
+ * to wake-up.
  */
-int pci_wake_from_d3(struct pci_dev *dev, bool enable)
+int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable)
 {
-	return pci_pme_capable(dev, PCI_D3cold) ?
-			pci_enable_wake(dev, PCI_D3cold, enable) :
-			pci_enable_wake(dev, PCI_D3hot, enable);
+	if (!enable && !atomic_read(&dev->wakeup_count))
+		return 0;
+
+	return enable ? pci_enable_wakeup(dev) : pci_disable_wakeup(dev);
 }
 
 /**
@@ -1323,18 +1352,16 @@ pci_power_t pci_target_state(struct pci_
  */
 int pci_prepare_to_sleep(struct pci_dev *dev)
 {
-	pci_power_t target_state = pci_target_state(dev);
 	int error;
+	pci_power_t target_state = pci_target_state(dev);
 
 	if (target_state == PCI_POWER_ERROR)
 		return -EIO;
 
-	pci_enable_wake(dev, target_state, device_may_wakeup(&dev->dev));
-
+	pci_enable_wakeup(dev);
 	error = pci_set_power_state(dev, target_state);
-
 	if (error)
-		pci_enable_wake(dev, target_state, false);
+		pci_disable_wakeup(dev);
 
 	return error;
 }
@@ -1347,7 +1374,7 @@ int pci_prepare_to_sleep(struct pci_dev 
  */
 int pci_back_from_sleep(struct pci_dev *dev)
 {
-	pci_enable_wake(dev, PCI_D0, false);
+	pci_disable_wakeup(dev);
 	return pci_set_power_state(dev, PCI_D0);
 }
 
@@ -1362,6 +1389,7 @@ void pci_pm_init(struct pci_dev *dev)
 
 	device_enable_async_suspend(&dev->dev, true);
 	dev->pm_cap = 0;
+	atomic_set(&dev->wakeup_count, 0);
 
 	/* find PCI PM capability in list */
 	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -241,6 +241,7 @@ struct pci_dev {
 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
 	unsigned int	no_d1d2:1;	/* Only allow D0 and D3 */
+	atomic_t	wakeup_count;
 
 #ifdef CONFIG_PCIEASPM
 	struct pcie_link_state	*link_state;	/* ASPM link state. */
@@ -734,11 +735,15 @@ pci_power_t pci_choose_state(struct pci_
 bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
 void pci_pme_active(struct pci_dev *dev, bool enable);
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable);
-int pci_wake_from_d3(struct pci_dev *dev, bool enable);
 pci_power_t pci_target_state(struct pci_dev *dev);
 int pci_prepare_to_sleep(struct pci_dev *dev);
 int pci_back_from_sleep(struct pci_dev *dev);
 
+static inline int pci_wake_from_d3(struct pci_dev *dev, bool enable)
+{
+	return pci_enable_wake(dev, PCI_D3hot, enable);
+}
+
 /* Functions for PCI Hotplug drivers to use */
 int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
 #ifdef CONFIG_HOTPLUG
