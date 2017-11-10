From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/3] PM / Domain: renesas: Fix active wakeup behavior
Date: Fri, 10 Nov 2017 16:52:01 +0100
Message-ID: <CAPDyKFpZRkNNOs7o2QurDrUA3XLhDbPqedjOiezStzz=X+u5kg@mail.gmail.com>
References: <1510234022-29442-1-git-send-email-geert+renesas@glider.be>
 <CAPDyKFrJ67POYoB1PQUjWEWxgzcGuBRUMKSs5NmjoyLOFLuk4A@mail.gmail.com>
 <CAMuHMdU84DFZmFACuXLqhFsR-Q+1d3GPG3NFPinLRW8=96BDCA@mail.gmail.com>
 <CAPDyKFrstmMQ=R49EKXQ3fs=_pwhmJkaX8K0dY4u9OZVxY3Z4w@mail.gmail.com> <CAMuHMdVHT7Oebp-_5WRp2BZ5FU5d8aSsjPPNNKRQr3o17onquQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVHT7Oebp-_5WRp2BZ5FU5d8aSsjPPNNKRQr3o17onquQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10 November 2017 at 14:22, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Fri, Nov 10, 2017 at 1:49 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 10 November 2017 at 11:22, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> On Fri, Nov 10, 2017 at 10:57 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> On 9 November 2017 at 14:26, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>>>>> If a device in a Renesas ARM SoC is part of a Clock Domain, and it is
>>>>> used as a wakeup source, it must be kept active during system suspend.
>>>>
>>>> Geert, I think we discussed this a bit already. I wonder if the above
>>>> is a correct statement for all devices in these PM domains, that has
>>>> wakeups?
>>>
>>> It is true for all wakeup sources (e.g. Ethernet and serial).
>>>
>>>> Don't these SoCs make use of any external logic (out-of-band IRQ) to
>>>> deal with the wakeup IRQs?
>>>>
>>>> For example, how is GPIO irqs dealt with in this regards?
>>>
>>> Interrupt controllers (incl. GPIO) may, depending on SoC type:
>>>   - be located in a controllable power area (SH/R-Mobile),
>>>   - may run from a controllable module clock (SH/R-Mobile, R-Car Gen2/Gen3,
>>>     RZ/A1, RZ/G1).
>>>
>>> So there are no out-of-band IRQs in the wakeup path, unless on SoCs where
>>> the interrupt controllers are in an always-on power area, AND run from a
>>> fixed clock. I think only R-Car Gen1 falls in that category.
>>> Still, R-Car Gen1 needs active_wakeup for wakeup sources.
>>
>> Perhaps out-of-band IRQ is a too vague term. :-) Anyway, let me
>> elaborate a bit more.
>>
>> Apologize for being so persistent, but I really want to get to bottom with this.
>>
>> According to the statement above, it seems like IRQs (including GPIOs)
>> is controllable from a separate "power area" (or module clock). In
>
> There are two ways to save power: disabling the module clock, and powering
> down the module logic.
>
>> many ARM SoCs that "power area" is a separate piece of external logic,
>> sometimes it may even consist a small co-processor. I guess you
>> already know that, but wanted to point it out for clarity.
>
> Sure.
>
> I think on some older SH/R-Mobile SoCs you can do something similar,
> but even there you have to keep the interrupt controller's power area powered.
> This makes sense, given those SoCs also have an SH core, which could be used
> as the small co-processor that powers down the whole ARM subsystem and
> handles wakeup through the SH subsystem's interrupt controller.
>
>> For that reason, some serial drivers re-routs its serial rx pin to a
>> GPIO IRQ to deal with wakeup, instead of keeping the serial device
>> always powered. This enables the GPIO IRQ to be managed by the
>> external logic, thus allowing the serial device and the PM domain it
>> is attached to, to be powered off. Especially during system suspend,
>> that may avoid wasting lots of power.
>
> Doesn't re-routing a pin to a GPIO require using pinctrl?

Yes.

>
> Here the serial device is the wakeup source, but it doesn't handle wakeup
> itself...

Exactly.

>
>> Another example, where I think a more fine grained method is preferred
>> over using GENPD_FLAG_ACTIVE_WAKEUP, is when an SD card controller has
>> an card detect pin hooked up to a GPIO. Thus the device_may_wakeup()
>> would return true for the SD card controller's struct device, but that
>> does not mean that the device needs to stay powered during system
>> suspend.
>
> This one is more tricky, as I think we're already using a GPIO for CD on
> many boards.
> Then the SD device is the wakeup source, but it doesn't handle wakeup
> itself...

Exactly!

>
> So you not only need a flag to opt-in, but also a flag to opt-out?

>From a genpd point of view, the default method is to trusts the driver
to deal with the wakeup, then it treats the device (and thus the PM
domain) as it can be powered down, even if it is configured as a
wakeup source.

Therefore, I have so far, only seen a reason to enable an opt-in
method, to let drivers instruct genpd that it needs to change its
default behavior.

>
>>> See series "[PATCH/RFC 0/3] renesas: irqchip: Use wakeup_path i.s.o.
>>> explicit clock handling", which includes GPIO interrupts.
>>>
>>>> If that is the case, you should really avoid using the big hammer
>>>> method of setting the GENPD_FLAG_ACTIVE_WAKEUP.
>>>
>>> So I think I do need the big hammer ;-)
>>
>> From a hypothetical point of view, if you were to use the more fine
>> grained method I proposed [1] (or something very similar), how many
>> drivers would you need to change, to be able to remove the current
>> workaround?
>
> I think five:
>
>   - drivers/gpio/gpio-rcar.c
>   - drivers/irqchip/irq-renesas-intc-irqpin.c
>   - drivers/irqchip/irq-renesas-irqc.c
>   - drivers/net/ethernet/renesas/ravb_main.c
>   - drivers/net/ethernet/renesas/sh_eth.c

Great, that sounds quite limited. :-)

>
> Note that while setting the flag wouldn't harm, it would not be necessary for
> gpio-rcar and renesas-intc-irqpin when running on R-Car Gen1.  Not setting it
> means using platform knowledge in a device driver, which is what genpd was
> supposed to solve in the first place, and thus IMHO a layering violation.

The flag (assuming you mean WAKEUP_POWERED), is to allow drivers to
instruct the bus type and PM domain about that it think it uses
"in-band-wakeup". If the bus type and PM domain has additional
knowledge about wakeup configurations, it's free to override that
behavior. So there should be no "layering violation. :-)

In other words, genpd should continue to respect the
GENPD_FLAG_ACTIVE_WAKEUP, but my point is, that I think the flag
should be more carefully set by genpd clients.

Does it make sense?

Kind regards
Uffe
