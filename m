From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] PM / core: Add WAKEUP_PATH driver flag
Date: Fri, 15 Dec 2017 16:56:30 +0100
Message-ID: <1513353391-30806-3-git-send-email-ulf.hansson@linaro.org>
References: <1513353391-30806-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513353391-30806-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

During system suspend, a driver may find that the wakeup setting is enabled
for its device and therefore configures it to deliver system wakeup
signals.

Additionally, sometimes the driver and its device, relies on some further
consumed resource, like an irqchip or a phy for example, to stay powered
on, as to be able to deliver system wakeup signals.

In general the driver deals with this, via raising an "enable count" of the
consumed resource or via a subsystem specific API, like irq_set_irq_wake()
or enable|disable_irq_wake() for an irqchip.

However, this information about the wakeup path for resources, is currently
not available to a PM domain (unless it has some HW-logic that knows this),
which means that it may decide to power off a device and its PM domain. In
other words, it may prevent the wakeup signal from being delivered.

For this reason, let's introduce a new WAKEUP_PATH driver flag, to allow a
driver to indicate that it controls a resource needed in the wakeup path.
Make the PM core to check the WAKEUP_PATH flag immediately after the
->suspend() callback has been invoked and set the wakeup_path status flag
accordingly. In this way the wakeup_path flag also becomes propagated to
the parent device, which may be useful for some cases.

For a PM domain that needs the information about the wakeup path, it should
check the wakeup_path status flag for its attached devices in a later
suspend phase, but perhaps also the WAKEUP_PATH driver flag explicitly, in
case it has been set after the ->suspend() callback has been invoked for
the device.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/main.c | 3 ++-
 include/linux/pm.h        | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 810e5fb..1327726 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1620,7 +1620,8 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
  End:
 	if (!error) {
 		dev->power.is_suspended = true;
-		if (device_may_wakeup(dev))
+		if (device_may_wakeup(dev) ||
+		    dev_pm_test_driver_flags(dev, DPM_FLAG_WAKEUP_PATH))
 			dev->power.wakeup_path = true;
 		dpm_propagate_to_parent(dev);
 		dpm_clear_suppliers_direct_complete(dev);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index e723b78..ebc6ef8 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -560,6 +560,7 @@ struct pm_subsys_data {
  * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
  * SMART_SUSPEND: No need to resume the device from runtime suspend.
  * LEAVE_SUSPENDED: Avoid resuming the device during system resume if possible.
+ * WAKEUP_PATH: The device is used in the wakeup path from system suspend.
  *
  * Setting SMART_PREPARE instructs bus types and PM domains which may want
  * system suspend/resume callbacks to be skipped for the device to return 0 from
@@ -576,11 +577,17 @@ struct pm_subsys_data {
  *
  * Setting LEAVE_SUSPENDED informs the PM core and middle-layer code that the
  * driver prefers the device to be left in suspend after system resume.
+ *
+ * Setting WAKEUP_PATH informs the PM core and the PM domain, that the device is
+ * a part of the wakeup path at system suspend. The PM core detects this flag
+ * and sets the wakeup_path status flag immeditaley after the ->suspend()
+ * callback has been invoked for the the device.
  */
 #define DPM_FLAG_NEVER_SKIP		BIT(0)
 #define DPM_FLAG_SMART_PREPARE		BIT(1)
 #define DPM_FLAG_SMART_SUSPEND		BIT(2)
 #define DPM_FLAG_LEAVE_SUSPENDED	BIT(3)
+#define DPM_FLAG_WAKEUP_PATH		BIT(4)
 
 struct dev_pm_info {
 	pm_message_t		power_state;
-- 
2.7.4
