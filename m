From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 6/9] PCI ACPI: Introduce
	acpi_pm_device_sleep_wake function
Date: Wed, 25 Jun 2008 23:31:02 +0200
Message-ID: <200806252331.02963.rjw__18563.9368057766$1214429606$gmane$org@sisk.pl>
References: <200806200145.33053.rjw@sisk.pl>
	<1214389766.9800.106.camel@yakui_zhao.sh.intel.com>
	<200806252057.47869.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806252057.47869.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 25 of June 2008, Rafael J. Wysocki wrote:
> On Wednesday, 25 of June 2008, Zhao Yakui wrote:
> > On Wed, 2008-06-25 at 16:11 +0800, Zhang Rui wrote:
> > > Hi, Rafael,
> > > 
> > > On Fri, 2008-06-20 at 01:51 +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > 
> > > > PCI ACPI: Introduce acpi_pm_device_sleep_wake function
> > > > 
> > > > Introduce function acpi_pm_device_sleep_wake() for enabling and
> > > > disabling the system wake-up capability of devices that are power
> > > > manageable by ACPI.
> > > > 
> > > > Introduce callback .sleep_wake() in struct pci_platform_pm_ops and
> > > > for the ACPI PCI 'driver' make it use acpi_pm_device_sleep_wake().
> > > 
> > > acpi_pm_device_sleep_wake only enable/disable the power of wakeup
> > > device, right?
> > > If it doesn't set the acpi_device->wakeup.state.enabled, the wake up GPE
> > > will not be enabled, which means the pci devices which have invoked
> > > platform_pci_sleep_wake(dev, true) can not wake up the system as
> > > excepted.
> > > so this patch won't work. Is this what you want? or do I miss something?
> > >From the patch it seems that acpi_dev->wakeup.state.enable is not set in
> > >the function of acpi_pm_device_sleep_wake. If it is not set, it means
> > >that the corresponding GPE won't be enabled. The device still can't wake
> > >up the sleeping system. 
> 
> This is a good point, because I forgot about the GPE.
> 
> However, it's not my intention to set acpi_device->wakeup.state.enabled in
> acpi_pm_device_sleep_wake().  Instead, I'd like to use the
> /sys/devices/.../power/wakeup interface and more precisely the
> dev->power.should_wakeup flag that is supposed to have been set/unset as
> needed _before_ acpi_pm_device_sleep_wake() is called.
> 
> Still, I'll need to make the code in drivers/acpi/sleep/wakeup.c enable/disable
> the wake-up GPEs for devices that have both dev->power.can_wakeup and
> dev->power.should_wakeup set, as though these devices had
> acpi_device->wakeup.state.enabled set.
> 
> > > But what is annoying me is that,
> > > if acpi_device->wakeup.state.enabled is set in
> > > acpi_pm_device_sleep_wake, this may bring some other trouble.
> > > A lot of pci devices will call platform_pci_sleep_wake(dev, true) by
> > > default, they won't wake up the system before because the wake up GPEs
> > > are disabled, but they will do if this patch is applied.
> > > So some of the users may got the "resume immediately after sleep"
> > > problem, that's a regression, isn't it?
> 
> That won't happen as long as the devices' dev->power.should_wakeup flags are
> not set.
> 
> Note that in the most recent series of patches these flags are unset by default
> for devices that cannot generate PME#, but there are PCI devices that can
> generate both PME# and the ACPI-enabled wake-up events and those devices will
> have dev->power.should_wakeup set by default.  Still, if that may cause any
> problems, we can unset dev->power.should_wakeup for all devices during
> initialization and let the user space set it as desired.
> 
> > What Rui said is right. In current kernel when the system enters the
> > sleeping state, the pci_enable_wake(dev,state, 1) will be called for the
> > PCI device. If acpi_dev->wakeup.state.enabled is set in
> > acpi_pm_device_sleep_wake , it means that the wakeup GPE will be
> > enabled. Maybe some systems will be resumed immediately after sleeping.
> > this is not what we expected.
> 
> However, pci_enable_wake() calls device_may_wakeup() and immediately aborts if
> that returns 'false', so the user space can control its behavior using the
> /sys/devices/.../power/wakeup interface.
> 
> > > 
> > > we have discussed this a couple of times on the list, but we have not
> > > got a solution yet.
> > > IMO, both Dave's and your patches are good, and we can be a little
> > > aggressive to merge them, and fix the drivers once we get any
> > > regressions ASAP.
> > As the acpi_dev->wakeup.state.enabled is not touched in this patch, it
> > will be OK to merge them. 
> > 
> > If acpi_dev->wakeup.state.enable is required to be set/unset in
> > acpi_pm_device_sleep_wake, maybe Rui's suggestion is good. Unless some
> > device is expected to wake up the sleeping system, we will enable the
> > corresponding GPE. Otherwise it will be assumed that the device needn't
> > wake up the sleeping system and unnecessary to enable the device power
> > and the corresponding GPE.
> > > i.e. either change pci_enable_wake(dev, 1) to pci_enable_wake(dev, 0) in
> > > the drivers suspend method, or invoke  device_set_wakeup_enable(dev, 0)
> > > to disable the wakeup ability after the call to device_init_wakeup(dev,
> > > 1).
> > > 
> > > any ideas?
> 
> Please see above. :-)

