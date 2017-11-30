From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v2 0/8] Introduct cpu idle prediction functionality
Date: Thu, 30 Nov 2017 09:00:58 +0800
Message-ID: <0f4d78d4-09d7-5b68-8706-5427b39fa0ed@linux.intel.com>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:5172 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752682AbdK3BBA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Nov 2017 20:01:00 -0500
In-Reply-To: <1506756034-6340-1-git-send-email-aubrey.li@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de, peterz@infradead.org, rjw@rjwysocki.net, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

Thanks Rafael's comments against V2. I'd like to ping here to see which
direction this proposal should go and what fundamental change this proposal
should make.

I'm also open to any suggestions if my proposal is not on the right way.

Thanks,
-Aubrey

On 2017/9/30 15:20, Aubrey Li wrote:
> We found under some latency intensive workloads, short idle periods occurs
> very common, then idle entry and exit path starts to dominate, so it's
> important to optimize them. To determine the short idle pattern, we need
> to figure out how long of the coming idle and the threshold of the short
> idle interval.
> 
> A cpu idle prediction functionality is introduced in this proposal to catch
> the short idle pattern.
> 
> Firstly, we check the IRQ timings subsystem, if there is an event
> coming soon.
> -- https://lwn.net/Articles/691297/
> 
> Secondly, we check the idle statistics of scheduler, if it's likely we'll
> go into a short idle.
> -- https://patchwork.kernel.org/patch/2839221/
> 
> Thirdly, we predict the next idle interval by using the prediction
> fucntionality in the idle governor if it has.
> 
> For the threshold of the short idle interval, we record the timestamps of
> the idle entry, and multiply by a tunable parameter at here:
> -- /proc/sys/kernel/fast_idle_ratio
> 
> We use the output of the idle prediction to skip turning tick off if a
> short idle is determined in this proposal. Reprogramming hardware timer
> twice(off and on) is expensive for a very short idle. There are some
> potential optimizations can be done according to the same indicator.
> 
> I observed when system is idle, the idle predictor reports 20/s long idle
> and ZERO fast idle on one CPU. And when the workload is running, the idle
> predictor reports 72899/s fast idle and ZERO long idle on the same CPU.
> 
> Aubrey Li (8):
>   cpuidle: menu: extract prediction functionality
>   cpuidle: record the overhead of idle entry
>   cpuidle: add a new predict interface
>   tick/nohz: keep tick on for a fast idle
>   timers: keep sleep length updated as needed
>   cpuidle: make fast idle threshold tunable
>   cpuidle: introduce irq timing to make idle prediction
>   cpuidle: introduce run queue average idle to make idle prediction
> 
>  drivers/cpuidle/Kconfig          |   1 +
>  drivers/cpuidle/cpuidle.c        | 109 +++++++++++++++++++++++++++++++++++++++
>  drivers/cpuidle/governors/menu.c |  69 ++++++++++++++++---------
>  include/linux/cpuidle.h          |  21 ++++++++
>  kernel/sched/idle.c              |  14 ++++-
>  kernel/sysctl.c                  |  12 +++++
>  kernel/time/tick-sched.c         |   7 +++
>  7 files changed, 209 insertions(+), 24 deletions(-)
> 
