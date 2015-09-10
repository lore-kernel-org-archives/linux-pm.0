From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v6 2/5] PM / OPP: get the voltage for all OPPs
Date: Thu, 10 Sep 2015 18:09:29 +0100
Message-ID: <1441904972-5809-3-git-send-email-javi.merino@arm.com>
References: <1441904972-5809-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34827 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbbIJRMp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Sep 2015 13:12:45 -0400
In-Reply-To: <1441904972-5809-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

The OPP library is now used for power models to calculate the power
that a device would consume at a specific OPP.  To do that, we use a
simple power model which takes frequency and voltage as inputs.  We get
the voltage and frequency from the OPP library.

The devfreq cooling device for the thermal framework controls
temperature by disabling OPPs.  The power model needs to calculate the
power that would be consumed if we reenabled the OPP.  Therefore, let
dev_pm_opp_get_voltage() work for disabled OPPs.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/base/power/opp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index eb254497a494..c9a0187bba10 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -217,7 +217,7 @@ static struct device_opp *_find_device_opp(struct device *dev)
 }
 
 /**
- * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an available opp
+ * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an opp
  * @opp:	opp for which voltage has to be returned for
  *
  * Return: voltage in micro volt corresponding to the opp, else
@@ -239,7 +239,7 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 	opp_rcu_lockdep_assert();
 
 	tmp_opp = rcu_dereference(opp);
-	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available)
+	if (IS_ERR_OR_NULL(tmp_opp))
 		pr_err("%s: Invalid parameters\n", __func__);
 	else
 		v = tmp_opp->u_volt;
-- 
1.9.1

