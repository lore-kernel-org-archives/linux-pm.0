Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026536;
	b=dExOGcY10f1lwT50NHFXlnQkmESOGfPFIoS4pyqYxxn4kAmsSygmAA9VhAr4YS2VbEhF
	 m9i3seSjubjlQKnLOhuO4NUISt50nr+h0o1tNRXBG+PIf82VToykzTy58P0vKZjJ+GNJJ
	 jxiFwKqNRuFa9bsGAkBlxObesat388pq5TECU2ywmrSNXubXqtqCUrIzDnEC1FfMdMMf4
	 kvj6wWg+QEu2+PctwUOZdlyWqseDWoBAJv0ambUm0H2tRvmEWoPtxHvQpV1WlHBqXf7Ap
	 7f18X8RxIj92Eg3mytxuXqdQrZTaFUJiMgM++HbAjOEzGr0UxQNCLRfX0PmxzKMFfJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026536;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mbfVeWlSKjBTPDf3UW/JdVQOQzcMJMzpFsXl+aLUPY4=;
	b=YWiuloTgVpLCt0jJvhFD+/UKyb43MrfJxL7EFJAReigHgfjDGjs9LzsK8vxq0jN7ErCM
	 hbmbSofjW1Db3qS4WoM4C5JUNbMEoExuW7d4RBeaA2zK6mqzJPSy1+KPzBsiL8ea65ziu
	 KTRB7s72Z7noKf8XlkuvXps2T8o16bXUdA0APyeCtaKSRqCAiQYj1TnUGqh0nV5fi9DaP
	 FSzrllsKTjGKsTLzvQTdwArt0RsxH/ROXdrQ4aUabt2OrYHBRb/XCHwxmoBOs/xIA0luj
	 Jo09rAUbi2CsBOW7Uje/l5F9PV3OhmqRfwUbgKKqkOl+HK0to7DSiWg/Gbbt2dX9Y9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0C606A31D;
	Mon, 26 Oct 2026 14:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE16E1F01825;
	Mon, 26 Oct 2026 14:55:31 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 00/11] arm64: renesas: r8a78000: Add PWM support
Date: Mon, 26 Oct 2026 15:55:16 +0100
Message-ID: <cover.1793026273.git.geert+renesas@glider.be>
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

This patch series enables PWM support for the Renesas R-Car X5H SoC, as
found on the Renesas Ironhide development board.  On this board, clocks,
power-domains, and resets must be accessed only through SCMI firmware.

Just like its GPIO counterpart[1], this series is a bit special, in that
several patches are not meant to be applied upstream yet:
  1. The first patch, targeting the PWM tree, documents support for the
     16-Bit Timer Pulse Unit (TPU) on R-Car X5H; no driver changes are
     needed,
  2. Patches 2-6, targeting the PWM tree too, document and add support
     for the PWM instances on R-Car X5H, after a few customary
     refactorings,
  3. Patch 7, targeting a shared DT bindings branch, adds PWM clock
     definitions,
  4. Patch 8, targeting renesas-devel, adds the various PWM device nodes
     to the R-Car X5H .dtsi file,
  5. The remaining patches are marked DNI, and depend on code or DTS
     that is not yet upstream.  More detail can be found in the
     individual patches.

PWM instances 0 to 5 and TPU channels 0 and 1 have been tested on
Ironhide using a set of blinkenlights and a logic analyzer.

Thanks for your comments!

[1] "[PATCH 0/7] arm64: renesas: r8a78000: Enable GPIO support"
    https://lore.kernel.org/cover.1792776697.git.geert+renesas@glider.be

Geert Uytterhoeven (10):
  dt-bindings: pwm: renesas,pwm-rcar: Add support for R-Car X5H
  pwm: rcar: Use FIELD_PREP() for PWMCR_CC0 access
  pwm: rcar: Add helper variable dev to rcar_pwm_probe()
  pwm: rcar: Parametrize cycle counter field size
  pwm: rcar: Add support for R-Car Gen5
  dt-bindings: clock: renesas,r8a78000-cpg: Add PWM clocks
  arm64: dts: renesas: r8a78000: Add PWM nodes
  [DNI] clk: renesas: r8a78000: Add PWM clocks
  [DNI] pmdomain: renesas: r8a78000: Add PWM support
  [DNI] arm64: dts: renesas: ironhide: Enable PWM

Khanh Le (1):
  dt-bindings: pwm: renesas,tpu-pwm: Add support for R-Car X5H

 .../bindings/pwm/renesas,pwm-rcar.yaml        |  61 +++++----
 .../bindings/pwm/renesas,tpu-pwm.yaml         |   1 +
 .../boot/dts/renesas/r8a78000-ironhide.dts    |  84 ++++++++++++
 arch/arm64/boot/dts/renesas/r8a78000.dtsi     | 121 ++++++++++++++++++
 drivers/clk/renesas/r8a78000-cpg.c            |   6 +
 drivers/pmdomain/renesas/r8a78000-mdlc.c      |   2 +
 drivers/pwm/pwm-rcar.c                        |  92 ++++++++-----
 .../dt-bindings/clock/renesas,r8a78000-cpg.h  |   3 +
 8 files changed, 312 insertions(+), 58 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
