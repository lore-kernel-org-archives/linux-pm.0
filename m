From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 00/11] ARM: shmobile: r8a7740/armadillo800eva legacy PM domain support
Date: Thu, 25 Sep 2014 18:15:31 +0200
Message-ID: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi Simon, Magnus,

This series improves PM domain support for r8a7740/armadillo800eva legacy,
mimicking (parts of) the existing PM domain support for sh7372/mackerel.

More specifically, they
  - Add missing devices to existing PM domains,
  - Add missing PM domains, hooking up devices and subdomains,

Changes in v2:
  - Dropped FIXMes on behavior that turned out to be expected,
  - Hook up the HDMI-Link hardware block,
  - Really add the A4MP and D4 PM domains, as fixes are available (see
    dependencies below),
  - Move special CPU domain handling from A4S to A3SM,

There are a few dependencies to make resume from s2ram work:
  - "[PATCH/RFC] fbdev: sh_mobile_hdmi: Re-init regs before irq re-enable on
    resume",
  - "[PATCH] ARM: hw_breakpoint: Trap undef instruction exceptions on wake-up",
    or an alternative solution.

Apart from that, I'm not aware of any regressions (except perhaps for USB,
which I was unable to get working anyway).

Please note that DT/multi-platform PM domain support is added in an (almost)
independent series.

Thanks!

Geert Uytterhoeven (11):
  ARM: shmobile: r8a7740: Add missing A3SP pm domain devices
  ARM: shmobile: r8a7740: Add missing A4S pm domain devices
  ARM: shmobile: armadillo800eva legacy: Add missing A3SP pm domain
    devices
  ARM: shmobile: armadillo800eva legacy: Add missing A4S pm domain
    devices
  ARM: shmobile: r8a7740: Add A3RV pm domain support
  ARM: shmobile: r8a7740: Add A3SG pm domain support
  ARM: shmobile: r8a7740/armadillo legacy: Add A4MP pm domain support
  ARM: shmobile: r8a7740: Add D4 pm domain support
  ARM: shmobile: r8a7740/armadillo legacy: Add A4R pm domain support
  ARM: shmobile: r8a7740: Add A4SU pm domain support
  ARM: shmobile: r8a7740: Add A3SM pm domain support

 arch/arm/mach-shmobile/board-armadillo800eva.c | 12 +++++++++-
 arch/arm/mach-shmobile/pm-r8a7740.c            | 32 ++++++++++++++++++++++----
 arch/arm/mach-shmobile/setup-r8a7740.c         | 11 +++++++++
 3 files changed, 50 insertions(+), 5 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
