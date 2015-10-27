From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 29/70] cpufreq: interactive: allow arbitrary speed / target load mappings
Date: Tue, 27 Oct 2015 18:30:17 +0100
Message-ID: <1445967059-6897-29-git-send-email-czoborbalint@gmail.com>
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

Accept a string of target loads and speeds at which to apply the
target loads, per the documentation update in this patch.  For example,
"85 1000000:90 1700000:99" targets CPU load 85% below speed 1GHz,  90%
at or above 1GHz, until 1.7GHz and above, at which load 99% is targeted=
=2E

Attempt to avoid oscillations by evaluating the current speed
weighted by current load against each new choice of speed, choosing a
higher speed if the current load requires a higher speed.

Change-Id: Ie3300206047c84eca5a26b0b63ea512e5207550e
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 Documentation/cpu-freq/governors.txt  |   17 +++
 drivers/cpufreq/cpufreq_interactive.c |  186 +++++++++++++++++++++++++=
+++++---
 2 files changed, 189 insertions(+), 14 deletions(-)

diff --git a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-f=
req/governors.txt
index 509b179..b15f6d2 100644
--- a/Documentation/cpu-freq/governors.txt
+++ b/Documentation/cpu-freq/governors.txt
@@ -244,6 +244,23 @@ short-term load since idle exit to determine the c=
pu speed to ramp to.
=20
 The tuneable values for this governor are:
=20
+target_loads: CPU load values used to adjust speed to influence the
+current CPU load toward that value.  In general, the lower the target
+load, the more often the governor will raise CPU speeds to bring load
+below the target.  The format is a single target load, optionally
+followed by pairs of CPU speeds and CPU loads to target at or above
+those speeds.  Colons can be used between the speeds and associated
+target loads for readability.  For example:
+
+   85 1000000:90 1700000:99
+
+targets CPU load 85% below speed 1GHz, 90% at or above 1GHz, until
+1.7GHz and above, at which load 99% is targeted.  If speeds are
+specified these must appear in ascending order.  Higher target load
+values are typically specified for higher speeds, that is, target load
+values also usually appear in an ascending order. The default is
+target load 90% for all speeds.
+
 min_sample_time: The minimum amount of time to spend at the current
 frequency before ramping down. This is to ensure that the governor has
 seen enough historic cpu load data to determine the appropriate
diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 17c42cc..6ea77a0 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -70,7 +70,10 @@ static unsigned long go_hispeed_load;
=20
 /* Target load.  Lower values result in higher CPU speeds. */
 #define DEFAULT_TARGET_LOAD 90
-static unsigned long target_load =3D DEFAULT_TARGET_LOAD;
+static unsigned int default_target_loads[] =3D {DEFAULT_TARGET_LOAD};
+static spinlock_t target_loads_lock;
+static unsigned int *target_loads =3D default_target_loads;
+static int ntarget_loads =3D ARRAY_SIZE(default_target_loads);
=20
 /*
  * The minimum amount of time to spend at a frequency before we can ra=
mp down.
@@ -125,6 +128,110 @@ static void cpufreq_interactive_timer_resched(
 				     &pcpu->time_in_idle_timestamp);
 }
=20
+static unsigned int freq_to_targetload(unsigned int freq)
+{
+	int i;
+	unsigned int ret;
+
+	spin_lock(&target_loads_lock);
+
+	for (i =3D 0; i < ntarget_loads - 1 && freq >=3D target_loads[i+1]; i=
 +=3D 2)
+		;
+
+	ret =3D target_loads[i];
+	spin_unlock(&target_loads_lock);
+	return ret;
+}
+
+/*
+ * If increasing frequencies never map to a lower target load then
+ * choose_freq() will find the minimum frequency that does not exceed =
its
+ * target load given the current load.
+ */
+
+static unsigned int choose_freq(
+	struct cpufreq_interactive_cpuinfo *pcpu, unsigned int curload)
+{
+	unsigned int freq =3D pcpu->policy->cur;
+	unsigned int loadadjfreq =3D freq * curload;
+	unsigned int prevfreq, freqmin, freqmax;
+	unsigned int tl;
+	int index;
+
+	freqmin =3D 0;
+	freqmax =3D UINT_MAX;
+
+	do {
+		prevfreq =3D freq;
+		tl =3D freq_to_targetload(freq);
+
+		/*
+		 * Find the lowest frequency where the computed load is less
+		 * than or equal to the target load.
+		 */
+
+		cpufreq_frequency_table_target(
+			pcpu->policy, pcpu->freq_table, loadadjfreq / tl,
+			CPUFREQ_RELATION_L, &index);
+		freq =3D pcpu->freq_table[index].frequency;
+
+		if (freq > prevfreq) {
+			/* The previous frequency is too low. */
+			freqmin =3D prevfreq;
+
+			if (freq >=3D freqmax) {
+				/*
+				 * Find the highest frequency that is less
+				 * than freqmax.
+				 */
+				cpufreq_frequency_table_target(
+					pcpu->policy, pcpu->freq_table,
+					freqmax - 1, CPUFREQ_RELATION_H,
+					&index);
+				freq =3D pcpu->freq_table[index].frequency;
+
+				if (freq =3D=3D freqmin) {
+					/*
+					 * The first frequency below freqmax
+					 * has already been found to be too
+					 * low.  freqmax is the lowest speed
+					 * we found that is fast enough.
+					 */
+					freq =3D freqmax;
+					break;
+				}
+			}
+		} else if (freq < prevfreq) {
+			/* The previous frequency is high enough. */
+			freqmax =3D prevfreq;
+
+			if (freq <=3D freqmin) {
+				/*
+				 * Find the lowest frequency that is higher
+				 * than freqmin.
+				 */
+				cpufreq_frequency_table_target(
+					pcpu->policy, pcpu->freq_table,
+					freqmin + 1, CPUFREQ_RELATION_L,
+					&index);
+				freq =3D pcpu->freq_table[index].frequency;
+
+				/*
+				 * If freqmax is the first frequency above
+				 * freqmin then we have already found that
+				 * this speed is fast enough.
+				 */
+				if (freq =3D=3D freqmax)
+					break;
+			}
+		}
+
+		/* If same frequency chosen as previous then done. */
+	} while (freq !=3D prevfreq);
+
+	return freq;
+}
+
 static void cpufreq_interactive_timer(unsigned long data)
 {
 	u64 now;
@@ -180,7 +287,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 	    pcpu->target_freq < hispeed_freq)
 		new_freq =3D hispeed_freq;
 	else
