From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 11/15] power-supply: Mark 'if' blocks in power_supply_changed_work() with 'likely'
Date: Thu,  4 Sep 2014 17:31:32 +0530
Message-ID: <fa90116c19ac2415fa9981de6ca115c58143cf56.1409831636.git.viresh.kumar@linaro.org>
References: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:55791 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926AbaIDMDD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:03:03 -0400
Received: by mail-pa0-f53.google.com with SMTP id fa1so20047661pad.12
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:03:00 -0700 (PDT)
In-Reply-To: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409831636.git.viresh.kumar@linaro.org>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Zoran Markovic <zrn.markovic@gmail.com>

The 'if' statements in power_supply_changed_work() are mostly there for taking
care of races and normally they will always evaluate to true. Optimize them for
fast execution with 'likely' statements.

Also there is need to have better comments in code to mention about the races
clearly. Get them in place.

Cc: Zoran Markovic <zrn.markovic@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/power/power_supply_core.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index bcff7fd..26518c8 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -78,7 +78,14 @@ static void power_supply_changed_work(struct work_struct *work)
 	dev_dbg(psy->dev, "%s\n", __func__);
 
 	spin_lock_irqsave(&psy->changed_lock, flags);
-	if (psy->changed) {
+	/*
+	 * Check 'changed' here to avoid issues due to race between
+	 * power_supply_changed() and this routine. In worst case
+	 * power_supply_changed() can be called again just before we take above
+	 * lock. During the first call of this routine we will mark 'changed' as
+	 * false and it will stay false for the next call as well.
+	 */
+	if (likely(psy->changed)) {
 		psy->changed = false;
 		spin_unlock_irqrestore(&psy->changed_lock, flags);
 		class_for_each_device(power_supply_class, NULL, psy,
@@ -89,12 +96,13 @@ static void power_supply_changed_work(struct work_struct *work)
 		kobject_uevent(&psy->dev->kobj, KOBJ_CHANGE);
 		spin_lock_irqsave(&psy->changed_lock, flags);
 	}
+
 	/*
-	 * Dependent power supplies (e.g. battery) may have changed state
-	 * as a result of this event, so poll again and hold the
-	 * wakeup_source until all events are processed.
+	 * Hold the wakeup_source until all events are processed.
+	 * power_supply_changed() might have called again and have set 'changed'
+	 * to true.
 	 */
-	if (!psy->changed)
+	if (likely(!psy->changed))
 		pm_relax(psy->dev);
 	spin_unlock_irqrestore(&psy->changed_lock, flags);
 }
-- 
2.0.3.693.g996b0fd

