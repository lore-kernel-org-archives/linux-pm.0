From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 3/6] cpufreq: Implement cpufreq_generic_suspend()
Date: Mon, 25 Nov 2013 19:41:43 +0530
Message-ID: <2b3f1f76ff383697c1ee8c8eeb0029d95b53248f.1385374822.git.viresh.kumar@linaro.org>
References: <cover.1385374819.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1385374819.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1385374819.git.viresh.kumar@linaro.org>
References: <cover.1385374819.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nm@ti.com, swarren@wwwdotorg.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, jinchoi@broadcom.com, tianyu.lan@intel.com, sebastian.capella@linaro.org, jhbird.choi@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Multiple platforms need to set CPU to a particular frequency before suspending
system. And so they need a common infrastructure which is provided by this
patch. Those platforms just need to initialize their ->suspend() pointers with
the generic routine.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 25 +++++++++++++++++++++++++
 include/linux/cpufreq.h   |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 026efe4a..f6da551 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1466,6 +1466,31 @@ static struct subsys_interface cpufreq_interface = {
 };
 
 /*
+ * In case platform wants some specific frequency to be configured
+ * during suspend..
+ */
+int cpufreq_generic_suspend(struct cpufreq_policy *policy)
+{
+	int ret;
+
+	if (!policy->suspend_freq) {
+		pr_err("%s: suspend_freq can't be zero\n", __func__);
+		return -EINVAL;
+	}
+
+	pr_debug("%s: Setting suspend-freq: %u\n", __func__,
+			policy->suspend_freq);
+
+	ret = __cpufreq_driver_target(policy, policy->suspend_freq,
+			CPUFREQ_RELATION_H);
+	if (ret)
+		pr_err("%s: unable to set suspend-freq: %u. err: %d\n",
+				__func__, policy->suspend_freq, ret);
+
+	return ret;
+}
+
+/*
  * Callbacks for suspending/resuming governors as some platforms can't change
  * frequency after this point in suspend cycle. Because some of the devices
  * (like: i2c, regulators, etc) they use for changing frequency are suspended
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 6d93f91..94ccac5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -72,6 +72,8 @@ struct cpufreq_policy {
 	unsigned int		max;    /* in kHz */
 	unsigned int		cur;    /* in kHz, only needed if cpufreq
 					 * governors are used */
+	unsigned int		suspend_freq; /* freq to set during suspend */
+
 	unsigned int		policy; /* see above */
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
@@ -257,6 +259,7 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
 void cpufreq_suspend(void);
 void cpufreq_resume(void);
+int cpufreq_generic_suspend(struct cpufreq_policy *policy);
 
 const char *cpufreq_get_current_driver(void);
 
-- 
1.7.12.rc2.18.g61b472e

