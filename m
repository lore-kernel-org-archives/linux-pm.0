From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpuidle: menu: Handle stopped tick more aggressively
Date: Mon, 13 Aug 2018 09:58:07 +0200
Message-ID: <CAJZ5v0jPfKd7BLWjLdLE_M4uJqDrmSgMWyypFB_+DVvAtr0etg@mail.gmail.com>
References: <1951009.1jlQfyrxio@aspire.rjw.lan> <3174357.2tBMdxG3bF@aspire.rjw.lan>
 <20180810092034.GF11817@leoy-ThinkPad-X240s> <CAJZ5v0h8T99pqhNoj+V9Mb5yS621OT_=d05YbWtbCW5H362myA@mail.gmail.com>
 <20180810123143.GG11817@leoy-ThinkPad-X240s> <CAJZ5v0h5XWES6ye152MjijWKqTWBVO2mjo5Jz3MmMn+=7tRqWA@mail.gmail.com>
 <20180812134404.GA28966@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180812134404.GA28966@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 12, 2018 at 3:44 PM <leo.yan@linaro.org> wrote:
>
> On Sun, Aug 12, 2018 at 12:07:45PM +0200, Rafael J. Wysocki wrote:
>
> [...]
>
> > > > > > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > > > > > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > > > > > @@ -285,9 +285,8 @@ static int menu_select(struct cpuidle_dr
> > > > > >  {
> > > > > >       struct menu_device *data = this_cpu_ptr(&menu_devices);
> > > > > >       int latency_req = cpuidle_governor_latency_req(dev->cpu);
> > > > > > -     int i;
> > > > > > -     int first_idx;
> > > > > > -     int idx;
> > > > > > +     int first_idx = 0;
> > > > > > +     int idx, i;
> > > > > >       unsigned int interactivity_req;
> > > > > >       unsigned int expected_interval;
> > > > > >       unsigned long nr_iowaiters, cpu_load;
> > > > > > @@ -307,6 +306,18 @@ static int menu_select(struct cpuidle_dr
> > > > > >       /* determine the expected residency time, round up */
> > > > > >       data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
> > > > > >
> > > > > > +     /*
> > > > > > +      * If the tick is already stopped, the cost of possible short idle
> > > > > > +      * duration misprediction is much higher, because the CPU may be stuck
> > > > > > +      * in a shallow idle state for a long time as a result of it.  In that
> > > > > > +      * case say we might mispredict and use the known time till the closest
> > > > > > +      * timer event for the idle state selection.
> > > > > > +      */
> > > > > > +     if (tick_nohz_tick_stopped()) {
> > > > > > +             data->predicted_us = ktime_to_us(delta_next);
> > > > > > +             goto select;
> > > > > > +     }
> > > > > > +
> > > > >
> > > > > This introduce two potential issues:
> > > > >
> > > > > - This will totally ignore the typical pattern in idle loop; I
> > > > >   observed on the mmc driver can trigger multiple times (> 10 times)
> > > > >   with consistent interval;
> > > >
> > > > I'm not sure what you mean by "ignore".
> > >
> > > You could see after move code from blow to this position, the typical
> > > pattern interval will not be accounted; so if in the middle of idles
> > > there have a bunch of interrupts with fix pattern, the upper code
> > > cannot detect this pattern anymore.
> >
> > I'm not really following you here.
> >
> > The part of the code skipped for tick_nohz_tick_stopped() doesn't
> > update the data at all AFAICS.  It only computes some values that
> > would be discarded later anyway, so I'm not sure what the point of
> > running that computation is.
>
> Sorry I don't explain clearly, so try to rephrase:
>
> With your patch for the tick stopped case, it directly uses tick delta
> value as prediction and goto 'select' tag.  So it skips below code
> pieces, these codes have minor improvement for typical pattern which
> can be applied in the middle of idles, for example, the mmc driver
> triggers 16 interrupts with ~1500us interval, these interrupts are all
> handled within the idle loop, so the typical pattern can detect the mmc
> interrupts pattern and it will help idle governor to select a shallower
> idle state so can avoid to break the residency.
>
> You mentioned these computed values would be discarded later, this is
> true for most cases, but it isn't always true actually.  Without your
> patch, the governor will discard the computed values only when
> 'data->predicted_us < TICK_USEC', otherwise the interval pattern is
> still be applied in the prediction.

OK, right.

I'll fix that up in v4, thanks!
