From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/15] PM / OPP: Drop unlikely before IS_ERR(_OR_NULL)
Date: Fri, 31 Jul 2015 14:08:22 +0530
Message-ID: <e1450411635640569812705b1945ffc2382a3a1f.1438331416.git.viresh.kumar@linaro.org>
References: <cover.1438331416.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438331416.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438331416.git.viresh.kumar@linaro.org>
References: <cover.1438331416.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "open list:HIBERNATION aka Software Suspend,
	aka swsusp" <linux-pm@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
is no need to do that again from its callers. Drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 677fb2843553..f60bdd5cbb71 100644
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
