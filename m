From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v6 5/7][Resend] cpufreq: Move governor symbols to cpufreq.h
Date: Tue, 22 Mar 2016 02:51:56 +0100
Message-ID: <1586499.XsEFRqGpvD@vostro.rjw.lan>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64686 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754366AbcCVB4h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 21:56:37 -0400
In-Reply-To: <7262976.zPkLj56ATU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move definitions of symbols related to transition latency and
sampling rate to include/linux/cpufreq.h so they can be used by
(future) goverernors located outside of drivers/cpufreq/.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch was new in v4, no changes since then.

---
 drivers/cpufreq/cpufreq_governor.h |   14 --------------
 include/linux/cpufreq.h            |   14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -24,20 +24,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 
-/*
- * The polling frequency depends on the capability of the processor. Default
- * polling frequency is 1000 times the transition latency of the processor. The
- * governor will work on any processor with transition latency <= 10ms, using
- * appropriate sampling rate.
- *
- * For CPUs with transition latency > 10ms (mostly drivers with CPUFREQ_ETERNAL)
- * this governor will not work. All times here are in us (micro seconds).
- */
-#define MIN_SAMPLING_RATE_RATIO			(2)
-#define LATENCY_MULTIPLIER			(1000)
-#define MIN_LATENCY_MULTIPLIER			(20)
-#define TRANSITION_LATENCY_LIMIT		(10 * 1000 * 1000)
-
 /* Ondemand Sampling types */
 enum {OD_NORMAL_SAMPLE, OD_SUB_SAMPLE};
 
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -426,6 +426,20 @@ static inline unsigned long cpufreq_scal
 #define CPUFREQ_POLICY_POWERSAVE	(1)
 #define CPUFREQ_POLICY_PERFORMANCE	(2)
 
+/*
+ * The polling frequency depends on the capability of the processor. Default
+ * polling frequency is 1000 times the transition latency of the processor. The
+ * ondemand governor will work on any processor with transition latency <= 10ms,
+ * using appropriate sampling rate.
+ *
+ * For CPUs with transition latency > 10ms (mostly drivers with CPUFREQ_ETERNAL)
+ * the ondemand governor will not work. All times here are in us (microseconds).
+ */
+#define MIN_SAMPLING_RATE_RATIO		(2)
+#define LATENCY_MULTIPLIER		(1000)
+#define MIN_LATENCY_MULTIPLIER		(20)
+#define TRANSITION_LATENCY_LIMIT	(10 * 1000 * 1000)
+
 /* Governor Events */
 #define CPUFREQ_GOV_START	1
 #define CPUFREQ_GOV_STOP	2

