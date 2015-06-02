From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [RFC/PATCH 4/6] OPP: Allow notifiers to call dev_pm_opp_get_{voltage,freq} RCU-free
Date: Mon,  1 Jun 2015 18:47:57 -0700
Message-ID: <1433209679-31389-5-git-send-email-sboyd@codeaurora.org>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

We pass the dev_pm_opp structure to OPP notifiers but the users
of the notifier need to surround calls to dev_pm_opp_get_*() with
RCU read locks to avoid lockdep warnings. The notifier is already
called with the dev_opp's srcu lock held, so it should be safe to
assume the devm_pm_opp structure is already protected inside the
notifier. Update the lockdep check for this.

Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This is probably wrong, but it's what I had to hack up
to be able to use the OPP functions from within the notifier
to figure out the new values of the OPP without having to take
an RCU read lock.

 drivers/base/power/opp.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index b997a7eabcd4..6d75022c6a0e 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -108,9 +108,10 @@ static LIST_HEAD(dev_opp_list);
 /* Lock to allow exclusive modification to the device and opp lists */
 static DEFINE_MUTEX(dev_opp_list_lock);
 
-#define opp_rcu_lockdep_assert()					\
+#define opp_rcu_lockdep_assert(s)					\
 do {									\
 	rcu_lockdep_assert(rcu_read_lock_held() ||			\
+				(s && srcu_read_lock_held(s)) || 	\
 				lockdep_is_held(&dev_opp_list_lock),	\
 			   "Missing rcu_read_lock() or "		\
 			   "dev_opp_list_lock protection");		\
@@ -169,9 +170,10 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 	struct dev_pm_opp *tmp_opp;
 	unsigned long v = 0;
 
-	opp_rcu_lockdep_assert();
+	opp_rcu_lockdep_assert(&opp->dev_opp->srcu_head.srcu);
 
-	tmp_opp = rcu_dereference(opp);
+	tmp_opp = srcu_dereference_check(opp, &opp->dev_opp->srcu_head.srcu,
+					 rcu_read_lock_held());
 	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
 		pr_err("%s: Invalid parameters\n", __func__);
 	else
@@ -201,9 +203,10 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 	struct dev_pm_opp *tmp_opp;
 	unsigned long f = 0;
 
-	opp_rcu_lockdep_assert();
+	opp_rcu_lockdep_assert(&opp->dev_opp->srcu_head.srcu);
 
-	tmp_opp = rcu_dereference(opp);
+	tmp_opp = srcu_dereference_check(opp, &opp->dev_opp->srcu_head.srcu,
+					 rcu_read_lock_held());
 	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
 		pr_err("%s: Invalid parameters\n", __func__);
 	else
@@ -282,7 +285,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
-	opp_rcu_lockdep_assert();
+	opp_rcu_lockdep_assert(NULL);
 
 	dev_opp = _find_device_opp(dev);
 	if (IS_ERR(dev_opp)) {
@@ -330,7 +333,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
-	opp_rcu_lockdep_assert();
+	opp_rcu_lockdep_assert(NULL);
 
 	if (!dev || !freq) {
 		dev_err(dev, "%s: Invalid argument freq=%p\n", __func__, freq);
@@ -380,7 +383,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
-	opp_rcu_lockdep_assert();
+	opp_rcu_lockdep_assert(NULL);
 
 	if (!dev || !freq) {
 		dev_err(dev, "%s: Invalid argument freq=%p\n", __func__, freq);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
