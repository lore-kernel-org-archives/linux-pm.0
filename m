From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/2] ARM: gic: Document optional Clock and Power Domain properties
Date: Mon, 14 Sep 2015 22:06:42 +0200
Message-ID: <1442261204-30931-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi,

On some SoCs, the GIC may be part of a PM Domain (hardware Power and/or
Clock Domain).  Document the related optional DT properties.

This patch series:
  - Adds support for the PL390 GIC variant, as the PL390 has different
    clock inputs than the A9 MPCore GIC that is currently (incorrectly)
    described in various Renesas DTSes instead,
  - Documents optional Clock and Power Domain properties.

This will allow to properly describe later the relationship between the
GIC and the Clock and/or Power Domain topology on Renesas SoCs, and
prevent clocks from being disabled inadvertently.

This is v2 of "[PATCH] ARM: gic: Document Power and Clock Domain optional
properties" (https://lkml.org/lkml/2015/4/27/401).

Changes since v1:
  - Add "arm,pl390",
  - Add "clock-names" to DT bindings,
  - Document clock inputs on various GIC variants.

Thanks for your comments!

Geert Uytterhoeven (2):
  irqchip: gic: Add arm,pl390 support
  irqchip: gic: Document optional Clock and Power Domain properties

 Documentation/devicetree/bindings/arm/gic.txt | 24 ++++++++++++++++++++----
 drivers/irqchip/irq-gic.c                     |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
