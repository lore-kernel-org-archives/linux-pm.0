From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 0/5] ARM: shmobile: Add INTC-SYS clock to device tree
Date: Wed, 18 Mar 2015 20:15:59 +0100
Message-ID: <1426706164-28309-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:36140 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933229AbbCRTQO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 15:16:14 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi,

This RFC patch series adds the INTC-SYS clock to the device tree on SoCs
that have such a clock (r8a73a4 and r8a779x). This clock is the module
clock for the GIC, and thus must not be disabled, as that would cause a
lock-up.

Currently, the GIC driver cannot enable the module clock for several
reasons:
  - It does not use a platform device, so Runtime PM is not an option,
  - gic_of_init() runs before any clocks are registered, so it cannot
    explicitly enable the clock,
  - gic_of_init() cannot return -EPROBE_DEFER, as IRQCHIP_DECLARE()
    doesn't support deferred probing.

Hence we have to keep on relying on the boot loader for enabling the
module clock.

To prevent the module clock from being disabled when the CCF core thinks
it is unused, and thus causing a system lock-up, add a quirk to the MSTP
clock driver to make sure the module clock is never disabled.

I'm not sure about the parent clock of INTC-SYS, as this doesn't seem to
be documented in the SoC's user manuals. However, on r8a7740 it is
documented to be the ZSA (AXI) clock, so I used the ZS clock. The actual
clock and rate don't matter much, as the parent clock can't be
disabled.

As usual when involving clocks, the DTS changes depend stricly on the
driver change. Else the clock will be disabled as assumed unused,
breaking the boot.

The DTS changes depend on the series "[PATCH 0/7] ARM: shmobile: Add
IRQC clock to device tree" I've just sent.

This was tested on r8a73a4/ape6evm and r8a7791/koelsch.

Thanks for your comments!

Geert Uytterhoeven (5):
  [RFC] clk: shmobile: mstp: Never disable INTC-SYS
  [RFC] ARM: shmobile: r8a73a4: Add INTC-SYS clock to device tree
  [RFC] ARM: shmobile: r8a7790: Add INTC-SYS clock to device tree
  [RFC] ARM: shmobile: r8a7791: Add INTC-SYS clock to device tree
  [RFC] ARM: shmobile: r8a7794: Add INTC-SYS clock to device tree

 arch/arm/boot/dts/r8a73a4.dtsi            | 11 +++++++----
 arch/arm/boot/dts/r8a7790.dtsi            |  7 ++++---
 arch/arm/boot/dts/r8a7791.dtsi            |  7 ++++---
 arch/arm/boot/dts/r8a7794.dtsi            |  7 ++++---
 drivers/clk/shmobile/clk-mstp.c           |  6 ++++++
 include/dt-bindings/clock/r8a73a4-clock.h |  1 +
 include/dt-bindings/clock/r8a7790-clock.h |  1 +
 include/dt-bindings/clock/r8a7791-clock.h |  1 +
 include/dt-bindings/clock/r8a7794-clock.h |  1 +
 9 files changed, 29 insertions(+), 13 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
