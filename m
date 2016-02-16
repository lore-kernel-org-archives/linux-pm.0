From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/4] Enable PM and PM_GENERIC_DOMAINS for SoCs with PM Domains
Date: Tue, 16 Feb 2016 16:31:48 +0100
Message-ID: <1455636712-3040-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi Simon, Magnus,

All supported Renesas ARM SoCs (except for Emma Mobile EV2) have clock
domains. Some SoCs also have power domains. To ensure proper operation
of on-SoC modules, module clocks must be ungated, and power domains must
be powered up when needed.

Currently the user can choose to build a kernel with power management
enabled or disabled:
  - If CONFIG_PM=y, power domains and/or module clocks are handled
    dynamically by Runtime PM and the generic power domain.
  - If CONFIG_PM=n, power domains are assumed to be powered up by reset
    state or by the boot loader, and module clocks are handled by the
    legacy clock domain on driver (un)bind.
    The latter is implemented using a platform bus notifier, which
    applies not only to all on-SoC devices, but to all platform devices
    present in the system.

To remove the dependency on implicit assumptions, and to get rid of the
peculiarities of the legacy clock domain, enable CONFIG_PM and
CONFIG_PM_GENERIC_DOMAINS unconditionally, for all Renesas ARM SoCs with
clock and/or power domains.

Patches:
  - Patches 1 and 2 enable PM and PM_GENERIC_DOMAINS,
  - Patch 3 removes the now unused legacy clock domain code for Renesas
    ARM SoCs,
  - Patch 4 relieves you from maintaining drivers/sh/, which is no
    longer used on Renesas ARM SoCs, and returns it to the SuperH
    people.

Notes:
  - This does cause an increase in kernel size.  Given bloat-o-meter
    reports a modest increase of 26 KiB for an RZ/A1H kernel, this
    should not be a problem, even when used on RZ/A1H with XIP and
    internal RAM only.
  - Patch 3 does break booting R-Car Gen2 boards using pre-v4.3 DTSes
    that don't have power-domains properties,
  - Patch 3 may unbreak SuperH-based ARCH_SHMOBILE platforms, which were
    probably broken since v4.4 by commit 0ba58de231066e47 ("drivers: sh:
    Get rid of CONFIG_ARCH_SHMOBILE_MULTI"),
  - Currently CONFIG_PM=n doesn't work anyway on r8a7795 as "drivers:
    sh: Handle PM_GENERIC_DOMAINS_OF=n with new r8a7795 CPG/MSSR
    driver" isn't upstream.

For your convenience, I've also pushed this series to
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git#topic/mandatory-pm-v1

Thanks for your comments!

Geert Uytterhoeven (4):
  ARM: shmobile: Enable PM and PM_GENERIC_DOMAINS for SoCs with PM
    Domains
  arm64: renesas: Enable PM and PM_GENERIC_DOMAINS for SoCs with PM
    Domains
  drivers: sh: Stop using the legacy clock domain on ARM
  MAINTAINERS: Drop drivers/sh/ for Renesas ARM

 MAINTAINERS                    |  1 -
 arch/arm/mach-shmobile/Kconfig | 13 ++++++++-----
 arch/arm64/Kconfig.platforms   |  3 ++-
 drivers/Makefile               |  1 -
 drivers/sh/pm_runtime.c        |  9 ---------
 5 files changed, 10 insertions(+), 17 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
