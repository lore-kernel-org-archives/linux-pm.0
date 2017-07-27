From: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Subject: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states
 after some time
Date: Thu, 27 Jul 2017 14:50:14 +0200
Message-ID: <4491b9f9-bc6f-f173-5816-c46a2f41de8e@tu-dresden.de>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout6.zih.tu-dresden.de ([141.30.67.75]:55016 "EHLO
        mailout6.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751510AbdG0NHh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 09:07:37 -0400
In-Reply-To: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alex Shi <alex.shi@linaro.org>, Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, linux-pm@vger.kernel.org
Cc: =?UTF-8?Q?Marcus_H=c3=a4hnel?= <mhaehnel@os.inf.tu-dresden.de>, Daniel Hackenberg <daniel.hackenberg@tu-dresden.de>, =?UTF-8?Q?Robert_Sch=c3=b6ne?= <robert.schoene@tu-dresden.de>, "mario.bielert@tu-dresden.de" <mario.bielert@tu-dresden.de>

On several contemporary Intel systems, we have observed that the idle
power consumption is sometimes significantly too high, e.g. 105 W instead
of 74 W for several seconds.

We tracked this issue down to patterns that confuse the heuristic of the
menu idle governor. If the governor observes several consecutive short
sleeps, it does expect another short sleep duration despite no immediate
timers, sending the CPU into a shallow sleep state. On a dyntick-idle
kernel, there are no means for the core to enter a more efficient sleep
state if the prediction was wrong. Ironically this is particularly
problematic if some cores of the system have very infrequent activity, i.e.
many cores and optimized configuration for low idle power.

The effect, cause, triggers, mitigation technique and verification thereof
are described in detail in the a paper that is pending publication [1].

Fixing the heuristic to make a better prediction does not seem to be
generally feasible. The following patch addresses this issue by setting a
timer such that when the an expected immediate wake-up fails to appear, the
CPU is woken up to go into a deeper sleep state. If the heuristic was
right, the timer is simply canceled.

Please consider the patch a draft for discussion. We need to address:

  * Avoid programming the fallback timer when the deepest sleep state is
    already chosen.
  * Determine good default values for the introduced configurables. This
    is difficult due to the large variety of system configurations affected
    by the menu governor. Nevertheless we believe this can be done such
     that many systems benefit without significant degradation in any case.
  * Document (or remove) the sysfs entries.

But first, I would like to invite comments if this is going in the right
direction, or if this should be addressed in a different way.

[1] https://tu-dresden.de/zih/forschung/ressourcen/dateien/projekte/haec/powernightmares.pdf

       
Signed-off-by: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Signed-off-by: Marcus Hähnel <mhaehnel@os.inf.tu-dresden.de>
---

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 61b64c2b2cb8..45bbeb362809 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -22,6 +22,7 @@
  #include <linux/sched/stat.h>
  #include <linux/math64.h>
  #include <linux/cpu.h>
+#include <linux/smp.h>
  
  /*
   * Please note when changing the tuning values:
@@ -130,6 +131,10 @@ struct menu_device {
  	unsigned int	correction_factor[BUCKETS];
  	unsigned int	intervals[INTERVALS];
  	int		interval_ptr;
+
+	struct hrtimer	fallback_timer;
+	int             have_timer;
+	unsigned int	disregard_past;
  };
  
  
@@ -190,6 +195,85 @@ static inline int performance_multiplier(unsigned long nr_iowaiters, unsigned lo
  
  static DEFINE_PER_CPU(struct menu_device, menu_devices);
  
+static unsigned int fallback_timer_disregard_past = 1;
+static unsigned int diff_threshold_bits = 8;
+static unsigned int fallback_timer_enabled;
+static unsigned int fallback_timer_interval_us = 10000;
+
+#define MENU_ATTR_RW(name, var, range_min, range_max, wfun) \
+	static ssize_t show_##name(struct device *dev, \
+				   struct device_attribute *attr, char *buf) \
+	{ \
+		return snprintf(buf, 12, "%i\n", var); \
+	} \
+	static ssize_t store_##name(struct device *dev, \
+				    struct device_attribute *attr, \
+				    const char *buf, size_t count) \
+	{ \
+		unsigned int tmp; \
+		int ret = kstrtouint(buf, 10, &tmp); \
+		if (ret != 1) \
+			return -EINVAL; \
+		if (tmp > range_max || tmp < range_min) { \
+			pr_warn("value outside of valid range [%u, %u]\n", \
+				range_min, range_max); \
+			return -EINVAL; \
+		} \
+		var = tmp; \
+		wfun \
+		return count; \
+	} \
+	static DEVICE_ATTR(fallback_timer_##name, 0644, \
+			   show_##name, store_##name)
+
+MENU_ATTR_RW(threshold_bits, diff_threshold_bits, 0, 31, {});
+
+MENU_ATTR_RW(enable, fallback_timer_enabled, 0, 1, {
+	int i;
+
+	for_each_possible_cpu(i) {
+		struct menu_device *data = per_cpu_ptr(&menu_devices, i);
+
+		if (!fallback_timer_enabled) {
+			data->have_timer = 0;
+			hrtimer_cancel(&(data->fallback_timer));
+		}
+	} });
+
+MENU_ATTR_RW(interval_us, fallback_timer_interval_us, 1, 1000000, {});
+
+MENU_ATTR_RW(disregard_past, fallback_timer_disregard_past, 0, 1, {
+	int i;
+
+	for_each_possible_cpu(i) {
+		struct menu_device *data = per_cpu_ptr(&menu_devices, i);
+
+		data->disregard_past = 0;
+	} });
+
+static struct attribute *menu_attrs[] = {
+	&dev_attr_fallback_timer_threshold_bits.attr,
+	&dev_attr_fallback_timer_enable.attr,
+	&dev_attr_fallback_timer_interval_us.attr,
+	&dev_attr_fallback_timer_disregard_past.attr,
+	NULL
+};
+
+static struct attribute_group menu_attr_group = {
+	.attrs = menu_attrs,
+	.name = "cpuidle_menu",
+};
+
+int menu_add_interface(struct device *dev)
+{
+	return sysfs_create_group(&dev->kobj, &menu_attr_group);
+}
+
+void menu_remove_interface(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &menu_attr_group);
+}
+
  static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
  
  /*
@@ -275,6 +359,14 @@ static unsigned int get_typical_interval(struct menu_device *data)
  	goto again;
  }
  
+static enum hrtimer_restart fallback_timer_fun(struct hrtimer *tmr)
+{
+	struct menu_device *mdata = this_cpu_ptr(&menu_devices);
+
+	mdata->disregard_past = 1;
+	return HRTIMER_NORESTART;
+}
+
  /**
   * menu_select - selects the next idle state to enter
   * @drv: cpuidle driver containing state data
@@ -293,6 +385,11 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
  	unsigned long nr_iowaiters, cpu_load;
  	int resume_latency = dev_pm_qos_raw_read_value(device);
  
+	if (fallback_timer_enabled && data->have_timer) {
+		data->have_timer = 0;
+		hrtimer_cancel(&(data->fallback_timer));
+	}
+
  	if (data->needs_update) {
  		menu_update(drv, dev);
  		data->needs_update = 0;
@@ -322,7 +419,32 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
  					 RESOLUTION * DECAY);
  
  	expected_interval = get_typical_interval(data);
-	expected_interval = min(expected_interval, data->next_timer_us);
+
+	if (fallback_timer_enabled && fallback_timer_disregard_past
+	    && data->disregard_past)  {
+		expected_interval = data->next_timer_us;
+		// Only disregard the past once! Then try again
+		data->disregard_past = 0;
+	} else {
+		if (fallback_timer_enabled
+		    && expected_interval < (data->next_timer_us >> diff_threshold_bits)
+		    && data->next_timer_us > fallback_timer_interval_us * 2) {
+			/*
+			 * Program the fallback timer if the gap between the
+			 * expected interval by heuristic and the next regular
+			 * timer are too far apart.
+			 * However, only do this when we didn't just wakup from
+			 * a timer and are told to disregard the heuristic
+			 */
+			ktime_t interval =
+				ktime_set(0, fallback_timer_interval_us * 1000);
+
+			hrtimer_start(&(data->fallback_timer), interval,
+				      HRTIMER_MODE_REL_PINNED);
+			data->have_timer = 1;
+		}
+		expected_interval = min(expected_interval, data->next_timer_us);
+	}
  
  	if (CPUIDLE_DRIVER_STATE_START > 0) {
  		struct cpuidle_state *s = &drv->states[CPUIDLE_DRIVER_STATE_START];
@@ -398,6 +520,11 @@ static void menu_reflect(struct cpuidle_device *dev, int index)
  {
  	struct menu_device *data = this_cpu_ptr(&menu_devices);
  
+	if (fallback_timer_enabled && data->have_timer) {
+		data->have_timer = 0;
+		hrtimer_cancel(&data->fallback_timer);
+	}
+
  	data->last_state_idx = index;
  	data->needs_update = 1;
  }
@@ -486,6 +613,10 @@ static int menu_enable_device(struct cpuidle_driver *drv,
  
  	memset(data, 0, sizeof(struct menu_device));
  
+	hrtimer_init(&(data->fallback_timer),
+		     CLOCK_REALTIME, HRTIMER_MODE_REL_PINNED);
+	data->fallback_timer.function = fallback_timer_fun;
+
  	/*
  	 * if the correction factor is 0 (eg first time init or cpu hotplug
  	 * etc), we actually want to start out with a unity factor.
@@ -509,6 +640,10 @@ static struct cpuidle_governor menu_governor = {
   */
  static int __init init_menu(void)
  {
+	int ret = menu_add_interface(cpu_subsys.dev_root);
+
+	if (ret)
+		return ret;
  	return cpuidle_register_governor(&menu_governor);
  }
  
