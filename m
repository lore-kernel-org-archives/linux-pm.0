From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCHC 3/3] sched/fair: use the idle state info to choose
 the idlest cpu
Date: Fri, 18 Apr 2014 11:38:45 +0200
Message-ID: <20140418093845.GD11096@twins.programming.kicks-ass.net>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org>
 <1396009796-31598-4-git-send-email-daniel.lezcano@linaro.org>
 <alpine.LFD.2.11.1404012208110.1571@knanqh.ubzr>
 <534FDCDC.6000806@linaro.org>
 <alpine.LFD.2.11.1404171138470.980@knanqh.ubzr>
 <534FFBB3.8050601@linaro.org>
 <alpine.LFD.2.11.1404171207531.980@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1404171207531.980@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, mingo@elte.hu, rjw@rjwysocki.net, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 17, 2014 at 12:21:28PM -0400, Nicolas Pitre wrote:
> CPU topology is needed to properly describe scheduling domains.  Whether 
> we balance across domains or pack using as few domains as possible is a 
> separate issue.  In other words, you shouldn't have to care in this 
> patch series.
> 
> And IMHO coupled C-state is a low-level mechanism that should remain 
> private to cpuidle which the scheduler shouldn't be aware of.

I'm confused.. why wouldn't you want to expose these?
