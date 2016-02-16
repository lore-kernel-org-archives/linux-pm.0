From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] gpio: rcar: Add Runtime PM handling for interrupts
Date: Tue, 16 Feb 2016 08:34:07 +0100
Message-ID: <CAMuHMdWwzdq4ohfsvScVh4HVRgRjZ8zbDi8ns=xNd+Nk_+-skg@mail.gmail.com>
References: <1455031183-18294-1-git-send-email-geert+renesas@glider.be>
	<CACRpkdYPdjFzMW7YfObjmmaLk9=K-DkyJprsz0v0eAg+c-_y=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36799 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbcBPHeI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2016 02:34:08 -0500
In-Reply-To: <CACRpkdYPdjFzMW7YfObjmmaLk9=K-DkyJprsz0v0eAg+c-_y=A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

Hi Linus,

On Mon, Feb 15, 2016 at 11:10 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Tue, Feb 9, 2016 at 4:19 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>
> Quoting in verbatim as we add new recipients.
>
> I don't know about any runtime_pm_get():s from the irqchip functions:
> Ulf and others are discussing with Thomas Gleixner about a more general
> solution here.
>
> But since it's a regression I guess we need quick decisions.
>
>> The R-Car GPIO driver handles Runtime PM for requested GPIOs only.
>>
>> When using a GPIO purely as an interrupt source, no Runtime PM handling
>> is done, and the GPIO module's clock may not be enabled.
>>
>> To fix this:
>>   - Add .irq_request_resources() and .irq_release_resources() callbacks
>>     to handle Runtime PM when an interrupt is requested,
>
> This is pretty OK since they are slowpath.
>
>>   - Runtime-resume the device before writing to the GPIO module's
>>     registers for disabling/enabling an interrupt, or for configuring
>>     the interrupt type,
>
> Will that have *any* effect now that .irq_request_resources has increased
> usecount to 1?
>
> Isn't it enough with the patches to .irq_request/release_resources to get
> this working?

The registers are also being written to to:
  1. Disable the IRQ,
  2. Set the type.

Unfortunately .irq_request() is the third step, not the first.

>>   - Add checks to warn when the GPIO module's registers are accessed
>>     while the device is runtime-suspended.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> This fixes ravb Ethernet on r8a7795/Salvator-X, which was "broken" by
>> commit d5c3d84657db57bd ("net: phy: Avoid polling PHY with
>> PHY_IGNORE_INTERRUPTS").
>>
>> Does it also fix the HDMI interrupt on r8a7791/Koelsch?
>>
>> Notes:
>>   1. I assume gpio_rcar_irq_{dis,en}able() may be called from contexts
>>      where pm_runtime_get_sync() may not be called.
>>      However, so far I didn't see any reports from the might_sleep_if()
>>      check in __pm_runtime_resume(),
>>   2. gpio_rcar_irq_disable() is called from the IRQ core before
>>      gpio_rcar_irq_set_type().
>>      Else an alternative solution could be to just runtime-resume the
>>      device from gpio_rcar_irq_set_type() when an interrupt is setup,
>>      and never call pm_runtime_put() again. That would cause issues when
>>      compiling gpio-rcar as a module, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
