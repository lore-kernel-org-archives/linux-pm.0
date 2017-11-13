From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 1/3] PM / core: Re-factor some code dealing with parents in __device_suspend()
Date: Mon, 13 Nov 2017 16:46:41 +0100
Message-ID: <1510588003-16650-2-git-send-email-ulf.hansson@linaro.org>
References: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:47728 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753296AbdKMPqw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Nov 2017 10:46:52 -0500
Received: by mail-lf0-f67.google.com with SMTP id f125so18821249lff.4
        for <linux-pm@vger.kernel.org>; Mon, 13 Nov 2017 07:46:52 -0800 (PST)
In-Reply-To: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Let's make the code a bit more readable by moving some of the code, which
deals with adjustments for parent devices in __device_suspend(), into its
own function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v2:
	- Added Geert's Reviewed-by tag.

---
 drivers/base/power/main.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 6c6f1c7..8089e72 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1422,6 +1422,22 @@ static int legacy_suspend(struct device *dev, pm_message_t state,
 	return error;
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
 static void dpm_clear_suppliers_direct_complete(struct device *dev)
 {
 	struct device_link *link;
@@ -1530,19 +1546,8 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 
  End:
 	if (!error) {
-		struct device *parent = dev->parent;
-
 		dev->power.is_suspended = true;
-		if (parent) {
-			spin_lock_irq(&parent->power.lock);
-
-			dev->parent->power.direct_complete = false;
-			if (dev->power.wakeup_path
-			    && !dev->parent->power.ignore_children)
-				dev->parent->power.wakeup_path = true;
-
-			spin_unlock_irq(&parent->power.lock);
-		}
+		dpm_propagate_to_parent(dev);
 		dpm_clear_suppliers_direct_complete(dev);
 	}
 
-- 
2.7.4
