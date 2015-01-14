From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/4] ARM: shmobile: Add DT support for memory controllers
Date: Wed, 14 Jan 2015 12:12:58 +0100
Message-ID: <1421233982-15883-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi Simon, Magnus,

This patch series adds DT binding documentation and devices nodes to
describe memory-controllers in R-Mobile and SH-Mobile SoCs.

Currently memory controller device nodes are used only to reference PM
domains, and prevent these PM domains from being powered down, which
would crash the system.

As such this series is a prerequisite for adding DT PM domain support to
sh73a0 (SH-Mobile AG5) and r7a73a4 (R-Mobile APE6).
For r8a7740 (R-Mobile A1), this wasn't a hard prerequisite for PM
domain support, as the A4S PM domain is never turned off anyway
because its child PM domain A3SM contains the CPU core.

The patches for sh73a0 and r8a7740 have been sent before as part of
(patches in) the series "[PATCH RFC 0/7] ARM: shmobile: sh73a0: DT PM
domain support" (https://lkml.org/lkml/2014/11/19/404).

"ARM: shmobile: r8a7740 dtsi: Add memory-controller node" depends on
the DT R-Mobile PM Domain support for r8a7740 that's queued up in
Simon's tree under tag renesas-dt-pm-for-v3.20, as the
memory-controller node already contains a power-domains property.

The two other dtsi patches do not add power-domains properties yet.
These will be added when adding PM domain support for sh73a0 resp.
r8a73a4.

Thanks!

Geert Uytterhoeven (4):
  ARM: shmobile: Add DT bindings for Renesas memory controllers
  ARM: shmobile: r8a73a4 dtsi: Add memory-controller nodes
  ARM: shmobile: r8a7740 dtsi: Add memory-controller node
  ARM: shmobile: sh73a0 dtsi: Add memory-controller nodes

 .../renesas-memory-controllers.txt                 | 44 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a73a4.dtsi                     | 10 +++++
 arch/arm/boot/dts/r8a7740.dtsi                     |  6 +++
 arch/arm/boot/dts/sh73a0.dtsi                      | 16 ++++++++
 4 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas-memory-controllers.txt

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
