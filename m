Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777908;
	b=GXa+cB/f/ZoOsrB/aou+uLmQpHBXkMZf7j6ymZczGqexjNhAX6nKm2k/8faK2v9CkStN
	 LXNyXXCiV9Gj1/GpcmqcbFbo0LoalhsDQzKmo1nQIznILGfe8jC9NEQUq0u3zQNXfHhjY
	 IqQA2jhvMXnBINzK0Dck1c5Cbjka4jqk5TiJrvFIUHNtLNgTL06anvK87nfcOyUsBAxT4
	 7M1niQQuQRg1TjLxm1ER63u1ZK4OklDtkDrTFvGw2dEyh9xsHik2bp7beAEn4GapWZG+r
	 IM8ZjK+wVqwrJF47VT1qhcaOUUKcI9mgTbzGMnjTeBo8h4FZ3ooSpnSMSAxf10kIsBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777908;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FOFI7yP3FEG3uscSb6Zxru+rlWqxhK9+E0KjenFAYd8=;
	b=p9s/WYRu+Yd5NZqY6B7IzVFE2HJtyjz56pbtgH53eATUXlYXyks5u7oPkriJmV8C9Ato
	 Kezq9qyhb7LEOr1/vgcabUQXVuAMGNnUISD/aRM7A0nz6rGUEkc/vFr1ausz6M5JeVOJX
	 V0y7llj+0pPcDTBCB8L5Dmev4hlA0SIACJkWnDZj59u6U8CQM2lxZuAtMGem3Q0/zShCm
	 xuZZ2g921I4asWOIT+umgTLOt2sLGhCXhGOO1C0rcTdKEcW8wbxv2PLacGZRSPEhK+pFg
	 6+mPo3eH52RV8qRJHMxapSHh8J6g3mFCyOWG+EixKUNEweRdQ1ljdCL8UP0AOCh8RJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF27B606A31A;
	Fri, 23 Oct 2026 17:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7EB1F01825;
	Fri, 23 Oct 2026 17:51:09 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/7] arm64: renesas: r8a78000: Enable GPIO support
Date: Fri, 23 Oct 2026 19:50:38 +0200
Message-ID: <cover.1792776697.git.geert+renesas@glider.be>
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

This patch series enables GPIO support for the Renesas R-Car X5H SoC, as
found on the Renesas Ironhide development board.  On this board, clocks,
power-domains, and resets must be accessed only through SCMI firmware.

The series is a bit special, in that most patches are not meant to be
applied upstream yet:
  1. The first patch, targeting the GPIO tree, restores the abily to use
     the R-Car GPIO driver on a system that does not have pin control
     support yet (pin control is not yet supported by SCMI on Ironhide),
  2. The second patch, targeting a shared DT bindings branch, adds GPIO
     clock definitions,
  3. The third patch, targeting renesas-devel, adds GPIO device nodes to
     the R-Car X5H .dtsi file,
  4. The remaining patches are marked RFC or DNI; the latter depend on
     code or DTS that is not yet upstream.  More detail can be found in
     the individual patches.

This has been tested on Ironhide using GP05_15..GP05_20 (exposed on the
PWM connector), with and without SCMI.

Thanks for your comments!

Geert Uytterhoeven (6):
  gpio: rcar: Convert to gpiochip_generic_{request,free}()
  dt-bindings: clock: renesas,r8a78000-cpg: Add GPIO clocks
  [DNI] clk: renesas: r8a78000: Add GPIO clocks
  [RFC] pmdomain: renesas: r8a78000: Add default GPIO support
  [DNI] pmdomain: renesas: r8a78000: Add SCMI GPIO support
  [DNI] arm64: dts: renesas: r8a78000: Add gpio-ranges

Marek Vasut (1):
  arm64: dts: renesas: r8a78000: Add GPIO controller nodes

 arch/arm64/boot/dts/renesas/r8a78000.dtsi     | 166 ++++++++++++++++++
 drivers/clk/renesas/r8a78000-cpg.c            |  12 ++
 drivers/gpio/gpio-rcar.c                      |   5 +-
 drivers/pmdomain/renesas/r8a78000-mdlc.c      |  50 ++++++
 .../dt-bindings/clock/renesas,r8a78000-cpg.h  |  16 ++
 5 files changed, 246 insertions(+), 3 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
