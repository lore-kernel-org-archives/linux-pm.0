From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v4 1/2] PM / core: Re-structure code for clearing the direct_complete flag
Date: Tue,  9 Jan 2018 10:03:39 +0100
Message-ID: <1515488620-10575-2-git-send-email-ulf.hansson@linaro.org>
References: <1515488620-10575-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1515488620-10575-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

To make the code more consistent, let's clear the parent's direct_complete
flag along with clearing it for suppliers, instead of as currently, when
propagating the wakeup_path flag to parents.

While changing this, let's take the opportunity to rename the affected
internal functions, to make them self-explanatory. Like this:

dpm_clear_suppliers_direct_complete -> dpm_clear_superiors_direct_complete
dpm_propagate_to_parent -> dpm_propagate_wakeup_to_parent

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index ebcec7e..720e36e 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1660,7 +1660,7 @@ static int legacy_suspend(struct device *dev, pm_message_t state,
 	return error;
 }
 
-static void dpm_propagate_to_parent(struct device *dev)
+static void dpm_propagate_wakeup_to_parent(struct device *dev)
 {
 	struct device *parent = dev->parent;
 
@@ -1669,18 +1669,23 @@ static void dpm_propagate_to_parent(struct device *dev)
 
 	spin_lock_irq(&parent->power.lock);
 
-	parent->power.direct_complete = false;
 	if (dev->power.wakeup_path && !parent->power.ignore_children)
 		parent->power.wakeup_path = true;
 
 	spin_unlock_irq(&parent->power.lock);
 }
 
-static void dpm_clear_suppliers_direct_complete(struct device *dev)
+static void dpm_clear_superiors_direct_complete(struct device *dev)
 {
 	struct device_link *link;
 	int idx;
 
+	if (dev->parent) {
+		spin_lock_irq(&dev->parent->power.lock);
+		dev->parent->power.direct_complete = false;
+		spin_unlock_irq(&dev->parent->power.lock);
+	}
+
 	idx = device_links_read_lock();
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
@@ -1791,8 +1796,8 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 		if (device_may_wakeup(dev))
 			dev->power.wakeup_path = true;
 
-		dpm_propagate_to_parent(dev);
-		dpm_clear_suppliers_direct_complete(dev);
+		dpm_propagate_wakeup_to_parent(dev);
+		dpm_clear_superiors_direct_complete(dev);
 	}
 
 	device_unlock(dev);
-- 
2.7.4
