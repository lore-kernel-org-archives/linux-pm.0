From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/4] ARM: shmobile: R-Mobile: Add SYSC restart handler
Date: Wed,  3 Dec 2014 15:17:03 +0100
Message-ID: <1417616227-6715-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi Simon, Magnus, Arnd,

This patch series extends the PM domain platform driver for the R-Mobile
System Controller (SYSC) to register a restart handler, and removes the
restart handler hacks on DT-based R-Mobile A1 (r8a7740) and SH-Mobile AG5
(sh73a0) platforms.

Note that this supports DT-based platforms only. Legacy platforms keep
on using the restart callback in struct machine_desc.

This was tested on r8a7740/armadillo-multiplatform,
sh73a0/kzm9g-reference, and sh73a0/kzm9g-multiplatform.

Arnd: is this what you had in mind in your response to "[GIT PULL] Third
Round of Renesas ARM Based Soc Updates for v3.19"
(http://www.spinics.net/lists/arm-kernel/msg379348.html)?

Dependencies:
  - The first two patches depend on the series "[PATCH v6 0/7] ARM:
    shmobile: R-Mobile: DT PM domain support", as that series adds the
    SYSC PM domain platform driver for DT-based platforms and adds the
    SYSC device node to r8a7740.dtsi,
  - The last two patches also depend on the series "[PATCH RFC 0/7] ARM:
    shmobile: sh73a0: DT PM domain support", as that series adds the
    SYSC device node to sh73a0.dtsi.

Thanks!

Geert Uytterhoeven (4):
  ARM: shmobile: R-Mobile: Add SYSC restart handler
  ARM: shmobile: r8a7740: Remove restart callback
  ARM: shmobile: sh73a0: Remove restart callback
  ARM: shmobile: kzm9g-reference: Remove restart callback

 arch/arm/mach-shmobile/board-kzm9g-reference.c |  8 -----
 arch/arm/mach-shmobile/pm-rmobile.c            | 48 +++++++++++++++++++++++++-
 arch/arm/mach-shmobile/setup-r8a7740.c         |  8 -----
 arch/arm/mach-shmobile/setup-sh73a0.c          |  8 -----
 4 files changed, 47 insertions(+), 25 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
