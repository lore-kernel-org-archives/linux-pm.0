From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/9] CPUFreq: governors: further cleanups
Date: Thu, 3 Sep 2015 10:14:54 +0530
Message-ID: <20150903044454.GH13140@linux>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33414 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617AbbICEpC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 00:45:02 -0400
Received: by pacex6 with SMTP id ex6so28761856pac.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2015 21:45:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com

On 27-07-15, 17:58, Viresh Kumar wrote:
> Hi Rafael,
> 
> This series fixes few more possible race conditions. Over that there is
> some non-trivial cleanup, in order to simplify code.
> 
> Preeti did review some of them before she left and shared concerns on
> others, all that is sorted out now.
> 
> V1->V2:
> - Dropped 2/10 from V1 as it wasn't required
> - 3/10 saw some changes due to above patch being dropped
> - 7/10 changed a bit as we check for pending work items by looking at
>   shared->policy, rather than calling delayed_work_pending. We wanted to
>   check if governor is operational or not and the new check is enough
>   for that.
> 
> Viresh Kumar (9):
>   cpufreq: Use __func__ to print function's name
>   cpufreq: conservative: remove 'enable' field
>   cpufreq: ondemand: only queue canceled works from
>     update_sampling_rate()
>   cpufreq: governor: Drop __gov_queue_work()
>   cpufreq: ondemand: Drop unnecessary locks from update_sampling_rate()
>   cpufreq: ondemand: queue work for policy->cpus together
>   cpufreq: ondemand: update sampling rate immidiately
>   cpufreq: governor: Quit work-handlers early if governor is stopped
>   cpufreq: Get rid of ->governor_enabled and its lock

I thought you had some review comment for this series?

-- 
viresh
