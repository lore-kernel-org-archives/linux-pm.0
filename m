From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: schedutil: Examine the correct CPU when we
 update util
Date: Fri, 3 Nov 2017 21:15:59 +0530
Message-ID: <20171103154559.GJ4240@vireshk-i7>
References: <20171103034022.GD4240@vireshk-i7>
 <20171103133642.8636-1-chris.redpath@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:47390 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbdKCPqC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Nov 2017 11:46:02 -0400
Received: by mail-pf0-f196.google.com with SMTP id z11so2475302pfk.4
        for <linux-pm@vger.kernel.org>; Fri, 03 Nov 2017 08:46:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171103133642.8636-1-chris.redpath@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Redpath <chris.redpath@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On 03-11-17, 13:36, Chris Redpath wrote:
> After
> 674e75411fc2 ("sched: cpufreq: Allow remote cpufreq callbacks")
> 
> We stopped always reading utilization for the cpu we are running
> the governor on, and instead read it for the cpu which we've been
> told has updated utilization. This is stored in sugov_cpu->cpu.
> 
> The value is set in sugov_register but we clear it in sugov_start
> which leads to always looking at the utilization of CPU0 instead
> of the correct one.
> 
> Let's fix this by consolidating the initialization code into
> sugov_start().
> 
> Fixes: 674e75411fc2 ("sched: cpufreq: Allow remote cpufreq callbacks")
> Signed-off-by: Chris Redpath <chris.redpath@arm.com>
> Reviewed-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Reviewed-by: Brendan Jackman <brendan.jackman@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
