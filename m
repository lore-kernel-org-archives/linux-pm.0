From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 14/15] power-supply: Avoid unnecessary 'goto' statements
Date: Thu,  4 Sep 2014 17:31:35 +0530
Message-ID: <1a001657c973ac4f639844d8501e0573f1b7bc80.1409831636.git.viresh.kumar@linaro.org>
References: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:54535 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaIDMDP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:03:15 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so204808pdj.34
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:03:14 -0700 (PDT)
In-Reply-To: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409831636.git.viresh.kumar@linaro.org>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Using 'goto' statements for freeing resources on failures is a good choice as it
makes code very clean, and reduces the chances of human errors.

Though in most cases compiler may take care of this. But adding unnecessary
'goto' statements wouldn't make anything better. Code becomes less readable
actually.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
I am not sure if Maintainers would like this patch specially, but I just wanted
to give a try at making code better. Sorry if you didn't like it :)
---
 drivers/power/power_supply_core.c |  3 +--
 drivers/power/power_supply_leds.c | 19 ++++---------------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 376464e..81177e2 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -599,7 +599,7 @@ static int __power_supply_register(struct device *parent,
 
 	power_supply_changed(psy);
 
-	goto success;
+	return 0;
 
 create_triggers_failed:
 	psy_unregister_cooler(psy);
@@ -612,7 +612,6 @@ static int __power_supply_register(struct device *parent,
 check_supplies_failed:
 dev_set_name_failed:
 	put_device(dev);
-success:
 	return rc;
 }
 
diff --git a/drivers/power/power_supply_leds.c b/drivers/power/power_supply_leds.c
index 995f966..effa093 100644
--- a/drivers/power/power_supply_leds.c
+++ b/drivers/power/power_supply_leds.c
@@ -57,8 +57,6 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 
 static int power_supply_create_bat_triggers(struct power_supply *psy)
 {
-	int rc = 0;
-
 	psy->charging_full_trig_name = kasprintf(GFP_KERNEL,
 					"%s-charging-or-full", psy->name);
 	if (!psy->charging_full_trig_name)
@@ -87,7 +85,7 @@ static int power_supply_create_bat_triggers(struct power_supply *psy)
 	led_trigger_register_simple(psy->charging_blink_full_solid_trig_name,
 				    &psy->charging_blink_full_solid_trig);
 
-	goto success;
+	return 0;
 
 charging_blink_full_solid_failed:
 	kfree(psy->full_trig_name);
@@ -96,9 +94,7 @@ static int power_supply_create_bat_triggers(struct power_supply *psy)
 charging_failed:
 	kfree(psy->charging_full_trig_name);
 charging_full_failed:
-	rc = -ENOMEM;
-success:
-	return rc;
+	return -ENOMEM;
 }
 
 static void power_supply_remove_bat_triggers(struct power_supply *psy)
@@ -132,20 +128,13 @@ static void power_supply_update_gen_leds(struct power_supply *psy)
 
 static int power_supply_create_gen_triggers(struct power_supply *psy)
 {
-	int rc = 0;
-
 	psy->online_trig_name = kasprintf(GFP_KERNEL, "%s-online", psy->name);
 	if (!psy->online_trig_name)
-		goto online_failed;
+		return -ENOMEM;
 
 	led_trigger_register_simple(psy->online_trig_name, &psy->online_trig);
 
-	goto success;
-
-online_failed:
-	rc = -ENOMEM;
-success:
-	return rc;
+	return 0;
 }
 
 static void power_supply_remove_gen_triggers(struct power_supply *psy)
-- 
2.0.3.693.g996b0fd

