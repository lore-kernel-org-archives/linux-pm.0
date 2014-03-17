From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle: sysfs: Export target residency information
Date: Mon, 17 Mar 2014 12:17:30 +0100
Message-ID: <1395055050-27729-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:61872 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932658AbaCQLRZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Mar 2014 07:17:25 -0400
Received: by mail-wi0-f177.google.com with SMTP id cc10so1968149wib.4
        for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2014 04:17:24 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

>From userspace, there is no way to know the target residency for each idle
state. If we want to write tools to measure the accuracy of the idle state
selection from the governor, we need this info.

As the exit latency is exported through sysfs, exporting the target residency
in the same place makes sense.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/sysfs.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index e918b6d..efe2f17 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -293,6 +293,7 @@ static ssize_t show_state_##_name(struct cpuidle_state *state, \
 }
 
 define_show_state_function(exit_latency)
+define_show_state_function(target_residency)
 define_show_state_function(power_usage)
 define_show_state_ull_function(usage)
 define_show_state_ull_function(time)
@@ -304,6 +305,7 @@ define_store_state_ull_function(disable)
 define_one_state_ro(name, show_state_name);
 define_one_state_ro(desc, show_state_desc);
 define_one_state_ro(latency, show_state_exit_latency);
+define_one_state_ro(residency, show_state_target_residency);
 define_one_state_ro(power, show_state_power_usage);
 define_one_state_ro(usage, show_state_usage);
 define_one_state_ro(time, show_state_time);
@@ -313,6 +315,7 @@ static struct attribute *cpuidle_state_default_attrs[] = {
 	&attr_name.attr,
 	&attr_desc.attr,
 	&attr_latency.attr,
+	&attr_residency.attr,
 	&attr_power.attr,
 	&attr_usage.attr,
 	&attr_time.attr,
-- 
1.7.9.5

