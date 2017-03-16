From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/17] thermal: cpu_cooling: Avoid accessing potentially freed structures
Date: Thu, 16 Mar 2017 10:59:36 +0530
Message-ID: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36811 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbdCPF36 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2017 01:29:58 -0400
Received: by mail-pf0-f172.google.com with SMTP id o126so18987911pfb.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2017 22:29:57 -0700 (PDT)
In-Reply-To: <cover.1489639999.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "4 . 2+" <stable@vger.kernel.org>

After the lock is dropped, it is possible that the cpufreq_dev gets
freed before we call get_level() and that can cause kernel to crash.

Drop the lock after we are done using the structure.

Cc: 4.2+ <stable@vger.kernel.org>
Fixes: 02373d7c69b4 ("thermal: cpu_cooling: fix lockdep problems in cpu_cooling")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index c2525b585487..6fd258d62e47 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -155,8 +155,10 @@ unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
 	mutex_lock(&cooling_list_lock);
 	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
 		if (cpumask_test_cpu(cpu, &cpufreq_dev->allowed_cpus)) {
+			unsigned long level = get_level(cpufreq_dev, freq);
+
 			mutex_unlock(&cooling_list_lock);
-			return get_level(cpufreq_dev, freq);
+			return level;
 		}
 	}
 	mutex_unlock(&cooling_list_lock);
-- 
2.7.1.410.g6faf27b
