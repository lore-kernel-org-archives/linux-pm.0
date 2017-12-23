From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/3] phy: core: Move runtime PM reference counting to
 the parent device
Date: Sat, 23 Dec 2017 13:39:45 +0100
Message-ID: <CAJZ5v0hmSaWiy9zQPP+0FySySW4yNCm92mTtJ7ebd+rBjjqJng@mail.gmail.com>
References: <1513778960-10073-1-git-send-email-ulf.hansson@linaro.org>
 <1513778960-10073-2-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0iwR1MnBokL29_QmUw2F6fgNNwzP7WLhtAL37MkMLd1xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33881 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdLWMjq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Dec 2017 07:39:46 -0500
In-Reply-To: <CAJZ5v0iwR1MnBokL29_QmUw2F6fgNNwzP7WLhtAL37MkMLd1xQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Thu, Dec 21, 2017 at 2:39 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Dec 20, 2017 at 3:09 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> The runtime PM deployment in the phy core is deployed using the phy core
>> device, which is created by the phy core and assigned as a child device of
>> the phy provider device.
>>
>> The behaviour around the runtime PM deployment cause some issues during
>> system suspend, in cases when the phy provider device is put into a low
>> power state via a call to the pm_runtime_force_suspend() helper, as is the
>> case for a Renesas SoC, which has its phy provider device attached to the
>> generic PM domain.
>>
>> In more detail, the problem in this case is that pm_runtime_force_suspend()
>> expects the child device of the provider device, which is the phy core
>> device, to be runtime suspended, else a WARN splat will be printed
>> (correctly) when runtime PM gets re-enabled at system resume.
>
> So we are now trying to work around issues with
> pm_runtime_force_suspend().  Lovely. :-/
>
>> In the current scenario, even if a call to phy_power_off() triggers it to
>> invoke pm_runtime_put() during system suspend, the phy core device doesn't
>> get runtime suspended, because this is prevented in the system suspend
>> phases by the PM core.
>>
>> To solve this problem, let's move the runtime PM deployment from the phy
>> core device to the phy provider device, as this provides the similar
>> behaviour. Changing this makes it redundant to enable runtime PM for the
>> phy core device, so let's avoid doing that.
>
> I'm not really convinced that this approach is the best one to be honest.
>
> I'll have a deeper look at this in the next few days, stay tuned.

So IMO the changes you are proposing make sense regardless of the
genpd issue, because they generally simplify the phy code, but the
additional use_runtime_pm field in struct phy represents redundant
information (manipulating reference counters shouldn't matter if
runtime PM is disabled), so it doesn't appear to be necessary.

[On a related note, I'm not sure why phy tries to intercept runtime PM
errors and "fix up" the reference counters.  That doesn't look right
to me at all.]

That said, the current phy code is not strictly invalid.  While it
looks more complicated than necessary, it doesn't do things documented
as invalid in principle, so saying "The behaviour around the runtime
PM deployment cause some issues during system suspend" in the
changelog is describing the problem from a very specific angle.
Simply put, pm_runtime_force_suspend() and the current phy code cannot
work together and so using them together is a bug.  None of them
individually is at fault, but combining them is incorrect.

Fortunately enough, the phy code can be modified so that it can be
used with pm_runtime_force_suspend() without problems, but picturing
it as "problematic", because it cannot do that today is not entirely
fair IMO.

Thanks,
Rafael
