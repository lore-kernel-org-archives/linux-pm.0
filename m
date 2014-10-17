From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: Locking issues with cpufreq and sysfs
Date: Fri, 17 Oct 2014 08:15:30 -0400
Message-ID: <54410862.6020508@redhat.com>
References: <543BCF9A.1060603@redhat.com> <CAKohpo=KVJRdX1h=Pp2mo63QXh+5ygS9RQ=EUXaq8z+JBDFykQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=KVJRdX1h=Pp2mo63QXh+5ygS9RQ=EUXaq8z+JBDFykQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, =?UTF-8?B?Um9iZXJ0IFNjaMO2bmU=?= <robert.schoene@tu-dresden.de>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org



On 10/17/2014 07:38 AM, Viresh Kumar wrote:
> On 13 October 2014 18:41, Prarit Bhargava <prarit@redhat.com> wrote:
>> There are several issues with the current locking design of cpufreq.  Most
>> notably is the panic reported here:
>>
>> http://marc.info/?l=linux-kernel&m=140622451625236&w=2
>>
>> which was introduced by commit 955ef4833574636819cd269cfbae12f79cbde63a,
>> cpufreq: Drop rwsem lock around CPUFREQ_GOV_POLICY_EXIT, which introduces
> 
> Don't know whats going wrong but I am just not able to reproduce the
> lockdep again :(
> I have tried this on two boards and am making sure that all things are correctly
> configured. I am trying this on two of Exynos boards, One a dual-A15 and another
> big little with 8 cores..
> 
> 
> @@ -2195,9 +2195,7 @@ static int cpufreq_set_policy(struct
> cpufreq_policy *policy,
>         /* end old governor */
>         if (old_gov) {
>                 __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
> -               up_write(&policy->rwsem);
>                 __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
> -               down_write(&policy->rwsem);
>         }
> 
>         /* start new governor */
> @@ -2206,9 +2204,7 @@ static int cpufreq_set_policy(struct
> cpufreq_policy *policy,
>                 if (!__cpufreq_governor(policy, CPUFREQ_GOV_START))
>                         goto out;
> 
> -               up_write(&policy->rwsem);
>                 __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
> -               down_write(&policy->rwsem);
>         }
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c
> b/drivers/cpufreq/cpufreq_governor.c
> index 1b44496..1a6972a 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -323,6 +323,7 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
>                 return 0;
>         case CPUFREQ_GOV_POLICY_EXIT:
>                 if (!--dbs_data->usage_count) {
> +                       pr_info("%s\n", __func__);
>                         sysfs_remove_group(get_governor_parent_kobj(policy),
>                                         get_sysfs_attr(dbs_data));
> 
> 

Hmmm

This is what I'm doing:

echo ondemand > scaling_governor
cat ondemand/*
echo conservative > scaling_governor

OOC what are you doing to test?

P.

> 
> 
> .config attached too, please let me know what am I missing.
> 
