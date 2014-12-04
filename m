From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] ARM: shmobile: R-mobile: Fix SYSC register lengths
Date: Thu,  4 Dec 2014 13:31:36 +0100
Message-ID: <1417696298-27740-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi Simon, Magnus,

This patch series fixes the register lengths of the SYSC device nodes, by
adding the missing 0x prefixes. They were really intended to be 0x8000, not
8000.
This doesn't cause any problems for now, but at least the second range
is documented to cover the full 32 KiB on R-Mobile A1 (r8a7740).
Sorry for not noticing before.

Perhaps these can still be folded into the commits that introduced the bugs?
  - commit 0f3dad1d6c519ddf ("PM / Domains: Add DT bindings for the R-Mobile
    System Controller"),
  - commit 2f49e6f2721c4344 ("ARM: shmobile: r8a7740 dtsi: Add PM domain
    support").

Thanks!

Geert Uytterhoeven (2):
  PM / Domains: R-Mobile SYSC: Add missing 0x prefixes to example
  ARM: shmobile: r8a7740 dtsi: Add missing 0x prefix to SYSC reg lengths

 Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt | 2 +-
 arch/arm/boot/dts/r8a7740.dtsi                                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
