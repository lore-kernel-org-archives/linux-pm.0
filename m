From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.21-rc5-git 1/3] new platform_enable_wake()
	hook; use it in PCI
Date: Thu, 5 Apr 2007 12:48:56 -0700
Message-ID: <200704051248.56703.david-b__9991.71737717024$1175803736$gmane$org@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This defines a platform hook to enable/disable a device as a wakeup event
source.  It's initially for use with ACPI, but more generally it could be
used whenever enable_irq_wake()/disable_irq_wake() don't suffice.

The hook is called -- if available -- inside pci_enable_wake(); and the
semantics of that call are enhanced so that support for PCI PME# is no
longer needed.  It can now work for devices with "legacy PCI PM", when
platform support allows it.  (That support would use some board-specific
signal for for the same purpose as PME#.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/base/power/main.c |    3 ++
 drivers/pci/pci.c         |   61 ++++++++++++++++++++++++++++++++---------=
-----
 include/linux/pm.h        |    5 +++
 3 files changed, 51 insertions(+), 18 deletions(-)

--- g26.orig/include/linux/pm.h	2007-04-04 12:26:00.000000000 -0700
+++ g26/include/linux/pm.h	2007-04-04 13:03:34.000000000 -0700
@@ -273,6 +273,11 @@ extern void __suspend_report_result(cons
 		__suspend_report_result(__FUNCTION__, fn, ret);		\
 	} while (0)
 =

+/* platform hook to activate device wakeup capability, if
+ * that's not already handled by enable_irq_wake() etc
+ */
+extern int (*platform_enable_wakeup)(struct device *dev, int is_on);
+
 #else /* !CONFIG_PM */
 =

 static inline int device_suspend(pm_message_t state)
--- g26.orig/drivers/base/power/main.c	2007-04-04 13:03:33.000000000 -0700
+++ g26/drivers/base/power/main.c	2007-04-04 13:03:34.000000000 -0700
@@ -29,6 +29,9 @@ LIST_HEAD(dpm_off_irq);
 DECLARE_MUTEX(dpm_sem);
 DECLARE_MUTEX(dpm_list_sem);
 =

+int (*platform_enable_wakeup)(struct device *dev, int is_on) =3D NULL;
+
+
 /**
  *	device_pm_set_parent - Specify power dependency.
  *	@dev:		Device who needs power.
--- g26.orig/drivers/pci/pci.c	2007-04-04 12:26:06.000000000 -0700
+++ g26/drivers/pci/pci.c	2007-04-04 13:31:37.000000000 -0700
@@ -891,31 +891,53 @@ pci_disable_device(struct pci_dev *dev)
 }
 =

 /**
- * pci_enable_wake - enable device to generate PME# when suspended
- * @dev: - PCI device to operate on
- * @state: - Current state of device.
- * @enable: - Flag to enable or disable generation
- * =

- * Set the bits in the device's PM Capabilities to generate PME# when
- * the system is suspended. =

- *
- * -EIO is returned if device doesn't have PM Capabilities. =

- * -EINVAL is returned if device supports it, but can't generate wake even=
ts.
- * 0 if operation is successful.
- * =

+ * pci_enable_wake - enable PCI device as wakeup event source
+ * @dev: PCI device affected
+ * @state: PCI state from which device will issue wakeup events
+ * @enable: True to enable event generation; false to disable
+ *
+ * This enables the device as a wakeup event source, or disables it.
+ * When such events involves platform-specific hooks, those hooks are
+ * called automatically by this routine.
+ *
+ * Devices with legacy power management (no standard PCI PM capabilities)
+ * always require such platform hooks.  Depending on the platform, devices
+ * supporting the standard PCI PME# signal may require such platform hooks;
+ * they always update bits in config space to allow PME# generation.
+ *
+ * -EIO is returned if the device can't ever be a wakeup event source.
+ * -EINVAL is returned if the device can't generate wakeup events from
+ * the specified PCI state.  Returns zero if the operation is successful.
  */
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
 {
 	int pm;
+	int status;
 	u16 value;
 =

+	/* Note that drivers should verify device_may_wakeup(&dev->dev)
+	 * before calling this function.  Platform code should report
+	 * errors when drivers try to enable wakeup on devices that
+	 * can't issue wakeups, or on which wakeups were disabled by
+	 * userspace updating the /sys/devices.../power/wakeup file.
+	 */
+
+	if (platform_enable_wakeup) {
+		status =3D platform_enable_wakeup(&dev->dev, enable);
+		if (status)
+			return status;
+	} else
+		status =3D -EIO;
+
 	/* find PCI PM capability in list */
 	pm =3D pci_find_capability(dev, PCI_CAP_ID_PM);
 =

-	/* If device doesn't support PM Capabilities, but request is to disable
-	 * wake events, it's a nop; otherwise fail */
-	if (!pm) =

-		return enable ? -EIO : 0; =

+	/* If device doesn't support PM Capabilities, but caller wants to
+	 * disable wake events, it's a NOP.  Otherwise fail unless the
+	 * platform hooks handled this legacy device already.
+	 */
+	if (!pm)
+		return enable ? status : 0;
 =

 	/* Check device's ability to generate PME# */
 	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
@@ -924,8 +946,11 @@ int pci_enable_wake(struct pci_dev *dev,
 	value >>=3D ffs(PCI_PM_CAP_PME_MASK) - 1;   /* First bit of mask */
 =

 	/* Check if it can generate PME# from requested state. */
-	if (!value || !(value & (1 << state))) =

+	if (!value || !(value & (1 << state))) {
+		if (enable && platform_enable_wakeup)
+			(void) platform_enable_wakeup(&dev->dev, 0);
 		return enable ? -EINVAL : 0;
+	}
 =

 	pci_read_config_word(dev, pm + PCI_PM_CTRL, &value);
 =

@@ -936,7 +961,7 @@ int pci_enable_wake(struct pci_dev *dev,
 		value &=3D ~PCI_PM_CTRL_PME_ENABLE;
 =

 	pci_write_config_word(dev, pm + PCI_PM_CTRL, value);
-	=

+
 	return 0;
 }
 =
