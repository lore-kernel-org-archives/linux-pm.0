From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] thermal: rcar: Fix crash and restore symmetry
Date: Wed,  4 Feb 2015 13:22:33 +0100
Message-ID: <1423052555-14792-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:54157 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965590AbbBDMWm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 07:22:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-pm@vger.kernel.org, linux-shvger.kernel.org@ramsan.of.borg, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi,

This series fixes an intermittent crash (NULL pointer dereference) in
the rcar-thermal driver due to a race condition, and restores symmetry
in the error and remove paths.

So far I could trigger the race condition only on r8a73a4, and only
after a soft power-on reset using the rmobile-reset driver, which is
queued for v3.20. I could not trigger it on r8a7791.
I haven't tested this on any other r8a779x, or on r8a7779.
Hence I'm not sure it's worthwhile adding this to -stable yet.

This was tested on r8a73a4/ape6evm (fixes the crash) and
r8a7791/koelsch (crash not seen).

Thanks!

Geert Uytterhoeven (2):
  thermal: rcar: Fix race condition between init and interrupt
  thermal: rcar: Restore symmetry in error and remove paths

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
