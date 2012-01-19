From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] input: CPU frequency booster
Date: Thu, 19 Jan 2012 23:52:59 +0100
Message-ID: <201201192353.00761.trenn@suse.de>
References: <1326977615-4387-1-git-send-email-amiettinen@nvidia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1326977615-4387-1-git-send-email-amiettinen@nvidia.com>
Sender: cpufreq-owner@vger.kernel.org
To: Antti P Miettinen <amiettinen@nvidia.com>
Cc: davej@redhat.com, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, khilman@ti.com, j-pihet@ti.com, markgross@thegnar.org, cpufreq@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

Not sure which email I should take to answer...

I can't see why pm_qos is needed at all, better use cpufreq
providing interface.
PPC (BIOS request to cut max_frequency) in
drivers/acpi/processor_perflib.c is a nice example

I'd also put this into drivers/cpufreq/cpufreq_input_boost.c.

Find below a re-written version of the booster.
Instead of pm_qos, it simply uses cpufreq interface:
/sys/devices/system/cpu/cpufreq/input_boost_freq
/sys/devices/system/cpu/cpufreq/input_boost_time

I started with global cpufreq variables, they could also
be declared per cpu like scaling_min_freq or others
(at least input_boost_freq, input_boost_time should probably
stay global). That would be:
/sys/devices/system/cpu/cpuX/cpufreq/input_boost_freq

A mechanism to set the right variables on the right HW
so that no userspace interaction is needed by default would be great.
Is there a PCI id, CPU family/model that could get checked
in the init func and automatically set the right values?

Now that this is part of cpufreq core, one could use these:
/* the following 3 funtions are for cpufreq core use only */                                                                                                          
struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu);                                                                                        
struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu);                                                                                                             
void   cpufreq_cpu_put(struct cpufreq_policy *data);                                                                                                                  

to find the 2nd lowest P-state or similar as default boost freq

A comment on which platforms this makes sense at all would be great.
Does any X86 machine need this?
Which ARM platforms you'd recommend to enable this in .config?

Could you give below a test, please.
Compile tested only.
Based on latest Linus git tree.
What do you think about it?

    Thomas

---
 drivers/cpufreq/Kconfig               |    9 ++
 drivers/cpufreq/Makefile              |    3 +
 drivers/cpufreq/cpufreq_input_boost.c |  238 +++++++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index e24a2a1..3f584d6 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -179,6 +179,15 @@ config CPU_FREQ_GOV_CONSERVATIVE
 
 	  If in doubt, say N.
 
+config INPUT_CFBOOST
+       boolean "CPU frequency booster"
+       depends on INPUT
+       help
+         Say Y here if you want to boost frequency upon input events;
+
+         To compile this driver as a module, choose M here: the
+         module will be called input-cfboost.
+
 menu "x86 CPU frequency scaling drivers"
 depends on X86
 source "drivers/cpufreq/Kconfig.x86"
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index ac000fa..d083b9f 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -10,6 +10,9 @@ obj-$(CONFIG_CPU_FREQ_GOV_USERSPACE)	+= cpufreq_userspace.o
 obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)	+= cpufreq_ondemand.o
 obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o
 
+# CPUfreq misc
+obj-$(CONFIG_INPUT_CFBOOST)		+= cpufreq_input_boost.o
+
 # CPUfreq cross-arch helpers
 obj-$(CONFIG_CPU_FREQ_TABLE)		+= freq_table.o
 
