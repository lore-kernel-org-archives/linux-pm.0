From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] cpufreq: Make cpufreq_boost_supported() static
Date: Sun, 27 Dec 2015 00:23:48 +0100
Message-ID: <7055444.k3FMydYOLT@vostro.rjw.lan>
References: <2196419.fjWAQbI2Nm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2196419.fjWAQbI2Nm@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

cpufreq_boost_supported() is not used outside of cpufreq.c, so make
it static.

While at it, refactor it as a one-liner (which it really is).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    8 ++------
 include/linux/cpufreq.h   |    5 -----
 2 files changed, 2 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2330,14 +2330,10 @@ int cpufreq_boost_trigger_state(int stat
 	return ret;
 }
 
-int cpufreq_boost_supported(void)
+static bool cpufreq_boost_supported(void)
 {
-	if (likely(cpufreq_driver))
-		return cpufreq_driver->boost_supported;
-
-	return 0;
+	return likely(cpufreq_driver) && cpufreq_driver->boost_supported;
 }
-EXPORT_SYMBOL_GPL(cpufreq_boost_supported);
 
 static int create_boost_sysfs_file(void)
 {
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -574,7 +574,6 @@ ssize_t cpufreq_show_cpus(const struct c
 
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_boost_trigger_state(int state);
-int cpufreq_boost_supported(void);
 int cpufreq_boost_enabled(void);
 int cpufreq_enable_boost_support(void);
 bool policy_has_boost_freq(struct cpufreq_policy *policy);
@@ -583,10 +582,6 @@ static inline int cpufreq_boost_trigger_
 {
 	return 0;
 }
-static inline int cpufreq_boost_supported(void)
-{
-	return 0;
-}
 static inline int cpufreq_boost_enabled(void)
 {
 	return 0;
