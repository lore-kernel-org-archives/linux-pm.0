From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v11 7/8] cpuidle: Pre-store next timer/tick before
 selecting an idle state
Date: Tue, 26 Feb 2019 23:17:51 +0100
Message-ID: <CAJZ5v0icO1VUm7bFLA+3=zLF2BpbP5QC=evS9b0LAbWAC+SqhQ@mail.gmail.com>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <20190226145415.19411-8-ulf.hansson@linaro.org> <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>Linux
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 26, 2019 at 11:08 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 26, 2019 at 3:54 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > A common piece of data used by cpuidle governors, is the information about
> > when the next timer/tick is going to fire. Rather than having each governor
> > calling tick_nohz_get_next_timer|hrtimer() separately, let's consolidate
> > the code by calling these functions before invoking the ->select() callback
> > of the governor - and store the output data in the struct cpuidle_device.
>
> That misses the point IMO.
>
> You don't need to store two values in struct cpuidle_device, but just
> one, and not before running ->select(), but before invoking the
> driver's ->enter() callback.
>
> At that point, the decision on whether or not to stop the scheduler
> tick has been made already and it should be sufficient to store the
> return value of tick_nohz_get_next_hrtimer() introduced by patch
> [3/8],

Or the difference between in and ts->idle_entrytime for that matter,
whichever is more useful.

> because that value represents the next timer regardless of what
> has been decided with respect to the tick.
>
> And you won't need the tick_nohz_get_next_timer() any more then.
