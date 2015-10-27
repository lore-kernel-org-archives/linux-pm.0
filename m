From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 20/70] cpufreq: interactive: remove input_boost handling
Date: Tue, 27 Oct 2015 18:30:08 +0100
Message-ID: <1445967059-6897-20-git-send-email-czoborbalint@gmail.com>
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

Now handled in userspace Power HAL instead.

Change-Id: I78a4a2fd471308bfcd785bbefcc65fede27314cf
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |  146 -------------------------=
--------
 1 file changed, 146 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index e9c8516..4b60b6e 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -30,7 +30,6 @@
 #include <linux/kthread.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
-#include <linux/input.h>
 #include <asm/cputime.h>
=20
 #define CREATE_TRACE_POINTS
@@ -90,20 +89,6 @@ static unsigned long timer_rate;
 static unsigned long above_hispeed_delay_val;
=20
 /*
- * Boost pulse to hispeed on touchscreen input.
- */
-
-static int input_boost_val;
-
-struct cpufreq_interactive_inputopen {
-	struct input_handle *handle;
-	struct work_struct inputopen_work;
-};
-
-static struct cpufreq_interactive_inputopen inputopen;
-static struct workqueue_struct *inputopen_wq;
-
-/*
  * Non-zero means longer-term speed boost active.
  */
=20
@@ -476,96 +461,6 @@ static void cpufreq_interactive_boost(void)
 		wake_up_process(speedchange_task);
 }