-		new_freq =3D pcpu->policy->cur * cpu_load / target_load;
+		new_freq =3D choose_freq(pcpu, cpu_load);
=20
 	if (pcpu->target_freq >=3D hispeed_freq &&
 	    new_freq > pcpu->target_freq &&
@@ -414,29 +521,79 @@ static void cpufreq_interactive_boost(void)
 		wake_up_process(speedchange_task);
 }
=20
-static ssize_t show_target_load(
+static ssize_t show_target_loads(
 	struct kobject *kobj, struct attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lu\n", target_load);
+	int i;
+	ssize_t ret =3D 0;
+
+	spin_lock(&target_loads_lock);
+
+	for (i =3D 0; i < ntarget_loads; i++)
+		ret +=3D sprintf(buf + ret, "%u%s", target_loads[i],
+			       i & 0x1 ? ":" : " ");
+
+	ret +=3D sprintf(buf + ret, "\n");
+	spin_unlock(&target_loads_lock);
+	return ret;
 }
=20
-static ssize_t store_target_load(
+static ssize_t store_target_loads(
 	struct kobject *kobj, struct attribute *attr, const char *buf,
 	size_t count)
 {
 	int ret;
-	unsigned long val;
+	const char *cp;
+	unsigned int *new_target_loads =3D NULL;
+	int ntokens =3D 1;
+	int i;
=20
-	ret =3D strict_strtoul(buf, 0, &val);
-	if (ret < 0)
-		return ret;
-	target_load =3D val;
+	cp =3D buf;
+	while ((cp =3D strpbrk(cp + 1, " :")))
+		ntokens++;
+
+	if (!(ntokens & 0x1))
+		goto err_inval;
+
+	new_target_loads =3D kmalloc(ntokens * sizeof(unsigned int), GFP_KERN=
EL);
+	if (!new_target_loads) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	cp =3D buf;
+	i =3D 0;
+	while (i < ntokens) {
+		if (sscanf(cp, "%u", &new_target_loads[i++]) !=3D 1)
+			goto err_inval;
+
+		cp =3D strpbrk(cp, " :");
+		if (!cp)
+			break;
+		cp++;
+	}
+
+	if (i !=3D ntokens)
+		goto err_inval;
+
+	spin_lock(&target_loads_lock);
+	if (target_loads !=3D default_target_loads)
+		kfree(target_loads);
+	target_loads =3D new_target_loads;
+	ntarget_loads =3D ntokens;
+	spin_unlock(&target_loads_lock);
 	return count;
+
+err_inval:
+	ret =3D -EINVAL;
+err:
+	kfree(new_target_loads);
+	return ret;
 }
=20
-static struct global_attr target_load_attr =3D
-	__ATTR(target_load, S_IRUGO | S_IWUSR,
-		show_target_load, store_target_load);
+static struct global_attr target_loads_attr =3D
+	__ATTR(target_loads, S_IRUGO | S_IWUSR,
+		show_target_loads, store_target_loads);
=20
 static ssize_t show_hispeed_freq(struct kobject *kobj,
 				 struct attribute *attr, char *buf)
@@ -599,7 +756,7 @@ static struct global_attr boostpulse =3D
 	__ATTR(boostpulse, 0200, NULL, store_boostpulse);
=20
 static struct attribute *interactive_attributes[] =3D {
-	&target_load_attr.attr,
+	&target_loads_attr.attr,
 	&hispeed_freq_attr.attr,
 	&go_hispeed_load_attr.attr,
 	&above_hispeed_delay.attr,
@@ -739,6 +896,7 @@ static int __init cpufreq_interactive_init(void)
 		pcpu->cpu_timer.data =3D i;
 	}
=20
+	spin_lock_init(&target_loads_lock);
 	spin_lock_init(&speedchange_cpumask_lock);
 	speedchange_task =3D
 		kthread_create(cpufreq_interactive_speedchange_task, NULL,
--=20
1.7.9.5
