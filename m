From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC v2] gpio: rcar: Add Runtime PM handling for interrupts
Date: Thu, 25 Feb 2016 15:26:15 +0100
Message-ID: <CAMuHMdXSHPbdPXRQFwV=4yHwrd858Sk8HU15px4a9GVSmgPs4w@mail.gmail.com>
References: <1455811590-15836-1-git-send-email-geert+renesas@glider.be>
	<CACRpkdZw+2s77+5UO6x91FTuTgA86Y-Brxd=ZziTGE8AuUPgLA@mail.gmail.com>
	<CAMuHMdV=6G-7Y3kFOaeffCgFzStmFQfDO6othA3up6G7ahqPzQ@mail.gmail.com>
	<CACRpkdafH1mU7Z3P=w9bJUqijEFQFmkVvR4p-OTy4XiOqL3Rrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdafH1mU7Z3P=w9bJUqijEFQFmkVvR4p-OTy4XiOqL3Rrw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Wolfram Sang <wsa@the-dreams.de>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Linus,

On Thu, Feb 25, 2016 at 3:19 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Feb 25, 2016 at 10:37 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Thu, Feb 25, 2016 at 10:07 AM, Linus Walleij
>> <linus.walleij@linaro.org> wrote:
>>> On Thu, Feb 18, 2016 at 5:06 PM, Geert Uytterhoeven
>>> <geert+renesas@glider.be> wrote:
>>>
>>>> The R-Car GPIO driver handles Runtime PM for requested GPIOs only.
>>>>
>>>> When using a GPIO purely as an interrupt source, no Runtime PM handling
>>>> is done, and the GPIO module's clock may not be enabled.
>>>>
>>>> To fix this:
>>>>   - Add .irq_request_resources() and .irq_release_resources() callbacks
>>>>     to handle Runtime PM when an interrupt is requested,
>>>>   - Add irq_bus_lock() and sync_unlock() callbacks to handle Runtime PM
>>>>     when e.g. disabling/enabling an interrupt, or configuring the
>>>>     interrupt type.
>>>>
>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>
>>> Patch applied with Marc's ACK.
>>
>> Thanks!
>>
>> Can we have it in v4.5? Else Ethernet won't work on r8a7795/salvator-x.
>
> Argh that is late. But I'll move it over to the fixes branch...

Thanks!

The issue was exposed by commit d5c3d84657db57bd ("net: phy: Avoid polling
PHY with PHY_IGNORE_INTERRUPTS"), which went upstream only in v4.5-rc3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
