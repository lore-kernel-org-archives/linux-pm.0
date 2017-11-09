From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 0/3] renesas: irqchip: Use wakeup_path i.s.o. explicit clock handling
Date: Thu,  9 Nov 2017 14:48:30 +0100
Message-ID: <1510235313-32445-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi all,

If an interrupt controller in a Renesas ARM SoC is part of a Clock
Domain, and it is part of the wakeup path, it must be kept active during
system suspend.

Currently this is handled in all interrupt controller drivers by
explicitly increasing the use count of the module clock when the device
is part of the wakeup path.  However, this explicit clock handling is
merely a workaround for a failure to properly communicate wakeup
information to the device core.

Hence this series fixes the affected drivers by setting the devices'
power.wakeup_path fields instead, to indicate they are part of the
wakeup path.  Depending on the PM Domain's active_wakeup configuration,
the genpd core code will keep the device enabled (and the clock running)
during system suspend when needed.

Note that most of these patches depend on the series "[PATCH v2 0/3] PM
/ Domain: renesas: Fix active wakeup behavior", hence they should not be
applied yet.

This has been tested on r8a73a4/ape6evm, r8a7740/armadillo,
r8a7791/koelsch, r8a7795/salvator-x and -xs, r8a7796/salvator-x, and
sh73a0/kzm9g.

Thanks for your comments!

Geert Uytterhoeven (3):
  irqchip/renesas-intc-irqpin: Use wakeup_path i.s.o. explicit clock
    handling
  irqchip/renesas-irqc: Use wakeup_path i.s.o. explicit clock handling
  gpio: rcar: Use wakeup_path i.s.o. explicit clock handling

 drivers/gpio/gpio-rcar.c                  | 43 +++++++++++++----------------
 drivers/irqchip/irq-renesas-intc-irqpin.c | 45 +++++++++++++------------------
 drivers/irqchip/irq-renesas-irqc.c        | 35 ++++++++++++------------
 3 files changed, 54 insertions(+), 69 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
