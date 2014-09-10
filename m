From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/4] cpufreq: allow driver-specific flags
Date: Wed, 10 Sep 2014 11:41:49 +0200
Message-ID: <1410342112-13264-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
 <1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

Exactly like the cpuidle subsystem separates core cpuidle flags from
driver-specific cpuidle flags, this commit extends the cpufreq
subsystem with the same idea: the cpufreq_driver->flags field contain
the existing core cpufreq flags in the low 16 bits, and
driver-specific flags in the high 16 bits.

A new function called cpufreq_get_driver_flags() is added to allow a
cpufreq driver to retrieve those flags, since they are typically
needed from a cpufreq_policy->init() callback, which does not have
access to the cpufreq_driver structure. This function call is similar
to the existing cpufreq_get_current_driver() function call.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/cpufreq/cpufreq.c | 15 +++++++++++++++
 include/linux/cpufreq.h   |  5 ++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d9fdedd..e41b971 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1728,6 +1728,21 @@ const char *cpufreq_get_current_driver(void)
 }
 EXPORT_SYMBOL_GPL(cpufreq_get_current_driver);
 
+/**
+ *	cpufreq_get_driver_flags - return current driver's flags
+ *
+ *	Return the flags of the currently loaded cpufreq driver, or 0
+ *	if none.
+ */
+unsigned int cpufreq_get_driver_flags(void)
+{
+	if (cpufreq_driver)
+		return cpufreq_driver->flags & CPUFREQ_DRIVER_FLAGS_MASK;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_get_driver_flags);
+
 /*********************************************************************
  *                     NOTIFIER LISTS INTERFACE                      *
  *********************************************************************/
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 138336b..fa35601 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -218,7 +218,7 @@ __ATTR(_name, 0644, show_##_name, store_##_name)
 
 struct cpufreq_driver {
 	char			name[CPUFREQ_NAME_LEN];
-	u8			flags;
+	unsigned int		flags;
 
 	/* needed by all drivers */
 	int	(*init)		(struct cpufreq_policy *policy);
@@ -308,10 +308,13 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_NEED_INITIAL_FREQ_CHECK	(1 << 5)
 
+#define CPUFREQ_DRIVER_FLAGS_MASK (0xFFFF0000)
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
 const char *cpufreq_get_current_driver(void);
+unsigned int cpufreq_get_driver_flags(void);
 
 static inline void cpufreq_verify_within_limits(struct cpufreq_policy *policy,
 		unsigned int min, unsigned int max)
-- 
2.0.0
