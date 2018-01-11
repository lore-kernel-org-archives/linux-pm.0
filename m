From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Thu, 11 Jan 2018 13:32:15 +0100
Message-ID: <CAPDyKFqzON3PFgYbkBiAy0Bexzjj0YwwPZbgs6O3k3dXO_v4eA@mail.gmail.com>
References: <4069324.Q7yJt6I4hJ@aspire.rjw.lan> <CAMuHMdUQQ_iH=HczLNoCsrbmEAG=7BKFEQbspg=SUYczt_4-WA@mail.gmail.com>
 <CAJZ5v0gzAPkHjWEt0Vog+HcbObXSy6nqmsL1_-LT6+F3u7TPSQ@mail.gmail.com>
 <2074722.H5Hd6orL2D@aspire.rjw.lan> <CAPDyKFoEHFpvvDgkuMSyyTMyCsmXv_Psg9uO+BjXcP0QSeE4EA@mail.gmail.com>
 <CAJZ5v0hZZ88yjX2TThKJShhX7f1T2C9O-dOho1SsMUtQykzrZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hZZ88yjX2TThKJShhX7f1T2C9O-dOho1SsMUtQykzrZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[...]

>>> Index: linux-pm/drivers/base/power/domain.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/base/power/domain.c
>>> +++ linux-pm/drivers/base/power/domain.c
>>> @@ -1048,8 +1048,9 @@ static int genpd_finish_suspend(struct d
>>>         if (ret)
>>>                 return ret;
>>>
>>> -       if (genpd->dev_ops.stop && genpd->dev_ops.start) {
>>> -               ret = pm_runtime_force_suspend(dev);
>>> +       if (genpd->dev_ops.stop && genpd->dev_ops.start &&
>>> +           !pm_runtime_status_suspended(dev)) {
>>> +               ret = genpd_stop_dev(genpd, dev);
>>
>> Something like this existed there before, but because of other
>> internal genpd reasons. It's an option but there are issues with it.
>
> OK
>
>> I think it's fragile because invoking the ->stop() callback may
>> trigger calls to "disable" resources (like clocks, pinctrls, etc) for
>> the device. Doing this at ->suspend_noirq() may be too late, as that
>> subsystem/driver for the resource(s) may already be system suspended.
>> This is the classic problem of suspending (and later resuming) devices
>> in in-correct order.
>
> Well, this is what happens with the current code too.

Correct.

>
> I mean if unmodified genpd_finish_suspend() runs, it will call
> pm_runtime_force_suspend() and that will check the device's runtime PM
> status in the first place.  If that is "suspended", it will return
> right away without doing anything (after disabling runtime PM, but
> that is irrelevant here as runtime PM is already disabled).  In turn,
> if the runtime PM status is "active", it will run
> genpd_runtime_suspend() (as the callback) and that will run the
> driver's runtime PM callback and the genpd_stop_dev() right after it.
> Thus, if calling genpd_stop_dev() at that point is problematic, it is
> problematic already today.
>
> What the patch does is essentially to drop the driver's runtime PM
> callback (should not be necessary) and the domain power off (certainly
> not necessary) from that path, but to keep the genpd_stop_dev()
> invocation that may be necessary in principle (the device is "active",
> so genpd_runtime_suspend() has not run for it, so genpd_stop_dev() has
> not been called for it yet, but it may be good to stop the clocks
> before powering off the domain).

I understand your suggested approach and it may work.

>
> The resume part is basically running genpd_start_dev() for the devices
> for which genpd_stop_dev() was run by genpd_finish_suspend(), which is
> because the subsequent driver callbacks may expect the clocks to be
> enabled.
>
>> Today we deal with this, by drivers/subsystem assigning the right
>> level of callback, as well as making sure the "dpm_list" is sorted
>> correctly (yeah, we have device links as well).
>>
>> The point is, we can go for this solution, but is it good enough?
>
> I would like to treat it as a step away from what is there today,
> retaining some of the existing functionality.
>
> From a quick look at the existing users of genpd that use the device
> start/stop functionality, running genpd_stop_dev()/genpd_start_dev()
> in the "noirq" phases should not be problematic for them at least.

I guess so.

Still, the error report by Geert worries me, but I don't think it
worth to speculate, but rather test and see.

>
>> Another option, is to simply to remove (and not replace with something
>> else) the calls to pm_runtime_force_ suspend|resume() from genpd.
>
> Right.
>
>> This moves the entire responsibility to the driver, to put its device into
>> low power state during system suspend, but with the benefit of that it
>> can decide to use the correct level of suspend/resume callbacks.
>
> Drivers of the devices in the "stop/start" domains will have to use
> pm_runtime_force_ suspend|resume() internally then to benefit from the
> domain's management of clocks, but that just may be the only way to
> avoid more problems.

Agree.

>
>> No matter how we do it, changing this may introduce some potential
>> regressions from a power consumption point of view, however although
>> only for those SoCs that uses the ->start|stop() callbacks. To
>> mitigate these power regressions, some drivers needs to be fixed, but
>> that seems inevitable anyway, doesn't it?
>
> Yes, it does.
>
> I would say let's try to go with this patch of mine as submitted and
> see how far we can get with that.
>
> That essentially doesn't prevent us from dropping the
> genpd_stop_dev()/genpd_start_dev() from the "noirq" stages if need be
> after all, but dropping them right away may cause the fallout to be
> more dramatic, at least in theory.
>

Well, my guesses is that would be a step to make the behavior a bit
more deterministic and perhaps less fragile than today.

On the other hand, I am also concerned about the future users of the
->stop|start() callbacks, including related drivers dealing with the
affected devices. That in a sense, that converting the code in genpd
to what you suggest, would still not encourage related drivers to
behave correctly during system suspend/resume. Then down the road,
when additional new users of the ->stop|start() callbacks may have
been added, it may be even harder to drop calling them in from the
noirq phases.

So to conclude, I would prefer to drop calling
pm_runtime_force_suspend|resume() from genpd, without a replacement,
but I am willing to accept also your suggested alternative.

Kind regards
Uffe
