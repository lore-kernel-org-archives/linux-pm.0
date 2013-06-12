From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: fix governor start/stop race condition
Date: Wed, 12 Jun 2013 14:02:51 +0530
Message-ID: <CAKohpok2AEe3bL=mPAoxbenEBaWU=WjkRckbvcnzjnUwFZgnuA@mail.gmail.com>
References: <1371021986-20985-1-git-send-email-chenxg@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:46313 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab3FLIcw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2013 04:32:52 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so12682187obq.7
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2013 01:32:51 -0700 (PDT)
In-Reply-To: <1371021986-20985-1-git-send-email-chenxg@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Xiaoguang Chen <chenxg@marvell.com>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, njiang1@marvell.com, zjwu@marvell.com, ylmao@marvell.com, chenxg.marvell@gmail.com

On 12 June 2013 12:56, Xiaoguang Chen <chenxg@marvell.com> wrote:
> cpufreq governor stop and start should be kept in sequence.
> If not, there will be unexpected behavior, for example:
>
> we have 4 cpus and policy->cpu=cpu0, cpu1/2/3 are linked to cpu0.
> the normal sequence is as below:
>
> 1) Current governor is userspace, one application tries to set
> governor to ondemand. it will call __cpufreq_set_policy in which it
> will stop userspace governor and then start ondemand governor.
>
> 2) Current governor is userspace, now cpu0 hotplugs in cpu3, it will
> call cpufreq_add_policy_cpu. on which it first stops userspace
> governor, and then starts userspace governor.
>
> Now if the sequence of above two cases interleaves, it becames
> below sequence:
>
> 1) application stops userspace governor
> 2)                                      hotplug stops userspace governor
> 3) application starts ondemand governor
> 4)                                      hotplug starts a governor
>
> in step 4, hotplug is supposed to start userspace governor, but now
> the governor has been changed by application to ondemand, so hotplug
> starts ondemand governor again !!!!
>
> The solution is: do not allow stop one policy's governor multi-times
> Governor stop should only do once for one policy, after it is stopped,
> no other governor stop should be executed.
>
> Signed-off-by: Xiaoguang Chen <chenxg@marvell.com>
> ---
>  drivers/cpufreq/cpufreq.c | 9 +++++++++
>  include/linux/cpufreq.h   | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 2d53f47..b4a2c94 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1562,6 +1562,11 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>
>         pr_debug("__cpufreq_governor for CPU %u, event %u\n",
>                                                 policy->cpu, event);
> +
> +       if ((!policy->governor_enabled && (event == CPUFREQ_GOV_STOP)) ||
> +           (policy->governor_enabled && (event == CPUFREQ_GOV_START)))
> +               return 0;

Few things:
- because __cpufreq_governor() isn't protected by locks, both calls for
stopping governor can reach to this point and race can still happen. So,
both may stop governor.
- Returning zero doesn't seems to be the right thing, as this may cause
STOP called by one user and START called by another. For example,
STOP happened due to governor change. STOP called for hotplug and
0 is returned. START called by hotplug as STOP was successful. :)

Maybe -EBUSY would make more sense here.
