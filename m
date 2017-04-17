From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 01/17] thermal: cpu_cooling: Avoid accessing potentially freed structures
Date: Mon, 17 Apr 2017 11:31:46 +0530
Message-ID: <b75219c6511ff0cf9a4c9c7603091286b803ae22.1492408342.git.viresh.kumar@linaro.org>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33408 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932810AbdDQGCo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 02:02:44 -0400
Received: by mail-pf0-f176.google.com with SMTP id s16so61535562pfs.0
        for <linux-pm@vger.kernel.org>; Sun, 16 Apr 2017 23:02:44 -0700 (PDT)
In-Reply-To: <cover.1492408342.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492408342.git.viresh.kumar@linaro.org>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "4 . 2+" <stable@vger.kernel.org>

After the lock is dropped, it is possible that the cpufreq_dev gets
freed before we call get_level() and that can cause kernel to crash.

Drop the lock after we are done using the structure.

Cc: 4.2+ <stable@vger.kernel.org> # 4.2+
Fixes: 02373d7c69b4 ("thermal: cpu_cooling: fix lockdep problems in cpu_cooling")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 69d0f430b2d1..be29489dd247 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -153,8 +153,10 @@ unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
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
2.12.0.432.g71c3a4f4ba37
