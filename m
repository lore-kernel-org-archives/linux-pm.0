From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v4 2/2] PM / core: Propagate wakeup_path status flag in __device_suspend_late()
Date: Tue,  9 Jan 2018 10:03:40 +0100
Message-ID: <1515488620-10575-3-git-send-email-ulf.hansson@linaro.org>
References: <1515488620-10575-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1515488620-10575-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Currently the wakeup_path status flag becomes propagated from a child
device to its parent device at __device_suspend(). This allows a driver
dealing with a parent device to act on the flag from its ->suspend()
callback.

However, in situations when the wakeup_path status flag needs to be set
from a ->suspend_late() callback, its value doesn't get propagated to the
parent by the PM core. Let's address this limitation, by also propagating
the flag at __device_suspend_late().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/main.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 720e36e..02a497e 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1447,6 +1447,21 @@ int dpm_suspend_noirq(pm_message_t state)
 	return ret;
 }
 
+static void dpm_propagate_wakeup_to_parent(struct device *dev)
+{
+	struct device *parent = dev->parent;
+
+	if (!parent)
+		return;
+
+	spin_lock_irq(&parent->power.lock);
+
+	if (dev->power.wakeup_path && !parent->power.ignore_children)
+		parent->power.wakeup_path = true;
+
+	spin_unlock_irq(&parent->power.lock);
+}
+
 static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
 						pm_message_t state,
 						const char **info_p)
@@ -1527,6 +1542,7 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 		async_error = error;
 		goto Complete;
 	}
+	dpm_propagate_wakeup_to_parent(dev);
 
 Skip:
 	dev->power.is_late_suspended = true;
@@ -1660,21 +1676,6 @@ static int legacy_suspend(struct device *dev, pm_message_t state,
 	return error;
 }
 
-static void dpm_propagate_wakeup_to_parent(struct device *dev)
-{
-	struct device *parent = dev->parent;
-
-	if (!parent)
-		return;
-
-	spin_lock_irq(&parent->power.lock);
-
-	if (dev->power.wakeup_path && !parent->power.ignore_children)
-		parent->power.wakeup_path = true;
-
-	spin_unlock_irq(&parent->power.lock);
-}
-
 static void dpm_clear_superiors_direct_complete(struct device *dev)
 {
 	struct device_link *link;
-- 
2.7.4
