From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 2/4] PM / core: Propagate wakeup_path status flag in __device_suspend_late()
Date: Tue,  2 Jan 2018 17:08:51 +0100
Message-ID: <1514909333-4450-3-git-send-email-ulf.hansson@linaro.org>
References: <1514909333-4450-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1514909333-4450-1-git-send-email-ulf.hansson@linaro.org>
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
 drivers/base/power/main.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 7aeb91d..612bf1b 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1476,6 +1476,22 @@ static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
 	return callback;
 }
 
+static void dpm_propagate_to_parent(struct device *dev)
+{
+	struct device *parent = dev->parent;
+
+	if (!parent)
+		return;
+
+	spin_lock_irq(&parent->power.lock);
+
+	parent->power.direct_complete = false;
+	if (dev->power.wakeup_path && !parent->power.ignore_children)
+		parent->power.wakeup_path = true;
+
+	spin_unlock_irq(&parent->power.lock);
+}
+
 /**
  * __device_suspend_late - Execute a "late suspend" callback for given device.
  * @dev: Device to handle.
@@ -1528,6 +1544,7 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 		goto Complete;
 	}
 
+	dpm_propagate_to_parent(dev);
 Skip:
 	dev->power.is_late_suspended = true;
 
@@ -1660,22 +1677,6 @@ static int legacy_suspend(struct device *dev, pm_message_t state,
 	return error;
 }
 
-static void dpm_propagate_to_parent(struct device *dev)
-{
-	struct device *parent = dev->parent;
-
-	if (!parent)
-		return;
-
-	spin_lock_irq(&parent->power.lock);
-
-	parent->power.direct_complete = false;
-	if (dev->power.wakeup_path && !parent->power.ignore_children)
-		parent->power.wakeup_path = true;
-
-	spin_unlock_irq(&parent->power.lock);
-}
-
 static void dpm_clear_suppliers_direct_complete(struct device *dev)
 {
 	struct device_link *link;
-- 
2.7.4
