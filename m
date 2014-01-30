From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 3/3] idle: store the idle state index in the struct rq
Date: Thu, 30 Jan 2014 17:35:01 +0100
Message-ID: <20140130163501.GG5002@laptop.programming.kicks-ass.net>
References: <1391090962-15032-1-git-send-email-daniel.lezcano@linaro.org>
 <1391090962-15032-4-git-send-email-daniel.lezcano@linaro.org>
 <20140130153150.GD5002@laptop.programming.kicks-ass.net>
 <52EA7D8A.6080604@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52EA7D8A.6080604@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: nicolas.pitre@linaro.org, mingo@redhat.com, tglx@linutronix.de, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 30, 2014 at 05:27:54PM +0100, Daniel Lezcano wrote:
> struct cpuidle_state *state = &drv->states[rq->index];
> 
> And from the state, we have the following informations:
> 
> struct cpuidle_state {
> 
> 	[ ... ]
> 
>         unsigned int    exit_latency; /* in US */
>         int             power_usage; /* in mW */
>         unsigned int    target_residency; /* in US */
>         bool            disabled; /* disabled on all CPUs */
> 
> 	[ ... ]
> };

Right, but can we say that a higher index will save more power and have
a higher exit latency? Or is a driver free to have a random mapping from
idle_index to state?

Also, we should probably create a pretty function to get that state,
just like you did in patch 1.

> IIRC, Alex Shi sent a patchset to improve the choosing of the idlest cpu and
> the exit_latency was needed.

Right. However if we have a 'natural' order in the state array the index
itself might often be sufficient to find the least idle state, in this
specific case the absolute exit latency doesn't matter, all we want is
the lowest one.

Not dereferencing the state array saves hitting cold cachelines.
