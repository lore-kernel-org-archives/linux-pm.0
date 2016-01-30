From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [RFC PATCH 00/19] cpufreq locking cleanups and documentation
Date: Fri, 29 Jan 2016 16:57:02 -0800
Message-ID: <56AC0A5E.1010505@codeaurora.org>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37297 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472AbcA3A5F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jan 2016 19:57:05 -0500
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 01/11/2016 09:35 AM, Juri Lelli wrote:
> Hi all,
>
> In the context of the ongoing discussion about introducing a simple platform
> energy model to guide scheduling decisions (Energy Aware Scheduling [1])
> concerns have been expressed by Peter about the component in charge of driving
> clock frequency selection (Steve recently posted an update of such component
> [2]): https://lkml.org/lkml/2015/8/15/141.
>
> The problem is that, with this new approach, cpufreq core functions need to be
> accessed from scheduler hot-paths and the overhead associated with the current
> locking scheme might result to be unsustainable.
>
> Peter's proposed approach of using RCU logic to reduce locking overhead seems
> reasonable, but things may not be so straightforward as originally thought. The
> very first thing I actually realized when I started looking into this is that
> it was hard for me to understand which locking mechanism was protecting which
> data structure. As mostly a way to build a better understanding of the current
> cpufreq locking scheme and also as preparatory work for implementing RCU logic,
> I came up with this set of patches. In fact, at this stage, I would like each
> patch to be considered as a question I'm asking rather than a proposed change,
> thus the RFC tag for the series; with the intent of documenting current locking
> scheme and modifying it a bit in order to make RCU logic implementation easier.
> Actually, as you'll soon notice, I didn't really start from scratch. Mike
> shared with me some patches he has been developing while looking at the same
> problem. I've given Mike attribution for the patches that I took unchanged from
> him, with thanks for sharing his findings with me.
>
> High level description of patches:
>
>   o [01-04] cleanup and move code around to make things (hopefully) cleaner
>   o [05-14] insert lockdep assertions and fix uncovered erroneous situations
>   o [15-18] remove overkill usage of locking mechanism
>   o 19      adds documentation for the cleaned up locking scheme
>
> With Viresh' tests [3] on both arm TC2 and arm64 Juno boards I'm not seeing
> anything bad happening. However, coverage is really small (as is my personal
> confidence of not breaking things for other confs :-)).
>
> This set is based on top of linux-pm/linux-next as of today and it is also
> available from here:
>
>   git://linux-arm.org/linux-jl.git upstream/cpufreq_cleanups
>
> Comments, concerns and rants are the primary goal of this posting; I'm thus
> looking forward to them.
>
> Best,
>
> - Juri
>
> [1] https://lkml.org/lkml/2015/7/7/754
> [2] https://lkml.org/lkml/2015/12/9/35
> [3] https://git.linaro.org/people/viresh.kumar/cpufreq-tests.git
>
> Juri Lelli (16):
>    cpufreq: kill for_each_policy
>    cpufreq: bring data structures close to their locks
>    cpufreq: assert locking when accessing cpufreq_policy_list
>    cpufreq: always access cpufreq_policy_list while holding
>      cpufreq_driver_lock
>    cpufreq: assert locking when accessing cpufreq_governor_list
>    cpufreq: fix warning for cpufreq_init_policy unlocked access to
>      cpufreq_governor_list
>    cpufreq: fix warning for show_scaling_available_governors unlocked
>      access to cpufreq_governor_list
>    cpufreq: assert policy->rwsem is held in cpufreq_set_policy
>    cpufreq: assert policy->rwsem is held in __cpufreq_governor
>    cpufreq: fix locking of policy->rwsem in cpufreq_init_policy
>    cpufreq: fix locking of policy->rwsem in cpufreq_offline_prepare
>    cpufreq: fix locking of policy->rwsem in cpufreq_offline_finish
>    cpufreq: remove useless usage of cpufreq_governor_mutex in
>      __cpufreq_governor
>    cpufreq: hold policy->rwsem across CPUFREQ_GOV_POLICY_EXIT
>    cpufreq: stop checking for cpufreq_driver being present in
>      cpufreq_cpu_get
>    cpufreq: documentation: document locking scheme
>
> Michael Turquette (3):
>    cpufreq: do not expose cpufreq_governor_lock
>    cpufreq: merge governor lock and mutex
>    cpufreq: remove transition_lock
>
>   Documentation/cpu-freq/core.txt    |  44 +++++++++++++
>   drivers/cpufreq/cpufreq.c          | 132 +++++++++++++++++++++++--------------
>   drivers/cpufreq/cpufreq_governor.h |   2 -
>   include/linux/cpufreq.h            |   5 --
>   4 files changed, 125 insertions(+), 58 deletions(-)
>

Juri,

I haven't looked at the cpufreq-tests, but I doubt they do hotplug 
testing where they remove all the CPUs of a policy (to trigger a policy 
exit).

Can you please add that to your testing? I wouldn't be surprised if some 
of your clean ups would cause a dead lock. This clean up series is 
definitely appreciated, but I think the patch series might still be 
missing some patches that are needed to make things work without 
deadlocking.

I'll try to do a deeper analysis/review/testing, but kinda hard pressed 
on time here.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
