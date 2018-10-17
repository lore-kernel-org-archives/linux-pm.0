From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 3/3] thermal: da9062/61: Prevent hardware access during
 system suspend
Date: Wed, 17 Oct 2018 11:14:24 +0200
Message-ID: <CAMuHMdWEzDenwgT8gkK7+_rEyjeVBCKrLaML5sMRkiZkzJN8jg@mail.gmail.com>
References: <20181012072017.10765-1-geert+renesas@glider.be>
 <20181012072017.10765-4-geert+renesas@glider.be> <6ED8E3B22081A4459DAC7699F3695FB7021C4CCFCB@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7021C4CCFCB@SW-EX-MBX02.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Support Opensource <Support.Opensource@diasemi.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Steve,

On Wed, Oct 17, 2018 at 10:57 AM Steve Twiss
<stwiss.opensource@diasemi.com> wrote:
> On 12 October 2018 08:20 Geert Uytterhoeven wrote:
> > Subject: [PATCH v2 3/3] thermal: da9062/61: Prevent hardware access during
> > system suspend
> >
> > The workqueue used for monitoring the hardware may run while the device
> > is already suspended.  Fix this by using the freezable system workqueue
> > instead, cfr. commit 51e20d0e3a60cf46 ("thermal: Prevent polling from
> > happening during system suspend").
>
> My thinking was:  this device is a PMIC and it will power the system. So when
> the device is turned off, the S/W will also not be running.
>
> Although my assumption only works if the PMIC device is the primary system
> power -- this has always been the case so far. And although I don't have any
> evidence this will change, it may become untrue in the future of course.

This is not about powering off the system, but about suspending the system,
which suspends all drivers.

The issue is that the normal workqueue may run while the system is being
suspended.  Accessing the DA9062 may or may not work at that time,
depending on the i2c controller being usable or not.

Due to the DA9062 being an i2c device, I agree this is different than
for rcar-thermal, where the rcar-thermal device itself cannot be
accessed because it is suspended.

> > Fixes: 608567aac3206ae8 ("thermal: da9062/61: Thermal junction temperature
> > monitoring driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Untested due to lack of hardware.
>
> So, I have not been able to make any time to test this patch yet -- and with
> current workloads this might take a bit of time before I get to it.

The main thing to test is what happens when da9062_thermal_poll_on() is
called while the i2c controller is already suspended, and whether that
is mitigated by my patch.
Looking at the function, I guess it starts spewing error messages, and
will continue triggering itself, by virtue of enabling the interrupt again,
without having been able to disable its cause.

> > --- a/drivers/thermal/da9062-thermal.c
> > +++ b/drivers/thermal/da9062-thermal.c
> > @@ -106,7 +106,7 @@ static void da9062_thermal_poll_on(struct work_struct
> > *work)
> >                                          THERMAL_EVENT_UNSPECIFIED);
> >
> >               delay = msecs_to_jiffies(thermal->zone->passive_delay);
> > -             schedule_delayed_work(&thermal->work, delay);
> > +             queue_delayed_work(system_freezable_wq, &thermal->work,
> > delay);
> >               return;
> >       }
> >
> > @@ -125,7 +125,7 @@ static irqreturn_t da9062_thermal_irq_handler(int irq,
> > void *data)
> >       struct da9062_thermal *thermal = data;
> >
> >       disable_irq_nosync(thermal->irq);
> > -     schedule_delayed_work(&thermal->work, 0);
> > +     queue_delayed_work(system_freezable_wq, &thermal->work, 0);
> >
> >       return IRQ_HANDLED;
> >  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
