From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/7] ARM: shmobile: Add IRQC clock to device tree
Date: Wed, 18 Mar 2015 19:55:54 +0100
Message-ID: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:41047 "EHLO
	baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933215AbbCRS4E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 14:56:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi,

This patch series adds the IRQC clock to the device tree on SoCs that
have such a clock (r8a73a4 and r8a779x), and adds mininal runtime PM
support to the renesas-irqc driver, to make sure the clock is enabled
when needed by the external IRQ controller(s).
Before, the clock was assumed enabled by the bootloader or reset state.

As usual when involving clocks, the DTS changes depend stricly on the
driver changes. Else the clock will be disabled as assumed unused,
breaking the boot.

This was tested on r8a73a4/ape6evm and r8a7791/koelsch.

Thanks!

Geert Uytterhoeven (7):
  irqchip: renesas-irqc: Add more register documentation
  irqchip: renesas-irqc: Add minimal runtime PM support
  irqchip: renesas-irqc: Add functional clock to bindings
  ARM: shmobile: r8a7734: Add IRQC clock to device tree
  ARM: shmobile: r8a7790: Add IRQC clock to device tree
  ARM: shmobile: r8a7791: Add IRQC clock to device tree
  ARM: shmobile: r8a7794: Add IRQC clock to device tree

 .../bindings/interrupt-controller/renesas,irqc.txt |  4 +++-
 arch/arm/boot/dts/r8a73a4.dtsi                     | 11 +++++----
 arch/arm/boot/dts/r8a7790.dtsi                     |  9 +++++++
 arch/arm/boot/dts/r8a7791.dtsi                     |  9 +++++++
 arch/arm/boot/dts/r8a7794.dtsi                     |  9 +++++++
 drivers/irqchip/irq-renesas-irqc.c                 | 28 ++++++++++++++++++----
 include/dt-bindings/clock/r8a73a4-clock.h          |  1 +
 include/dt-bindings/clock/r8a7790-clock.h          |  3 +++
 include/dt-bindings/clock/r8a7791-clock.h          |  3 +++
 include/dt-bindings/clock/r8a7794-clock.h          |  3 +++
 10 files changed, 70 insertions(+), 10 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
