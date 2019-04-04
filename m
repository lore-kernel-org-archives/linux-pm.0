From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RFC] gpio: pca953x: Configure wake-up path when wake-up is enabled
Date: Thu, 4 Apr 2019 11:06:35 +0200
Message-ID: <CAMuHMdVMOo2R2ehuU9XiVy0NS9J=mJkx0Mo-rsT=OBs-1kvH=Q@mail.gmail.com>
References: <20190320103927.21227-1-geert+renesas@glider.be> <CAPDyKFpecPdcqagc567kZJeWbe6y_0j9JAVKcE6c9Ltv+OG-Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpecPdcqagc567kZJeWbe6y_0j9JAVKcE6c9Ltv+OG-Yw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On Thu, Apr 4, 2019 at 10:55 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 20 Mar 2019 at 11:39, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > If a device is part of the wake-up path, it should indicate this by
> > setting its power.wakeup_path field.  This allows the genpd core code to
> > keep the device enabled during system suspend when needed.
> >
> > As regulators powering devices are not handled by genpd, the driver
> > handles these itself, and thus must skip regulator control when the
> > device is part of the wake-up path.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Note that I don't really need this on the Renesas Ebisu-4D board, as
> > there is no regulator or PM Domain controlling power to the GPIO
> > expander on that board.  I did want to have all wake-up path processing
> > implemented in the driver for completeness, and did test its behavior
> > with gpio-keys configured as a wake-up source.
>
> All above makes perfect sense to me.

> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

> > However, while this approach is known to work fine on other boards, with
> > other GPIO and interrupt controllers (gpio-rcar, irq-renesas-irqc,
> > irq-renesas-intc-irqpin), it wouldn't work on Ebisu-4D, due to different
> > device suspend ordering.
> >
> > The proper ordering is:
> >   1. When gpio-keys is suspended, its suspend handler calls
> >      enable_irq_wake(), invoking pca953x_irq_set_wake(), and causing
> >      pca953x_chip.wakeup_path to be incremented,
> >   2. When gpio-pca953x is suspended, it checks pca953x_chip.wakeup_path,
> >      and marks the device to be part of the wake-up path.
>
> Right.
>
> >
> > However, gpio-keys is suspended _after_ gpio-pca953x, breaking the
> > scheme :-(
>
> Would it make sense to fixup the ordering issue via creating a
> parent/child relationship or setting up a device link?

Could that be due to gpio_keys not having rudimentary Runtime PM support?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
