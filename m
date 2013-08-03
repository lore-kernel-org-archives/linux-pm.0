From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] OPP: Export opp_add()
Date: Sat,  3 Aug 2013 14:55:06 +0530
Message-ID: <58acb4a8a4e98089078de3ed71999730b6d97b4b.1375521724.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:42366 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab3HCJZZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Aug 2013 05:25:25 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so1509769pab.24
        for <linux-pm@vger.kernel.org>; Sat, 03 Aug 2013 02:25:25 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, pavel@ucw.cz
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Export opp_add() so that modules can use it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index c8ec186..ef89897 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -460,6 +460,7 @@ int opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	srcu_notifier_call_chain(&dev_opp->head, OPP_EVENT_ADD, new_opp);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(opp_add);
 
 /**
  * opp_set_availability() - helper to set the availability of an opp
-- 
1.7.12.rc2.18.g61b472e