=20
-/*
- * Pulsed boost on input event raises CPUs to hispeed_freq and lets
- * usual algorithm of min_sample_time  decide when to allow speed
- * to drop.
- */
-
-static void cpufreq_interactive_input_event(struct input_handle *handl=
e,
-					    unsigned int type,
-					    unsigned int code, int value)
-{
-	if (input_boost_val && type =3D=3D EV_SYN && code =3D=3D SYN_REPORT) =
{
-		trace_cpufreq_interactive_boost("input");
-		cpufreq_interactive_boost();
-	}
-}
-
-static void cpufreq_interactive_input_open(struct work_struct *w)
-{
-	struct cpufreq_interactive_inputopen *io =3D
-		container_of(w, struct cpufreq_interactive_inputopen,
-			     inputopen_work);
-	int error;
-
-	error =3D input_open_device(io->handle);
-	if (error)
-		input_unregister_handle(io->handle);
-}
-
-static int cpufreq_interactive_input_connect(struct input_handler *han=
dler,
-					     struct input_dev *dev,
-					     const struct input_device_id *id)
-{
-	struct input_handle *handle;
-	int error;
-
-	pr_info("%s: connect to %s\n", __func__, dev->name);
-	handle =3D kzalloc(sizeof(struct input_handle), GFP_KERNEL);
-	if (!handle)
-		return -ENOMEM;
-
-	handle->dev =3D dev;
-	handle->handler =3D handler;
-	handle->name =3D "cpufreq_interactive";
-
-	error =3D input_register_handle(handle);
-	if (error)
-		goto err;
-
-	inputopen.handle =3D handle;
-	queue_work(inputopen_wq, &inputopen.inputopen_work);
-	return 0;
-err:
-	kfree(handle);
-	return error;
-}
-
-static void cpufreq_interactive_input_disconnect(struct input_handle *=
handle)
-{
-	input_close_device(handle);
-	input_unregister_handle(handle);
-	kfree(handle);
-}
-
-static const struct input_device_id cpufreq_interactive_ids[] =3D {
-	{
-		.flags =3D INPUT_DEVICE_ID_MATCH_EVBIT |
-			 INPUT_DEVICE_ID_MATCH_ABSBIT,
-		.evbit =3D { BIT_MASK(EV_ABS) },
-		.absbit =3D { [BIT_WORD(ABS_MT_POSITION_X)] =3D
-			    BIT_MASK(ABS_MT_POSITION_X) |
-			    BIT_MASK(ABS_MT_POSITION_Y) },
-	}, /* multi-touch touchscreen */
-	{
-		.flags =3D INPUT_DEVICE_ID_MATCH_KEYBIT |
-			 INPUT_DEVICE_ID_MATCH_ABSBIT,
-		.keybit =3D { [BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH) },
-		.absbit =3D { [BIT_WORD(ABS_X)] =3D
-			    BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) },
-	}, /* touchpad */
-	{ },
-};
-
-static struct input_handler cpufreq_interactive_input_handler =3D {
-	.event          =3D cpufreq_interactive_input_event,
-	.connect        =3D cpufreq_interactive_input_connect,
-	.disconnect     =3D cpufreq_interactive_input_disconnect,
-	.name           =3D "cpufreq_interactive",
-	.id_table       =3D cpufreq_interactive_ids,
-};
-
 static ssize_t show_hispeed_freq(struct kobject *kobj,
 				 struct attribute *attr, char *buf)
 {
@@ -678,27 +573,6 @@ static ssize_t store_timer_rate(struct kobject *ko=
bj,
 static struct global_attr timer_rate_attr =3D __ATTR(timer_rate, 0644,
 		show_timer_rate, store_timer_rate);
=20
-static ssize_t show_input_boost(struct kobject *kobj, struct attribute=
 *attr,
-				char *buf)
-{
-	return sprintf(buf, "%u\n", input_boost_val);
-}
-
-static ssize_t store_input_boost(struct kobject *kobj, struct attribut=
e *attr,
-				 const char *buf, size_t count)
-{
-	int ret;
-	unsigned long val;
-
-	ret =3D strict_strtoul(buf, 0, &val);
-	if (ret < 0)
-		return ret;
-	input_boost_val =3D val;
-	return count;
-}
-
-define_one_global_rw(input_boost);
-
 static ssize_t show_boost(struct kobject *kobj, struct attribute *attr=
,
 			  char *buf)
 {
@@ -753,7 +627,6 @@ static struct attribute *interactive_attributes[] =3D=
 {
 	&above_hispeed_delay.attr,
 	&min_sample_time_attr.attr,
 	&timer_rate_attr.attr,
-	&input_boost.attr,
 	&boost.attr,
 	&boostpulse.attr,
 	NULL,
@@ -832,11 +705,6 @@ static int cpufreq_governor_interactive(struct cpu=
freq_policy *policy,
 		if (rc)
 			return rc;
=20
-		rc =3D input_register_handler(&cpufreq_interactive_input_handler);
-		if (rc)
-			pr_warn("%s: failed to register input handler\n",
-				__func__);
-
 		idle_notifier_register(&cpufreq_interactive_idle_nb);
 		break;
=20
@@ -856,12 +724,10 @@ static int cpufreq_governor_interactive(struct cp=
ufreq_policy *policy,
 			pcpu->idle_exit_time =3D 0;
 		}
=20
-		flush_work(&inputopen.inputopen_work);
 		if (atomic_dec_return(&active_count) > 0)
 			return 0;
=20
 		idle_notifier_unregister(&cpufreq_interactive_idle_nb);
-		input_unregister_handler(&cpufreq_interactive_input_handler);
 		sysfs_remove_group(cpufreq_global_kobject,
 				&interactive_attr_group);
=20
@@ -908,21 +774,10 @@ static int __init cpufreq_interactive_init(void)
 	sched_setscheduler_nocheck(speedchange_task, SCHED_FIFO, &param);
 	get_task_struct(speedchange_task);
=20
-	inputopen_wq =3D create_workqueue("cfinteractive");
-
-	if (!inputopen_wq)
-		goto err_freetask;
-
-	INIT_WORK(&inputopen.inputopen_work, cpufreq_interactive_input_open);
-
 	/* NB: wake up so the thread does not look hung to the freezer */
 	wake_up_process(speedchange_task);
=20
 	return cpufreq_register_governor(&cpufreq_gov_interactive);
-
-err_freetask:
-	put_task_struct(speedchange_task);
-	return -ENOMEM;
 }
=20
 #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_INTERACTIVE
@@ -936,7 +791,6 @@ static void __exit cpufreq_interactive_exit(void)
 	cpufreq_unregister_governor(&cpufreq_gov_interactive);
 	kthread_stop(speedchange_task);
 	put_task_struct(speedchange_task);
-	destroy_workqueue(inputopen_wq);
 }
=20
 module_exit(cpufreq_interactive_exit);
--=20
1.7.9.5
