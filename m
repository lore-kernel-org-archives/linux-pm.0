From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] arm64: dts: r8a7796: Add SYSC PM Domains
Date: Tue, 31 May 2016 11:08:43 +0200
Message-ID: <1464685726-21611-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:49938 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756873AbcEaJIo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 05:08:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm+renesas@opensource.se>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Simon, Magnus,

This patch series adds support for the power areas exposed by the System
Controller on the Renesas R-Car M3-W SoC to the DTS.

This series is against Simon's "[PATCH v3 0/3] arm64: Add Renesas
R8A7796 SoC support".  It has a build and runtime dependency on my series
"[PATCH v2 0/3] soc: renesas: rcar-sysc: Add support for R-Car M3-W power
areas".

For your convenience, I've pushed this series to the
topic/r8a7796-sysc-dt-v1 branch of
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git.
This has been tested on r8a7796/salvator-x.

Thanks!

Geert Uytterhoeven (2):
  arm64: dts: r8a7796: Add SYSC PM Domains
  arm64: dts: r8a7796: Use SYSC "always-on" PM Domain

 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
