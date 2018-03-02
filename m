From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 3/3] gpio: rcar: Use wakeup_path i.s.o. explicit clock handling
Date: Fri, 2 Mar 2018 09:44:46 +0100
Message-ID: <CACRpkdapq0i1uJwXknHKWsWoobXev885R2JeMZRoXi7ucoTMjA@mail.gmail.com>
References: <1518443713-1835-1-git-send-email-geert+renesas@glider.be>
 <1518443713-1835-4-git-send-email-geert+renesas@glider.be>
 <CACRpkdbnJ7W4EPqXtMAM_z1aO5UpuKh=-CCCSQFEToca1LU2=A@mail.gmail.com> <CAMuHMdUGga9j6FKwKt+jO=kGvJ2+_znkFmfgmYx-_h5oTTs3pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUGga9j6FKwKt+jO=kGvJ2+_znkFmfgmYx-_h5oTTs3pw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 2, 2018 at 9:20 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Thu, Mar 1, 2018 at 5:06 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Mon, Feb 12, 2018 at 2:55 PM, Geert Uytterhoeven
>> <geert+renesas@glider.be> wrote:
>>
>>> Since commit ab82fa7da4dce5c7 ("gpio: rcar: Prevent module clock disable
>>> when wake-up is enabled"), when a GPIO is used for wakeup, the GPIO
>>> block's module clock (if exists) is manually kept running during system
>>> suspend, to make sure the device stays active.
>>>
>>> However, this explicit clock handling is merely a workaround for a
>>> failure to properly communicate wakeup information to the device core.
>>>
>>> Instead, set the device's power.wakeup_path field, to indicate this
>>> device is part of the wakeup path.  Depending on the PM Domain's
>>> active_wakeup configuration, the genpd core code will keep the device
>>> enabled (and the clock running) during system suspend when needed.
>>> This allows for the removal of all explicit clock handling code from the
>>> driver.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>> v3:
>>
>> Patch applied for v4.16 fixes.
>
> Are you aware this conflicts with commit 51750fb167a05468 ("gpio: gpio-rcar:
> Support S2RAM") in gpio/for-next?

No but I guess I will become aware.

I have not yet mixed the fixes and devel branches for next.

> You can find the resolution in
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/tree/drivers/gpio/gpio-rcar.c?h=renesas-drivers-2018-02-28-v4.16-rc3

Thanks!

Yours,
Linus Walleij
