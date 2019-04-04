From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC] gpio: pca953x: Configure wake-up path when wake-up is enabled
Date: Thu, 4 Apr 2019 17:46:14 +0200
Message-ID: <CAPDyKFr7hu+ELfDSgQ+E3D=eNJR_8iJMPSobLpKDJ0Tgw=27vQ@mail.gmail.com>
References: <20190320103927.21227-1-geert+renesas@glider.be>
 <CAPDyKFpecPdcqagc567kZJeWbe6y_0j9JAVKcE6c9Ltv+OG-Yw@mail.gmail.com> <CAMuHMdVMOo2R2ehuU9XiVy0NS9J=mJkx0Mo-rsT=OBs-1kvH=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVMOo2R2ehuU9XiVy0NS9J=mJkx0Mo-rsT=OBs-1kvH=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[...]

> > > However, while this approach is known to work fine on other boards, with
> > > other GPIO and interrupt controllers (gpio-rcar, irq-renesas-irqc,
> > > irq-renesas-intc-irqpin), it wouldn't work on Ebisu-4D, due to different
> > > device suspend ordering.
> > >
> > > The proper ordering is:
> > >   1. When gpio-keys is suspended, its suspend handler calls
> > >      enable_irq_wake(), invoking pca953x_irq_set_wake(), and causing
> > >      pca953x_chip.wakeup_path to be incremented,
> > >   2. When gpio-pca953x is suspended, it checks pca953x_chip.wakeup_path,
> > >      and marks the device to be part of the wake-up path.
> >
> > Right.
> >
> > >
> > > However, gpio-keys is suspended _after_ gpio-pca953x, breaking the
> > > scheme :-(
> >
> > Would it make sense to fixup the ordering issue via creating a
> > parent/child relationship or setting up a device link?
>
> Could that be due to gpio_keys not having rudimentary Runtime PM support?

You are saying that the parent/child relation ship is already there?

In such case, it shouldn't matter whether runtime PM is deployed or
not, the PM core should propagate the wakeup_path flag from children
to parents in __device_suspend() and in device_suspend_late(). If that
doesn't happen there is bug in the PM core.

Kind regards
Uffe