Appended is a patch that contains the majority of what I'd like to do.

I thought it would be better to split that into multiple smaller patches, but
apparently not.

Tha patch is against the mainline, on top of the patches 01-05 from the series
at https://lists.linux-foundation.org/pipermail/linux-pm/2008-June/017839.html,
but the difference between this one and the linux-next counterpart is minimal.

Please have a look.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

PCI ACPI: Rework PCI handling of wake-up

* Introduce function acpi_pm_device_sleep_wake() for enabling and
  disabling the system wake-up capability of devices that are power
  manageable by ACPI.

* Introduce function acpi_bus_can_wakeup() allowing other (dependent)
  subsystems to check if ACPI is able to enable the system wake-up
  capability of given device.

* Introduce callback .sleep_wake() in struct pci_platform_pm_ops and
  for the ACPI PCI 'driver' make it use acpi_pm_device_sleep_wake().

* Introduce callback .can_wakeup() in struct pci_platform_pm_ops and
  for the ACPI 'driver' make it use acpi_bus_can_wakeup().

* Move the PME# handlig code out of pci_enable_wake() and split it
  into two functions, pci_pme_capable() and pci_pme_active(),
  allowing the caller to check if given device is capable of
  generating PME# from given power state and to enable/disable the
  device's PME# functionality, respectively.

* Modify pci_enable_wake() to use the new ACPI callbacks and the new
  PME#-related functions.

* Drop the generic .platform_enable_wakeup() callback that is not
  used any more.

* Introduce device_set_wakeup_capable() that will set the
  power.can_wakeup flag of given device.

* Rework PCI device PM initialization so that, if given device is
  capable of generating wake-up events, either natively through the
  PME# mechanism, or with the help of the platform, its
  power.can_wakeup flag is set and its power.should_wakeup flag is
  unset as appropriate.

* Make ACPI set the power.can_wakeup flag for devices found to be
  wake-up capable by it.

* Make the ACPI wake-up code enable/disable GPEs for devices that
  have both power.can_wakeup flag and power.should_wakeup flags
  set.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/bus.c          |   11 +++
 drivers/acpi/glue.c         |    2 
 drivers/acpi/sleep/main.c   |   25 +++++++
 drivers/acpi/sleep/wakeup.c |   15 +++-
 drivers/base/power/sysfs.c  |    3 
 drivers/pci/pci-acpi.c      |   19 +++++
 drivers/pci/pci.c           |  155 +++++++++++++++++++++++++++++++-------------
 drivers/pci/pci.h           |    8 ++
 drivers/pci/probe.c         |    3 
 include/acpi/acpi_bus.h     |    2 
 include/linux/pm_wakeup.h   |   26 +------
 11 files changed, 201 insertions(+), 68 deletions(-)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -482,6 +482,31 @@ int acpi_pm_device_sleep_state(struct de
 		*d_min_p = d_min;
 	return d_max;
 }
+
+/**
+ *	acpi_pm_device_sleep_wake - enable or disable the system wake-up
+ *                                  capability of given device
+ *	@dev: device to handle
+ *	@enable: 'true' - enable, 'false' - disable the wake-up capability
+ */
+int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
+{
+	acpi_handle handle;
+	struct acpi_device *adev;
+
+	if (!device_may_wakeup(dev))
+		return -EINVAL;
+
+	handle = DEVICE_ACPI_HANDLE(dev);
+	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &adev))) {
+		printk(KERN_DEBUG "ACPI handle has no context!\n");
+		return -ENODEV;
+	}
+
+	return enable ?
+		acpi_enable_wakeup_device_power(adev, acpi_target_sleep_state) :
+		acpi_disable_wakeup_device_power(adev);
+}
 #endif
 
 static void acpi_power_off_prepare(void)
