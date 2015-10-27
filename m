From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 10/70] cpufreq: interactive: Boost frequency on touchscreen input
Date: Tue, 27 Oct 2015 18:29:58 +0100
Message-ID: <1445967059-6897-10-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38872 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965187AbbJ0Rbu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 13:31:50 -0400
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>

=46rom: Todd Poynor <toddpoynor@google.com>

Based on previous patches by Tero Kristo <tero.kristo@nokia.com>,
Brian Steuer <bsteuer@codeaurora.org>,
David Ng <dave@codeaurora.org>,
Antti P Miettinen <amiettinen@nvidia.com>, and
Thomas Renninger <trenn@suse.de>

Change-Id: Ic55fedcf6f9310f43a7022fb88e23b0392122769
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 Documentation/cpu-freq/governors.txt       |    3 +
 drivers/cpufreq/cpufreq_interactive.c      |  164 ++++++++++++++++++++=
+++++++-
 include/trace/events/cpufreq_interactive.h |   12 ++
 3 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-f=
req/governors.txt
index 40894da..4172cad 100644
--- a/Documentation/cpu-freq/governors.txt
+++ b/Documentation/cpu-freq/governors.txt
@@ -264,6 +264,9 @@ Default is 20000 uS.
 timer_rate: Sample rate for reevaluating cpu load when the system is
 not idle.  Default is 20000 uS.
=20
+input_boost: If non-zero, boost speed of all CPUs to hispeed_freq on
+touchscreen activity.  Default is 0.
+
=20
 3. The Governor Interface in the CPUfreq Core
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 083f790..1387cd5 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -29,6 +29,8 @@
 #include <linux/workqueue.h>
 #include <linux/kthread.h>
 #include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/input.h>
=20
 #define CREATE_TRACE_POINTS
 #include <trace/events/cpufreq_interactive.h>
@@ -92,6 +94,19 @@ static unsigned long timer_rate;
 #define DEFAULT_ABOVE_HISPEED_DELAY DEFAULT_TIMER_RATE
 static unsigned long above_hispeed_delay_val;
=20
+/*
+ * Boost to hispeed on touchscreen input.
+ */
+
+static int input_boost_val;
+
+struct cpufreq_interactive_inputopen {
+	struct input_handle *handle;
+	struct work_struct inputopen_work;
+};
+
+static struct cpufreq_interactive_inputopen inputopen;
+
 static int cpufreq_governor_interactive(struct cpufreq_policy *policy,
 		unsigned int event);
=20
@@ -468,6 +483,125 @@ static void cpufreq_interactive_freq_down(struct =
work_struct *work)
 	}
 }
