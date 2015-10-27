From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 42/70] cpufreq: interactive: allow arbitrary speed / delay mappings
Date: Tue, 27 Oct 2015 18:30:30 +0100
Message-ID: <1445967059-6897-42-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Minsung Kim <ms925.kim@samsung.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Minsung Kim <ms925.kim@samsung.com>

Accept a string of delays and speeds at which to apply the delay before
raising each step above hispeed. For example, "80000 1300000:200000
1500000:40000" means that the delay at or above 1GHz, until 1.3GHz is 8=
0 msecs,
the delay until 1.5GHz is 200 msecs and the delay at or above 1.5GHz is=
 40
msecs when hispeed_freq is 1GHz.

[toddpoynor@google.com: add documentation]
Change-Id: Ifeebede8b1acbdd0a53e5c6916bccbf764dc854f
Signed-off-by: Minsung Kim <ms925.kim@samsung.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 Documentation/cpu-freq/governors.txt  |   12 ++-
 drivers/cpufreq/cpufreq_interactive.c |  185 ++++++++++++++++++++++---=
--------
 2 files changed, 134 insertions(+), 63 deletions(-)

diff --git a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-f=
req/governors.txt
index 4d8ae34..ac8a37e 100644
--- a/Documentation/cpu-freq/governors.txt
+++ b/Documentation/cpu-freq/governors.txt
@@ -260,7 +260,17 @@ Default is 99%.
=20
 above_hispeed_delay: When speed is at or above hispeed_freq, wait for
 this long before raising speed in response to continued high load.
-Default is 20000 uS.
+The format is a single delay value, optionally followed by pairs of
+CPU speeds and the delay to use at or above those speeds.  Colons can
+be used between the speeds and associated delays for readability.  For
+example:
+
+   80000 1300000:200000 1500000:40000
+
+uses delay 80000 uS until CPU speed 1.3 GHz, at which speed delay
+200000 uS is used until speed 1.5 GHz, at which speed (and above)
+delay 40000 uS is used.  If speeds are specified these must appear in
+ascending order.  Default is 20000 uS.
=20
 timer_rate: Sample rate for reevaluating CPU load when the CPU is not
 idle.  A deferrable timer is used, such that the CPU will not be woken
diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 3447e58..620b46c 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -94,7 +94,11 @@ static unsigned long timer_rate =3D DEFAULT_TIMER_RA=
TE;
  * timer interval.
  */
 #define DEFAULT_ABOVE_HISPEED_DELAY DEFAULT_TIMER_RATE
-static unsigned long above_hispeed_delay_val =3D DEFAULT_ABOVE_HISPEED=
_DELAY;
+static unsigned int default_above_hispeed_delay[] =3D {
+	DEFAULT_ABOVE_HISPEED_DELAY };
+static spinlock_t above_hispeed_delay_lock;
+static unsigned int *above_hispeed_delay =3D default_above_hispeed_del=
ay;
+static int nabove_hispeed_delay =3D ARRAY_SIZE(default_above_hispeed_d=
elay);
=20
 /* Non-zero means indefinite speed boost active */
 static int boost_val;
@@ -144,6 +148,23 @@ static void cpufreq_interactive_timer_resched(
 	spin_unlock_irqrestore(&pcpu->load_lock, flags);
 }
