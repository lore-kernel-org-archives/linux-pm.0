From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.21-git] pci_choose_state() works,
	does ACPI magic
Date: Wed, 9 May 2007 12:22:29 -0700
Message-ID: <200705091222.29561.david-b__38582.2498625659$1178739805$gmane$org@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Provide new ACPI method tracking the target system state, for use
during suspend() and other PM calls.  It returns ACPI_STATE_S0
except during true suspend paths.

Use that to finally implement the platform_pci_choose_state() hook
on ACPI platforms.  It calls "_S3D" and similar methods, and uses
the result appropriately.

Fix pci_choose_state() to finally behave sanely too.

Minor whitespace fixes.

Lightly tested -- STR only, with only USB affected by the new code.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
 drivers/acpi/sleep/main.c |   29 +++++++++++-
 drivers/pci/pci-acpi.c    |  107 +++++++++++++++++++++++++++++++++-------------
 drivers/pci/pci.c         |   51 ++++++++++++---------
 include/acpi/acpixf.h     |    2 
 4 files changed, 135 insertions(+), 54 deletions(-)

--- g26.orig/include/acpi/acpixf.h	2007-05-09 08:57:37.000000000 -0700
+++ g26/include/acpi/acpixf.h	2007-05-09 08:58:33.000000000 -0700
@@ -329,6 +329,8 @@ acpi_get_sleep_type_data(u8 sleep_state,
 
 acpi_status acpi_enter_sleep_state_prep(u8 sleep_state);
 
+int acpi_get_target_sleep_state(void);
+
 acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state);
 
 acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void);
--- g26.orig/drivers/acpi/sleep/main.c	2007-05-09 08:57:37.000000000 -0700
+++ g26/drivers/acpi/sleep/main.c	2007-05-09 08:58:33.000000000 -0700
@@ -35,6 +35,20 @@ static u32 acpi_suspend_states[] = {
 
 static int init_8259A_after_S1;
 
+static u8 acpi_target_sleep_state = ACPI_STATE_S0;
+
+/**
+ *	acpi_get_target_sleep_state - return target ACPI S-state
+ *
+ *	When used during suspend processing, this returns the target state
+ *	such as ACPI_STATE_S3.  Otherwise it returns ACPI_STATE_S0.
+ */
+int acpi_get_target_sleep_state(void)
+{
+	return acpi_target_sleep_state;
+}
+/* EXPORT_SYMBOL(acpi_get_target_sleep_state); ... if you need it */
+
 /**
  *	acpi_pm_prepare - Do preliminary suspend work.
  *	@pm_state:		suspend state we're entering.
@@ -50,12 +64,16 @@ extern void acpi_power_off(void);
 static int acpi_pm_prepare(suspend_state_t pm_state)
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
+	int status;
 
 	if (!sleep_states[acpi_state]) {
 		printk("acpi_pm_prepare does not support %d \n", pm_state);
 		return -EPERM;
 	}
-	return acpi_sleep_prepare(acpi_state);
+	status = acpi_sleep_prepare(acpi_state);
+	if (status == 0)
+		acpi_target_sleep_state = acpi_state;
+	return status;
 }
 
 /**
@@ -78,8 +96,10 @@ static int acpi_pm_enter(suspend_state_t
 	/* Do arch specific saving of state. */
 	if (pm_state > PM_SUSPEND_STANDBY) {
 		int error = acpi_save_state_mem();
-		if (error)
+		if (error) {
+			acpi_target_sleep_state = ACPI_STATE_S0;
 			return error;
+		}
 	}
 
 	local_irq_save(flags);
@@ -103,6 +123,10 @@ static int acpi_pm_enter(suspend_state_t
 		break;
 
 	default:
+		/* "should never happen" */
+		acpi_target_sleep_state = ACPI_STATE_S0;
+		local_irq_restore(flags);
+		WARN_ON(1);
 		return -EINVAL;
 	}
 
@@ -113,6 +137,7 @@ static int acpi_pm_enter(suspend_state_t
 	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3))
 		acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
 
+	acpi_target_sleep_state = ACPI_STATE_S0;
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
 
