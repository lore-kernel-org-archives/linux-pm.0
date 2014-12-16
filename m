From: Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH] PM / OPP: add some lockdep annotations
Date: Mon, 15 Dec 2014 16:42:04 -0800
Message-ID: <20141216004204.GA30467@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:41499 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbaLPAmR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 19:42:17 -0500
Received: by mail-yk0-f180.google.com with SMTP id 9so5496547ykp.11
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2014 16:42:16 -0800 (PST)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Certain OPP APIs need to be called under RCU lock; let's add a few
rcu_lockdep_assert() calls to warn about potential misuse.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/base/power/opp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index d24dd614a..852eebf 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -218,6 +218,11 @@ int dev_pm_opp_get_opp_count(struct device *dev)
 	struct dev_pm_opp *temp_opp;
 	int count = 0;
 
+	rcu_lockdep_assert(rcu_read_lock_held() ||
+				lockdep_is_held(&dev_opp_list_lock),
+			   "dev_pm_opp_get_opp_count() needs rcu_read_lock() "
+			   "or dev_opp_list_lock protection");
+
 	dev_opp = find_device_opp(dev);
 	if (IS_ERR(dev_opp)) {
 		int r = PTR_ERR(dev_opp);
@@ -267,6 +272,11 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
+	rcu_lockdep_assert(rcu_read_lock_held() ||
+				lockdep_is_held(&dev_opp_list_lock),
+			   "dev_pm_opp_find_freq_exact() needs rcu_read_lock() "
+			   "or dev_opp_list_lock protection");
+
 	dev_opp = find_device_opp(dev);
 	if (IS_ERR(dev_opp)) {
 		int r = PTR_ERR(dev_opp);
@@ -313,6 +323,11 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
+	rcu_lockdep_assert(rcu_read_lock_held() ||
+				lockdep_is_held(&dev_opp_list_lock),
+			   "dev_pm_opp_find_freq_ceil() needs rcu_read_lock() "
+			   "or dev_opp_list_lock protection");
+
 	if (!dev || !freq) {
 		dev_err(dev, "%s: Invalid argument freq=%p\n", __func__, freq);
 		return ERR_PTR(-EINVAL);
@@ -361,6 +376,11 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
+	rcu_lockdep_assert(rcu_read_lock_held() ||
+				lockdep_is_held(&dev_opp_list_lock),
+			   "dev_pm_opp_find_freq_floor() needs rcu_read_lock() "
+			   "or dev_opp_list_lock protection");
+
 	if (!dev || !freq) {
 		dev_err(dev, "%s: Invalid argument freq=%p\n", __func__, freq);
 		return ERR_PTR(-EINVAL);
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