=20
+static void cpufreq_interactive_boost(void)
+{
+	int i;
+	int anyboost =3D 0;
+	unsigned long flags;
+	struct cpufreq_interactive_cpuinfo *pcpu;
+
+	trace_cpufreq_interactive_boost(hispeed_freq);
+	spin_lock_irqsave(&up_cpumask_lock, flags);
+
+	for_each_online_cpu(i) {
+		pcpu =3D &per_cpu(cpuinfo, i);
+
+		if (pcpu->target_freq < hispeed_freq) {
+			pcpu->target_freq =3D hispeed_freq;
+			cpumask_set_cpu(i, &up_cpumask);
+			pcpu->target_set_time_in_idle =3D
+				get_cpu_idle_time_us(i, &pcpu->target_set_time);
+			anyboost =3D 1;
+		}
+
+		/*
+		 * Refresh time at which current (possibly being
+		 * boosted) speed last validated (reset timer for
+		 * allowing speed to drop).
+		 */
+
+		pcpu->target_validate_time_in_idle =3D
+			get_cpu_idle_time_us(i, &pcpu->target_validate_time);
+	}
+
+	spin_unlock_irqrestore(&up_cpumask_lock, flags);
+
+	if (anyboost)
+		wake_up_process(up_task);
+}
+
+static void cpufreq_interactive_input_event(struct input_handle *handl=
e,
+					    unsigned int type,
+					    unsigned int code, int value)
+{
+	if (input_boost_val && type =3D=3D EV_SYN && code =3D=3D SYN_REPORT)
+		cpufreq_interactive_boost();
+}
+
+static void cpufreq_interactive_input_open(struct work_struct *w)
+{
+	struct cpufreq_interactive_inputopen *io =3D
+		container_of(w, struct cpufreq_interactive_inputopen,
+			     inputopen_work);
+	int error;
+
+	error =3D input_open_device(io->handle);
+	if (error)
+		input_unregister_handle(io->handle);
+}
+
+static int cpufreq_interactive_input_connect(struct input_handler *han=
dler,
+					     struct input_dev *dev,
+					     const struct input_device_id *id)
+{
+	struct input_handle *handle;
+	int error;
+
+	pr_info("%s: connect to %s\n", __func__, dev->name);
+	handle =3D kzalloc(sizeof(struct input_handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev =3D dev;
+	handle->handler =3D handler;
+	handle->name =3D "cpufreq_interactive";
+
+	error =3D input_register_handle(handle);
+	if (error)
+		goto err;
+
+	inputopen.handle =3D handle;
+	queue_work(down_wq, &inputopen.inputopen_work);
+	return 0;
+err:
+	kfree(handle);
+	return error;
+}
+
+static void cpufreq_interactive_input_disconnect(struct input_handle *=
handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+static const struct input_device_id cpufreq_interactive_ids[] =3D {
+	{
+		.flags =3D INPUT_DEVICE_ID_MATCH_EVBIT |
+			 INPUT_DEVICE_ID_MATCH_ABSBIT,
+		.evbit =3D { BIT_MASK(EV_ABS) },
+		.absbit =3D { [BIT_WORD(ABS_MT_POSITION_X)] =3D
+			    BIT_MASK(ABS_MT_POSITION_X) |
+			    BIT_MASK(ABS_MT_POSITION_Y) },
+	}, /* multi-touch touchscreen */
+	{
+		.flags =3D INPUT_DEVICE_ID_MATCH_KEYBIT |
+			 INPUT_DEVICE_ID_MATCH_ABSBIT,
+		.keybit =3D { [BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH) },
+		.absbit =3D { [BIT_WORD(ABS_X)] =3D
+			    BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) },
+	}, /* touchpad */
+	{ },
+};
+
+static struct input_handler cpufreq_interactive_input_handler =3D {
+	.event          =3D cpufreq_interactive_input_event,
+	.connect        =3D cpufreq_interactive_input_connect,
+	.disconnect     =3D cpufreq_interactive_input_disconnect,
+	.name           =3D "cpufreq_interactive",
+	.id_table       =3D cpufreq_interactive_ids,
+};
+
 static ssize_t show_hispeed_freq(struct kobject *kobj,
 				 struct attribute *attr, char *buf)
 {
@@ -580,12 +714,34 @@ static ssize_t store_timer_rate(struct kobject *k=
obj,
 static struct global_attr timer_rate_attr =3D __ATTR(timer_rate, 0644,
 		show_timer_rate, store_timer_rate);
=20
+static ssize_t show_input_boost(struct kobject *kobj, struct attribute=
 *attr,
+				char *buf)
+{
+	return sprintf(buf, "%u\n", input_boost_val);
+}
+
+static ssize_t store_input_boost(struct kobject *kobj, struct attribut=
e *attr,
+				 const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D strict_strtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+	input_boost_val =3D val;
+	return count;
+}
+
+define_one_global_rw(input_boost);
+
 static struct attribute *interactive_attributes[] =3D {
 	&hispeed_freq_attr.attr,
 	&go_hispeed_load_attr.attr,
 	&above_hispeed_delay.attr,
 	&min_sample_time_attr.attr,
 	&timer_rate_attr.attr,
+	&input_boost.attr,
 	NULL,
 };
=20
@@ -641,6 +797,11 @@ static int cpufreq_governor_interactive(struct cpu=
freq_policy *policy,
 		if (rc)
 			return rc;
=20
+		rc =3D input_register_handler(&cpufreq_interactive_input_handler);
+		if (rc)
+			pr_warn("%s: failed to register input handler\n",
+				__func__);
+
 		break;
=20
 	case CPUFREQ_GOV_STOP:
@@ -663,6 +824,7 @@ static int cpufreq_governor_interactive(struct cpuf=
req_policy *policy,
 		if (atomic_dec_return(&active_count) > 0)
 			return 0;
=20
+		input_unregister_handler(&cpufreq_interactive_input_handler);
 		sysfs_remove_group(cpufreq_global_kobject,
 				&interactive_attr_group);
=20
@@ -742,7 +904,7 @@ static int __init cpufreq_interactive_init(void)
 	mutex_init(&set_speed_lock);
=20
 	idle_notifier_register(&cpufreq_interactive_idle_nb);
-
+	INIT_WORK(&inputopen.inputopen_work, cpufreq_interactive_input_open);
 	return cpufreq_register_governor(&cpufreq_gov_interactive);
=20
 err_freeuptask:
diff --git a/include/trace/events/cpufreq_interactive.h b/include/trace=
/events/cpufreq_interactive.h
index 3a90d3d..19e070b 100644
--- a/include/trace/events/cpufreq_interactive.h
+++ b/include/trace/events/cpufreq_interactive.h
@@ -81,6 +81,18 @@ DEFINE_EVENT(loadeval, cpufreq_interactive_notyet,
 		     unsigned long curfreq, unsigned long targfreq),
 	    TP_ARGS(cpu_id, load, curfreq, targfreq)
 );
+
+TRACE_EVENT(cpufreq_interactive_boost,
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
 #endif /* _TRACE_CPUFREQ_INTERACTIVE_H */
=20
 /* This part must be outside protection */
--=20
1.7.9.5

