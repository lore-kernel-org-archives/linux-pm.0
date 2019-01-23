From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v6 1/2] PM-runtime: update accounting_timestamp only when enable
Date: Wed, 23 Jan 2019 09:50:37 +0100
Message-ID: <CAKfTPtDxWK-W-jP7Ak3Nk_zksCbVrY0CHT+OnWZgt1t17AYjFw@mail.gmail.com>
References: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org>
 <1548167070-421-2-git-send-email-vincent.guittot@linaro.org> <CAPDyKFqeo1Yxso-iYF4Co-eRYXKDRmiFHi9i5wiZSCXGtgSdkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqeo1Yxso-iYF4Co-eRYXKDRmiFHi9i5wiZSCXGtgSdkQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thara Gopinath <thara.gopinath@linaro.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 23 Jan 2019 at 09:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 22 Jan 2019 at 15:24, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Initializing accounting_timestamp to something different from 0 during
> > pm_runtime_init() doesn't make sense and put useless ordering constraint between
> > timekeeping_init() and pm_runtime_init().
> > PM runtime should start accounting time only when it is enable and discard
> > the period when disabled.
> > Set accounting_timestamp to now when enabling PM runtime.
>
> Hmm, my first impression is that this sounds like a reasonable thing
> to do. However, there are couple of more things to consider.
>
> 1) update_pm_runtime_accounting() is setting a new value of
> dev->power.accounting_timestamp, no matter of whether runtime PM has
> been enabled. That's seems wrong to me, at least from the perspective
> of what we are trying to change here. So you probably needs to fix
> that too.

note that whatever is done before enabling pm runtime, this will be
overwritten during the enablement.
I can add a clean up patch but this behavior is already there with jiffies.

Or do you think that update_pm_runtime_accounting can be called before
timekeeping_init() ?

>
> 2) I don't think you explicitly need to set
> dev->power.accounting_timestamp to zero at pm_runtime_init(). Just
> leave it uninitialized, as we are anyways going to initialize it
> before we make use of it.

yes probably

>
> 3) How will this change affect accounting while being system
> suspended? As you know, the PM core disables and re-enables runtime PM

So the time in system suspended will not be accounted

> during a system suspend/resume sequence. It looks to me, that you
> actually need to call update_pm_runtime_accounting() from
> pm_runtime_enable|disable(), or something along those lines, as to get
> the accounting correct, no?

I thought that everything was already done for jiffies too. As soon as
pm runtime is disable, we can't really account this time to
suspended_time or active_time because we don't have control anymore

I think that we don't need any additional changes for
pm_runtime_enable because we just init the accounting_timestamp and
there is no active or suspend runtime to account yet
For pm_runtime_disable(), I thought that everything was already there
otherwise it means that we already didn't account the time correctly.
I will have a deeper look at that

>
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
