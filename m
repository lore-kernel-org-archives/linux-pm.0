From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle: add 'failed' statistic
Date: Fri,  7 Mar 2014 05:14:10 +0100
Message-ID: <1394165650-6927-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:38338 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaCGEOQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Mar 2014 23:14:16 -0500
Received: by mail-pd0-f170.google.com with SMTP id v10so3513556pde.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Mar 2014 20:14:16 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The actual statistics give some informations about the different idle states a
cpu entered but unfortunately it does not show if the state is resulting from
good selections or not. This simple patch adds the 'failed' statistic for each
state, so we can easily do a ratio between the 'usage' and the 'failed' to
deduce how efficient the state selections have been.

Is considered 'failed' when a state duration is lesser than the target
residency which means the state consumed more power than the expected power
saving.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c |    4 ++++
 drivers/cpuidle/sysfs.c   |    3 +++
 include/linux/cpuidle.h   |    1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 09d05ab..c2323e7 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -100,6 +100,10 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 		 */
 		dev->states_usage[entered_state].time += dev->last_residency;
 		dev->states_usage[entered_state].usage++;
+
+		/* We stayed less than the target residency */
+		if (diff < drv->states[entered_state].target_residency)
+			dev->states_usage[entered_state].failed++;
 	} else {
 		dev->last_residency = 0;
 	}
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index e918b6d..1c7eb90 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -296,6 +296,7 @@ define_show_state_function(exit_latency)
 define_show_state_function(power_usage)
 define_show_state_ull_function(usage)
 define_show_state_ull_function(time)
+define_show_state_ull_function(failed)
 define_show_state_str_function(name)
 define_show_state_str_function(desc)
 define_show_state_ull_function(disable)
@@ -307,6 +308,7 @@ define_one_state_ro(latency, show_state_exit_latency);
 define_one_state_ro(power, show_state_power_usage);
 define_one_state_ro(usage, show_state_usage);
 define_one_state_ro(time, show_state_time);
+define_one_state_ro(failed, show_state_failed);
 define_one_state_rw(disable, show_state_disable, store_state_disable);
 
 static struct attribute *cpuidle_state_default_attrs[] = {
@@ -316,6 +318,7 @@ static struct attribute *cpuidle_state_default_attrs[] = {
 	&attr_power.attr,
 	&attr_usage.attr,
 	&attr_time.attr,
+	&attr_failed.attr,
 	&attr_disable.attr,
 	NULL
 };
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 50fcbb0..bdad544 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -32,6 +32,7 @@ struct cpuidle_driver;
 struct cpuidle_state_usage {
 	unsigned long long	disable;
 	unsigned long long	usage;
+	unsigned long long	failed;
 	unsigned long long	time; /* in US */
 };
 
-- 
1.7.9.5

