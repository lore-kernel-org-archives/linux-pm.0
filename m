From: Alan Cooper <alcooperx@gmail.com>
Subject: Re: [PATCH] PM / core: Clear the direct_complete flag on errors
Date: Thu, 4 Oct 2018 09:59:00 -0400
Message-ID: <CAOGqxeXCsXbxOcDrdjsgLXXxOtFfyzE0-zVEU6Y9kLxUaVfDiQ@mail.gmail.com>
References: <61559514.Vym8FNvob2@aspire.rjw.lan> <CAPDyKFoUdQRUYQ0qb5WM=Bi-F_4Fe8VEPNYZGu2ezMPj_wxoPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoUdQRUYQ0qb5WM=Bi-F_4Fe8VEPNYZGu2ezMPj_wxoPg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

> On 4 October 2018 at 11:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If __device_suspend() returns early on an error or pending wakeup
> > and the power.direct_complete flag has been set for the device
> > already, the subsequent device_resume() will be confused by it
> > and it will call pm_runtime_enable() incorrectly, as runtime PM
> > has not been disabled for the device by __device_suspend().
>
> I think it would be fair to mention that is related to the async
> suspend path, in dpm_suspend().

This also fixed the issue and looks cleaner.

>
> >
> > To avoid that, clear power.direct_complete if __device_suspend()
> > is not going to disable runtime PM for the device before returning.
>
> Overall, by looking at the behavior in dpm_suspend() of async
> suspended devices, it does look a bit fragile to me.
>
> My worries is that we put asynced suspended devices in the
> dpm_suspended_list, no matter if the device was successfully suspended
> or not. This differs from the no-async path.
>
> In the long run, maybe we should change that instead?

I originally looked into this. Currently dmp_suspend moves async
devices from the prepared list to the suspended list as they are
queued and I looked at moving this to __device_suspend (after the
checks for async_error and wake_pending) but realized that this would
change normal resume ordering and was afraid that would be too
disruptive.

Al


On Thu, Oct 4, 2018 at 9:23 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On 4 October 2018 at 11:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If __device_suspend() returns early on an error or pending wakeup
> > and the power.direct_complete flag has been set for the device
> > already, the subsequent device_resume() will be confused by it
> > and it will call pm_runtime_enable() incorrectly, as runtime PM
> > has not been disabled for the device by __device_suspend().
>
> I think it would be fair to mention that is related to the async
> suspend path, in dpm_suspend().
>
> >
> > To avoid that, clear power.direct_complete if __device_suspend()
> > is not going to disable runtime PM for the device before returning.
>
> Overall, by looking at the behavior in dpm_suspend() of async
> suspended devices, it does look a bit fragile to me.
>
> My worries is that we put asynced suspended devices in the
> dpm_suspended_list, no matter if the device was successfully suspended
> or not. This differs from the no-async path.
>
> In the long run, maybe we should change that instead?
>
> >
> > Fixes: aae4518b3124 (PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily)
> > Reported-by: Al Cooper <alcooperx@gmail.com>
> > Cc: 3.16+ <stable@vger.kernel.org> # 3.16+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Kind regards
> Uffe
>
> > ---
> >  drivers/base/power/main.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/base/power/main.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/main.c
> > +++ linux-pm/drivers/base/power/main.c
> > @@ -1713,8 +1713,10 @@ static int __device_suspend(struct devic
> >
> >         dpm_wait_for_subordinate(dev, async);
> >
> > -       if (async_error)
> > +       if (async_error) {
> > +               dev->power.direct_complete = false;
> >                 goto Complete;
> > +       }
> >
> >         /*
> >          * If a device configured to wake up the system from sleep states
> > @@ -1726,6 +1728,7 @@ static int __device_suspend(struct devic
> >                 pm_wakeup_event(dev, 0);
> >
> >         if (pm_wakeup_pending()) {
> > +               dev->power.direct_complete = false;
> >                 async_error = -EBUSY;
> >                 goto Complete;
> >         }
> >
