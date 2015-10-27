From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 19/70] cpufreq: interactive: handle speed up and down in the realtime task
Date: Tue, 27 Oct 2015 18:30:07 +0100
Message-ID: <1445967059-6897-19-git-send-email-czoborbalint@gmail.com>
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

Not useful to have a separate, non-realtime workqueue for speed down
events, avoid priority inversion for speed up events.

Change-Id: Iddcd05545245c847aa1bbe0b8790092914c813d2
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c      |  148 +++++++++-----------=
--------
 include/trace/events/cpufreq_interactive.h |    8 +-
 2 files changed, 45 insertions(+), 111 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 184140a..e9c8516 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -58,15 +58,10 @@ struct cpufreq_interactive_cpuinfo {
=20
 static DEFINE_PER_CPU(struct cpufreq_interactive_cpuinfo, cpuinfo);
=20
-/* Workqueues handle frequency scaling */
-static struct task_struct *up_task;
-static struct workqueue_struct *down_wq;
-static struct work_struct freq_scale_down_work;
-static cpumask_t up_cpumask;
-static spinlock_t up_cpumask_lock;
-static cpumask_t down_cpumask;
-static spinlock_t down_cpumask_lock;
-static struct mutex set_speed_lock;
+/* realtime thread handles frequency scaling */
+static struct task_struct *speedchange_task;
+static cpumask_t speedchange_cpumask;
+static spinlock_t speedchange_cpumask_lock;
=20
 /* Hi speed to bump to from lo speed when load burst (default max) */
 static u64 hispeed_freq;
@@ -106,6 +101,7 @@ struct cpufreq_interactive_inputopen {
 };
=20
 static struct cpufreq_interactive_inputopen inputopen;
+static struct workqueue_struct *inputopen_wq;
=20
 /*
  * Non-zero means longer-term speed boost active.
@@ -259,19 +255,11 @@ static void cpufreq_interactive_timer(unsigned lo=
ng data)
 	pcpu->target_set_time_in_idle =3D now_idle;
 	pcpu->target_set_time =3D pcpu->timer_run_time;
=20
-	if (new_freq < pcpu->target_freq) {
-		pcpu->target_freq =3D new_freq;
-		spin_lock_irqsave(&down_cpumask_lock, flags);
-		cpumask_set_cpu(data, &down_cpumask);
-		spin_unlock_irqrestore(&down_cpumask_lock, flags);
-		queue_work(down_wq, &freq_scale_down_work);
-	} else {
-		pcpu->target_freq =3D new_freq;
-		spin_lock_irqsave(&up_cpumask_lock, flags);
-		cpumask_set_cpu(data, &up_cpumask);
-		spin_unlock_irqrestore(&up_cpumask_lock, flags);
-		wake_up_process(up_task);
-	}
+	pcpu->target_freq =3D new_freq;
+	spin_lock_irqsave(&speedchange_cpumask_lock, flags);
+	cpumask_set_cpu(data, &speedchange_cpumask);
+	spin_unlock_irqrestore(&speedchange_cpumask_lock, flags);
+	wake_up_process(speedchange_task);
=20
 rearm_if_notmax:
 	/*
@@ -394,7 +382,7 @@ static void cpufreq_interactive_idle_end(void)
=20
 }
=20
-static int cpufreq_interactive_up_task(void *data)
+static int cpufreq_interactive_speedchange_task(void *data)
 {
 	unsigned int cpu;
 	cpumask_t tmp_mask;
@@ -403,22 +391,23 @@ static int cpufreq_interactive_up_task(void *data=
)
=20
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		spin_lock_irqsave(&up_cpumask_lock, flags);
+		spin_lock_irqsave(&speedchange_cpumask_lock, flags);
=20
-		if (cpumask_empty(&up_cpumask)) {
-			spin_unlock_irqrestore(&up_cpumask_lock, flags);
+		if (cpumask_empty(&speedchange_cpumask)) {
+			spin_unlock_irqrestore(&speedchange_cpumask_lock,
+					       flags);
 			schedule();
=20
 			if (kthread_should_stop())
 				break;
=20
-			spin_lock_irqsave(&up_cpumask_lock, flags);
+			spin_lock_irqsave(&speedchange_cpumask_lock, flags);
 		}
=20
 		set_current_state(TASK_RUNNING);
-		tmp_mask =3D up_cpumask;
-		cpumask_clear(&up_cpumask);
-		spin_unlock_irqrestore(&up_cpumask_lock, flags);
+		tmp_mask =3D speedchange_cpumask;
+		cpumask_clear(&speedchange_cpumask);
+		spin_unlock_irqrestore(&speedchange_cpumask_lock, flags);
=20
 		for_each_cpu(cpu, &tmp_mask) {
 			unsigned int j;
@@ -430,8 +419,6 @@ static int cpufreq_interactive_up_task(void *data)
 			if (!pcpu->governor_enabled)
 				continue;
=20
-			mutex_lock(&set_speed_lock);
-
 			for_each_cpu(j, pcpu->policy->cpus) {
 				struct cpufreq_interactive_cpuinfo *pjcpu =3D
 					&per_cpu(cpuinfo, j);
@@ -444,8 +431,8 @@ static int cpufreq_interactive_up_task(void *data)
 				__cpufreq_driver_target(pcpu->policy,
 							max_freq,
 							CPUFREQ_RELATION_H);
-			mutex_unlock(&set_speed_lock);
-			trace_cpufreq_interactive_up(cpu, pcpu->target_freq,
+			trace_cpufreq_interactive_setspeed(cpu,
+						     pcpu->target_freq,
 						     pcpu->policy->cur);
 		}
 	}
@@ -453,48 +440,6 @@ static int cpufreq_interactive_up_task(void *data)
 	return 0;
 }
=20
-static void cpufreq_interactive_freq_down(struct work_struct *work)
-{
-	unsigned int cpu;
-	cpumask_t tmp_mask;
-	unsigned long flags;
-	struct cpufreq_interactive_cpuinfo *pcpu;
-
-	spin_lock_irqsave(&down_cpumask_lock, flags);
-	tmp_mask =3D down_cpumask;
-	cpumask_clear(&down_cpumask);
-	spin_unlock_irqrestore(&down_cpumask_lock, flags);
-
-	for_each_cpu(cpu, &tmp_mask) {
-		unsigned int j;
-		unsigned int max_freq =3D 0;
-
-		pcpu =3D &per_cpu(cpuinfo, cpu);
-		smp_rmb();
-
-		if (!pcpu->governor_enabled)
-			continue;
-
-		mutex_lock(&set_speed_lock);
-
-		for_each_cpu(j, pcpu->policy->cpus) {
-			struct cpufreq_interactive_cpuinfo *pjcpu =3D
-				&per_cpu(cpuinfo, j);
-
-			if (pjcpu->target_freq > max_freq)
-				max_freq =3D pjcpu->target_freq;
-		}
-
-		if (max_freq !=3D pcpu->policy->cur)
-			__cpufreq_driver_target(pcpu->policy, max_freq,
-						CPUFREQ_RELATION_H);
-
-		mutex_unlock(&set_speed_lock);
-		trace_cpufreq_interactive_down(cpu, pcpu->target_freq,
-					       pcpu->policy->cur);
-	}
-}
-
 static void cpufreq_interactive_boost(void)
 {
 	int i;
@@ -502,14 +447,14 @@ static void cpufreq_interactive_boost(void)
 	unsigned long flags;
 	struct cpufreq_interactive_cpuinfo *pcpu;
=20
-	spin_lock_irqsave(&up_cpumask_lock, flags);
+	spin_lock_irqsave(&speedchange_cpumask_lock, flags);
=20
 	for_each_online_cpu(i) {
 		pcpu =3D &per_cpu(cpuinfo, i);
=20
 		if (pcpu->target_freq < hispeed_freq) {
 			pcpu->target_freq =3D hispeed_freq;
-			cpumask_set_cpu(i, &up_cpumask);
+			cpumask_set_cpu(i, &speedchange_cpumask);
 			pcpu->target_set_time_in_idle =3D
 				get_cpu_idle_time_us(i, &pcpu->target_set_time);
 			pcpu->hispeed_validate_time =3D pcpu->target_set_time;
@@ -525,10 +470,10 @@ static void cpufreq_interactive_boost(void)
 		pcpu->floor_validate_time =3D ktime_to_us(ktime_get());
 	}
=20
-	spin_unlock_irqrestore(&up_cpumask_lock, flags);
+	spin_unlock_irqrestore(&speedchange_cpumask_lock, flags);
=20
 	if (anyboost)
-		wake_up_process(up_task);
+		wake_up_process(speedchange_task);
 }
=20
 /*
@@ -580,7 +525,7 @@ static int cpufreq_interactive_input_connect(struct=
 input_handler *handler,
 		goto err;
=20
 	inputopen.handle =3D handle;
-	queue_work(down_wq, &inputopen.inputopen_work);
+	queue_work(inputopen_wq, &inputopen.inputopen_work);
 	return 0;
 err:
 	kfree(handle);
@@ -911,7 +856,7 @@ static int cpufreq_governor_interactive(struct cpuf=
req_policy *policy,
 			pcpu->idle_exit_time =3D 0;
 		}
=20
-		flush_work(&freq_scale_down_work);
+		flush_work(&inputopen.inputopen_work);
 		if (atomic_dec_return(&active_count) > 0)
 			return 0;
=20
@@ -953,35 +898,30 @@ static int __init cpufreq_interactive_init(void)
 		pcpu->cpu_timer.data =3D i;
 	}
=20
-	spin_lock_init(&up_cpumask_lock);
-	spin_lock_init(&down_cpumask_lock);
-	mutex_init(&set_speed_lock);
-
-	up_task =3D kthread_create(cpufreq_interactive_up_task, NULL,
-				 "kinteractiveup");
-	if (IS_ERR(up_task))
-		return PTR_ERR(up_task);
+	spin_lock_init(&speedchange_cpumask_lock);
+	speedchange_task =3D
+		kthread_create(cpufreq_interactive_speedchange_task, NULL,
+			       "cfinteractive");
+	if (IS_ERR(speedchange_task))
+		return PTR_ERR(speedchange_task);
=20
-	sched_setscheduler_nocheck(up_task, SCHED_FIFO, &param);
-	get_task_struct(up_task);
+	sched_setscheduler_nocheck(speedchange_task, SCHED_FIFO, &param);
+	get_task_struct(speedchange_task);
=20
-	/* No rescuer thread, bind to CPU queuing the work for possibly
-	   warm cache (probably doesn't matter much). */
-	down_wq =3D alloc_workqueue("knteractive_down", 0, 1);
+	inputopen_wq =3D create_workqueue("cfinteractive");
=20
-	if (!down_wq)
-		goto err_freeuptask;
+	if (!inputopen_wq)
+		goto err_freetask;
=20
-	INIT_WORK(&freq_scale_down_work, cpufreq_interactive_freq_down);
 	INIT_WORK(&inputopen.inputopen_work, cpufreq_interactive_input_open);
=20
 	/* NB: wake up so the thread does not look hung to the freezer */
-	wake_up_process(up_task);
+	wake_up_process(speedchange_task);
=20
 	return cpufreq_register_governor(&cpufreq_gov_interactive);
=20
-err_freeuptask:
-	put_task_struct(up_task);
+err_freetask:
+	put_task_struct(speedchange_task);
 	return -ENOMEM;
 }