--- g26.orig/drivers/pci/pci-acpi.c	2007-05-09 08:57:37.000000000 -0700
+++ g26/drivers/pci/pci-acpi.c	2007-05-09 12:16:25.000000000 -0700
@@ -225,52 +225,99 @@ acpi_status pci_osc_control_set(acpi_han
 EXPORT_SYMBOL(pci_osc_control_set);
 
 /*
- * _SxD returns the D-state with the highest power
- * (lowest D-state number) supported in the S-state "x".
+ * PCI devices in the ACPI tables may have various PM-related methods,
+ * like _SxD and _SxW (where 'x' is a target S-state).
  *
- * If the devices does not have a _PRW
- * (Power Resources for Wake) supporting system wakeup from "x"
- * then the OS is free to choose a lower power (higher number
- * D-state) than the return value from _SxD.
+ * Not all devices are listed in the ACPI tables; PCI/Cardbus/.. addon
+ * devices are not known to ACPI.  We ignore those devices.  However,
+ * support for PME# depends on the PCI root bridge, which *is* known
+ * to ACPI ... and which may need to enable a GPE if any child devices
+ * are wakeup-enabled.
  *
- * But if _PRW is enabled at S-state "x", the OS
- * must not choose a power lower than _SxD --
- * unless the device has an _SxW method specifying
- * the lowest power (highest D-state number) the device
- * may enter while still able to wake the system.
+ * All PM-enabled PCI devices can support PCI_D3.
  *
- * ie. depending on global OS policy:
- *
- * if (_PRW at S-state x)
- *	choose from highest power _SxD to lowest power _SxW
- * else // no _PRW at S-state x
- * 	choose highest power _SxD or any lower power
- *
- * currently we simply return _SxD, if present.
+ * For now, prefer lowest power state unless ACPI suggests otherwise.
  */
-
 static int acpi_pci_choose_state(struct pci_dev *pdev, pm_message_t state)
 {
-	/* TBD */
+	static const u8 state_conv[] = {
+		[ACPI_STATE_D0] = PCI_D0,	/* highest power */
+		[ACPI_STATE_D1] = PCI_D1,
+		[ACPI_STATE_D2] = PCI_D2,
+		[ACPI_STATE_D3] = PCI_D3hot,
+	};
+
+	acpi_handle		handle = DEVICE_ACPI_HANDLE(&pdev->dev);
+	struct acpi_device	*adev;
+	char			sxd[] = "_SxD";
+	unsigned long		d_min, d_max;
+	int			s_state;
+
+	/* Device isn't known to ACPI? */
+	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &adev)))
+		return -ENODEV;
+
+	s_state = acpi_get_target_sleep_state();
+	if (s_state > ACPI_STATE_S3)
+		return PCI_D3cold;
+
+	/* Any device can handle D0 and D3; we'll assume that if it can
+	 * wake, it can wake from D3 *or* ACPI will tell us.
+	 */
+	d_min = ACPI_STATE_D3;
+	d_max = ACPI_STATE_D3;
+
+	/* If present, _SxD methods give the minimum D-state we may use
+	 * for each S-state ... with lowest latency state switching.
+	 *
+	 * We rely on acpi_evaluate_integer() not clobbering the integer
+	 * provided -- that's our fault recovery, we ignore retval.
+	 */
+	sxd[2] = '0' + s_state;
+	if (s_state > ACPI_STATE_S0)
+		acpi_evaluate_integer(handle, sxd, NULL, &d_min);
+
+	/* If _PRW says we can wake from the upcoming system state, the
+	 * _SxD value can wake ... and we'll assume a wakeup-aware driver.
+	 * If _SxW methods exist (ACPI 3.x), they give the lowest power
+	 * D-state that can also wake the system.  _S0W can be valid.
+	 */
+	if (device_may_wakeup(&pdev->dev)
+			&& adev->wakeup.sleep_state <= s_state) {
+		d_max = d_min;
+		sxd[3] = 'W';
+		acpi_evaluate_integer(handle, sxd, NULL, &d_max);
+	}
 
-	return -ENODEV;
+	/* Use the lowest power option ACPI allows */
+	return state_conv[d_max];
 }
 
 static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
-	static int state_conv[] = {
-		[0] = 0,
-		[1] = 1,
-		[2] = 2,
-		[3] = 3,
-		[4] = 3
+
+	static const u8 state_conv[] = {
+		[PCI_D0] = ACPI_STATE_D0,
+		[PCI_D1] = ACPI_STATE_D1,
+		[PCI_D2] = ACPI_STATE_D2,
+		[PCI_D3hot] = ACPI_STATE_D3,
+		[PCI_D3cold] = ACPI_STATE_D3
 	};
-	int acpi_state = state_conv[(int __force) state];
 
 	if (!handle)
 		return -ENODEV;
-	return acpi_bus_set_power(handle, acpi_state);
+
+	switch (state) {
+	case PCI_D0:
+	case PCI_D1:
+	case PCI_D2:
+	case PCI_D3hot:
+	case PCI_D3cold:
+		return acpi_bus_set_power(handle, state_conv[state]);
+	}
+
+	return -EINVAL;
 }
 
 
--- g26.orig/drivers/pci/pci.c	2007-05-09 08:57:37.000000000 -0700
+++ g26/drivers/pci/pci.c	2007-05-09 12:17:08.000000000 -0700
@@ -500,43 +500,50 @@ pci_set_power_state(struct pci_dev *dev,
 }
 
 int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
- 
+
 /**
  * pci_choose_state - Choose the power state of a PCI device
  * @dev: PCI device to be suspended
- * @state: target sleep state for the whole system. This is the value
- *	that is passed to suspend() function.
+ * @mesg: The value passed to the suspend() function.
  *
  * Returns PCI power state suitable for given device and given system
- * message.
+ * power transition.
  */
 
-pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
+pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t mesg)
 {
-	int ret;
-
-	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
-		return PCI_D0;
-
-	if (platform_pci_choose_state) {
-		ret = platform_pci_choose_state(dev, state);
-		if (ret >= 0)
-			state.event = ret;
-	}
+	pci_power_t state = PCI_D0;
+	int pos;
 
-	switch (state.event) {
+	switch (mesg.event) {
 	case PM_EVENT_ON:
-		return PCI_D0;
 	case PM_EVENT_FREEZE:
 	case PM_EVENT_PRETHAW:
-		/* REVISIT both freeze and pre-thaw "should" use D0 */
+		break;
+
+	/* Speed things up by only using PCI power states when going into
+	 * a real system suspend state.
+	 */
 	case PM_EVENT_SUSPEND:
-		return PCI_D3hot;
+		pos = pci_find_capability(dev, PCI_CAP_ID_PM);
+		if (pos) {
+			int ret = -ENOSYS;
+
+			if (platform_pci_choose_state && !pci_no_d1d2(dev))
+				ret = platform_pci_choose_state(dev, mesg);
+
+			/* FIXME if the device is wakeup-enabled, check its
+			 * PM capabilities.  Never return a state that can't
+			 * issue wakeup events.
+			 */
+			if (ret < 0)
+				state = PCI_D3hot;
+		}
+		break;
 	default:
-		printk("Unrecognized suspend event %d\n", state.event);
-		BUG();
+		WARN_ON(1);
 	}
-	return PCI_D0;
+	return state;
 }
 
 EXPORT_SYMBOL(pci_choose_state);
