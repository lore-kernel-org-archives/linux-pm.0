From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: create sysfs symlink for cpus onlined after boot
Date: Mon, 10 Apr 2017 15:41:12 +0530
Message-ID: <20170410101112.GJ24555@vireshk-i7>
References: <1490304286-18311-1-git-send-email-pprakash@codeaurora.org>
 <2246294.s9H9y0mptv@aspire.rjw.lan>
 <276b4adc-3525-d736-795e-09ccb2be1c7c@codeaurora.org>
 <7178193.VD2MsPrHSl@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35735 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752475AbdDJKLQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 06:11:16 -0400
Received: by mail-pg0-f52.google.com with SMTP id 81so103546610pgh.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2017 03:11:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7178193.VD2MsPrHSl@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Prakash, Prashanth" <pprakash@codeaurora.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On 27-03-17, 19:29, Rafael J. Wysocki wrote:
> OK, queued up, thanks!
> 
> I'll push it for merging by the end of the week unless someone (Viresh in
> particular) finds any problems with it.

Sorry for being late to the party. I don't see any cases where this
would break, but maybe we can simplify things by always creating links
while onlining a CPU.

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index bc96d423781a..f700e06d4bad 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -922,9 +922,6 @@ static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu)
 {
        struct device *dev = get_cpu_device(cpu);
 
-       if (!dev)
-               return;
-
        if (cpumask_test_and_set_cpu(cpu, policy->real_cpus))
                return;
 
@@ -1013,6 +1010,8 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 {
        int ret = 0;
 
+       add_cpu_dev_symlink(policy, cpu);
+
        /* Has this CPU been taken care of already? */
        if (cpumask_test_cpu(cpu, policy->cpus))
                return 0;
@@ -1188,10 +1187,8 @@ static int cpufreq_online(unsigned int cpu)
                policy->user_policy.min = policy->min;
                policy->user_policy.max = policy->max;
 
-               for_each_cpu(j, policy->related_cpus) {
+               for_each_cpu(j, policy->related_cpus)
                        per_cpu(cpufreq_cpu_data, j) = policy;
-                       add_cpu_dev_symlink(policy, j);
-               }
        } else {
                policy->min = policy->user_policy.min;
                policy->max = policy->user_policy.max;
@@ -1266,6 +1263,7 @@ static int cpufreq_online(unsigned int cpu)
                goto out_exit_policy;
        }
 
+       add_cpu_dev_symlink(policy, cpu);
        up_write(&policy->rwsem);
 
        kobject_uevent(&policy->kobj, KOBJ_ADD);
@@ -1311,11 +1309,6 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
                        return ret;
        }
 
-       /* Create sysfs link on CPU registration */
-       policy = per_cpu(cpufreq_cpu_data, cpu);
-       if (policy)
-               add_cpu_dev_symlink(policy, cpu);
-
        return 0;
 }
 
-- 
viresh