=20
@@ -994,9 +934,9 @@ module_init(cpufreq_interactive_init);
 static void __exit cpufreq_interactive_exit(void)
 {
 	cpufreq_unregister_governor(&cpufreq_gov_interactive);
-	kthread_stop(up_task);
-	put_task_struct(up_task);
-	destroy_workqueue(down_wq);
+	kthread_stop(speedchange_task);
+	put_task_struct(speedchange_task);
+	destroy_workqueue(inputopen_wq);
 }
=20
 module_exit(cpufreq_interactive_exit);
diff --git a/include/trace/events/cpufreq_interactive.h b/include/trace=
/events/cpufreq_interactive.h
index 0791f27..ba0634e 100644
--- a/include/trace/events/cpufreq_interactive.h
+++ b/include/trace/events/cpufreq_interactive.h
@@ -28,13 +28,7 @@ DECLARE_EVENT_CLASS(set,
 	      __entry->actualfreq)
 );
=20
-DEFINE_EVENT(set, cpufreq_interactive_up,
-	TP_PROTO(u32 cpu_id, unsigned long targfreq,
-	     unsigned long actualfreq),
-	TP_ARGS(cpu_id, targfreq, actualfreq)
-);
-
-DEFINE_EVENT(set, cpufreq_interactive_down,
+DEFINE_EVENT(set, cpufreq_interactive_setspeed,
 	TP_PROTO(u32 cpu_id, unsigned long targfreq,
 	     unsigned long actualfreq),
 	TP_ARGS(cpu_id, targfreq, actualfreq)
--=20
1.7.9.5