=20
+static unsigned int freq_to_above_hispeed_delay(unsigned int freq)
+{
+	int i;
+	unsigned int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&above_hispeed_delay_lock, flags);
+
+	for (i =3D 0; i < nabove_hispeed_delay - 1 &&
+			freq >=3D above_hispeed_delay[i+1]; i +=3D 2)
+		;
+
+	ret =3D above_hispeed_delay[i];
+	spin_unlock_irqrestore(&above_hispeed_delay_lock, flags);
+	return ret;
+}
+
 static unsigned int freq_to_targetload(unsigned int freq)
 {
 	int i;
@@ -316,7 +337,8 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
=20
 	if (pcpu->target_freq >=3D hispeed_freq &&
 	    new_freq > pcpu->target_freq &&
-	    now - pcpu->hispeed_validate_time < above_hispeed_delay_val) {
+	    now - pcpu->hispeed_validate_time <
+	    freq_to_above_hispeed_delay(pcpu->policy->cur)) {
 		trace_cpufreq_interactive_notyet(
 			data, cpu_load, pcpu->target_freq,
 			pcpu->policy->cur, new_freq);
@@ -580,6 +602,56 @@ static struct notifier_block cpufreq_notifier_bloc=
k =3D {
 	.notifier_call =3D cpufreq_interactive_notifier,
 };
=20
+static unsigned int *get_tokenized_data(const char *buf, int *num_toke=
ns)
+{
+	const char *cp;
+	int i;
+	int ntokens =3D 1;
+	unsigned int *tokenized_data;
+
+	cp =3D buf;
+	while ((cp =3D strpbrk(cp + 1, " :")))
+		ntokens++;
+
+	if (!(ntokens & 0x1)) {
+		tokenized_data =3D ERR_PTR(-EINVAL);
+		goto err;
+	}
+
+	tokenized_data =3D kmalloc(ntokens * sizeof(unsigned int), GFP_KERNEL=
);
+	if (!tokenized_data) {
+		tokenized_data =3D ERR_PTR(-ENOMEM);
+		goto err;
+	}
+
+	cp =3D buf;
+	i =3D 0;
+	while (i < ntokens) {
+		if (sscanf(cp, "%u", &tokenized_data[i++]) !=3D 1) {
+			tokenized_data =3D ERR_PTR(-EINVAL);
+			goto err_kfree;
+		}
+
+		cp =3D strpbrk(cp, " :");
+		if (!cp)
+			break;
+		cp++;
+	}
+
+	if (i !=3D ntokens) {
+		tokenized_data =3D ERR_PTR(-EINVAL);
+		goto err_kfree;
+	}
+
+	*num_tokens =3D ntokens;
+	return tokenized_data;
+
+err_kfree:
+	kfree(tokenized_data);
+err:
+	return tokenized_data;
+}
+
 static ssize_t show_target_loads(
 	struct kobject *kobj, struct attribute *attr, char *buf)
 {
@@ -602,40 +674,13 @@ static ssize_t store_target_loads(
 	struct kobject *kobj, struct attribute *attr, const char *buf,
 	size_t count)
 {
-	int ret;
-	const char *cp;
+	int ntokens;
 	unsigned int *new_target_loads =3D NULL;
-	int ntokens =3D 1;
-	int i;
 	unsigned long flags;
=20
-	cp =3D buf;
-	while ((cp =3D strpbrk(cp + 1, " :")))
-		ntokens++;
-
-	if (!(ntokens & 0x1))
-		goto err_inval;
-
-	new_target_loads =3D kmalloc(ntokens * sizeof(unsigned int), GFP_KERN=
EL);
-	if (!new_target_loads) {
-		ret =3D -ENOMEM;
-		goto err;
-	}
-
-	cp =3D buf;
-	i =3D 0;
-	while (i < ntokens) {
-		if (sscanf(cp, "%u", &new_target_loads[i++]) !=3D 1)
-			goto err_inval;
-
-		cp =3D strpbrk(cp, " :");
-		if (!cp)
-			break;
-		cp++;
-	}
-
-	if (i !=3D ntokens)
-		goto err_inval;
+	new_target_loads =3D get_tokenized_data(buf, &ntokens);
+	if (IS_ERR(new_target_loads))
+		return PTR_RET(new_target_loads);
=20
 	spin_lock_irqsave(&target_loads_lock, flags);
 	if (target_loads !=3D default_target_loads)
@@ -644,18 +689,56 @@ static ssize_t store_target_loads(
 	ntarget_loads =3D ntokens;
 	spin_unlock_irqrestore(&target_loads_lock, flags);
 	return count;
-
-err_inval:
-	ret =3D -EINVAL;
-err:
-	kfree(new_target_loads);
-	return ret;
 }
=20
 static struct global_attr target_loads_attr =3D
 	__ATTR(target_loads, S_IRUGO | S_IWUSR,
 		show_target_loads, store_target_loads);
=20
+static ssize_t show_above_hispeed_delay(
+	struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	int i;
+	ssize_t ret =3D 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&above_hispeed_delay_lock, flags);
+
+	for (i =3D 0; i < nabove_hispeed_delay; i++)
+		ret +=3D sprintf(buf + ret, "%u%s", above_hispeed_delay[i],
+			       i & 0x1 ? ":" : " ");
+
+	ret +=3D sprintf(buf + ret, "\n");
+	spin_unlock_irqrestore(&above_hispeed_delay_lock, flags);
+	return ret;
+}
+
+static ssize_t store_above_hispeed_delay(
+	struct kobject *kobj, struct attribute *attr, const char *buf,
+	size_t count)
+{
+	int ntokens;
+	unsigned int *new_above_hispeed_delay =3D NULL;
+	unsigned long flags;
+
+	new_above_hispeed_delay =3D get_tokenized_data(buf, &ntokens);
+	if (IS_ERR(new_above_hispeed_delay))
+		return PTR_RET(new_above_hispeed_delay);
+
+	spin_lock_irqsave(&above_hispeed_delay_lock, flags);
+	if (above_hispeed_delay !=3D default_above_hispeed_delay)
+		kfree(above_hispeed_delay);
+	above_hispeed_delay =3D new_above_hispeed_delay;
+	nabove_hispeed_delay =3D ntokens;
+	spin_unlock_irqrestore(&above_hispeed_delay_lock, flags);
+	return count;
+
+}
+
+static struct global_attr above_hispeed_delay_attr =3D
+	__ATTR(above_hispeed_delay, S_IRUGO | S_IWUSR,
+		show_above_hispeed_delay, store_above_hispeed_delay);
+
 static ssize_t show_hispeed_freq(struct kobject *kobj,
 				 struct attribute *attr, char *buf)
 {
@@ -724,28 +807,6 @@ static ssize_t store_min_sample_time(struct kobjec=
t *kobj,
 static struct global_attr min_sample_time_attr =3D __ATTR(min_sample_t=
ime, 0644,
 		show_min_sample_time, store_min_sample_time);
=20
-static ssize_t show_above_hispeed_delay(struct kobject *kobj,
-					struct attribute *attr, char *buf)
-{
-	return sprintf(buf, "%lu\n", above_hispeed_delay_val);
-}
-
-static ssize_t store_above_hispeed_delay(struct kobject *kobj,
-					 struct attribute *attr,
-					 const char *buf, size_t count)
-{
-	int ret;
-	unsigned long val;
-
-	ret =3D strict_strtoul(buf, 0, &val);
-	if (ret < 0)
-		return ret;
-	above_hispeed_delay_val =3D val;
-	return count;
-}
-
-define_one_global_rw(above_hispeed_delay);
-
 static ssize_t show_timer_rate(struct kobject *kobj,
 			struct attribute *attr, char *buf)
 {
@@ -865,9 +926,9 @@ define_one_global_rw(boostpulse_duration);
=20
 static struct attribute *interactive_attributes[] =3D {
 	&target_loads_attr.attr,
+	&above_hispeed_delay_attr.attr,
 	&hispeed_freq_attr.attr,
 	&go_hispeed_load_attr.attr,
-	&above_hispeed_delay.attr,
 	&min_sample_time_attr.attr,
 	&timer_rate_attr.attr,
 	&timer_slack.attr,
--=20
1.7.9.5
