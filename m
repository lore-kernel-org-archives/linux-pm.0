From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 0/3] renesas: irqchip: Use WAKEUP_PATH driver PM flag
Date: Fri, 5 Jan 2018 10:16:53 +0100
Message-ID: <CAMuHMdVBBnH2REi4RP6N6S5PaCgrwFteHXPRtnr9jPwtUbx_qA@mail.gmail.com>
References: <1514554304-18989-1-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0heO9DxbxnrXJeXC0RDQV-oOb=KLJmXWm7uuy=y7U2KjA@mail.gmail.com>
 <CAMuHMdX0p7rnrtdVOeh71Nd4k8aU3Pi-L6y+LTFKoh21XNUs4w@mail.gmail.com> <CAJZ5v0iphV9w6wQy2uQ=wW3HEC+eK4ZnS8fBE-GFuESjXM4PCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39117 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbeAEJQz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jan 2018 04:16:55 -0500
In-Reply-To: <CAJZ5v0iphV9w6wQy2uQ=wW3HEC+eK4ZnS8fBE-GFuESjXM4PCQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-gpio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Rafael,

On Sun, Dec 31, 2017 at 12:47 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Sun, Dec 31, 2017 at 10:22 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Sun, Dec 31, 2017 at 1:56 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Fri, Dec 29, 2017 at 2:31 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>
>>>> Changes in v2: [By Ulf Hansson]
>>>>         - I have picked up the series from Geert [1] and converted it into use
>>>>         the WAKEUP_PATH driver PM flag. This includes some minor changes to each
>>>>         patch and updates to the changelogs.
>>>>         - An important note, the WAKEUP_PATH driver PM flag is introduced in a
>>>>         separate series [2], not yet applied, so @subject series depends on it.
>>>>         - One more note, two of the patches has a checkpatch error, however I
>>>>         did not fix them, becuase I think that should be done separate.
>>>>
>>>> [1]
>>>> https://lkml.org/lkml/2017/11/9/382
>>>> [2]
>>>> https://marc.info/?l=linux-pm&m=151454744124661&w=2
>>>>
>>>> More information below, picked from Geert's previous cover letter.
>>>>
>>>> Kind regards
>>>> Uffe
>>>>
>>>>
>>>> Hi all,
>>>>
>>>> If an interrupt controller in a Renesas ARM SoC is part of a Clock
>>>> Domain, and it is part of the wakeup path, it must be kept active during
>>>> system suspend.
>>>>
>>>> Currently this is handled in all interrupt controller drivers by
>>>> explicitly increasing the use count of the module clock when the device
>>>> is part of the wakeup path.  However, this explicit clock handling is
>>>> merely a workaround for a failure to properly communicate wakeup
>>>> information to the device core.
>>>>
>>>> Hence this series fixes the affected drivers by setting the devices'
>>>> power.wakeup_path fields instead, to indicate they are part of the
>>>> wakeup path.  Depending on the PM Domain's active_wakeup configuration,
>>>> the genpd core code will keep the device enabled (and the clock running)
>>>> during system suspend when needed.
>>>
>>> However, there is a convention, documented in the kerneldoc comment of
>>> device_init_wakeup(), by which devices participating in system wakeup
>>> "passively" (like USB controllers and hubs) are expected to have it
>>> enabled by default.
>>>
>>> If that convention was followed by the devices in question here, the
>>> wakeup_path bit would be set for them and no other code changes would
>>> be necessary.  So is there any reason for not following it?
>>
>> Yes there is.  The need to stay enabled during system suspend depends
>> on the consumer of the interrupt. It is controlled by the consumer using
>> the irq_chip.irq_set_wake() callback at runtime, and may change at runtime.
>>
>> If the wakeup_path flag is always set, the interrupt controller will
>> never be suspended during system suspend, and thus waste power.
>
> OK
>
> For IRQ chips in particular, I think, you don't need add new fields to
> struct dev_pm_info to make it work.
>
> In ->suspend (or ->suspend_late, which may be better) you can check
> the IRQD_WAKEUP_STATE flag of the irq_desc associated with the pin.
> If that is set, you can simply set power.wakeup_path for the device
> and that will make genpd skip it.  Wouldn't that work?

The irq_desc is per pin, while suspend is called per platform device, which
contains one or more irq_chips, each serving one or more pins.
So checking for IRQD_WAKEUP_STATE means looping over all irq_descs
associated to the platform device.

Which made me realize {gpio_rcar,irqc,intc_irqpin}_priv.wakeup_path should
not be a flag, but a counter. Currently it works by luck, as we never have
two independent wake-up sources being routed through the same irqchip.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
