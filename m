From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v6 1/2] PM-runtime: update accounting_timestamp only when enable
Date: Tue, 22 Jan 2019 17:01:31 +0100
Message-ID: <CAKfTPtBfbUpnGOWJsDp06PeQSyOBreX31=3iRvkR1sdFOv29Mg@mail.gmail.com>
References: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org>
 <1548167070-421-2-git-send-email-vincent.guittot@linaro.org> <CAJZ5v0gxYvDQZVrkQZ-eQgoQDhwRYR1x+SC_q7uxxbko0R03=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gxYvDQZVrkQZ-eQgoQDhwRYR1x+SC_q7uxxbko0R03=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thara Gopinath <thara.gopinath@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 22 Jan 2019 at 16:14, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jan 22, 2019 at 3:24 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Initializing accounting_timestamp to something different from 0 during
> > pm_runtime_init() doesn't make sense and put useless ordering constraint between
> > timekeeping_init() and pm_runtime_init().
> > PM runtime should start accounting time only when it is enable and discard
> > the period when disabled.
> > Set accounting_timestamp to now when enabling PM runtime.
> >
> > Suggested-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/base/power/runtime.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index fb5e2b6..7df1d05 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1306,6 +1306,10 @@ void pm_runtime_enable(struct device *dev)
> >
> >         spin_lock_irqsave(&dev->power.lock, flags);
> >
> > +       /* About to enable runtime pm, set accounting_timestamp to now */
> > +       if (dev->power.disable_depth == 1)
> > +               dev->power.accounting_timestamp = jiffies;
>
> I would do this in the dev->power.disable_depth > 0 branch below.
> Just check if disable_depth is zero after decrementing it and update
> accounting_timestamp if so.

My goal was to prevent nested "if" which is sometime difficult to read.
I'm going to change that and send a new version

Vincent

>
> > +
> >         if (dev->power.disable_depth > 0)
> >                 dev->power.disable_depth--;
> >         else
> > @@ -1506,7 +1510,7 @@ void pm_runtime_init(struct device *dev)
> >         dev->power.request_pending = false;
> >         dev->power.request = RPM_REQ_NONE;
> >         dev->power.deferred_resume = false;
> > -       dev->power.accounting_timestamp = jiffies;
> > +       dev->power.accounting_timestamp = 0;
> >         INIT_WORK(&dev->power.work, pm_runtime_work);
> >
> >         dev->power.timer_expires = 0;
> > --
> > 2.7.4
> >
