From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC/RFT 1/6] PM / clock_ops: Make pm_clk_notify() do nothing in case DT passes power-domains
Date: Thu, 23 Apr 2015 14:15:39 +0530
Message-ID: <1429778744-13352-2-git-send-email-rnayak@codeaurora.org>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

pm_clk_notify() intends to do nothing if the device is associated
with a pm_domain other than whats stored in pm_clk_notifier_block.
In case of DT though, just checking for an existing dev->pm_domain
is not very useful as dev->pm_domain actually gets populated much later.

Add a check for a 'power-domains' DT property to identify if the
device would be assocaiated with a different power domain at
a later point in time.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/base/power/clock_ops.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 8abea66..6618818 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #ifdef CONFIG_PM
 
@@ -323,6 +324,7 @@ int pm_clk_resume(struct device *dev)
  * of PM clocks, depending on @action.
  *
  * If the device's pm_domain field is already populated with a value different
+ * or is expected to be populated with a different value later (in case of DT)
  * from the one stored in the struct pm_clk_notifier_block object, the function
  * does nothing.
  */
@@ -332,7 +334,7 @@ static int pm_clk_notify(struct notifier_block *nb,
 	struct pm_clk_notifier_block *clknb;
 	struct device *dev = data;
 	char **con_id;
-	int error;
+	int error, sz;
 
 	dev_dbg(dev, "%s() %ld\n", __func__, action);
 
@@ -343,6 +345,10 @@ static int pm_clk_notify(struct notifier_block *nb,
 		if (dev->pm_domain)
 			break;
 
+		/* With DT dev->pm_domain hookup happens later */
+		if (of_find_property(dev->of_node, "power-domains", &sz))
+			break;
+
 		error = pm_clk_create(dev);
 		if (error)
 			break;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
