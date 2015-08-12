From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V1 Resend 02/10] PM / OPP: Drop unlikely before IS_ERR(_OR_NULL)
Date: Wed, 12 Aug 2015 15:59:39 +0530
Message-ID: <455a29a594b92b9ba06b14249d8f61a7ffbbecc1.1439375087.git.viresh.kumar@linaro.org>
References: <cover.1439375087.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1439375087.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1439375087.git.viresh.kumar@linaro.org>
References: <cover.1439375087.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
is no need to do that again from its callers. Drop it.

Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 51b220e615d3..97c31170437d 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -204,7 +204,7 @@ static struct device_opp *_find_device_opp(struct device *dev)
 {
 	struct device_opp *dev_opp;
 
-	if (unlikely(IS_ERR_OR_NULL(dev))) {
+	if (IS_ERR_OR_NULL(dev)) {
 		pr_err("%s: Invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
@@ -239,7 +239,7 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 	opp_rcu_lockdep_assert();
 
 	tmp_opp = rcu_dereference(opp);
-	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
+	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available)
 		pr_err("%s: Invalid parameters\n", __func__);
 	else
 		v = tmp_opp->u_volt;
@@ -271,7 +271,7 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 	opp_rcu_lockdep_assert();
 
 	tmp_opp = rcu_dereference(opp);
-	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
+	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available)
 		pr_err("%s: Invalid parameters\n", __func__);
 	else
 		f = tmp_opp->rate;
-- 
2.4.0
