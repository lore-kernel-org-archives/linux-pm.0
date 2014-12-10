From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/5] opp: reuse find_device_opp() instead of duplicating code
Date: Wed, 10 Dec 2014 09:45:33 +0530
Message-ID: <d2470f790112ca54e10a63f024314f11ea22f713.1418184737.git.viresh.kumar@linaro.org>
References: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:46314 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310AbaLJEQR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Dec 2014 23:16:17 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so1989070pab.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2014 20:16:17 -0800 (PST)
In-Reply-To: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
In-Reply-To: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
References: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Reuse find_device_opp() in opp_set_availability() instead of duplicating code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index fa065d6e1731..525ffb202d77 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -597,7 +597,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 static int opp_set_availability(struct device *dev, unsigned long freq,
 		bool availability_req)
 {
-	struct device_opp *tmp_dev_opp, *dev_opp = ERR_PTR(-ENODEV);
+	struct device_opp *dev_opp;
 	struct dev_pm_opp *new_opp, *tmp_opp, *opp = ERR_PTR(-ENODEV);
 	int r = 0;
 
@@ -611,12 +611,7 @@ static int opp_set_availability(struct device *dev, unsigned long freq,
 	mutex_lock(&dev_opp_list_lock);
 
 	/* Find the device_opp */
-	list_for_each_entry(tmp_dev_opp, &dev_opp_list, node) {
-		if (dev == tmp_dev_opp->dev) {
-			dev_opp = tmp_dev_opp;
-			break;
-		}
-	}
+	dev_opp = find_device_opp(dev);
 	if (IS_ERR(dev_opp)) {
 		r = PTR_ERR(dev_opp);
 		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);
-- 
2.2.0

