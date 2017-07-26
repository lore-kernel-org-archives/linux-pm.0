From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 3/9] cpufreq: Cap the default transition delay value
 to 10 ms
Date: Wed, 26 Jul 2017 11:36:34 +0530
Message-ID: <20170726060634.GY352@vireshk-i7>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
 <1b93c94cb8b4914314e4f50304c3cb11c53d8b14.1500373914.git.viresh.kumar@linaro.org>
 <1500983686.30745.28.camel@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36109 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdGZGGj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 02:06:39 -0400
Received: by mail-pg0-f46.google.com with SMTP id 125so79874562pgi.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Jul 2017 23:06:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1500983686.30745.28.camel@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 25-07-17, 14:54, Leonard Crestez wrote:

Thanks for reporting Leonard, really appreciate it.

> This patch made it's way into linux-next and it seems to cause imx socs
> to almost always hang around their max frequency with the ondemand
> governor, even when almost completely idle. The lowest frequency is
> never reached. This seems wrong?

Sure thing. Though I tried to reproduce it on Hikey today and it all
worked pretty fine with ondemand governor. The latency is around 500
us here. I don't have a clue right now on what's wrong in your setup.

> This driver calculates transition_latency at probe time, the value is
> not terribly accurate but it reaches values like latency = 109 us, so

So this is the value that is stored in the global variable
"transition_latency" in the imx6q-cpufreq.c file? i.e.
transition_latency = 109000 (ns) to be exact ?

> this patch clamps it at about 10% of the value.

Without this patch the sampling rate of ondemand governor will be 109
ms. And after this patch it would be capped at 10 ms. Why would that
screw up anyone's setup ? I don't have an answer to that right now.

> It's worth noting that the default IMX config has HZ=100 and
> NO_HZ_IDLE=y, so maybe doing idle checks at a rate comparable to the
> jiffie tick screws stuff up?

Maybe, but I am not sure at all.

Can you try few things ?

- Don't use this patch and try to change ondemand's sampling rate from
  sysfs. Try setting it to 10000 and see if the behavior is identical
  to after this patch.

- Find how much time does it really take to change the frequency of
  the CPU. I don't really thing 109 us is the right transition
  latency. Use attached patch for that and look for the print message.

-- 
viresh

--EVF5PPMfhYS0aIcm
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-cpufreq-Find-transition-latency-dynamically.patch"

>From 95d830ad8765d6c35fb9e91d5028bf3cf1ff2451 Mon Sep 17 00:00:00 2001
Message-Id: <95d830ad8765d6c35fb9e91d5028bf3cf1ff2451.1501049147.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 2 Jun 2017 15:00:58 +0530
Subject: [PATCH] cpufreq: Find transition latency dynamically

Test patch to find latency dynamically.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0d6fbb3099b4..e62d670dffd2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1076,6 +1076,62 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
 	return NULL;
 }
 
+static int find_dvfs_latency(struct cpufreq_policy *policy, unsigned long freq,
+			     unsigned int *latency_ns)
+{
+	u64 time;
+	int ret;
+
+	time = local_clock();
+	ret = __cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
+	*latency_ns = local_clock() - time;
+
+	return ret;
+}
+
+/*
+ * Find the transition latency dynamically by:
+ * - Switching to min freq first.
+ * - Then switching to max freq.
+ * - And finally switching back to the initial freq.
+ *
+ * The maximum duration of the above three freq changes should be good enough to
+ * find the maximum transition latency for a platform.
+ */
+static void cpufreq_find_target_latency(struct cpufreq_policy *policy)
+{
+	unsigned long initial_freq = policy->cur;
+	unsigned int latency_ns, latency_max_ns;
+	int ret;
+
+	if (!has_target())
+		return;
+
+	/* Go to min frequency first */
+	ret = find_dvfs_latency(policy, policy->cpuinfo.min_freq, &latency_ns);
+	if (ret)
+		return;
+
+	latency_max_ns = latency_ns;
+
+	/* Go to max frequency then.. */
+	ret = find_dvfs_latency(policy, policy->cpuinfo.max_freq, &latency_ns);
+	if (ret)
+		return;
+
+	latency_max_ns = max(latency_max_ns, latency_ns);
+
+	/* And finally switch back to where we started from */
+	ret = find_dvfs_latency(policy, initial_freq, &latency_ns);
+	if (ret)
+		return;
+
+	policy->cpuinfo.transition_latency = max(latency_max_ns, latency_ns);
+
+	pr_info("%s: Setting transition latency to %u ns for policy of CPU%d\n",
+		__func__, policy->cpuinfo.transition_latency, policy->cpu);
+}
+
 static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
 	struct cpufreq_governor *gov = NULL;
@@ -1345,6 +1401,8 @@ static int cpufreq_online(unsigned int cpu)
 	}
 
 	if (new_policy) {
+		cpufreq_find_target_latency(policy);
+
 		ret = cpufreq_add_dev_interface(policy);
 		if (ret)
 			goto out_exit_policy;
-- 
2.13.0.71.gd7076ec9c9cb


--EVF5PPMfhYS0aIcm--
