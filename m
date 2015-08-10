From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V1 Resend 02/11] PM / OPP: Drop unlikely before IS_ERR(_OR_NULL)
Date: Mon, 10 Aug 2015 11:42:24 +0530
Message-ID: <c3394808aef37f65b0fa2db650cf0cf1bfcaa970.1439187003.git.viresh.kumar@linaro.org>
References: <cover.1439187003.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33027 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbbHJGNK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 02:13:10 -0400
Received: by pdrh1 with SMTP id h1so49693366pdr.0
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2015 23:13:10 -0700 (PDT)
In-Reply-To: <cover.1439187003.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1439187003.git.viresh.kumar@linaro.org>
References: <cover.1439187003.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
is no need to do that again from its callers. Drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 3b188f20b43f..1a6bbfa53b6f 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -134,7 +134,7 @@ static struct device_opp *_find_device_opp(struct device *dev)
 {
 	struct device_opp *tmp_dev_opp, *dev_opp = ERR_PTR(-ENODEV);
 
-	if (unlikely(IS_ERR_OR_NULL(dev))) {
+	if (IS_ERR_OR_NULL(dev)) {
 		pr_err("%s: Invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
@@ -172,7 +172,7 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 	opp_rcu_lockdep_assert();
 
 	tmp_opp = rcu_dereference(opp);
-	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
+	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available)
 		pr_err("%s: Invalid parameters\n", __func__);
 	else
 		v = tmp_opp->u_volt;
@@ -204,7 +204,7 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 	opp_rcu_lockdep_assert();
 
 	tmp_opp = rcu_dereference(opp);
-	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
+	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available)
 		pr_err("%s: Invalid parameters\n", __func__);
 	else
 		f = tmp_opp->rate;
-- 
2.4.0

