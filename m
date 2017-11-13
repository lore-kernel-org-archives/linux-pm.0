From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/3] PM / core: Add IN_BAND_WAKEUP driver flag
Date: Mon, 13 Nov 2017 16:46:42 +0100
Message-ID: <1510588003-16650-3-git-send-email-ulf.hansson@linaro.org>
References: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

For some bus types and PM domains, it's not sufficient to only check the
return value from device_may_wakeup(), to fully understand how to configure
wakeup settings for the device during system suspend.

In particular, sometimes the device may need to remain in its power state,
in case the driver has configured it for in band IRQs, as to be able to
generate wakeup signals. Therefore, define and document an IN_BAND_WAKEUP
driver flag, to enable drivers to instruct bus types and PM domains about
this setting.

Of course, in case the bus type and PM domain has additional information
about wakeup settings of the device, they may override the behaviour.

Using the IN_BAND_WAKEUP driver flag for a device, may also affect how bus
types and PM domains should treat the device's parent during system
suspend. Therefore, in __device_suspend(), let the PM core propagate the
wakeup setting by using a status flag in the struct dev_pm_info for the
parent. This also makes it consistent with how the existing "wakeup_path"
status flag is being assigned.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Fixed comments from Rafael:
	  - Rename flag to IN_BAND_WAKEUP.
	  - Clarify doc and changelog.
	  - Use a separate status flag when propagating to parents in PM core.
	- I didn't add Geert's Reviewed-by, because of new changes.

---
 Documentation/driver-api/pm/devices.rst | 11 +++++++++++
 drivers/base/power/main.c               |  8 +++++++-
 include/linux/pm.h                      |  6 ++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/pm/devices.rst b/Documentation/driver-api/pm/devices.rst
index 53c1b0b..b7fddf2 100644
--- a/Documentation/driver-api/pm/devices.rst
+++ b/Documentation/driver-api/pm/devices.rst
@@ -414,6 +414,17 @@ when the system is in the sleep state.  For example, :c:func:`enable_irq_wake()`
 might identify GPIO signals hooked up to a switch or other external hardware,
 and :c:func:`pci_enable_wake()` does something similar for the PCI PME signal.
 
+Sometimes :c:func:`device_may_wakeup(dev)` is not sufficient to understand how a
+wakeup signal needs to be configured. Particularly, in some cases the driver
+needs to instruct bus types and PM domains, that it has configured the device to
+use an in-band wakeup setting, which may require the device to remain in its
+power state to be able to generate wakeup signals. Therefore, drivers can set
+``DPM_FLAG_IN_BAND_WAKEUP`` in :c:member:`power.driver_flags`, by passing the
+flag to :c:func:`dev_pm_set_driver_flags` helper, which instructs bus types and
+PM domains to use this configuration. However, the bus types and PM domains may
+override this setting, in case they have additional information about wakeup
+settings of the device.
+
 If any of these callbacks returns an error, the system won't enter the desired
 low-power state.  Instead, the PM core will unwind its actions by resuming all
 the devices that were suspended.
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 8089e72..8ec3189 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1432,8 +1432,11 @@ static void dpm_propagate_to_parent(struct device *dev)
 	spin_lock_irq(&parent->power.lock);
 
 	parent->power.direct_complete = false;
-	if (dev->power.wakeup_path && !parent->power.ignore_children)
+	if (dev->power.wakeup_path && !parent->power.ignore_children) {
 		parent->power.wakeup_path = true;
+		parent->power.wakeup_path_in_band =
+			dev->power.wakeup_path_in_band;
+	}
 
 	spin_unlock_irq(&parent->power.lock);
 }
@@ -1547,6 +1550,8 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
  End:
 	if (!error) {
 		dev->power.is_suspended = true;
+		if (dev_pm_test_driver_flags(dev, DPM_FLAG_IN_BAND_WAKEUP))
+			dev->power.wakeup_path_in_band = true;
 		dpm_propagate_to_parent(dev);
 		dpm_clear_suppliers_direct_complete(dev);
 	}
@@ -1671,6 +1676,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	device_lock(dev);
 
 	dev->power.wakeup_path = device_may_wakeup(dev);
+	dev->power.wakeup_path_in_band = false;
 
 	if (dev->power.no_pm_callbacks) {
 		ret = 1;	/* Let device go direct_complete */
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 65d3911..4efb16a 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -559,6 +559,7 @@ struct pm_subsys_data {
  * NEVER_SKIP: Do not skip system suspend/resume callbacks for the device.
  * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
  * SMART_SUSPEND: No need to resume the device from runtime suspend.
+ * WAKEUP_POWERED: Keep the device powered if it has wakeup enabled.
  *
  * Setting SMART_PREPARE instructs bus types and PM domains which may want
  * system suspend/resume callbacks to be skipped for the device to return 0 from
@@ -572,10 +573,14 @@ struct pm_subsys_data {
  * necessary from the driver's perspective.  It also may cause them to skip
  * invocations of the ->suspend_late and ->suspend_noirq callbacks provided by
  * the driver if they decide to leave the device in runtime suspend.
+ *
+ * Setting WAKEUP_POWERED instructs bus types and PM domains that the device
+ * needs to remain powered in system suspend, in case wakeup is enabled for it.
  */
 #define DPM_FLAG_NEVER_SKIP	BIT(0)
 #define DPM_FLAG_SMART_PREPARE	BIT(1)
 #define DPM_FLAG_SMART_SUSPEND	BIT(2)
+#define DPM_FLAG_IN_BAND_WAKEUP	BIT(3)
 
 struct dev_pm_info {
 	pm_message_t		power_state;
@@ -595,6 +600,7 @@ struct dev_pm_info {
 	struct completion	completion;
 	struct wakeup_source	*wakeup;
 	bool			wakeup_path:1;
+	bool			wakeup_path_in_band:1;
 	bool			syscore:1;
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
 #else
-- 
2.7.4
