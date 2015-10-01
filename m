From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] dmaengine: usb-dmac: Runtime PM Related Fixes
Date: Thu,  1 Oct 2015 09:22:16 +0200
Message-ID: <1443684138-32252-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:45816 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468AbbJAHWM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 03:22:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, dmaengine@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Vinod, Shimoda-san,

This series fixes a crash and an imbalance in the usb-dmac driver.

Geert Uytterhoeven (2):
  dmaengine: usb-dmac: Fix crash on runtime suspend
  dmaengine: usb-dmac: Fix pm_runtime_{enable,disable}() imbalance

 drivers/dma/sh/usb-dmac.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
