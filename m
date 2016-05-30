From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/3]  soc: renesas: rcar-sysc: Add support for R-Car M3-W power areas
Date: Mon, 30 May 2016 19:05:08 +0200
Message-ID: <1464627911-8126-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm+renesas@opensource.se>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi Simon, Magnus,

This patch series adds support for the power areas exposed by the System
Controller on the Renesas R-Car M3-W SoC. This is a prerequisite for
enabling devices (e.g. VSP and FCP) that reside in power areas.

/sys/kernel/debug/pm_genpd/pm_genpd_summary output:

    domain                          status          slaves
	/device                                             runtime status
    ----------------------------------------------------------------------
    clock-controller                on              
    a3ir                            off-0           
    3dg-b                           off-0           
    3dg-a                           off-0           3dg-b
    a2vc1                           off-0           
    a2vc0                           off-0           
    a3vc                            off-0           a2vc0, a2vc1
    cr7                             off-0           
    ca53-cpu3                       on              
    ca53-cpu2                       on              
    ca53-cpu1                       on              
    ca53-cpu0                       on              
    ca53-scu                        on              ca53-cpu0, ca53-cpu1, ca53-cpu2, ca53-cpu3
    ca57-cpu1                       on              
    ca57-cpu0                       on              
    ca57-scu                        on              ca57-cpu0, ca57-cpu1
    always-on                       on              ca57-scu, ca53-scu, cr7, a3vc, 3dg-a, a3ir
	/devices/platform/soc/e6e88000.serial               active

Changes compared to v1:
  - Add Acked-by.

For your convenience, I've pushed this series to the
topic/r8a7796-sysc-v2 branch of
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git.
This has been tested on r8a7796/salvator-x, and the code (minus the
acks, i.e. v1), has been part of renesas-drivers since 2016-05-10.

Thanks!

Geert Uytterhoeven (3):
  soc: renesas: rcar-sysc: Document r8a7796 support
  soc: renesas: Add r8a7796 SYSC PM Domain Binding Definitions
  soc: renesas: rcar-sysc: Add support for R-Car M3-W power areas

 .../bindings/power/renesas,rcar-sysc.txt           |  1 +
 drivers/soc/renesas/Makefile                       |  1 +
 drivers/soc/renesas/r8a7796-sysc.c                 | 48 ++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c                    |  3 ++
 drivers/soc/renesas/rcar-sysc.h                    |  1 +
 include/dt-bindings/power/r8a7796-sysc.h           | 36 ++++++++++++++++
 6 files changed, 90 insertions(+)
 create mode 100644 drivers/soc/renesas/r8a7796-sysc.c
 create mode 100644 include/dt-bindings/power/r8a7796-sysc.h

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
