From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Thu, 11 Jan 2018 19:44:02 +0100
Message-ID: <CAJZ5v0hrB-myMYSXoiLw23i_O2XuSmOkKMW+Z_Zz3GgUoUjLFg@mail.gmail.com>
References: <4069324.Q7yJt6I4hJ@aspire.rjw.lan> <CAMuHMdUQQ_iH=HczLNoCsrbmEAG=7BKFEQbspg=SUYczt_4-WA@mail.gmail.com>
 <CAJZ5v0gzAPkHjWEt0Vog+HcbObXSy6nqmsL1_-LT6+F3u7TPSQ@mail.gmail.com>
 <2074722.H5Hd6orL2D@aspire.rjw.lan> <CAPDyKFoEHFpvvDgkuMSyyTMyCsmXv_Psg9uO+BjXcP0QSeE4EA@mail.gmail.com>
 <CAJZ5v0hZZ88yjX2TThKJShhX7f1T2C9O-dOho1SsMUtQykzrZg@mail.gmail.com> <CAPDyKFqzON3PFgYbkBiAy0Bexzjj0YwwPZbgs6O3k3dXO_v4eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44979 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934939AbeAKSoE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jan 2018 13:44:04 -0500
In-Reply-To: <CAPDyKFqzON3PFgYbkBiAy0Bexzjj0YwwPZbgs6O3k3dXO_v4eA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>

On Thu, Jan 11, 2018 at 1:32 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

[cut]

>>>
>>> The point is, we can go for this solution, but is it good enough?
>>
>> I would like to treat it as a step away from what is there today,
>> retaining some of the existing functionality.
>>
>> From a quick look at the existing users of genpd that use the device
>> start/stop functionality, running genpd_stop_dev()/genpd_start_dev()
>> in the "noirq" phases should not be problematic for them at least.
>
> I guess so.
>
> Still, the error report by Geert worries me, but I don't think it
> worth to speculate, but rather test and see.

Agreed.

>>> Another option, is to simply to remove (and not replace with something
>>> else) the calls to pm_runtime_force_ suspend|resume() from genpd.
>>
>> Right.
>>
>>> This moves the entire responsibility to the driver, to put its device into
>>> low power state during system suspend, but with the benefit of that it
>>> can decide to use the correct level of suspend/resume callbacks.
>>
>> Drivers of the devices in the "stop/start" domains will have to use
>> pm_runtime_force_ suspend|resume() internally then to benefit from the
>> domain's management of clocks, but that just may be the only way to
>> avoid more problems.
>
> Agree.

But this doesn't look particularly attractive to me, because it would
add a requirement for drivers to implement their system-wide PM
callbacks in a specific way and, in my view, no such requirements
should be imposed by code that advertises itself as "generic" (by the
name at least).  In particular, drivers written to this requirement
might not be able to work correctly with other middle-layer code.

If genpd was a bus type, that wouldn't be particularly objectionable,
even though it is not particularly straightforward either, because
drivers register for a particular bus type and so they need to take
its specifics into account.  Drivers usually don't register for a
specific PM domain, however, and at least some of them may need to
work with different PM domain code on different platforms.

>>> No matter how we do it, changing this may introduce some potential
>>> regressions from a power consumption point of view, however although
>>> only for those SoCs that uses the ->start|stop() callbacks. To
>>> mitigate these power regressions, some drivers needs to be fixed, but
>>> that seems inevitable anyway, doesn't it?
>>
>> Yes, it does.
>>
>> I would say let's try to go with this patch of mine as submitted and
>> see how far we can get with that.
>>
>> That essentially doesn't prevent us from dropping the
>> genpd_stop_dev()/genpd_start_dev() from the "noirq" stages if need be
>> after all, but dropping them right away may cause the fallout to be
>> more dramatic, at least in theory.
>>
>
> Well, my guesses is that would be a step to make the behavior a bit
> more deterministic and perhaps less fragile than today.
>
> On the other hand, I am also concerned about the future users of the
> ->stop|start() callbacks, including related drivers dealing with the
> affected devices. That in a sense, that converting the code in genpd
> to what you suggest, would still not encourage related drivers to
> behave correctly during system suspend/resume.

I'm not sure what you mean here.

Drivers in principle should not need to worry about the ->stop|start()
part, because that belongs to a different code layer.

They only need to be able to expect certain things (like clocks) to be
there (or in a specific state) when their code is running in certain
cases.

Now, I realize that this is pure theory and that in practice, if
->stop|start() are there, drivers working with genpd are probably
platform-specific anyway, more or less, so it is not likely that they
will ever have to work with any other middle-layer code.

>Then down the road, when additional new users of the ->stop|start() callbacks
> may have been added, it may be even harder to drop calling them in from the
> noirq phases.
>
> So to conclude, I would prefer to drop calling
> pm_runtime_force_suspend|resume() from genpd, without a replacement,
> but I am willing to accept also your suggested alternative.

OK

Thanks,
Rafael
