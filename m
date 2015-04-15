From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH 3/3] sched: fair: Fix wrong idle timestamp usage
Date: Wed, 15 Apr 2015 18:10:57 +0100
Message-ID: <20150415171057.GA4300@e105550-lin.cambridge.arm.com>
References: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org>
 <1429092024-20498-3-git-send-email-daniel.lezcano@linaro.org>
 <20150415121831.GU5029@twins.programming.kicks-ass.net>
 <552E8715.4060601@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36507 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755521AbbDORKC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Apr 2015 13:10:02 -0400
Content-Disposition: inline
In-Reply-To: <552E8715.4060601@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, Ingo Molnar <mingo@redhat.com>

On Wed, Apr 15, 2015 at 04:43:17PM +0100, Daniel Lezcano wrote:
> On 04/15/2015 02:18 PM, Peter Zijlstra wrote:
> > On Wed, Apr 15, 2015 at 12:00:24PM +0200, Daniel Lezcano wrote:
> >> The find_idlest_cpu is assuming the rq->idle_stamp information reflects when
> >> the cpu entered the idle state. This is wrong as the cpu may exit and enter
> >> the idle state several times without the rq->idle_stamp being updated.
> >
> > Sure, but you forgot to tell us why it matters.
> 
> Yes, right. Thanks for pointing this out.
> 
> Assuming we are in the situation where there are several idle cpus in 
> the same idle state.
> 
> With the current code, the function find_idlest_cpu will choose a cpu 
> with the shortest idle duration. This information is based on the 
> rq->idle_stamp variable and is correct until one of the idle cpu is 
> exiting the cpuidle_enter function and re-entering it again. As soon as 
> this happen, the rq->idle_stamp value is no longer a reliable information.
> 
> Example:
> 
>   * CPU0 and CPU1 are running
>   * CPU2 and CPU3 are in the C3 state.
>   * CPU2 entered idle at T2
>   * CPU3 entered idle at T3
>   * T2 < T3
> 
> The function find_idlest_cpu will choose CPU3 because it has a shorter 
> idle duration.
> 
> Then CPU3 is woken up by an interrupt, process it and re-enter idle C3.
> 
> The information will still give the out to date information T2 < T3 and 
> find_idlest_cpu will choose CPU2 instead of CPU3.

I can't get the example to match your description of how
find_idlest_cpu() is supposed to work :-(

Did you mean CPU2 (not CPU3) getting woken up by an interrupt and
find_busiest_cpu() choosing CPU3 instead of CPU2 after the interrupt?

In your example find_busiest_cpu() should return CPU3 before the
interrupt as it went to sleep last and the interrupt on CPU3 should not
affect that choice as CPU3 is still the last cpu to go to sleep
(regardless of your patch). No?

Morten
