From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/RFC 00/15] ARM: shmobile: R-Car: Add SYSC PM Domain DT Support
Date: Thu,  4 Jun 2015 20:53:26 +0200
Message-ID: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

	Hi all,

The Renesas R-Car System Controller, as found in Renesas R-Car Gen1 and
Gen2 SoCs, provides power management for the CPU cores and various
coprocessors.

This RFC patch series adds preliminary DT support for the R-Car SYSC,
using the generic PM Domain.

Special cases, like PM domains containing CPU cores or SCUs, are
handled by scanning the DT topology.

The SYSCIER register value is derived from the PM domains found in DT,
which will allow to get rid of the hardcoded values in pm-rcar-gen2.c.
However, this means we have to scan for PM domains even if CONFIG_PM=n.
One step closer to making CONFIG_PM mandatory (and getting rid of
drivers/sh/pm_runtime.c ;-)?

Patches:
  - Patch 1 adds the DT binding documentation (alternatives I considered
    below the "---"-line),
  - Patch 2 contains the driver implementation,
  - Patches 3-6 add device nodes for the L2 cache-controller nodes, as
    R-Car Gen2 has separate power domains for the Cortex-A15 and/or
    Cortex-A7 L2 cache/SCU-combos,
  - Patches 7-10 add links from the CPU nodes to the L2 cache-controller
    nodes, and adds L1 cache information while we're at it,
  - Patches 11-15 add the SYSC PM domains themselves to the various dtsi
    files.

Questions:
  - What are the bindings for Cortex-A15/A7 L2 cache-controller nodes?
    For now I used 'compatible = "cache"', and some fairly standard
    properties.
  - Let's see how/if this integrates with "[PATCH RFC 0/3] PM / Domains:
    Generic PM domains for cpus" from Lina Iyer
    (http://www.spinics.net/lists/arm-kernel/msg423430.html)

Known issues:
  - Although this supports R-Car H1 (r8a7779), the DT PM domain code
    conflicts with the current setup code in pm-r8a7779, which is used
    regardless of DT,
  - This needs better integration with the PM code in pm-rcar-gen2, and
    the SMP code in smp-r8a7790.

Dependencies:
  - This is based on Simon Horman's renesas-devel-20150603-v4.1-rc6,
  - Series "[PATCH 00/11] ARM: shmobile: R-Mobile / R-Car PM Domain
    improvements", which I've just posted to linux-sh (only matters if
    you want to apply this series, not for the casual reviewer).

This was tested on r8a7791/koelsch.

Thanks for your comments!

Geert Uytterhoeven (15):
  PM / Domains: Add DT bindings for the R-Car System Controller
  ARM: shmobile: R-Car: Add DT support for PM domains
  ARM: shmobile: r8a7790 dtsi: Add L2 cache-controller nodes
  ARM: shmobile: r8a7791 dtsi: Add L2 cache-controller node
  ARM: shmobile: r8a7793 dtsi: Add L2 cache-controller node
  ARM: shmobile: r8a7794 dtsi: Add L2 cache-controller node
  ARM: shmobile: r8a7790 dtsi: Add L1 cache information to CPU nodes
  ARM: shmobile: r8a7791 dtsi: Add L1 cache information to CPU nodes
  ARM: shmobile: r8a7793 dtsi: Add L1 cache information to CPU node
  ARM: shmobile: r8a7794 dtsi: Add L1 cache information to CPU nodes
  ARM: shmobile: r8a7779 dtsi: Add SYSC PM domains
  ARM: shmobile: r8a7790 dtsi: Add SYSC PM domains
  ARM: shmobile: r8a7791 dtsi: Add SYSC PM domains
  ARM: shmobile: r8a7793 dtsi: Add SYSC PM domains
  ARM: shmobile: r8a7794 dtsi: Add SYSC PM domains

 .../bindings/power/renesas,sysc-rcar.txt           |  82 ++++++
 arch/arm/boot/dts/r8a7779.dtsi                     |  48 ++++
 arch/arm/boot/dts/r8a7790.dtsi                     | 193 +++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi                     |  73 +++++
 arch/arm/boot/dts/r8a7793.dtsi                     |  61 +++++
 arch/arm/boot/dts/r8a7794.dtsi                     |  71 +++++
 arch/arm/mach-shmobile/pm-rcar.c                   | 299 +++++++++++++++++++++
 7 files changed, 827 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
