From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/4] PM / Domains: Allow runtime PM during system PM phases
Date: Tue, 24 May 2016 08:40:57 +0200
Message-ID: <CAPDyKFpVmD7=nZRM9RMNc7VrME5NF1vVwoyeAbDbQ6D6GDjZVA@mail.gmail.com>
References: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org>
	<1463485296-22742-4-git-send-email-ulf.hansson@linaro.org>
	<m2zirgidc2.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35542 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbcEXGk7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2016 02:40:59 -0400
Received: by mail-wm0-f50.google.com with SMTP id a136so55917786wme.0
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2016 23:40:58 -0700 (PDT)
In-Reply-To: <m2zirgidc2.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On 24 May 2016 at 01:06, Kevin Hilman <khilman@baylibre.com> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> The PM core disables runtime PM at __device_suspend_late() before it calls
>> a system PM "late" callback for the device. When resuming the device,
>> after the corresponding "early" callback has been invoked, it re-enables
>> runtime PM.
>>
>> By changing genpd to conform to this behaviour, the device no longer have
>> to be unconditionally runtime resumed from genpd's ->prepare() callback. In
>> most cases that avoids unnecessary operations.
>
> ...avoids the unnecessary, and energy-wasting operaions of runtime
> resuming devices that have nothing to do, only to runtime suspend them
> shortly after.

Perfect, I will update.

>
>> As runtime PM then isn't disabled/enabled by genpd, the subsystem/driver
>> can rely on the generic behaviour from PM core. Consequentially runtime PM
>> is allowed in more phases of system PM than before.
>
> OK.  I like this change a lot, but it the changelog doesn't go into
> describing how this gets around the problems that were being worked
> around by having genpd disable runtime PM in the first place.  This
> changelog should describe how this appraoch deals with those problems,
> or why they don't exist anymore.

OK, I will try to elaborate a bit on this.

>
>> Although, because of this change and due to that genpd powers on the PM
>> domain unconditionally in the system PM resume "noirq" phase, it could
>> potentially cause a PM domain to stay powered on even if it's unused after
>> the system has resumed. To avoid this, let's schedule a power off work
>> when genpd's system PM ->complete() callback has been invoked for the last
>> device in the PM domain.
>
> OK.
>
>> Another issue that arises due to this change in genpd, concerns those
>> platforms/PM domains that makes use of genpd's device ->stop|start()
>> callbacks. In these scenarios, the corresponding subsystem/driver needs to
>> invoke pm_runtime_force_suspend() from a system PM suspend callback to
>> allow genpd's ->runtime_suspend() to be invoked for an active device, else
>> genpd can't "stop" a device that is "started".
>>
>> The subsystem/driver also needs to invoke pm_runtime_force_resume()
>> in a system PM resume callback, to restore the runtime PM state for the
>> device and to re-enable runtime PM.
>>
>> Currently not all involved subsystem/drivers makes use of
>> pm_runtime_force_suspend|resume() accordingly. Therefore, let's invoke
>> pm_runtime_force_suspend|resume() from genpd's "noirq" system PM
>> callbacks, in cases when the ->stop|start() callbacks are being used.
>>
>> In this way, devices are "stoped" during suspend and "started" during
>> resume, even in those cases when the subsystem/driver don't call
>> pm_runtime_force_suspend|resume() themselves.
>
> IMO, this last part might be better dealt with as a separate patch, so
> it's clear which parts are for the main genpd change, and which parts
> fixup the fallout.

I do that!

>
> On a related note, are there many genpd drivers using dev_ops->start and
> ->stop out there?  A quick grep didn't find anything other than the
> pm_clk stuff.
>
> Kevin

Currently it's only the pm_clk stuff. Although that is quite
extensively used among Renesas SoCs.

Thanks for reviewing!

Kind regards
Uffe
