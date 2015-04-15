From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] sched: fair: Fix wrong idle timestamp usage
Date: Wed, 15 Apr 2015 18:02:00 +0200
Message-ID: <20150415160200.GU23123@twins.programming.kicks-ass.net>
References: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org>
 <1429092024-20498-3-git-send-email-daniel.lezcano@linaro.org>
 <20150415121831.GU5029@twins.programming.kicks-ass.net>
 <552E8715.4060601@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:36492 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203AbbDOQI7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2015 12:08:59 -0400
Content-Disposition: inline
In-Reply-To: <552E8715.4060601@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.pitre@linaro.org, Ingo Molnar <mingo@redhat.com>

On Wed, Apr 15, 2015 at 05:43:17PM +0200, Daniel Lezcano wrote:
> On 04/15/2015 02:18 PM, Peter Zijlstra wrote:
> >On Wed, Apr 15, 2015 at 12:00:24PM +0200, Daniel Lezcano wrote:
> >>The find_idlest_cpu is assuming the rq->idle_stamp information reflects when
> >>the cpu entered the idle state. This is wrong as the cpu may exit and enter
> >>the idle state several times without the rq->idle_stamp being updated.
> >
> >Sure, but you forgot to tell us why it matters.
> 
> Yes, right. Thanks for pointing this out.
> 
> Assuming we are in the situation where there are several idle cpus in the
> same idle state.
> 
> With the current code, the function find_idlest_cpu will choose a cpu with
> the shortest idle duration. This information is based on the rq->idle_stamp
> variable and is correct until one of the idle cpu is exiting the
> cpuidle_enter function and re-entering it again. As soon as this happen, the
> rq->idle_stamp value is no longer a reliable information.
> 
> Example:
> 
>  * CPU0 and CPU1 are running
>  * CPU2 and CPU3 are in the C3 state.
>  * CPU2 entered idle at T2
>  * CPU3 entered idle at T3
>  * T2 < T3
> 
> The function find_idlest_cpu will choose CPU3 because it has a shorter idle
> duration.
> 
> Then CPU3 is woken up by an interrupt, process it and re-enter idle C3.
> 
> The information will still give the out to date information T2 < T3 and
> find_idlest_cpu will choose CPU2 instead of CPU3.
> 
> Even if that shouldn't have a big impact on the performance and energy side,
> we are dealing with a wrong information preventing us to improve the energy
> side later (eg. prevent to wakeup a cpu which did not reach its target
> residency yet).

Right, I figured as much; but no tangible results or behavioural fail
observed.

> >Urgh, you made horrid code more horrible.
> >
> >And all without reason.
> 
> Ok. What is horrible ? The 'if then else' blocks or the algorithm itself ?

Yeah the amount and depth of branches. I briefly tried to see if it
could be fixed but came up empty. Maybe I should try harder :-)
