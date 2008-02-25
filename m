From: Yi Yang <yi.y.yang@intel.com>
Subject: [PATCH 2.6.25-rc3] cpuidle: fix cpuidle time and usage
	overflow
Date: Mon, 25 Feb 2008 08:46:12 +0800
Message-ID: <1203900372.4954.8.camel__4573.82831159538$1203934222$gmane$org@yangyi-dev.bj.intel.com>
References: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com>
	<1201043126.3861.5.camel@yangyi-dev.bj.intel.com>
	<1203032921.3897.10.camel@yangyi-dev.bj.intel.com>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1203032921.3897.10.camel@yangyi-dev.bj.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: akpm@linux-foundation.org
Cc: cpufreq@lists.linux.org.uk, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

cpuidle C-state sysfs node time and usage are very easy to overflow because
they are all of unsigned int type, time will overflow within about two hours,
usage will take longer time to overflow, but they are increasing for ever.

This patch will convert them to unsigned long long.


Signed-off-by: Yi Yang <yi.y.yang@intel.com>
---
 drivers/cpuidle/cpuidle.c |    2 +-
 drivers/cpuidle/sysfs.c   |   10 ++++++++--
 include/linux/cpuidle.h   |    4 ++--

--- a/include/linux/cpuidle.h	2008-02-25 02:31:26.000000000 -0500
+++ b/include/linux/cpuidle.h	2008-02-25 04:30:24.000000000 -0500
@@ -38,8 +38,8 @@ struct cpuidle_state {
 	unsigned int	power_usage; /* in mW */
 	unsigned int	target_residency; /* in US */
 
-	unsigned int	usage;
-	unsigned int	time; /* in US */
+	unsigned long long	usage;
+	unsigned long long	time; /* in US */
 
 	int (*enter)	(struct cpuidle_device *dev,
 			 struct cpuidle_state *state);
--- a/drivers/cpuidle/cpuidle.c	2008-02-25 02:37:14.000000000 -0500
+++ b/drivers/cpuidle/cpuidle.c	2008-02-25 04:29:19.000000000 -0500
@@ -67,7 +67,7 @@ static void cpuidle_idle_call(void)
 	/* enter the state and update stats */
 	dev->last_residency = target_state->enter(dev, target_state);
 	dev->last_state = target_state;
-	target_state->time += dev->last_residency;
+	target_state->time += (unsigned long long)dev->last_residency;
 	target_state->usage++;
 
 	/* give the governor an opportunity to reflect on the outcome */
--- a/drivers/cpuidle/sysfs.c	2008-02-25 02:33:14.000000000 -0500
+++ b/drivers/cpuidle/sysfs.c	2008-02-25 03:10:50.000000000 -0500
@@ -218,6 +218,12 @@ static ssize_t show_state_##_name(struct
 	return sprintf(buf, "%u\n", state->_name);\
 }
 
+#define define_show_state_ull_function(_name) \
+static ssize_t show_state_##_name(struct cpuidle_state *state, char *buf) \
+{ \
+	return sprintf(buf, "%llu\n", state->_name);\
+}
+
 #define define_show_state_str_function(_name) \
 static ssize_t show_state_##_name(struct cpuidle_state *state, char *buf) \
 { \
@@ -228,8 +234,8 @@ static ssize_t show_state_##_name(struct
 
 define_show_state_function(exit_latency)
 define_show_state_function(power_usage)
-define_show_state_function(usage)
-define_show_state_function(time)
+define_show_state_ull_function(usage)
+define_show_state_ull_function(time)
 define_show_state_str_function(name)
 define_show_state_str_function(desc)
 
