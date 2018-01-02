From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 3/3] gpio: rcar: Use WAKEUP_PATH driver PM flag
Date: Tue, 2 Jan 2018 10:27:00 +0100
Message-ID: <CACRpkdZCApUP2YnYK09wzn3MOwH2XL3Jmm=FXHtsc2pwLyVNRw@mail.gmail.com>
References: <1514554304-18989-1-git-send-email-ulf.hansson@linaro.org> <1514554304-18989-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1514554304-18989-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-gpio@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 29, 2017 at 2:31 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> From: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Since commit ab82fa7da4dce5c7 ("gpio: rcar: Prevent module clock disable
> when wake-up is enabled"), when a GPIO is used for wakeup, the GPIO block's
> module clock (if exists) is manually kept running during system suspend, to
> make sure the device stays active.
>
> However, this explicit clock handling is merely a workaround for a failure
> to properly communicate wakeup information to the PM core. Instead, set the
> WAKEUP_PATH driver PM flag to indicate that the device is part of the
> wakeup path, which further also enables middle-layers and PM domains (like
> genpd) to act on this.
>
> In case the device is attached to genpd and depending on if it has an
> active wakeup configuration, genpd will keep the device active (the clock
> running) during system suspend when needed. This enables us to remove all
> explicit clock handling code from the driver, so let's do that as well.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [Ulf: Converted to use the WAKEUP_PATH driver PM flag]
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess it is dependent on the other patches?

If you want me to just apply it to the GPIO tree, tell me.

Yours,
Linus Walleij
