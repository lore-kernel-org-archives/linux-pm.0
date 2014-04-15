From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCHC 2/3] idle: store the idle state the cpu is
Date: Tue, 15 Apr 2014 14:43:30 +0200
Message-ID: <20140415124330.GK11182@twins.programming.kicks-ass.net>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org>
 <1396009796-31598-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:54775 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbaDOMnp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Apr 2014 08:43:45 -0400
Content-Disposition: inline
In-Reply-To: <1396009796-31598-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, rjw@rjwysocki.net, nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com

On Fri, Mar 28, 2014 at 01:29:55PM +0100, Daniel Lezcano wrote:
> @@ -143,6 +145,10 @@ static int cpuidle_idle_call(void)
>  			if (!ret) {
>  				trace_cpu_idle_rcuidle(next_state, dev->cpu);
>  
> +				*power = &drv->states[next_state].power;
> +
> +				wmb();
> +

I very much suspect you meant: smp_wmb(), as I don't see the hardware
reading that pointer, therefore UP wouldn't care. Also, any and all
barriers should come with a comment that describes the data ordering and
points to the matchin barriers.
