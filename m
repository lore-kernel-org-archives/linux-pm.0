From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v12 3/4] cpuidle: Export the next timer/tick expiration
 for a CPU
Date: Mon, 25 Mar 2019 15:23:27 +0100
Message-ID: <CAPDyKFr-zjhvQr-2FtiNyDig60zM=raY7+=G_dtA+H9g49RV8w@mail.gmail.com>
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-4-ulf.hansson@linaro.org> <2942111.nn8VVVUCAL@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2942111.nn8VVVUCAL@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 25 Mar 2019 at 13:21, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, February 27, 2019 8:58:35 PM CET Ulf Hansson wrote:
> > To be able to predict the sleep duration for a CPU that is entering idle,
> > knowing when the next timer/tick is going to expire, is extremely useful.
> > Both the teo and the menu cpuidle governors already makes use of this
> > information, while selecting an idle state.
> >
> > Moving forward, the similar prediction needs to be done, but for a group of
> > idle CPUs rather than for a single idle CPU. Following changes implements a
> > new genpd governor, which needs this.
> >
> > Support this, by sharing a new function called
> > tick_nohz_get_next_hrtimer(), which returns the next hrtimer or the next
> > tick, whatever that expires first.
> >
> > Additionally, when cpuidle is about to invoke the ->enter() callback, then
> > call tick_nohz_get_next_hrtimer() and store its return value in the per CPU
> > struct cpuidle_device, as to make it available outside cpuidle.
> >
> > Do note, at the point when cpuidle calls tick_nohz_get_next_hrtimer(), the
> > governor's ->select() callback has already made a decision whether to stop
> > the tick or not. In this way, tick_nohz_get_next_hrtimer() actually returns
> > the next timer expiration, whatever origin.
> >
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v12:
> >       - New patch.
> >
> > ---
> >  drivers/cpuidle/cpuidle.c |  8 ++++++++
> >  include/linux/cpuidle.h   |  1 +
> >  include/linux/tick.h      |  7 ++++++-
> >  kernel/time/tick-sched.c  | 12 ++++++++++++
> >  4 files changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index 7f108309e871..255365b1a6ab 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -328,6 +328,14 @@ int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> >  int cpuidle_enter(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> >                 int index)
> >  {
> > +     /*
> > +      * Store the next hrtimer, which becomes either next tick or the next
> > +      * timer event, whatever expires first. Additionally, to make this data
> > +      * useful for consumers outside cpuidle, we rely on that the governor's
> > +      * ->select() callback have decided, whether to stop the tick or not.
> > +      */
> > +     dev->next_hrtimer = tick_nohz_get_next_hrtimer();
>
> I would use WRITE_ONCE() to set next_hrtimer here and READ_ONCE() for
> reading that value in the next patch, as a matter of annotation if
> nothing else.

Okay!

>
> > +
> >       if (cpuidle_state_is_coupled(drv, index))
> >               return cpuidle_enter_state_coupled(dev, drv, index);
> >       return cpuidle_enter_state(dev, drv, index);
>
> Also I would clear next_hrtimer here to avoid dragging stale values
> around.

Right, I can do that.

However, at least in my case it would be an unnecessary update of the
variable, as I am never in a path where the value can be "stale". Even
if one theoretically could use a stale value, it's seems likely to not
be an issue, don't you think? Anyway, if I don't hear from you, I do
the change as you suggested.

>
> Apart from this the series LGTM.

Great, thanks. I re-spin a new version.

Kind regards
Uffe
