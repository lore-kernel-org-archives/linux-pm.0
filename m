From: Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH RFC] cpufreq: trace frequency limits change
Date: Thu, 19 Jul 2018 12:59:57 -0700
Message-ID: <20180719195957.59000-1-joel@joelfernandes.org>
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
index b0dfd3222013..6533c6987866 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2236,6 +2236,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	policy->min = new_policy->min;
 	policy->max = new_policy->max;
+	trace_cpu_frequency_limits(policy->max, policy->min, policy->cpu);
 
 	policy->cached_target_freq = UINT_MAX;
 
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 908977d69783..e978b05b0200 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -148,6 +148,31 @@ DEFINE_EVENT(cpu, cpu_frequency,
 	TP_ARGS(frequency, cpu_id)
 );
 
+TRACE_EVENT(cpu_frequency_limits,
+
+	TP_PROTO(unsigned int max_freq, unsigned int min_freq,
+		unsigned int cpu_id),
+
+	TP_ARGS(max_freq, min_freq, cpu_id),
+
+	TP_STRUCT__entry(
+		__field(u32,		min_freq)
+		__field(u32,		max_freq)
+		__field(u32,		cpu_id)
+	),
+
+	TP_fast_assign(
+		__entry->min_freq = min_freq;
+		__entry->max_freq = max_freq;
+		__entry->cpu_id = cpu_id;
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
2.18.0.203.gfac676dfb9-goog