diff --git a/drivers/cpufreq/cpufreq_input_boost.c b/drivers/cpufreq/cpufreq_input_boost.c
new file mode 100644
index 0000000..3ef8bca
--- /dev/null
+++ b/drivers/cpufreq/cpufreq_input_boost.c
@@ -0,0 +1,238 @@
+/*
+ * drivers/input/input-cfboost.c
+ *
+ * Copyright (C) 2012 NVIDIA Corporation
+ * Copyright (C) 2012 Thomas Renninger <trenn@suse.de>
+ *     Better integration into cpufreq subsystem
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/printk.h>
+#include <linux/workqueue.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/cpufreq.h>
+
+/* This module listens to input events and sets a temporary frequency
+ * floor upon input event detection. This is based on changes to
+ * cpufreq ondemand governor by:
+ *
+ * Tero Kristo <tero.kristo@nokia.com>
+ * Brian Steuer <bsteuer@codeaurora.org>
+ * David Ng <dave@codeaurora.org>
+ *
+ * at git://codeaurora.org/kernel/msm.git tree, commits:
+ *
+ * 2a6181bc76c6ce46ca0fa8e547be42acd534cf0e
+ * 1cca8861d8fda4e05f6b0c59c60003345c15454d
+ * 96a9aeb02bf5b3fbbef47e44460750eb275e9f1b
+ * b600449501cf15928440f87eff86b1f32d14214e
+ * 88a65c7ae04632ffee11f9fc628d7ab017c06b83
+ */
+
+MODULE_AUTHOR("Antti P Miettinen <amiettinen@nvidia.com>");
+MODULE_DESCRIPTION("Input event CPU frequency booster");
+MODULE_LICENSE("GPL v2");
+
+
+static struct work_struct boost;
+static struct delayed_work unboost;
+static struct workqueue_struct *cfb_wq;
+
+/* sysfs stuff **************************/
+static unsigned long boost_time;
+static unsigned int boost_freq = 500;
+
+static ssize_t show_input_boost_time (struct kobject *kobj,
+				      struct attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", boost_time);
+}
+static ssize_t show_input_boost_freq (struct kobject *kobj,
+				      struct attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", boost_freq);
+}
+
+static ssize_t store_input_boost_time(struct kobject *a, struct attribute *b,
+				const char *buf, size_t count)
+{
+	/* TBD: Check input! */
+	int ret;
+	ret = sscanf(buf, "%lu", &boost_time);
+	if (ret != 1)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t store_input_boost_freq(struct kobject *a, struct attribute *b,
+				const char *buf, size_t count)
+{
+	/* TBD: Check input! */
+	int ret;
+	ret = sscanf(buf, "%u", &boost_freq);
+	if (ret != 1)
+		return -EINVAL;
+	return count;
+}
+define_one_global_rw(input_boost_freq);
+define_one_global_rw(input_boost_time);
+
+static const struct attribute *input_boost_attr[] = {
+	&input_boost_freq.attr,
+	&input_boost_time.attr,
+};
+
+/* sysfs stuff **************************/
+
+
+static void cfb_boost(struct work_struct *w)
+{
+	struct cpufreq_policy policy;
+	int ret;
+
+	cancel_delayed_work_sync(&unboost);
+	ret = cpufreq_get_policy(&policy, 0);
+	if (ret)
+		return;
+	cpufreq_verify_within_limits(&policy, boost_freq,
+				     policy.cpuinfo.max_freq);
+	queue_delayed_work(cfb_wq, &unboost,
+			   msecs_to_jiffies(boost_time));
+}
+
+static void cfb_unboost(struct work_struct *w)
+{
+	struct cpufreq_policy policy;
+	int ret;
+	
+	ret = cpufreq_get_policy(&policy, 0);
+	if (ret)
+		return;
+
+	cpufreq_verify_within_limits(&policy, policy.cpuinfo.min_freq,
+				     policy.cpuinfo.max_freq);
+}
+
+static void cfb_input_event(struct input_handle *handle, unsigned int type,
+			    unsigned int code, int value)
+{
+	if (!work_pending(&boost))
+		queue_work(cfb_wq, &boost);
+}
+
+static int cfb_input_connect(struct input_handler *handler,
+			     struct input_dev *dev,
+			     const struct input_device_id *id)
+{
+	struct input_handle *handle;
+	int error;
+
+	handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev = dev;
+	handle->handler = handler;
+	handle->name = "icfboost";
+
+	error = input_register_handle(handle);
+	if (error)
+		goto err2;
+
+	error = input_open_device(handle);
+	if (error)
+		goto err1;
+
+	return 0;
+err1:
+	input_unregister_handle(handle);
+err2:
+	kfree(handle);
+	return error;
+}
+
+static void cfb_input_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+static const struct input_device_id cfb_ids[] = {
+	{ /* touch screen */
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
+		INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT_MASK(EV_ABS) },
+		.keybit = {[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH) },
+	},
+	{ /* mouse */
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
+		INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT_MASK(EV_REL) },
+		.keybit = {[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_MOUSE) },
+	},
+	{ },
+};
+
+static struct input_handler cfb_input_handler = {
+	.event          = cfb_input_event,
+	.connect        = cfb_input_connect,
+	.disconnect     = cfb_input_disconnect,
+	.name           = "icfboost",
+	.id_table       = cfb_ids,
+};
+
+static int __init cfboost_init(void)
+{
+	/* TBD: Properly clean up in all cases */
+	int ret;
+
+	ret = sysfs_create_files(cpufreq_global_kobject,
+				 input_boost_attr);
+
+	cfb_wq = create_workqueue("icfb-wq");
+	if (!cfb_wq)
+		return -ENOMEM;
+	INIT_WORK(&boost, cfb_boost);
+	INIT_DELAYED_WORK(&unboost, cfb_unboost);
+	ret = input_register_handler(&cfb_input_handler);
+	if (ret) {
+		destroy_workqueue(cfb_wq);
+		return ret;
+	}
+	return 0;
+}
+
+static void __exit cfboost_exit(void)
+{
+	sysfs_remove_files(cpufreq_global_kobject,
+			   input_boost_attr);
+
+	/* stop input events */
+	input_unregister_handler(&cfb_input_handler);
+	/* cancel pending work requests */
+	cancel_work_sync(&boost);
+	cancel_delayed_work_sync(&unboost);
+	/* clean up */
+	destroy_workqueue(cfb_wq);
+}
+
+module_init(cfboost_init);
+module_exit(cfboost_exit);
