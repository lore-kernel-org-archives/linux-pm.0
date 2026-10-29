Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279480;
	b=r+RqDgzb9miSrDBWdY8r2wMhcofRDfo7gwE9GW38nygpwjxg0I4IqIAnSjIUFjtnSom9
	 PNAu0K6s67mdfwgw7h/MySOdXqIcRs0QA+3dydxHT9+/P4P14layCfMEmc3JOP/fN3ksV
	 4rWKvAZfqt6bUV8sSGWyZGc0y5yW1TBz/gcRHyemBW0uxuMLPjMCXMQtb2kMuc1VJzeVV
	 492qZNX9GOrDd1HI5IfpbzZzOEX8mZ4aIX6wOK4vgoci6fnK/LbVToV2pIROenMK8ZybN
	 h0ZYB4L2MtAp56fziRHwr0zktzdghSrLCZRhi8GwE9NYETEShXUc0pDZZYj9T9Vo30g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279480;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XYm4E7ddPJtHvscJKwAMq1HRd8n6x2iQLhZvXJsJXDo=;
	b=T0pdovi4Xp6+E3mHDxKD8uC6tu7zSPNmTU2fyv3y3cNHOzDNDXb8q1rM2BtgSKFDb9LG
	 wXOYZkmfkec8WygfrCIlPRfwAAkQjX+2ojc/BGCJcIPUD3y6ClN4xaBgcuCTPwcJNkx7P
	 OvTVuki79H6HtcquFEJL2RE+pVvukxn5jJcrdHNKAfsNge0Ldmw2EHK6632dlX6GNhFIo
	 jaJBnpHb0IgO01VXuWUBKh6+EQDkXyCsVtVPolug42Cfgkmvn4YaqYT0/TbM27DzncpzR
	 N/uQEBpX9/H/IkY3ypSnctsDPXK55W6WLsKk2nSiKRpRGgy/LAHL14CyeUO/SSS4bbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536F606A31A;
	Thu, 29 Oct 2026 13:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297021F01825;
	Thu, 29 Oct 2026 13:11:16 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Biju Das <biju.das.au@gmail.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/9] arm64: renesas: r8a78000: Add PWM support
Date: Thu, 29 Oct 2026 14:11:01 +0100
Message-ID: <cover.1793278754.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series adds CAN-FD support for the Renesas R-Car X5H SoC, as
found on the Renesas Ironhide development board.  On this board, clocks,
power-domains, and resets must be accessed only through SCMI firmware.

Just like its GPIO[1] and PWM[2] counterparts, this series is a bit
special, in that several patches are not meant to be applied upstream
yet:
  1. The first RFC patch documents support for CAN-FD on R-Car X5H,
  2. Patches 2-4, targeting the can tree, add driver support for CAN-FD
     on R-Car X5H,
  3. Patch 5, targeting a shared DT bindings branch, adds a CAN-FD clock
     definition,
  4. RFC patch 6 adds CAN-FD device nodes to the R-Car X5H .dtsi file,
  5. The remaining patches are marked DNI, and depend on code or DTS
     that is not yet upstream.  More detail can be found in the
     individual patches.

CAN-FD channels 1 to 6 and 12 to 15 have been tested on Ironhide using
canfdtest and an oscilloscope.

Thanks for your comments!

[1] "[PATCH 0/7] arm64: renesas: r8a78000: Enable GPIO support"
    https://lore.kernel.org/cover.1792776697.git.geert+renesas@glider.be
[2] "[PATCH 00/11] arm64: renesas: r8a78000: Add PWM support"
    https://lore.kernel.org/cover.1793026273.git.geert+renesas@glider.be

Geert Uytterhoeven (9):
  [RFC] dt-bindings: can: renesas,rcar-canfd: Document R-Car X5H support
  can: rcar_canfd: Add Runtime PM support
  can: rcar_canfd: Make clkp local
  can: rcar_canfd: Add support for R-Car Gen5
  dt-bindings: clock: renesas,r8a78000-cpg: Add CAN-FD clock
  [RFC] arm64: dts: renesas: r8a78000: Add CAN-FD nodes
  [DNI] clk: renesas: r8a78000: Add CAN-FD clocks
  [DNI] pmdomain: renesas: r8a78000: Add CAN-FD support
  [DNI] arm64: dts: renesas: ironhide: Enable CAN-FD

 .../bindings/net/can/renesas,rcar-canfd.yaml  |  84 +++++++
 .../boot/dts/renesas/r8a78000-ironhide.dts    | 117 ++++++++-
 arch/arm64/boot/dts/renesas/r8a78000.dtsi     | 235 ++++++++++++++++++
 drivers/clk/renesas/r8a78000-cpg.c            |   5 +
 drivers/net/can/rcar/rcar_canfd.c             |  43 +++-
 drivers/pmdomain/renesas/r8a78000-mdlc.c      |   2 +
 .../dt-bindings/clock/renesas,r8a78000-cpg.h  |   1 +
 7 files changed, 476 insertions(+), 11 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
