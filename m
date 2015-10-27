From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 40/70] cpufreq: interactive: fix deadlock on spinlock in timer
Date: Tue, 27 Oct 2015 18:30:28 +0100
Message-ID: <1445967059-6897-40-git-send-email-czoborbalint@gmail.com>
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

Need to use irqsave/restore spinlock calls to avoid a deadlock in calls
from the timer.

Change-Id: I15b6b590045ba1447e34ca7b5ff342723e53a605
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   29 +++++++++++++++++--------=
----
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 51c34bf..e7f26aa 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -126,6 +126,7 @@ static void cpufreq_interactive_timer_resched(
 	struct cpufreq_interactive_cpuinfo *pcpu)
 {
 	unsigned long expires =3D jiffies + usecs_to_jiffies(timer_rate);
+	unsigned long flags;
=20
 	mod_timer_pinned(&pcpu->cpu_timer, expires);
 	if (timer_slack_val >=3D 0 && pcpu->target_freq > pcpu->policy->min) =
{
@@ -133,27 +134,28 @@ static void cpufreq_interactive_timer_resched(
 		mod_timer_pinned(&pcpu->cpu_slack_timer, expires);
 	}
=20
-	spin_lock(&pcpu->load_lock);
+	spin_lock_irqsave(&pcpu->load_lock, flags);
 	pcpu->time_in_idle =3D
 		get_cpu_idle_time_us(smp_processor_id(),
 				     &pcpu->time_in_idle_timestamp);
 	pcpu->cputime_speedadj =3D 0;
 	pcpu->cputime_speedadj_timestamp =3D pcpu->time_in_idle_timestamp;
-	spin_unlock(&pcpu->load_lock);
+	spin_unlock_irqrestore(&pcpu->load_lock, flags);
 }
=20
 static unsigned int freq_to_targetload(unsigned int freq)
 {
 	int i;
 	unsigned int ret;
+	unsigned long flags;
=20
-	spin_lock(&target_loads_lock);
+	spin_lock_irqsave(&target_loads_lock, flags);
=20
 	for (i =3D 0; i < ntarget_loads - 1 && freq >=3D target_loads[i+1]; i=
 +=3D 2)
 		;
=20
 	ret =3D target_loads[i];
-	spin_unlock(&target_loads_lock);
+	spin_unlock_irqrestore(&target_loads_lock, flags);
 	return ret;
 }
=20
@@ -284,11 +286,11 @@ static void cpufreq_interactive_timer(unsigned lo=
ng data)
 	if (!pcpu->governor_enabled)
 		goto exit;
=20
-	spin_lock(&pcpu->load_lock);
+	spin_lock_irqsave(&pcpu->load_lock, flags);
 	now =3D update_load(data);
 	delta_time =3D (unsigned int)(now - pcpu->cputime_speedadj_timestamp)=
;
 	cputime_speedadj =3D pcpu->cputime_speedadj;
-	spin_unlock(&pcpu->load_lock);
+	spin_unlock_irqrestore(&pcpu->load_lock, flags);
=20
 	if (WARN_ON_ONCE(!delta_time))
 		goto rearm;
@@ -549,6 +551,7 @@ static int cpufreq_interactive_notifier(
 	struct cpufreq_freqs *freq =3D data;
 	struct cpufreq_interactive_cpuinfo *pcpu;
 	int cpu;
+	unsigned long flags;
=20
 	if (val =3D=3D CPUFREQ_POSTCHANGE) {
 		pcpu =3D &per_cpu(cpuinfo, freq->cpu);
@@ -562,9 +565,9 @@ static int cpufreq_interactive_notifier(
 		for_each_cpu(cpu, pcpu->policy->cpus) {
 			struct cpufreq_interactive_cpuinfo *pjcpu =3D
 				&per_cpu(cpuinfo, cpu);
-			spin_lock(&pjcpu->load_lock);
+			spin_lock_irqsave(&pjcpu->load_lock, flags);
 			update_load(cpu);
-			spin_unlock(&pjcpu->load_lock);
+			spin_unlock_irqrestore(&pjcpu->load_lock, flags);
 		}
=20
 		up_read(&pcpu->enable_sem);
@@ -581,15 +584,16 @@ static ssize_t show_target_loads(
 {
 	int i;
 	ssize_t ret =3D 0;
+	unsigned long flags;
=20
-	spin_lock(&target_loads_lock);
+	spin_lock_irqsave(&target_loads_lock, flags);
=20
 	for (i =3D 0; i < ntarget_loads; i++)
 		ret +=3D sprintf(buf + ret, "%u%s", target_loads[i],
 			       i & 0x1 ? ":" : " ");
=20
 	ret +=3D sprintf(buf + ret, "\n");
-	spin_unlock(&target_loads_lock);
+	spin_unlock_irqrestore(&target_loads_lock, flags);
 	return ret;
 }
=20
@@ -602,6 +606,7 @@ static ssize_t store_target_loads(
 	unsigned int *new_target_loads =3D NULL;
 	int ntokens =3D 1;
 	int i;
+	unsigned long flags;
=20
 	cp =3D buf;
 	while ((cp =3D strpbrk(cp + 1, " :")))
@@ -631,12 +636,12 @@ static ssize_t store_target_loads(
 	if (i !=3D ntokens)
 		goto err_inval;
=20
-	spin_lock(&target_loads_lock);
+	spin_lock_irqsave(&target_loads_lock, flags);
 	if (target_loads !=3D default_target_loads)
 		kfree(target_loads);
 	target_loads =3D new_target_loads;
 	ntarget_loads =3D ntokens;
-	spin_unlock(&target_loads_lock);
+	spin_unlock_irqrestore(&target_loads_lock, flags);
 	return count;
=20
 err_inval:
--=20
1.7.9.5
