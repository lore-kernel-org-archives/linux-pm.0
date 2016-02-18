From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 10/12] cpufreq: governor: Relocate definitions of tuners structures
Date: Thu, 18 Feb 2016 02:32:53 +0100
Message-ID: <1878988.D1d202zxB7@vostro.rjw.lan>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2938006.67J0esUvOA@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the definitions of struct od_dbs_tuners and struct cs_dbs_tuners
from the common governor header to the ondemand and conservative
governor code, respectively, as they don't need to be in the common
header any more.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_conservative.c |    5 +++++
 drivers/cpufreq/cpufreq_governor.h     |   10 ----------
 drivers/cpufreq/cpufreq_ondemand.c     |    4 ++++
 3 files changed, 9 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -25,6 +25,11 @@ static inline struct cs_policy_dbs_info
 	return container_of(policy_dbs, struct cs_policy_dbs_info, policy_dbs);
 }
 
+struct cs_dbs_tuners {
+	unsigned int down_threshold;
+	unsigned int freq_step;
+};
+
 /* Conservative governor macros */
 #define DEF_FREQUENCY_UP_THRESHOLD		(80)
 #define DEF_FREQUENCY_DOWN_THRESHOLD		(20)
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -148,16 +148,6 @@ struct cpu_dbs_info {
 	struct policy_dbs_info *policy_dbs;
 };
 
-/* Per policy Governors sysfs tunables */
-struct od_dbs_tuners {
-	unsigned int powersave_bias;
-};
-
-struct cs_dbs_tuners {
-	unsigned int down_threshold;
-	unsigned int freq_step;
-};
-
 /* Common Governor data across policies */
 struct dbs_governor {
 	struct cpufreq_governor gov;
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -32,6 +32,10 @@ static inline struct od_policy_dbs_info
 	return container_of(policy_dbs, struct od_policy_dbs_info, policy_dbs);
 }
 
+struct od_dbs_tuners {
+	unsigned int powersave_bias;
+};
+
 /* On-demand governor macros */
 #define DEF_FREQUENCY_UP_THRESHOLD		(80)
 #define DEF_SAMPLING_DOWN_FACTOR		(1)
