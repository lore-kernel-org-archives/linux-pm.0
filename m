From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 0/7] PM / Domains: Add DT bindings for the R-Car System Controller
Date: Wed,  9 Mar 2016 20:18:35 +0100
Message-ID: <1457551122-21838-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

	Hi all,

This patch series introduces DT bindings for the R-Car System
Controller.

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

Thanks for your comments!

Geert Uytterhoeven (7):
  PM / Domains: Add DT bindings for the R-Car System Controller
  soc: renesas: Add r8a7779 SYSC PM Domain Binding Definitions
  soc: renesas: Add r8a7790 SYSC PM Domain Binding Definitions
  soc: renesas: Add r8a7791 SYSC PM Domain Binding Definitions
  soc: renesas: Add r8a7793 SYSC PM Domain Binding Definitions
  soc: renesas: Add r8a7794 SYSC PM Domain Binding Definitions
  soc: renesas: Add r8a7795 SYSC PM Domain Binding Definitions

 .../bindings/power/renesas,rcar-sysc.txt           | 48 ++++++++++++++++++++++
 include/dt-bindings/power/r8a7779-sysc.h           | 25 +++++++++++
 include/dt-bindings/power/r8a7790-sysc.h           | 31 ++++++++++++++
 include/dt-bindings/power/r8a7791-sysc.h           | 23 +++++++++++
 include/dt-bindings/power/r8a7793-sysc.h           | 27 ++++++++++++
 include/dt-bindings/power/r8a7794-sysc.h           | 23 +++++++++++
 include/dt-bindings/power/r8a7795-sysc.h           | 42 +++++++++++++++++++
 7 files changed, 219 insertions(+)
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
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
