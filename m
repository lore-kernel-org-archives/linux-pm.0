From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH 2/3] sched: idle: Add sched balance option
Date: Tue, 29 Apr 2014 10:26:24 +0100
Message-ID: <20140429092624.GE2639@e103034-lin>
References: <1398342291-16322-1-git-send-email-daniel.lezcano@linaro.org>
 <535911DC.9050109@linaro.org>
 <CAP245DXFRfARtEfj70XD8D8OiAT_1i_5G2zao+y0DT0Lg_YFJA@mail.gmail.com>
 <2713863.BLQTYQm2Oa@vostro.rjw.lan>
 <20140425132055.GC11096@twins.programming.kicks-ass.net>
 <535A94E3.5080004@linaro.org>
 <20140425184327.GH26782@laptop.programming.kicks-ass.net>
 <535E28D0.7050502@linaro.org>
 <20140428102819.GG27561@twins.programming.kicks-ass.net>
 <535E3673.8020606@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <535E3673.8020606@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Amit Kucheria <amit.kucheria@linaro.org>, Ingo Molnar <mingo@elte.hu>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 28, 2014 at 12:07:31PM +0100, Daniel Lezcano wrote:
> I'm really wondering if the cgroup couldn't be a good solution:
> 
> Amit pointed the conflict about the power vs performance with some 
> applications. We want to have for example a game to run fast performance 
> and some other application to save power.
> 
> The cgroup will allow to:
> 
>   * eg. create a couple of cgroup one for performance and the other one 
> for power and assign the different applications to one of these group

If you mean using the cgroups similar to how Android has foreground and
background groups, I think cgroups is a good way to distinguish between
tasks with different performance priorities.

We can't optimize for both energy and performance at the same time, but
it would allow us to only deliver high performance when a high
performance task is runnable. It would give us more fine-grained control
than either energy or performance for all tasks. If necessary, it would
also be possible to have more than two cgroups.
