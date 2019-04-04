From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC] gpio: pca953x: Configure wake-up path when wake-up is enabled
Date: Thu, 4 Apr 2019 12:24:59 +0700
Message-ID: <CACRpkdbqfJj37vHh3twpojHLoEnmcWqymbD8CYSi4PGPawP1Eg@mail.gmail.com>
References: <20190320103927.21227-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190320103927.21227-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 20, 2019 at 5:39 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> If a device is part of the wake-up path, it should indicate this by
> setting its power.wakeup_path field.  This allows the genpd core code to
> keep the device enabled during system suspend when needed.
>
> As regulators powering devices are not handled by genpd, the driver
> handles these itself, and thus must skip regulator control when the
> device is part of the wake-up path.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Note that I don't really need this on the Renesas Ebisu-4D board, as
> there is no regulator or PM Domain controlling power to the GPIO
> expander on that board.  I did want to have all wake-up path processing
> implemented in the driver for completeness, and did test its behavior
> with gpio-keys configured as a wake-up source.
>
> However, while this approach is known to work fine on other boards, with
> other GPIO and interrupt controllers (gpio-rcar, irq-renesas-irqc,
> irq-renesas-intc-irqpin), it wouldn't work on Ebisu-4D, due to different
> device suspend ordering.
>
> The proper ordering is:
>   1. When gpio-keys is suspended, its suspend handler calls
>      enable_irq_wake(), invoking pca953x_irq_set_wake(), and causing
>      pca953x_chip.wakeup_path to be incremented,
>   2. When gpio-pca953x is suspended, it checks pca953x_chip.wakeup_path,
>      and marks the device to be part of the wake-up path.
>
> However, gpio-keys is suspended _after_ gpio-pca953x, breaking the
> scheme :-(
>
> So depending on topology, this may work, or not...

This looks like the right way to do it to me.

Ulf/Rafael: could either of you confirm that this is the right way
to handle it when we have an optional external regulator cutting
power to the chip providing the wakeup like this?

Yours,
Linus Walleij
