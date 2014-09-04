From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/15] power-supply: Drop unnecessary typecasts
Date: Thu,  4 Sep 2014 17:31:26 +0530
Message-ID: <0ac40f9754bce63d88f6ee14948802ca9a7878d7.1409831636.git.viresh.kumar@linaro.org>
References: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:52997 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaIDMCa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:02:30 -0400
Received: by mail-pa0-f48.google.com with SMTP id ey11so19768132pad.7
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:02:27 -0700 (PDT)
In-Reply-To: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409831636.git.viresh.kumar@linaro.org>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Typecast from 'void *' to any other pointer type falls under implicit typecasts
category and so doesn't require explicit typecasts. Drop them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/power/power_supply_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 414384a..71d00ec 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -58,7 +58,7 @@ static bool __power_supply_is_supplied_by(struct power_supply *supplier,
 
 static int __power_supply_changed_work(struct device *dev, void *data)
 {
-	struct power_supply *psy = (struct power_supply *)data;
+	struct power_supply *psy = data;
 	struct power_supply *pst = dev_get_drvdata(dev);
 
 	if (__power_supply_is_supplied_by(psy, pst)) {
@@ -119,7 +119,7 @@ EXPORT_SYMBOL_GPL(power_supply_changed);
 static int __power_supply_populate_supplied_from(struct device *dev,
 						 void *data)
 {
-	struct power_supply *psy = (struct power_supply *)data;
+	struct power_supply *psy = data;
 	struct power_supply *epsy = dev_get_drvdata(dev);
 	struct device_node *np;
 	int i = 0;
@@ -158,7 +158,7 @@ static int power_supply_populate_supplied_from(struct power_supply *psy)
 static int  __power_supply_find_supply_from_node(struct device *dev,
 						 void *data)
 {
-	struct device_node *np = (struct device_node *)data;
+	struct device_node *np = data;
 	struct power_supply *epsy = dev_get_drvdata(dev);
 
 	/* return error breaks out of class_for_each_device loop */
@@ -257,7 +257,7 @@ static inline int power_supply_check_supplies(struct power_supply *psy)
 static int __power_supply_am_i_supplied(struct device *dev, void *data)
 {
 	union power_supply_propval ret = {0,};
-	struct power_supply *psy = (struct power_supply *)data;
+	struct power_supply *psy = data;
 	struct power_supply *epsy = dev_get_drvdata(dev);
 
 	if (__power_supply_is_supplied_by(epsy, psy))
-- 
2.0.3.693.g996b0fd

