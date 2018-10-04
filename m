From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5/6] cpuidle: menu: Avoid computations for very close timers
Date: Thu, 4 Oct 2018 19:11:44 +0200
Message-ID: <CAJZ5v0iqXLZoZ03Hqi-3h_txtnGnDLMYP5K4vtdp+JcJ97P2eg@mail.gmail.com>
References: <3510260.hvypppS8Bs@aspire.rjw.lan> <2753018.aK9edJ7Dvu@aspire.rjw.lan>
 <20181004155044.GD1881@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004155044.GD1881@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 4, 2018 at 5:50 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On Tue, Oct 02, 2018 at 11:46:28PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If the next timer event (with the tick excluded) is closer than the
> > target residency of the second state or the PM QoS latency constraint
> > is below its exit latency, state[0] will be used regardless of any
> > other factors, so skip the computations in menu_select() then and
> > return 0 straight away from it.
> >
> > Still, do that after the bucket has been determined to avoid
> > disturbing the wakeup statistics in general.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/menu.c |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > Index: linux-pm/drivers/cpuidle/governors/menu.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > @@ -309,6 +309,18 @@ static int menu_select(struct cpuidle_dr
> >       get_iowait_load(&nr_iowaiters, &cpu_load);
> >       data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
> >
> > +     if (unlikely(drv->state_count <= 1) ||
>
> I'm not sure this test is necessary.

Yes, it is IMO.

Strictly speaking it prevents state[1] from being accessed if the
count is not 2 at least.

> If state_count == 0, we don't have to select anything as the cpuidle can't register because of:
>
> static int __cpuidle_register_driver(struct cpuidle_driver *drv)
> {
>         int ret;
>
>         if (!drv || !drv->state_count)
>                 return -EINVAL;
>
>         [ ... ]
> }
>
> If state_count == 1, then there is nothing to select, it is always the state 0.

Which is why it is better to simply return 0 right away in this case. :-)

I guess I could compare state_count just to 1, but <= 1 works too.
