From: Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v3] cpufreq: trace frequency limits change
Date: Tue, 24 Jul 2018 10:35:44 -0700
Message-ID: <20180724173544.18876-1-joel@joelfernandes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com, Ruchi Kandoi <kandoiruchi@google.com>, Joel Fernandes <joel@joelfernandes.org>, Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steven Rostedt <rostedt@goodmis.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Ruchi Kandoi <kandoiruchi@google.com>

systrace used for tracing for Android systems has carried a patch for
many years in the Android tree that traces when the cpufreq limits
change.  With the help of this information, systrace can know when the
policy limits change and can visually display the data. Lets add
upstream support for the same.

Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
Viresh since I changed the patch, could you Ack it again?

v2->v3: reduce parameters to tracepoint call (Steve)
v1->v2: correct ordering of min/max (Viresh)

 Documentation/trace/events-power.rst |  1 +
 drivers/cpufreq/cpufreq.c            |  1 +
 include/trace/events/power.h         | 25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/trace/events-power.rst b/Documentation/trace/events-power.rst
index a77daca75e30..2ef318962e29 100644
--- a/Documentation/trace/events-power.rst
+++ b/Documentation/trace/events-power.rst
@@ -27,6 +27,7 @@ cpufreq.
 
   cpu_idle		"state=%lu cpu_id=%lu"
   cpu_frequency		"state=%lu cpu_id=%lu"
+  cpu_frequency_limits	"min=%lu max=%lu cpu_id=%lu"
 
 A suspend event is used to indicate the system going in and out of the
 suspend mode:
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b0dfd3222013..52566f1f1050 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2236,6 +2236,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	policy->min = new_policy->min;
 	policy->max = new_policy->max;
+	trace_cpu_frequency_limits(policy);
 
 	policy->cached_target_freq = UINT_MAX;
 
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 908977d69783..f7aece721aed 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -5,6 +5,7 @@
 #if !defined(_TRACE_POWER_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_POWER_H
 
+#include <linux/cpufreq.h>
 #include <linux/ktime.h>
 #include <linux/pm_qos.h>
 #include <linux/tracepoint.h>
@@ -148,6 +149,30 @@ DEFINE_EVENT(cpu, cpu_frequency,
 	TP_ARGS(frequency, cpu_id)
 );
 
+TRACE_EVENT(cpu_frequency_limits,
+
+	TP_PROTO(struct cpufreq_policy *policy),
+
+	TP_ARGS(policy),
+
+	TP_STRUCT__entry(
+		__field(u32, min_freq)
+		__field(u32, max_freq)
+		__field(u32, cpu_id)
+	),
+
+	TP_fast_assign(
+		__entry->min_freq = policy->min;
+		__entry->max_freq = policy->max;
+		__entry->cpu_id = policy->cpu;
+	),
+
+	TP_printk("min=%lu max=%lu cpu_id=%lu",
+		  (unsigned long)__entry->min_freq,
+		  (unsigned long)__entry->max_freq,
+		  (unsigned long)__entry->cpu_id)
+);
+
 TRACE_EVENT(device_pm_callback_start,
 
 	TP_PROTO(struct device *dev, const char *pm_ops, int event),
-- 
2.18.0.233.g985f88cf7e-goog
