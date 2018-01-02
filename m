From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/3] gpio: rcar: Use WAKEUP_PATH driver PM flag
Date: Tue, 2 Jan 2018 11:26:55 +0100
Message-ID: <CAJZ5v0jGv4C0e0vk02C_zOk6XdCh_Zho1LG3hwvfBBuXDBh29A@mail.gmail.com>
References: <1514554304-18989-1-git-send-email-ulf.hansson@linaro.org>
 <1514554304-18989-4-git-send-email-ulf.hansson@linaro.org>
 <CACRpkdZCApUP2YnYK09wzn3MOwH2XL3Jmm=FXHtsc2pwLyVNRw@mail.gmail.com> <CAMuHMdVwCmLYxVA0ivrE8MtCUpfVe4PrzTeC7jqqthShOw93JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVwCmLYxVA0ivrE8MtCUpfVe4PrzTeC7jqqthShOw93JA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-gpio@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 2, 2018 at 10:37 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Linus,
>
> On Tue, Jan 2, 2018 at 10:27 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Fri, Dec 29, 2017 at 2:31 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Since commit ab82fa7da4dce5c7 ("gpio: rcar: Prevent module clock disable
>>> when wake-up is enabled"), when a GPIO is used for wakeup, the GPIO block's
>>> module clock (if exists) is manually kept running during system suspend, to
>>> make sure the device stays active.
>>>
>>> However, this explicit clock handling is merely a workaround for a failure
>>> to properly communicate wakeup information to the PM core. Instead, set the
>>> WAKEUP_PATH driver PM flag to indicate that the device is part of the
>>> wakeup path, which further also enables middle-layers and PM domains (like
>>> genpd) to act on this.
>>>
>>> In case the device is attached to genpd and depending on if it has an
>>> active wakeup configuration, genpd will keep the device active (the clock
>>> running) during system suspend when needed. This enables us to remove all
>>> explicit clock handling code from the driver, so let's do that as well.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> [Ulf: Converted to use the WAKEUP_PATH driver PM flag]
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> I guess it is dependent on the other patches?
>
> Yes, it depends on (a) a clock patch queued in clk-next for v4.16, and (b) a PM
> patch introducing WAKEUP_PATH.  Applying it prematurely will cause build
> or runtime issues.

Plus, I'm not going to apply the WAKEUP_PATH thing just yet.

At least not in its current version.

Thanks,
Rafael
