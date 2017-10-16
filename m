From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 00/10] PM / Domain: renesas: Fix active wakeup behavior
Date: Mon, 16 Oct 2017 15:55:06 +0200
Message-ID: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:54962 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753032AbdJPNz2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 09:55:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

If a device in a Renesas ARM SoC is part of a Clock Domain, and it is
used as a wakeup source, it must be kept active during system suspend.
         
Currently this is handled in device-specific drivers by explicitly
increasing the use count of the module clock when the device is
configured as a wakeup source.  However, the proper way to prevent the
device from being stopped is to inform this requirement to the genpd
core.  Hence this series does that, so the workarounds can be removed.

This patch series consist of 4 parts:
  1. Patches 1-3 fix the clk-renesas-mstp, clk-renesas-cpg-mssr, and
     rcar-sysc Clock and/or PM Domain drivers by providing
     gpd_dev_ops.active_wakeup() callbacks,

  2. Patch 4 adds a new GENPD_FLAG_ACTIVE_WAKEUP flag, to avoid various
     PM Domain drivers that need similar behavior having to provide
     their own identical .active_wakeup() callbacks,

  3. Patches 5-8 convert PM Domain drivers to use the new
     GENPD_FLAG_ACTIVE_WAKEUP where appropriate (note that patches 6-8
     were separated from patches 1-3 deliberately, to avoid dependencies
     of patches 1-3 on patch 4),

  4. Patches 9-10 remove the no longer needed workarounds from the
     sh_eth and ravb Ethernet drivers.

The first 2 parts can be applied now, independently (to the clk-renesas,
renesas, resp. pm trees).
The last two parts have to wait until the first 2 parts have landed
upstream, hence the "RFC".

Notes:
  - The pm-rmobile driver already provided an .active_wakeup() callback,
    and Wake-on-LAN on r8a7740/armadillo800eva indeed doesn't need the
    workaround in the sh_eth driver,
  - For now, the gpio-rcar, irq-renesas-intc-irqpin, and
    irq-renesas-irqc drivers have to keep their workarounds, as they are
    not wakeup sources in-se, and thus not fixed by this series.

This has been tested on Koelsch with R-Car M2-W, Salvator-X with R-Car
H3 ES1.0 and M3-W ES1.0, and Salvator-XS with R-Car H3 ES2.0, and
regression tested on SH/R-Mobile boards.

For your convenience, this series is also available in the
topic/rcar-genpd-wakeup-v1 branch of my renesas-drivers git
repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.

Thanks for your comments!

Geert Uytterhoeven (10):
  clk: renesas: mstp: Keep wakeup sources active during system suspend
  clk: renesas: cpg-mssr: Keep wakeup sources active during system
    suspend
  soc: renesas: rcar-sysc: Keep wakeup sources active during system
    suspend
  PM / Domain: Allow genpd users to specify default active wakeup
    behavior
  [RFC] ARM: shmobile: pm-rmobile: Use GENPD_FLAG_ACTIVE_WAKEUP
  [RFC] clk: renesas: mstp: Use GENPD_FLAG_ACTIVE_WAKEUP
  [RFC] clk: renesas: cpg-mssr: Use GENPD_FLAG_ACTIVE_WAKEUP
  [RFC] soc: renesas: rcar-sysc: Use GENPD_FLAG_ACTIVE_WAKEUP
  [RFC] ravb: Remove obsolete explicit clock handling for WoL
  [RFC] sh_eth: Remove obsolete explicit clock handling for WoL

 arch/arm/mach-shmobile/pm-rmobile.c      |  8 +-------
 drivers/base/power/domain.c              |  8 ++++++++
 drivers/clk/renesas/clk-mstp.c           |  2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c   |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c |  8 --------
 drivers/net/ethernet/renesas/sh_eth.c    | 18 +++---------------
 drivers/soc/renesas/rcar-sysc.c          |  2 +-
 include/linux/pm_domain.h                |  7 ++++---
 8 files changed, 19 insertions(+), 36 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
