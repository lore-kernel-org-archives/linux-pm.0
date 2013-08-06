From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 03/10] cpufreq: Give consistent names for struct
 cpufreq_policy *
Date: Tue, 6 Aug 2013 19:08:24 +0530
Message-ID: <CAKohpon5mUOTt+4Mh5V4+abq0dJQH0MQyc2dAR4kKMjbuytRvw@mail.gmail.com>
References: <cover.1375530162.git.viresh.kumar@linaro.org>
	<fce918e3511ffbe508dd95d77e943b9e30b711ee.1375530162.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42940 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab3HFNiZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2013 09:38:25 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so840195obb.33
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2013 06:38:24 -0700 (PDT)
In-Reply-To: <fce918e3511ffbe508dd95d77e943b9e30b711ee.1375530162.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, l.majewski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

On 3 August 2013 17:19, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> They are named as policy, cur_policy, new_policy, data, etc.. Just name them
> poicy wherever possible.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c          | 200 ++++++++++++++++++-------------------
>  drivers/cpufreq/cpufreq_governor.h |   2 +-
>  drivers/cpufreq/cpufreq_ondemand.c |  10 +-
>  drivers/cpufreq/cpufreq_stats.c    |  14 +--
>  include/linux/cpufreq.h            |   2 +-
>  5 files changed, 111 insertions(+), 117 deletions(-)

Another Fixup :)

@Rafael: Apart from that I found things to be pretty stable now and
so I can go ahead with the V2 of this patchset.. And then maybe we
can get in linux-next so it receives some testing before 3.12.

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 1e630d0..7461a88 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -194,7 +194,7 @@ static int cpufreq_stats_create_table(struct
cpufreq_policy *policy,
 {
        unsigned int i, j, count = 0, ret = 0;
        struct cpufreq_stats *stat;
-       struct cpufreq_policy *data;
+       struct cpufreq_policy *current_policy;
        unsigned int alloc_size;
        unsigned int cpu = policy->cpu;
        if (per_cpu(cpufreq_stats_table, cpu))
@@ -203,13 +203,13 @@ static int cpufreq_stats_create_table(struct
cpufreq_policy *policy,
        if ((stat) == NULL)
                return -ENOMEM;

-       data = cpufreq_cpu_get(cpu);
-       if (data == NULL) {
+       current_policy = cpufreq_cpu_get(cpu);
+       if (current_policy == NULL) {
                ret = -EINVAL;
                goto error_get_fail;
        }

-       ret = sysfs_create_group(&data->kobj, &stats_attr_group);
+       ret = sysfs_create_group(&current_policy->kobj, &stats_attr_group);
        if (ret)
                goto error_out;

@@ -252,10 +252,10 @@ static int cpufreq_stats_create_table(struct
cpufreq_policy *policy,
        stat->last_time = get_jiffies_64();
        stat->last_index = freq_table_get_index(stat, policy->cur);
        spin_unlock(&cpufreq_stats_lock);
-       cpufreq_cpu_put(data);
+       cpufreq_cpu_put(current_policy);
        return 0;
 error_out:
-       cpufreq_cpu_put(data);
+       cpufreq_cpu_put(current_policy);
 error_get_fail:
        kfree(stat);
        per_cpu(cpufreq_stats_table, cpu) = NULL;
