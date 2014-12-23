From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 12/13] cpufreq: stats: Fix locking
Date: Tue, 23 Dec 2014 05:47:30 -0500
Message-ID: <54994842.3000801@redhat.com>
References: <cover.1418902789.git.viresh.kumar@linaro.org> <6277a557b0102524ca317bf0aa94d7b479375d6e.1418902789.git.viresh.kumar@linaro.org> <CAKohpok+7b3t3-82EO+9tpmBHavMxBT1r2ORhPcQbT3hT=p9mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33372 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755333AbaLWKri (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Dec 2014 05:47:38 -0500
In-Reply-To: <CAKohpok+7b3t3-82EO+9tpmBHavMxBT1r2ORhPcQbT3hT=p9mA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



On 12/23/2014 01:06 AM, Viresh Kumar wrote:
> On 18 December 2014 at 17:30, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Locking wasn't handled properly at places and this patch is an attempt to fix
>> it. Specially while creating/removing stat tables.
> 
> Because we were required to allocated memory from within locks, we had to
> use mutex here. So, just consider a mutex instead of spinlock everywhere in
> this file.

There is a subtle locking issue here that I want to make sure you're aware of
(mostly because it has bitten me in the past a few times).

> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 7701532b32c8..e18735816908 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -149,10 +149,12 @@ static void __cpufreq_stats_free_table(struct cpufreq_policy *policy)
>  
>  	pr_debug("%s: Free stat table\n", __func__);
>  
> +	spin_lock(&cpufreq_stats_lock);
>  	sysfs_remove_group(&policy->kobj, &stats_attr_group);

^^^ this line is not guaranteed to have removed the group files by the time it
returns.  That is important in this code IMO, as we are adding and removing the
stats entries rapidly.  You may hit the dreaded "sysfs file already exists"
WARNING if this is done too fast, or if sysfs is locked for some other reason
and delays the removal of the group.  In the worst case, it is possible you hit
a NULL pointer due to stale data access (because you kfree and set to a NULL
pointer below).

I've never found a good method to block this sort of add/remove sysfs file race
from happening.  Perhaps someone else may have a suggestion.  In the past I've
thought about adding a usage count to the sysfs file handlers themselves but
that seems to lead to blocking on userspace access...

>  	kfree(stat->time_in_state);
>  	kfree(stat);
>  	policy->stats_data = NULL;
> +	spin_unlock(&cpufreq_stats_lock);
>  }

There may not be an easy way around this ...

P.

> 
