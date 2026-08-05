Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B481ACED5;
	Wed,  5 Aug 2026 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943266; cv=none; b=k/WLwi7jOXO5LH3Mp0/bbd8atct1BjGQn0HJrIG3NQKCwPIGAisTwDN0aY4rWhZ3oW7tLIjlRy9Zo9sf3M/1oU5OHusU3jloyzYlM/Wbo+bM0MOEV93CTR3M+w0jgIrEYA4dLv/keGGAg3LPWvmHLAij0Bzfi7NNB3Y+5kO2mAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943266; c=relaxed/simple;
	bh=Ny5Kx9wXzwxNDJ9xElZ0YlC6exLF+nb2wacloxIZTs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9kjaC9YVWECffozgHnlDZt6T4KO9qcHfPXYQqDiTMZbjDGK0G1TmrdXYobmJPLpszAGDPKzHmjtUIC78K6+70S6UYRs6O0j+zPEeF3eFJr4QgAOpxi4wThk3hO9zFRfsmT1+5ma22vufBFOFqFpKrLqmsOI3hREpomjiS23aCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3A91F000E9;
	Wed,  5 Aug 2026 15:21:00 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 0/6] R-Car X5H CPG/MDLC support
Date: Wed,  5 Aug 2026 17:20:48 +0200
Message-ID: <cover.1785941595.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series adds minimal support for the Renesas R-Car X5H Clock
Pulse Generator (CPG) and Module Controller (MDLC), to aim for replacing
the dummy clocks in r8a78000.dtsi with proper hardware description.
These two components are closely related, in the sense that they are
both supposed to be accessed through the ARM System Control and
Management Interface (SCMI) on the Ironhide development board.

This series consists of three parts:
  1. Patches 1-2 add DT bindings and DT binding definitions,
  2. Patches 3-4 add minimal CPG and MDLC drivers,
  3. Patches 5-6 update the DTS.
Note that this series depends on v7.2-rc2, due to the use of
<linux/device-id/of.h>.

Changes compared to v2[1]:
  - Add Acked-by, Reviewed-by,
  - Add fixed-rate clocks to kerneldoc of r8a78000_cpg_priv.map,
  - Use devm_clk_hw_register_fixed_rate(), drop unregister_fixed_clks(),
  - Drop fill_clk_map(), as it is not really needed until SCMI remapping
    support is added later,
  - Replace <linux/mod_devicetable.h> by more specific
    <linux/device-id/of.h> in v7.2-rc2,
  - Add a comment to document only always-on domains are supported,
  - Consistently use /* sentinel */ for zero sentinels,
  - Drop trailing commas from sentinels,
  - Sort MDLC nodes (alphabetically, by label).

Major changes compared to v1[2] (more detail in the individual patches):
  - Add default support not using SCMI,
  - Drop everything related to SCMI.

Note that this series does not use or rely on SCMI in any way.
SCMI remapping support will be added in a subsequent series (old version
at [3]).
Full hardware support without using SCMI could be added, too, if anyone
would care about that use case.

For testing, I have pushed this series plus additional work (including
a rebased and updated version of [3]) to [4].

While I know it is getting late in the cycle, this work (especially the
DT bindings) are a dependency for about any R-Car X5H progress, so it
would be good to have it included in v7.3.
Hence I plan to queue the clock patches (1, 3) in renesas-clk for v7.3
(Stephen still hasn't merged my earlier PR for v7.3 anyway).
Ulf: It would be great if you could take the pmdomain patches (2, 4).
The DTS changes (5-6) can wait for v7.4; they have a hard dependency on
the presence of both drivers anyway.

Thanks for your comments!

[1] "[PATCH v2 0/6] R-Car X5H CPG/MDLC support"
    https://lore.kernel.org/cover.1783505142.git.geert+renesas@glider.be
[2] "[PATCH/RFC 00/14] R-Car X5H Ironhide SCMI CPG/MDLC remapping"
    https://lore.kernel.org/cover.1776793163.git.geert+renesas@glider.be
[3] "[PATCH v2 00/10] R-Car X5H Ironhide CPG/MDLC SCMI remapping support"
    https://lore.kernel.org/cover.1783505329.git.geert+renesas@glider.be
[4] topic/rcar-x5h-ironhide-scmi-cpg-mdlc-remapping-v3-wip branch of
    https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git

Geert Uytterhoeven (6):
  dt-bindings: clock: Document Renesas R-Car X5H Clock Pulse Generator
  dt-bindings: power: Document Renesas R-Car X5H Module Controller
  clk: renesas: Add R-Car X5H CPG driver
  pmdomain: renesas: Add R-Car X5H MDLC driver
  arm64: dts: renesas: r8a78000: Add CPG node
  arm64: dts: renesas: r8a78000: Add MDLC nodes

 .../bindings/clock/renesas,r8a78000-cpg.yaml  |  55 +++
 .../bindings/power/renesas,r8a78000-mdlc.yaml |  61 ++++
 arch/arm64/boot/dts/renesas/r8a78000.dtsi     | 300 ++++++++++++++--
 drivers/clk/renesas/Kconfig                   |   4 +
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r8a78000-cpg.c            | 166 +++++++++
 drivers/pmdomain/renesas/Kconfig              |   4 +
 drivers/pmdomain/renesas/Makefile             |   1 +
 drivers/pmdomain/renesas/r8a78000-mdlc.c      | 330 ++++++++++++++++++
 drivers/soc/renesas/Kconfig                   |   1 +
 .../dt-bindings/clock/renesas,r8a78000-cpg.h  |  14 +
 .../dt-bindings/power/renesas,r8a78000-mdlc.h |  15 +
 12 files changed, 927 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
 create mode 100644 Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
 create mode 100644 drivers/clk/renesas/r8a78000-cpg.c
 create mode 100644 drivers/pmdomain/renesas/r8a78000-mdlc.c
 create mode 100644 include/dt-bindings/clock/renesas,r8a78000-cpg.h
 create mode 100644 include/dt-bindings/power/renesas,r8a78000-mdlc.h

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