Index: linux-2.6/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-acpi.c
+++ linux-2.6/drivers/pci/pci-acpi.c
@@ -353,10 +353,29 @@ static int acpi_pci_set_power_state(stru
 	return error;
 }
 
+static bool acpi_pci_can_wakeup(struct pci_dev *dev)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+
+	return handle ? acpi_bus_can_wakeup(handle) : false;
+}
+
+static int acpi_pci_sleep_wake(struct pci_dev *dev, bool enable)
+{
+	int error = acpi_pm_device_sleep_wake(&dev->dev, enable);
+
+	if (!error)
+		printk(KERN_INFO "PCI: Wake-up capability of %s %s by ACPI\n",
+			pci_name(dev), enable ? "enabled" : "disabled");
+	return error;
+}
+
 static struct pci_platform_pm_ops acpi_pci_platform_pm = {
 	.is_manageable = acpi_pci_power_manageable,
 	.set_state = acpi_pci_set_power_state,
 	.choose_state = acpi_pci_choose_state,
+	.can_wakeup = acpi_pci_can_wakeup,
+	.sleep_wake = acpi_pci_sleep_wake,
 };
 
 /* ACPI bus type */
Index: linux-2.6/drivers/pci/pci.h
===================================================================
--- linux-2.6.orig/drivers/pci/pci.h
+++ linux-2.6/drivers/pci/pci.h
@@ -17,6 +17,11 @@ extern void pci_cleanup_rom(struct pci_d
  *                 platform; to be used during system-wide transitions from a
  *                 sleeping state to the working state and vice versa
  *
+ * @can_wakeup - returns 'true' if given device is capable of waking up the
+ *               system from a sleeping state
+ *
+ * @sleep_wake - enables/disables the system wake up capability of given device
+ *
  * If given platform is generally capable of power managing PCI devices, all of
  * these callbacks are mandatory.
  */
@@ -24,9 +29,12 @@ struct pci_platform_pm_ops {
 	bool (*is_manageable)(struct pci_dev *dev);
 	int (*set_state)(struct pci_dev *dev, pci_power_t state);
 	pci_power_t (*choose_state)(struct pci_dev *dev);
+	bool (*can_wakeup)(struct pci_dev *dev);
+	int (*sleep_wake)(struct pci_dev *dev, bool enable);
 };
 
 extern int pci_set_platform_pm(struct pci_platform_pm_ops *ops);
+extern void pci_pm_init(struct pci_dev *dev);
 
 extern int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
 extern int pci_user_read_config_word(struct pci_dev *dev, int where, u16 *val);
Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h
+++ linux-2.6/include/acpi/acpi_bus.h
@@ -337,6 +337,7 @@ int acpi_bus_get_status(struct acpi_devi
 int acpi_bus_get_power(acpi_handle handle, int *state);
 int acpi_bus_set_power(acpi_handle handle, int state);
 bool acpi_bus_power_manageable(acpi_handle handle);
+bool acpi_bus_can_wakeup(acpi_handle handle);
 #ifdef CONFIG_ACPI_PROC_EVENT
 int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data);
 int acpi_bus_generate_proc_event4(const char *class, const char *bid, u8 type, int data);
@@ -379,6 +380,7 @@ acpi_handle acpi_get_pci_rootbridge_hand
 
 #ifdef CONFIG_PM_SLEEP
 int acpi_pm_device_sleep_state(struct device *, int *);
+int acpi_pm_device_sleep_wake(struct device *, bool);
 #else /* !CONFIG_PM_SLEEP */
 static inline int acpi_pm_device_sleep_state(struct device *d, int *p)
 {
Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -382,7 +382,8 @@ static struct pci_platform_pm_ops *pci_p
 
 int pci_set_platform_pm(struct pci_platform_pm_ops *ops)
 {
-	if (!ops->is_manageable || !ops->set_state || !ops->choose_state)
+	if (!ops->is_manageable || !ops->set_state || !ops->choose_state
+	    || !ops->sleep_wake || !ops->can_wakeup)
 		return -EINVAL;
 	pci_platform_pm = ops;
 	return 0;
@@ -405,6 +406,17 @@ static inline pci_power_t platform_pci_c
 			pci_platform_pm->choose_state(dev) : PCI_POWER_ERROR;
 }
 
+static inline bool platform_pci_can_wakeup(struct pci_dev *dev)
+{
+	return pci_platform_pm ? pci_platform_pm->can_wakeup(dev) : false;
+}
+
+static inline int platform_pci_sleep_wake(struct pci_dev *dev, bool enable)
+{
+	return pci_platform_pm ?
+			pci_platform_pm->sleep_wake(dev, enable) : -ENODEV;
+}
+
 /**
  * pci_raw_set_power_state - Use PCI PM registers to set the power state of
  *                           given PCI device
@@ -1039,6 +1051,53 @@ int pci_set_pcie_reset_state(struct pci_
 }
 
 /**
+ * pci_pme_capable - check the capability of PCI device to generate PME#
+ * @dev: PCI device to handle.
+ * @pm: PCI PM capability offset of the device.
+ * @state: PCI state from which device will issue PME#.
+ */
+static bool pci_pme_capable(struct pci_dev *dev, int pm, pci_power_t state)
+{
+	u16 pmc;
+
+	if (!pm)
+		return false;
+
+	/* Check device's ability to generate PME# from given state */
+	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
+
+	pmc &= PCI_PM_CAP_PME_MASK;
+	pmc >>= ffs(PCI_PM_CAP_PME_MASK) - 1;   /* First bit of mask */
+
+	return !!(pmc & (1 << state));
+}
+
+/**
+ * pci_pme_active - enable or disable PCI device's PME# function
+ * @dev: PCI device to handle.
+ * @pm: PCI PM capability offset of the device.
+ * @enable: 'true' to enable PME# generation; 'false' to disable it.
+ *
+ * The caller must verify that the device is capable of generating PME# before
+ * calling this function with @enable equal to 'true'.
+ */
+static void pci_pme_active(struct pci_dev *dev, int pm, bool enable)
+{
+	u16 pmcsr;
+
+	if (!pm)
+		return;
+
+	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+	/* Clear PME_Status by writing 1 to it and enable PME# */
+	pmcsr |= PCI_PM_CTRL_PME_STATUS | PCI_PM_CTRL_PME_ENABLE;
+	if (!enable)
+		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
+
+	pci_write_config_word(dev, pm + PCI_PM_CTRL, pmcsr);
+}
+
+/**
  * pci_enable_wake - enable PCI device as wakeup event source
  * @dev: PCI device affected
  * @state: PCI state from which device will issue wakeup events
@@ -1053,62 +1112,72 @@ int pci_set_pcie_reset_state(struct pci_
  * supporting the standard PCI PME# signal may require such platform hooks;
  * they always update bits in config space to allow PME# generation.
  *
- * -EIO is returned if the device can't ever be a wakeup event source.
- * -EINVAL is returned if the device can't generate wakeup events from
- * the specified PCI state.  Returns zero if the operation is successful.
+ * RETURN VALUE:
+ * 0 is returned on success
+ * -EINVAL is returned if device is not supposed to wake up the system
+ * Error code depending on the platform is returned if both the platform and the
+ * native mechanism fail to enable the generation of wake-up events
  */
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
 {
 	int pm;
-	int status;
-	u16 value;
+	int error = 0;
 
-	/* Note that drivers should verify device_may_wakeup(&dev->dev)
-	 * before calling this function.  Platform code should report
-	 * errors when drivers try to enable wakeup on devices that
-	 * can't issue wakeups, or on which wakeups were disabled by
-	 * userspace updating the /sys/devices.../power/wakeup file.
-	 */
+	if (!device_may_wakeup(&dev->dev))
+		return -EINVAL;
 
-	status = call_platform_enable_wakeup(&dev->dev, enable);
+	if (enable && platform_pci_can_wakeup(dev))
+		error = platform_pci_sleep_wake(dev, true);
 
-	/* find PCI PM capability in list */
-	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-
-	/* If device doesn't support PM Capabilities, but caller wants to
-	 * disable wake events, it's a NOP.  Otherwise fail unless the
-	 * platform hooks handled this legacy device already.
+	/*
+	 * We are going to enable/disable the generation of PME# even if the
+	 * platform claims to have handled the device as requested.
 	 */
-	if (!pm)
-		return enable ? status : 0;
-
-	/* Check device's ability to generate PME# */
-	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
-
-	value &= PCI_PM_CAP_PME_MASK;
-	value >>= ffs(PCI_PM_CAP_PME_MASK) - 1;   /* First bit of mask */
-
-	/* Check if it can generate PME# from requested state. */
-	if (!value || !(value & (1 << state))) {
-		/* if it can't, revert what the platform hook changed,
-		 * always reporting the base "EINVAL, can't PME#" error
-		 */
+	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (!enable || pci_pme_capable(dev, pm, state)) {
+		pci_pme_active(dev, pm, enable);
 		if (enable)
-			call_platform_enable_wakeup(&dev->dev, 0);
-		return enable ? -EINVAL : 0;
+			return 0;
 	}
 
-	pci_read_config_word(dev, pm + PCI_PM_CTRL, &value);
-
-	/* Clear PME_Status by writing 1 to it and enable PME# */
-	value |= PCI_PM_CTRL_PME_STATUS | PCI_PM_CTRL_PME_ENABLE;
+	if (!enable && platform_pci_can_wakeup(dev))
+		error = platform_pci_sleep_wake(dev, false);
 
-	if (!enable)
-		value &= ~PCI_PM_CTRL_PME_ENABLE;
+	return error;
+}
 
-	pci_write_config_word(dev, pm + PCI_PM_CTRL, value);
+/**
+ * pci_pm_init - Initialize PM functions of given PCI device
+ * @dev: PCI device to handle.
+ */
+void pci_pm_init(struct pci_dev *dev)
+{
+	int pm;
+	u16 pmc;
 
-	return 0;
+	/* find PCI PM capability in list */
+	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (!pm)
+		return;
+	/* Check device's ability to generate PME# */
+	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
+	if (pmc & PCI_PM_CAP_PME_MASK) {
+		printk(KERN_INFO "PCI: Device %s supports PME# from"
+			"%s%s%s%s%s\n", pci_name(dev),
+			(pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
+			(pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
+			(pmc & PCI_PM_CAP_PME_D2) ? " D2" : "",
+			(pmc & PCI_PM_CAP_PME_D3) ? " D3hot" : "",
+			(pmc & PCI_PM_CAP_PME_D3cold) ? " D3cold" : "");
+		/*
+		 * Make device's PM flags reflect the wake-up capability, but
+		 * let the user space enable it to wake up the system as needed.
+		 */
+		device_set_wakeup_capable(&dev->dev, true);
+		device_set_wakeup_enable(&dev->dev, false);
+		/* Disable the PME# generation functionality */
+		pci_pme_active(dev, pm, false);
+	}
 }
 
 int
Index: linux-2.6/include/linux/pm_wakeup.h
===================================================================
--- linux-2.6.orig/include/linux/pm_wakeup.h
+++ linux-2.6/include/linux/pm_wakeup.h
@@ -35,6 +35,11 @@ static inline void device_init_wakeup(st
 	dev->power.can_wakeup = dev->power.should_wakeup = !!val;
 }
 
+static inline void device_set_wakeup_capable(struct device *dev, int val)
+{
+	dev->power.can_wakeup = !!val;
+}
+
 static inline int device_can_wakeup(struct device *dev)
 {
 	return dev->power.can_wakeup;
@@ -47,21 +52,7 @@ static inline void device_set_wakeup_ena
 
 static inline int device_may_wakeup(struct device *dev)
 {
-	return dev->power.can_wakeup & dev->power.should_wakeup;
-}
-
-/*
- * Platform hook to activate device wakeup capability, if that's not already
- * handled by enable_irq_wake() etc.
- * Returns zero on success, else negative errno
- */
-extern int (*platform_enable_wakeup)(struct device *dev, int is_on);
-
-static inline int call_platform_enable_wakeup(struct device *dev, int is_on)
-{
-	if (platform_enable_wakeup)
-		return (*platform_enable_wakeup)(dev, is_on);
-	return 0;
+	return dev->power.can_wakeup && dev->power.should_wakeup;
 }
 
 #else /* !CONFIG_PM */
@@ -80,11 +71,6 @@ static inline int device_can_wakeup(stru
 #define device_set_wakeup_enable(dev, val)	do {} while (0)
 #define device_may_wakeup(dev)			0
 
-static inline int call_platform_enable_wakeup(struct device *dev, int is_on)
-{
-	return 0;
-}
-
 #endif /* !CONFIG_PM */
 
 #endif /* _LINUX_PM_WAKEUP_H */
Index: linux-2.6/drivers/base/power/sysfs.c
===================================================================
--- linux-2.6.orig/drivers/base/power/sysfs.c
+++ linux-2.6/drivers/base/power/sysfs.c
@@ -6,9 +6,6 @@
 #include <linux/string.h>
 #include "power.h"
 
-int (*platform_enable_wakeup)(struct device *dev, int is_on);
-
-
 /*
  *	wakeup - Report/change current wakeup option for device
  *
Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -306,6 +306,17 @@ bool acpi_bus_power_manageable(acpi_hand
 
 EXPORT_SYMBOL(acpi_bus_power_manageable);
 
+bool acpi_bus_can_wakeup(acpi_handle handle)
+{
+	struct acpi_device *device;
+	int result;
+
+	result = acpi_bus_get_device(handle, &device);
+	return result ? false : device->wakeup.flags.valid;
+}
+
+EXPORT_SYMBOL(acpi_bus_can_wakeup);
+
 /* --------------------------------------------------------------------------
                                 Event Management
    -------------------------------------------------------------------------- */
Index: linux-2.6/drivers/pci/probe.c
===================================================================
--- linux-2.6.orig/drivers/pci/probe.c
+++ linux-2.6/drivers/pci/probe.c
@@ -984,6 +984,9 @@ void pci_device_add(struct pci_dev *dev,
 	/* Fix up broken headers */
 	pci_fixup_device(pci_fixup_header, dev);
 
+	/* Initialize power management of the device */
+	pci_pm_init(dev);
+
 	/*
 	 * Add the device to our list of discovered devices
 	 * and the bus list for fixup functions, etc.
Index: linux-2.6/drivers/acpi/glue.c
===================================================================
--- linux-2.6.orig/drivers/acpi/glue.c
+++ linux-2.6/drivers/acpi/glue.c
@@ -166,6 +166,8 @@ static int acpi_bind_one(struct device *
 				"firmware_node");
 		ret = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
 				"physical_node");
+		if (acpi_dev->wakeup.flags.valid)
+			device_set_wakeup_capable(dev, true);
 	}
 
 	return 0;
Index: linux-2.6/drivers/acpi/sleep/wakeup.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/wakeup.c
+++ linux-2.6/drivers/acpi/sleep/wakeup.c
@@ -66,12 +66,18 @@ void acpi_enable_wakeup_device(u8 sleep_
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
 			container_of(node, struct acpi_device, wakeup_list);
+		struct device *ldev;
+		bool wakeup_enabled;
+
 		if (!dev->wakeup.flags.valid)
 			continue;
+		ldev = acpi_get_physical_device(dev->handle);
+		wakeup_enabled = dev->wakeup.state.enabled ||
+			(ldev ? device_may_wakeup(ldev) : false);
 		/* If users want to disable run-wake GPE,
 		 * we only disable it for wake and leave it for runtime
 		 */
-		if (!dev->wakeup.state.enabled ||
+		if (!wakeup_enabled ||
 		    sleep_state > (u32) dev->wakeup.sleep_state) {
 			if (dev->wakeup.flags.run_wake) {
 				spin_unlock(&acpi_device_lock);
@@ -107,10 +113,15 @@ void acpi_disable_wakeup_device(u8 sleep
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
 			container_of(node, struct acpi_device, wakeup_list);
+		struct device *ldev;
+		bool wakeup_enabled;
 
 		if (!dev->wakeup.flags.valid)
 			continue;
-		if (!dev->wakeup.state.enabled ||
+		ldev = acpi_get_physical_device(dev->handle);
+		wakeup_enabled = dev->wakeup.state.enabled ||
+			(ldev ? device_may_wakeup(ldev) : false);
+		if (!wakeup_enabled ||
 		    sleep_state > (u32) dev->wakeup.sleep_state) {
 			if (dev->wakeup.flags.run_wake) {
 				spin_unlock(&acpi_device_lock);
