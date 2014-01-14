From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 3/3] power: clock_ops.c: report clock errors from clk_enable()
Date: Tue, 14 Jan 2014 12:23:42 +0000
Message-ID: <1389702222-17260-4-git-send-email-ben.dooks@codethink.co.uk>
References: <1389702222-17260-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389702222-17260-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If clk_enable() fails, then print a message so that the user can see
what is happening instead of silently failing to enable the clock.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
---
 drivers/base/power/clock_ops.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index cad7190..e870bbe 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -33,6 +33,21 @@ struct pm_clock_entry {
 };
 
 /**
+ * pm_clk_enable - Enable a clock, reporting any errors
+ * @dev: The device for the given clock
+ * @clk: The clock being enabled.
+ */
+static inline int __pm_clk_enable(struct device *dev, struct clk *clk)
+{
+	int ret = clk_enable(clk);
+	if (ret)
+		dev_err(dev, "%s: failed to enable clk %p, error %d\n",
+			__func__, clk, ret);
+
+	return ret;
+}
+
+/**
  * pm_clk_acquire - Acquire a device clock.
  * @dev: Device whose clock is to be acquired.
  * @ce: PM clock entry corresponding to the clock.
@@ -263,7 +278,7 @@ int pm_clk_resume(struct device *dev)
 
 	list_for_each_entry(ce, &psd->clock_list, node) {
 		if (ce->status < PCE_STATUS_ERROR) {
-			ret = clk_enable(ce->clk);
+			ret = __pm_clk_enable(dev, ce->clk);
 			if (!ret)
 				ce->status = PCE_STATUS_ENABLED;
 		}
@@ -381,7 +396,7 @@ int pm_clk_resume(struct device *dev)
 	spin_lock_irqsave(&psd->lock, flags);
 
 	list_for_each_entry(ce, &psd->clock_list, node)
-		clk_enable(ce->clk);
+		__pm_clk_enable(dev, ce->clk);
 
 	spin_unlock_irqrestore(&psd->lock, flags);
 
-- 
1.8.5.2
