From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 03/10] PM / OPP: Rename _allocate_opp() to _opp_allocate()
Date: Wed,  7 Dec 2016 10:11:59 +0530
Message-ID: <32fbd8524d2c0575273dab3b580bb70b90316667.1481085478.git.viresh.kumar@linaro.org>
References: <cover.1481085478.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34757 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbcLGEmX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 23:42:23 -0500
Received: by mail-pg0-f46.google.com with SMTP id x23so157295111pgx.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2016 20:42:22 -0800 (PST)
In-Reply-To: <cover.1481085478.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1481085478.git.viresh.kumar@linaro.org>
References: <cover.1481085478.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

Make the naming consistent with how other routines are named.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 4 ++--
 drivers/base/power/opp/of.c   | 2 +-
 drivers/base/power/opp/opp.h  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 9ff816217c6e..621a3dc94bfe 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1027,7 +1027,7 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 
-struct dev_pm_opp *_allocate_opp(struct device *dev,
+struct dev_pm_opp *_opp_allocate(struct device *dev,
 				 struct opp_table **opp_table)
 {
 	struct dev_pm_opp *opp;
@@ -1180,7 +1180,7 @@ int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 	/* Hold our table modification lock here */
 	mutex_lock(&opp_table_lock);
 
-	new_opp = _allocate_opp(dev, &opp_table);
+	new_opp = _opp_allocate(dev, &opp_table);
 	if (!new_opp) {
 		ret = -ENOMEM;
 		goto unlock;
diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 996ca3b42f47..f8512ca2bf41 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -287,7 +287,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	/* Hold our table modification lock here */
 	mutex_lock(&opp_table_lock);
 
-	new_opp = _allocate_opp(dev, &opp_table);
+	new_opp = _opp_allocate(dev, &opp_table);
 	if (!new_opp) {
 		ret = -ENOMEM;
 		goto unlock;
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index af9f2b849a66..0f23a1059605 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -193,7 +193,7 @@ struct opp_table {
 struct opp_table *_find_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
 void _dev_pm_opp_remove_table(struct device *dev, bool remove_all);
-struct dev_pm_opp *_allocate_opp(struct device *dev, struct opp_table **opp_table);
+struct dev_pm_opp *_opp_allocate(struct device *dev, struct opp_table **opp_table);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table);
 void _opp_remove(struct opp_table *opp_table, struct dev_pm_opp *opp, bool notify);
 int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt, bool dynamic);
-- 
2.7.1.410.g6faf27b

