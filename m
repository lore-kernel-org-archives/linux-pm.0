From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 0/7] PM / Domains: Add DT bindings for the R-Car System Controller
Date: Wed, 13 Apr 2016 16:44:16 +0200
Message-ID: <1460558663-10197-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:56752 "EHLO
	baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758267AbcDMOoY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2016 10:44:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Simon, Magnus,

This patch series introduces DT bindings for the R-Car System
Controller, as found on Renesas R-Car H1, R-Car Gen2, and R-Car Gen3
SoCs.

Changes compared to v4:
  - Add Reviewed-by,
  - Remove power-domains property from the sysc node again, as the
    System Controller itself is not part of the Clock Domain.

Changes compared to v3:
  - Add Reviewed-by, Acked-by,
  - Compatible value must contain "exactly one" instead of "one or
    more",
  - Add power-domains property to refer to the SoC's Clock Domain,
  - Drop R8A7779_PD_SH, as it's not documented in the datasheet,
  - Rename R8A779*_PD_SH to R8A779*_PD_SH_4A on R-Car Gen2,
  - Add always-on power area on R-Car H1 and R-Car Gen2,
  - Use numbers directly on R-Car M2-N, to make the header file
    self-contained.

Changes compared to v2:
  - Move power area hierarchy from DT to C (cfr. DT bindings for Renesas
    CPG/MSSR), and switch to "#power-domain-cells = <1>",
  - Drop fallback compatibility strings, as the bindings are
    SoC-specific,
  - Drop power area A3SH on R-Car H3, as it's no longer
    documented in the datasheet, and touching it seems to crash SYSC,
  - Add an "always-on" power area on R-Car H3,
  - Rename from renesas,sysc-rcar.txt to renesas,rcar-sysc.txt,
  - Extract bindings into a separate series (was "[PATCH/RFC v2 00/11]
    ARM/arm64: renesas: Add SYSC PM Domain DT Support",
    http://www.spinics.net/lists/arm-kernel/msg483199.html).

Changes compared to v1:
  - Add R-Car H3 (r8a7795) support,
  - Use "renesas,<type>-sysc" instead of "renesas,sysc-<type>",
  - Add fallback compatibility strings for R-Car Gen2 and Gen3.

Thanks for appplying!

Geert Uytterhoeven (7):
  PM / Domains: Add DT bindings for the R-Car System Controller
  soc: renesas: Add r8a7779 SYSC PM Domain Binding Definitions
  soc: renesas: Add r8a7790 SYSC PM Domain Binding Definitions
  soc: renesas: Add r8a7791 SYSC PM Domain Binding Definitions
  soc: renesas: Add r8a7793 SYSC PM Domain Binding Definitions
  soc: renesas: Add r8a7794 SYSC PM Domain Binding Definitions
  soc: renesas: Add r8a7795 SYSC PM Domain Binding Definitions

 .../bindings/power/renesas,rcar-sysc.txt           | 48 ++++++++++++++++++++++
 include/dt-bindings/power/r8a7779-sysc.h           | 27 ++++++++++++
 include/dt-bindings/power/r8a7790-sysc.h           | 34 +++++++++++++++
 include/dt-bindings/power/r8a7791-sysc.h           | 26 ++++++++++++
 include/dt-bindings/power/r8a7793-sysc.h           | 28 +++++++++++++
 include/dt-bindings/power/r8a7794-sysc.h           | 26 ++++++++++++
 include/dt-bindings/power/r8a7795-sysc.h           | 42 +++++++++++++++++++
 7 files changed, 231 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
 create mode 100644 include/dt-bindings/power/r8a7779-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7790-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7791-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7793-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7794-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7795-sysc.h

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
