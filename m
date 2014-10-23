From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 00/11] ARM: shmobile: r8a7740/armadillo800eva legacy PM domain support
Date: Thu, 23 Oct 2014 13:18:50 +0200
Message-ID: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
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

More specifically, it
  - Adds missing devices to existing PM domains,
  - Adds missing PM domains, hooking up devices and subdomains.

This series is based on renesas-devel-20141016-v3.17, but working resume from
s2ram depends on a fix for sh_mobile_hdmi which is only in v3.18-rc1.

Changes in v3:
  - Keep D4 PM domain powered, until the ARM debug/perf code uses resource
    management with runtime PM support.

Changes in v2:
  - Dropped FIXMes on behavior that turned out to be expected,
  - Hook up the HDMI-Link hardware block,
  - Really add the A4MP and D4 PM domains, as fixes are available,
  - Move special CPU domain handling from A4S to A3SM.

Please apply, after merging in v3.18-rc1.

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

 arch/arm/mach-shmobile/board-armadillo800eva.c | 12 ++++++-
 arch/arm/mach-shmobile/pm-r8a7740.c            | 44 +++++++++++++++++++++++---
 arch/arm/mach-shmobile/setup-r8a7740.c         | 11 +++++++
 3 files changed, 62 insertions(+), 5 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
