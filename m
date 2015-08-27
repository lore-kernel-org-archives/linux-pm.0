From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v5 2/5] PM / OPP: get the voltage for all OPPs
Date: Thu, 27 Aug 2015 11:55:48 +0100
Message-ID: <1440672951-7002-3-git-send-email-javi.merino@arm.com>
References: <1440672951-7002-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440672951-7002-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com, rufus.hamade@imgtec.com, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The OPP library is now used for power models to calculate the power
that a device would consume at a specific OPP.  To do that, we use a
simple power model which takes frequency and voltage as inputs.  We get
the voltage and frequency from the OPP library.

The devfreq cooling device for the thermal framework controls
temperature by disabling OPPs.  The power model needs to calculate the
power that would be consumed if we reenabled the OPP.  Therefore, let
dev_pm_opp_get_voltage() work for disabled OPPs.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/base/power/opp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 677fb2843553..3e5f7ae29ef9 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -150,7 +150,7 @@ static struct device_opp *_find_device_opp(struct device *dev)
 }
 
 /**
- * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an available opp
+ * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an opp
  * @opp:	opp for which voltage has to be returned for
  *
  * Return: voltage in micro volt corresponding to the opp, else
@@ -172,7 +172,7 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 	opp_rcu_lockdep_assert();
 
 	tmp_opp = rcu_dereference(opp);
-	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
+	if (unlikely(IS_ERR_OR_NULL(tmp_opp)))
 		pr_err("%s: Invalid parameters\n", __func__);
 	else
 		v = tmp_opp->u_volt;
-- 
1.9.1
