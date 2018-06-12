From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Date: Tue, 12 Jun 2018 19:35:14 +0200
Message-ID: <20180612173514.GV12217@hirez.programming.kicks-ass.net>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <20180612123036.GJ12180@hirez.programming.kicks-ass.net>
 <16d5649d-863c-10c7-9287-202568e713e6@linaro.org>
 <20180612125247.GO12217@hirez.programming.kicks-ass.net>
 <16770447-afe3-0fd7-19f9-1bd52c4c8ced@linaro.org>
 <20180612140654.GQ12217@hirez.programming.kicks-ass.net>
 <cce05d92-d51a-ab4f-83f2-37dcdee0cd6a@linaro.org>
 <20180612155841.GT12217@hirez.programming.kicks-ass.net>
 <7190a58e-05f2-216c-8b36-70692fa722bf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7190a58e-05f2-216c-8b36-70692fa722bf@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 12, 2018 at 07:02:57PM +0200, Daniel Lezcano wrote:
> Mmh, it is unclear for me if the park() vs wakeup() can happen at the
> same time.
> 
> If the park() function is called, that means the hotplug is allowed.

No, it means we're inside hot-un-plug, but that doesn't stop the hrtimer
from firing.

> If the hotplug is allowed, we can modify the online mask.
> 
> What happens with the online mask when we are processing it in an
> interrupt context ?

RCU-like, if you observe a CPU in the online mask, it will stay
available, but the bit might get cleared.

> > Maybe avoid the issue entire by having a
> > {period,idle} tuple, where your old run := period - idle.
> 
> Can you elaborate ? I don't get it.

Have a period parameter that specifies the interval in which you have
one injected idle, and specify for how long you want to inject idle;
then obviously idle < period.

> >>> Furthermore, should you not be using hrtimer_forward(&timer,
> >>> idle_duration + run_duration) instead? AFAICT the current scheme is
> >>> prone to drifting.
> >>
> >> (I assume you meant setting the timer in the wakeup task function).
> >>
> >> Yes, drifting is not an issue if that happens. This scheme is simpler
> >> and safer than setting the timer ahead before waking up the tasks with
> >> the risk it expires before all the tasks ended their idle cycles.
> > 
> > sloppy though..
> 
> Ok, do you prefer to see the timer set in the wakeup function and thus
> having a periodic tick for the idle injection ?

I think having a HRTIMER_RESTART handler that does hrtimer_forward() is
the most sensible. You will end up having to deal with threads not being
ready, but I think that's not a real problem.
