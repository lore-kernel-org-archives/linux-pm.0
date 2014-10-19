From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v3 1/3] cpufreq: allow driver-specific data
Date: Sun, 19 Oct 2014 11:30:27 +0200
Message-ID: <1413711029-17419-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1413711029-17419-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1413711029-17419-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

This commit extends the cpufreq_driver structure with an additional
'void *driver_data' field that can be filled by the ->probe() function
of a cpufreq driver to pass additional custom information to the
driver itself.

A new function called cpufreq_get_driver_data() is added to allow a
cpufreq driver to retrieve those driver data, since they are typically
needed from a cpufreq_policy->init() callback, which does not have
access to the cpufreq_driver structure. This function call is similar
to the existing cpufreq_get_current_driver() function call.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 15 +++++++++++++++
 include/linux/cpufreq.h   |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 24bf76f..058d6e0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1731,6 +1731,21 @@ const char *cpufreq_get_current_driver(void)
 }
 EXPORT_SYMBOL_GPL(cpufreq_get_current_driver);
 
+/**
+ *	cpufreq_get_driver_data - return current driver data
+ *
+ *	Return the private data of the currently loaded cpufreq
+ *	driver, or NULL if no cpufreq driver is loaded.
+ */
+void *cpufreq_get_driver_data(void)
+{
+	if (cpufreq_driver)
+		return cpufreq_driver->driver_data;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(cpufreq_get_driver_data);
+
 /*********************************************************************
  *                     NOTIFIER LISTS INTERFACE                      *
  *********************************************************************/
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 138336b..503b085 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -219,6 +219,7 @@ __ATTR(_name, 0644, show_##_name, store_##_name)
 struct cpufreq_driver {
 	char			name[CPUFREQ_NAME_LEN];
 	u8			flags;
+	void			*driver_data;
 
 	/* needed by all drivers */
 	int	(*init)		(struct cpufreq_policy *policy);
@@ -312,6 +313,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
 const char *cpufreq_get_current_driver(void);
+void *cpufreq_get_driver_data(void);
 
 static inline void cpufreq_verify_within_limits(struct cpufreq_policy *policy,
 		unsigned int min, unsigned int max)
-- 
2.0.0
