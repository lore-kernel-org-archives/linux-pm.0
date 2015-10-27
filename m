From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 12/70] cpufreq: interactive: Add sysfs boost interface for hints from userspace
Date: Tue, 27 Oct 2015 18:30:00 +0100
Message-ID: <1445967059-6897-12-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Todd Poynor <toddpoynor@google.com>

The explicit hint on/off version.

Change-Id: Ibf62b6d45bf6fb8c9c055b9bdaf074ce9374c04f
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 Documentation/cpu-freq/governors.txt       |    3 ++
 drivers/cpufreq/cpufreq_interactive.c      |   48 ++++++++++++++++++++=
+++++---
 include/trace/events/cpufreq_interactive.h |   13 ++++++++
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-f=
req/governors.txt
index 4172cad..4fcaa43 100644
--- a/Documentation/cpu-freq/governors.txt
+++ b/Documentation/cpu-freq/governors.txt
@@ -267,6 +267,9 @@ not idle.  Default is 20000 uS.
 input_boost: If non-zero, boost speed of all CPUs to hispeed_freq on
 touchscreen activity.  Default is 0.
=20
+boost: If non-zero, immediately boost speed of all CPUs to
+hispeed_freq.  If zero, allow CPU speeds to drop below hispeed_freq.
+
=20
 3. The Governor Interface in the CPUfreq Core
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 90db2c3..07b7caf 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -31,12 +31,11 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/input.h>
+#include <asm/cputime.h>
=20
 #define CREATE_TRACE_POINTS
 #include <trace/events/cpufreq_interactive.h>
=20
-#include <asm/cputime.h>
-
 static atomic_t active_count =3D ATOMIC_INIT(0);
=20
 struct cpufreq_interactive_cpuinfo {
@@ -94,7 +93,7 @@ static unsigned long timer_rate;
 static unsigned long above_hispeed_delay_val;
=20
 /*
- * Boost to hispeed on touchscreen input.
+ * Boost pulse to hispeed on touchscreen input.
  */
=20
 static int input_boost_val;
@@ -106,6 +105,12 @@ struct cpufreq_interactive_inputopen {
=20
 static struct cpufreq_interactive_inputopen inputopen;
=20
+/*
+ * Non-zero means longer-term speed boost active.
+ */
+
+static int boost_val;
+
 static int cpufreq_governor_interactive(struct cpufreq_policy *policy,
 		unsigned int event);
=20
@@ -189,7 +194,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 	if (load_since_change > cpu_load)
 		cpu_load =3D load_since_change;
=20
-	if (cpu_load >=3D go_hispeed_load) {
+	if (cpu_load >=3D go_hispeed_load || boost_val) {
 		if (pcpu->target_freq <=3D pcpu->policy->min) {
 			new_freq =3D hispeed_freq;
 		} else {
@@ -517,6 +522,12 @@ static void cpufreq_interactive_boost(void)
 		wake_up_process(up_task);
 }
=20
+/*
+ * Pulsed boost on input event raises CPUs to hispeed_freq and lets
+ * usual algorithm of min_sample_time  decide when to allow speed
+ * to drop.
+ */
+
 static void cpufreq_interactive_input_event(struct input_handle *handl=
e,
 					    unsigned int type,
 					    unsigned int code, int value)
@@ -732,6 +743,34 @@ static ssize_t store_input_boost(struct kobject *k=
obj, struct attribute *attr,
=20
 define_one_global_rw(input_boost);
=20
+static ssize_t show_boost(struct kobject *kobj, struct attribute *attr=
,
+			  char *buf)
+{
+	return sprintf(buf, "%d\n", boost_val);
+}
+
+static ssize_t store_boost(struct kobject *kobj, struct attribute *att=
r,
+			   const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	boost_val =3D val;
+
+	if (boost_val)
+		cpufreq_interactive_boost();
+	else
+		trace_cpufreq_interactive_unboost(hispeed_freq);
+
+	return count;
+}
+
+define_one_global_rw(boost);
+
 static struct attribute *interactive_attributes[] =3D {
 	&hispeed_freq_attr.attr,
 	&go_hispeed_load_attr.attr,
@@ -739,6 +778,7 @@ static struct attribute *interactive_attributes[] =3D=
 {
 	&min_sample_time_attr.attr,
 	&timer_rate_attr.attr,
 	&input_boost.attr,
+	&boost.attr,
 	NULL,
 };
=20
diff --git a/include/trace/events/cpufreq_interactive.h b/include/trace=
/events/cpufreq_interactive.h
index 19e070b..ae6f232 100644
--- a/include/trace/events/cpufreq_interactive.h
+++ b/include/trace/events/cpufreq_interactive.h
@@ -93,6 +93,19 @@ TRACE_EVENT(cpufreq_interactive_boost,
 	    ),
 	    TP_printk("freq=3D%lu", __entry->freq)
 );
+
+TRACE_EVENT(cpufreq_interactive_unboost,
+	    TP_PROTO(unsigned long freq),
+	    TP_ARGS(freq),
+	    TP_STRUCT__entry(
+		    __field(unsigned long, freq)
+	    ),
+	    TP_fast_assign(
+		    __entry->freq =3D freq;
+	    ),
+	    TP_printk("freq=3D%lu", __entry->freq)
+);
+
 #endif /* _TRACE_CPUFREQ_INTERACTIVE_H */
=20
 /* This part must be outside protection */
--=20
1.7.9.5
