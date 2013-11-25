From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] cpufreq: Make sure CPU is running on a freq from freq-table
Date: Mon, 25 Nov 2013 09:53:59 +0530
Message-ID: <046513da96dfec919a1a41d270c167147d4a9c8d.1385353358.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f47.google.com ([209.85.128.47]:65466 "EHLO
	mail-qe0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab3KYEYG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2013 23:24:06 -0500
Received: by mail-qe0-f47.google.com with SMTP id t7so3273331qeb.6
        for <linux-pm@vger.kernel.org>; Sun, 24 Nov 2013 20:24:05 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nm@ti.com, ceh@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

Sometimes boot loaders set CPU frequency to a value outside of frequency table
present with cpufreq core. In such cases CPU might be unstable if it has to run
on that frequency for long duration of time and so its better to set it to a
frequency which is specified in freq-table. This also makes cpufreq stats
inconsistent as cpufreq-stats would fail to register because current frequency
of CPU isn't found in freq-table.

Because we don't want this change to effect boot process badly, we go for the
next freq which is >= policy->cur ('cur' must be set by now, otherwise we will
end up setting freq to lowest of the table as 'cur' is initialized to zero).

In case where CPU is already running on one of the frequencies present in
freq-table, this would turn into a dummy call as __cpufreq_driver_target() would
return early.

Reported-by: Carlos Hernandez <ceh@ti.com>
Reported-and-tested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2
- Set to (policy->cur - 1) instead of policy->cur.
- return early in case __cpufreq_driver_target() fails.

 drivers/cpufreq/cpufreq.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 02d534d..7be996c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1038,6 +1038,38 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 		}
 	}
 
+	/*
+	 * Sometimes boot loaders set CPU frequency to a value outside of
+	 * frequency table present with cpufreq core. In such cases CPU might be
+	 * unstable if it has to run on that frequency for long duration of time
+	 * and so its better to set it to a frequency which is specified in
+	 * freq-table. This also makes cpufreq stats inconsistent as
+	 * cpufreq-stats would fail to register because current frequency of CPU
+	 * isn't found in freq-table.
+	 *
+	 * Because we don't want this change to effect boot process badly, we go
+	 * for the next freq which is >= policy->cur ('cur' must be set by now,
+	 * otherwise we will end up setting freq to lowest of the table as 'cur'
+	 * is initialized to zero).
+	 *
+	 * In case where CPU is already running on one of the frequencies
+	 * present in freq-table, this would turn into a dummy call as
+	 * __cpufreq_driver_target() would return early.
+	 *
+	 * We are passing target-freq as "policy->cur - 1" otherwise
+	 * __cpufreq_driver_target() would simply fail, as policy->cur will be
+	 * equal to target-freq.
+	 */
+	if (has_target()) {
+		ret = __cpufreq_driver_target(policy, policy->cur - 1,
+				CPUFREQ_RELATION_L);
+		if (ret) {
+			pr_err("%s: Unable to set frequency from table: %d\n",
+					__func__, ret);
+			goto err_out_unregister;
+		}
+	}
+
 	/* related cpus should atleast have policy->cpus */
 	cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
 
-- 
1.7.12.rc2.18.g61b472e

