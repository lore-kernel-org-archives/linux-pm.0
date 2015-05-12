From: Axel Haslam <ahaslam@baylibre.com>
Subject: validate callback for menu governor
Date: Tue, 12 May 2015 18:30:38 +0200
Message-ID: <CAKXjFTN7HBGNMBuxh8E8FaACG3xgYuLKYHs6vbQq7WtvKLttrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34480 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbbELQaj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 12:30:39 -0400
Received: by obfe9 with SMTP id e9so9814506obf.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2015 09:30:38 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, =?UTF-8?Q?Bartosz_Go=C5=82aszewski?= <bgolaszewski@baylibre.com>, Benoit Cousson <bcousson@baylibre.com>

Hi,

Recently a question about cpuidle and cluster off states came
up in a separate discussion [1].

The question is if it would be useful to add a "validate" callback in the
cpuidle menu governor. Cpuidle drivers could use this callback to check if
entering a cluster off state by the "last man" would not violate the target
residency requirements.

i think the same problem is explained at the top of
./drivers/cpuidle/cpuidle-big_little.c,
so im sorry if this was addressed before.

To illustrate the scenario, on a system where cpu0 and cpu1 are in the same
cluster and where the target residency time for the cluster off state is 5ms,
imagine that:

cpu 1 enters the cluster off  state at time t0.
the predicted wakeup by the governor for this cpu is in 20ms

cpu 0 enters the cluster off  state at t0 + 19ms.
the predicted wakeup is in 30ms.

in this case the cluster off state will actually be entered 1ms before cpu1
is predicted to wake up, and the cluster off residency constraint would not
be met.

To avoid this, before entering the cluster off state, the last cpu could
"validate" that the predicted wakeup time of all the cpus in his cluster
*still* don't violate the cluster off state requirements.

maybe this is a corner case that does not justify the added logic, which ends
up being more expensive.

a  simple prototype looks something like this:

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b8a5fa1..bdd3211 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/cpu.h>

 /*
  * Please note when changing the tuning values:
@@ -124,6 +125,7 @@ struct menu_device {

     unsigned int    next_timer_us;
     unsigned int    predicted_us;
+    unsigned int    predicted_time_us;
     unsigned int    bucket;
     unsigned int    correction_factor[BUCKETS];
     unsigned int    intervals[INTERVALS];
@@ -276,6 +278,45 @@ again:
     goto again;
 }

+/* Check if the idle state is still valid for a given cpu */
+static bool menu_validate(struct cpuidle_driver *drv,
+        struct cpuidle_device *dev,
+        int cpu,
+        int state)
+{
+    unsigned int now_us;
+    int last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
+    struct menu_device *data;
+    unsigned int remaining_us;
+    int i;
+
+    now_us = ktime_to_us(ktime_get_raw());
+    data = per_cpu_ptr(&menu_devices, cpu);
+    remaining_us = data->predicted_time_us - now_us;
+
+    /* Get the new recomended state for this cpu */
+    for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
+        struct cpuidle_state *s = &drv->states[i];
+        struct cpuidle_state_usage *su = &dev->states_usage[i];
+
+        if (s->disabled || su->disable)
+            continue;
+
+        if (s->target_residency > remaining_us)
+            continue;
+
+        last_state_idx = i;
+
+        /* state (or deeper) is still allowed */
+        if (last_state_idx >= state)
+            return true;
+    }
+
+    /* the cpu doest not allow for the requested state */
+    return false;
+
+}
+
 /**
  * menu_select - selects the next idle state to enter
  * @drv: cpuidle driver containing state data
@@ -352,6 +393,8 @@ static int menu_select(struct cpuidle_driver *drv,
struct cpuidle_device *dev)

         data->last_state_idx = i;
     }
+    data->predicted_time_us = ktime_to_us(ktime_get_raw())
+        + data->predicted_us;

     return data->last_state_idx;
 }
@@ -470,6 +513,7 @@ static struct cpuidle_governor menu_governor = {
     .enable =    menu_enable_device,
     .select =    menu_select,
     .reflect =    menu_reflect,
+    .validate =    menu_validate,
     .owner =    THIS_MODULE,
 };

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 9c5e892..e917fa9 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -226,6 +226,11 @@ struct cpuidle_governor {
                     struct cpuidle_device *dev);
     void (*reflect)        (struct cpuidle_device *dev, int index);

+    bool (*validate)    (struct cpuidle_driver *drv,
+                    struct cpuidle_device *dev,
+                    int cpu,
+                    int state);
+
     struct module         *owner;
 };

Regards
Axel

[1] http://marc.info/?l=linux-pm&m=143143190116868&w=2
