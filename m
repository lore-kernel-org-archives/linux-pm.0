From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/2] thermal: rcar: Fix crash and restore symmetry
Date: Mon, 23 Feb 2015 16:37:23 +0100
Message-ID: <1424705845-17726-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi,

This series fixes an intermittent crash (NULL pointer dereference) in
the rcar-thermal driver due to a race condition, and restores symmetry
in the error and remove paths.

So far I could trigger the race condition only on r8a73a4, after a soft
power-on reset using either the rmobile-reset driver, or the RESETA_N
button on the ape6evm board.  I could not trigger it on r8a7791.
I haven't tested this on any other r8a779x, or on r8a7779.

This was tested on r8a73a4/ape6evm (fixes the crash) and
r8a7791/koelsch (crash never seen).

Thanks for applying!

Geert Uytterhoeven (2):
  thermal: rcar: Fix race condition between init and interrupt
  thermal: rcar: Make error and remove paths symmetrical with init

 drivers/thermal/rcar_thermal.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
