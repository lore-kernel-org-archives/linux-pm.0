From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 0/6] ARM/arm64: dts: rcar: Add SYSC PM domains
Date: Wed,  9 Mar 2016 20:18:49 +0100
Message-ID: <1457551135-22078-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi all,

This patch series adds the R-Car System Controller to the DTS files for
the various R-Car SoCs, and hooks up devices to their respective PM
domains.

This is a dependency for the enablement of DU and VSP on R-Car H3, as
the VSPs are located in a PM Domain.

Changes compared to v2:
  - Move power area hierarchy from DT to C (cfr. DT bindings for Renesas
    CPG/MSSR), and switch to "#power-domain-cells = <1>",
  - Drop fallback compatibility strings, as the bindings are
    SoC-specific,
  - Add an "always-on" power area on R-Car H3.

Changes compared to v1:
  - Add R-Car H3 (r8a7795) support,
  - Use "renesas,<type>-sysc" instead of "renesas,sysc-<type>",
  - Add fallback compatibility strings for R-Car Gen2 and Gen3.

Dependencies:
  - renesas-devel-20160307-v4.5-rc7,
  - clk/clk-next with "[PATCH v2] clk: renesas: Rename header file
    renesas.h" applied,
  - "[PATCH 0/4] clk: renesas: PM Domain Cleanups and Preparation".
  - "[PATCH v3 0/7] PM / Domains: Add DT bindings for the R-Car System
    Controller",
  - "[PATCH v3 00/11] soc: renesas: Add R-Car SYSC PM Domain Support".
Note that these are hard dependencies: adding SYSC PM Domains to DTS
files without driver support cause breakage!

For your convenience, I've pushed this, incl. all dependencies, to the
topic/rcar-sysc-pd-v3 branch of
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git

Thanks for your comments!

Geert Uytterhoeven (6):
  ARM: dts: r8a7779: Add SYSC PM domains
  ARM: dts: r8a7790: Add SYSC PM domains
  ARM: dts: r8a7791: Add SYSC PM domains
  ARM: dts: r8a7793: Add SYSC PM domains
  ARM: dts: r8a7794: Add SYSC PM domains
  arm64: dts: r8a7795: Add SYSC PM domains

 arch/arm/boot/dts/r8a7779.dtsi           |  10 +++
 arch/arm/boot/dts/r8a7790.dtsi           |  17 +++++
 arch/arm/boot/dts/r8a7791.dtsi           |  10 +++
 arch/arm/boot/dts/r8a7793.dtsi           |   9 +++
 arch/arm/boot/dts/r8a7794.dtsi           |  10 +++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 115 +++++++++++++++++--------------
 6 files changed, 120 insertions(+), 51 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
