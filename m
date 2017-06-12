From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] renesas: sysc: Use GENPD_FLAG_ALWAYS_ON
Date: Mon, 12 Jun 2017 11:23:44 +0200
Message-ID: <1497259427-8299-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi Simon, Magnus,

Commit ffaa42e8a40b7f10 ("PM / Domains: Enable users of genpd to specify
always on PM domains") introduced a new flag GENPD_FLAG_ALWAYS_ON, which
allows to remove some code for drivers handling always-on PM domains.

This series does that for the Renesas R-Car SYSC driver (used on R-Car
Gen2 and Gen3, and RZ/G1) and the R-Mobile SYSC driver (used on R-Mobile
APE6 and A1, and SH-Mobile AG5).

Note that on R/SH-Mobile, the PM domain containing the serial console is
still handled locally.

Tested on:
  - r8a7790/koelsch and r8a7795/salvator-x,
  - r8a73a4/ape6evm, r8a7740/armadillo, sh73a0/kzm9g.

Thanks!

Geert Uytterhoeven (2):
  soc: renesas: rcar-sysc: Use GENPD_FLAG_ALWAYS_ON
  ARM: shmobile: pm-rmobile: Use GENPD_FLAG_ALWAYS_ON

 arch/arm/mach-shmobile/pm-rmobile.c | 19 ++++---------------
 drivers/soc/renesas/rcar-sysc.c     | 28 ++++------------------------
 drivers/soc/renesas/rcar-sysc.h     |  2 --
 3 files changed, 8 insertions(+), 41 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
