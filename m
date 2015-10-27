From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 41/70] cpufreq: interactive: fix race on governor start/stop
Date: Tue, 27 Oct 2015 18:30:29 +0100
Message-ID: <1445967059-6897-41-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Lianwei Wang <a22439@motorola.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Lianwei Wang <a22439@motorola.com>

There is race condition when both two cpu do CPUFREQ_GOV_STOP and one c=
pu
do CPUFREQ_GOV_START soon. The sysfs_remove_group is not done yet on on=
e
cpu, but sysfs_create_group is called on another cpu, which cause gover=
nor
start failed and then kernel panic in timer callback because the policy=
 and
cpu mask are all kfree in cpufreq driver.

Replace atomic with mutex to lock the whole START/STOP sequence.

Change-Id: I3762b3d44315ae021b8275aca84f5ea9147cc540
Signed-off-by: Lianwei Wang <a22439@motorola.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index e7f26aa..3447e58 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -35,7 +35,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/cpufreq_interactive.h>
=20
-static atomic_t active_count =3D ATOMIC_INIT(0);
+static int active_count;
=20
 struct cpufreq_interactive_cpuinfo {
 	struct timer_list cpu_timer;
@@ -61,6 +61,7 @@ static DEFINE_PER_CPU(struct cpufreq_interactive_cpui=
nfo, cpuinfo);
 static struct task_struct *speedchange_task;
 static cpumask_t speedchange_cpumask;
 static spinlock_t speedchange_cpumask_lock;
+static struct mutex gov_lock;
=20
 /* Hi speed to bump to from lo speed when load burst (default max) */
 static unsigned int hispeed_freq;
@@ -914,6 +915,8 @@ static int cpufreq_governor_interactive(struct cpuf=
req_policy *policy,
 		if (!cpu_online(policy->cpu))
 			return -EINVAL;
=20
+		mutex_lock(&gov_lock);
+
 		freq_table =3D
 			cpufreq_frequency_get_table(policy->cpu);
 		if (!hispeed_freq)
@@ -948,20 +951,26 @@ static int cpufreq_governor_interactive(struct cp=
ufreq_policy *policy,
 		 * Do not register the idle hook and create sysfs
 		 * entries if we have already done so.
 		 */
-		if (atomic_inc_return(&active_count) > 1)
+		if (++active_count > 1) {
+			mutex_unlock(&gov_lock);
 			return 0;
+		}
=20
 		rc =3D sysfs_create_group(cpufreq_global_kobject,
 				&interactive_attr_group);
-		if (rc)
+		if (rc) {
+			mutex_unlock(&gov_lock);
 			return rc;
+		}
=20
 		idle_notifier_register(&cpufreq_interactive_idle_nb);
 		cpufreq_register_notifier(
 			&cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
+		mutex_unlock(&gov_lock);
 		break;
=20
 	case CPUFREQ_GOV_STOP:
+		mutex_lock(&gov_lock);
 		for_each_cpu(j, policy->cpus) {
 			pcpu =3D &per_cpu(cpuinfo, j);
 			down_write(&pcpu->enable_sem);
@@ -971,14 +980,17 @@ static int cpufreq_governor_interactive(struct cp=
ufreq_policy *policy,
 			up_write(&pcpu->enable_sem);
 		}
=20
-		if (atomic_dec_return(&active_count) > 0)
+		if (--active_count > 0) {
+			mutex_unlock(&gov_lock);
 			return 0;
+		}
=20
 		cpufreq_unregister_notifier(
 			&cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
 		idle_notifier_unregister(&cpufreq_interactive_idle_nb);
 		sysfs_remove_group(cpufreq_global_kobject,
 				&interactive_attr_group);
+		mutex_unlock(&gov_lock);
=20
 		break;
=20
@@ -1018,6 +1030,7 @@ static int __init cpufreq_interactive_init(void)
=20
 	spin_lock_init(&target_loads_lock);
 	spin_lock_init(&speedchange_cpumask_lock);
+	mutex_init(&gov_lock);
 	speedchange_task =3D
 		kthread_create(cpufreq_interactive_speedchange_task, NULL,
 			       "cfinteractive");
--=20
1.7.9.5
