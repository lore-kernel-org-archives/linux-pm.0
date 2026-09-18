Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B524052B5;
	Fri, 18 Sep 2026 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751242; cv=none; b=Ukpo4e052OnY5ktqxvk9xXcZJ5kyIS7gC91lNaO3AT7LmmXrixmtNMV4nMT6Ot78dEyxQ88YnRicTZtHR/kT2jr9E198g8g7Lg7SH/HELaTnqmhrIjYGKK6NBNrfPN+kN+oyc+3U+1Ab8S0A1pbKbqyQ9nIieYAkMyMSKI3m0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751242; c=relaxed/simple;
	bh=Y6OrJwcqyHL60lTM3DMA24gGOWLdlxDTip5xo+/vHFE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WJ2KFb19+MTTPOMEOtrQfgcRG7QhAzLXaVFMW/lkDicMSNXqfRW8h08AIZb2gJYqVgWyIGwtCs+8lC6AXUd2drtbvCmZxaxQq03voz85iETFeJQfD+yNdqDAXfF+FUhzhQydwmi+iA2iuy2PZfhxL3ZXgIl7xvPUObEUVVYzme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=tRaSOTNv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tRaSOTNv"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:e327:a298:3a5b:4b08])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 07DEB4E46;
	Fri, 18 Sep 2026 19:05:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789751135;
	bh=Y6OrJwcqyHL60lTM3DMA24gGOWLdlxDTip5xo+/vHFE=;
	h=From:Subject:Date:To:Cc:From;
	b=tRaSOTNvZYpOyEsBm8LIEnyTV19BTydEQgMun34UAl1Pj91xYwErE12//D2o9LgYv
	 LGfrD0TZQRnZnh1XBVn8MwtNbqPbKhUDYrM8BiGFmbKA232XkuVjKhgiFc3zo8DM50
	 I10H6bYQa9ZLMzyaKVDPuKT8pFa8/dgNpcWxtqPM=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Subject: [PATCH DNI v2 00/11] media: rcar-fcp, vsp1: Enable on R-Car X5H
Date: Sat, 19 Sep 2026 02:06:57 +0900
Message-Id: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALFvrWoC/43NQQ7CIBCF4asY1o4BrKW68h6mC8oMdhItBJTUN
 L272BO4/N7if4vIlJiyuOwWkahw5jBV6P1OuNFOdwLGaqGlbuVZGaBo3w8oBo6QnIL5NELJEby
 L0FmPNGjTSG9EDcREnuctfuurR86vkD7bV1G/9a9sUSChcUZjQ7JrEa+MZHOYhmATHlx4in5d1
 y9sy0YJywAAAA==
X-Change-ID: 20260917-epaul-v7-3-rc1-x5h-vsp-fcp-8afdeb2740f7
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, 
 Paul Elder <paul.elder+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

This series is based on Geert's
"topic/rcar-x5h-ironhide-scmi-cpg-mdlc-remapping-v3" branch [0]. A
branch including this series is available here [1].

This series enables the FCPV{B,I,D} and the VSP{B,I,D} blocks on the Renesas
R-Car X5H SoC.

This has been tested on an Ironhide with the vsp-tests test suite [2].
VSPI:
145 tests: 138 passed, 0 failed, 7 skipped
VSPB:
115 tests: 104 passed, 0 failed, 11 skipped
VSPD (a):
114 tests: 99 passed, 0 failed, 15 skipped

VSPD (b) hangs on the tests, so that needs some investigation.

The first couple patches add clocks that are used by the FCP and VSP,
but as the upstream X5H CPG driver is barebones at the moment and we
don't yet ensure that the parents are enabled, these are marked as DNI
for the moment.

The last patch checks the device revision and prints it, which is useful
for debugging but is unnecessary processing for driver operation so it
is marked as DNI as well.

There was some odd behavior with the clocks, where from what I
understood was that the clocks for the FCPV{B,I} and VSP{B,I} are
always-on, but the tests would hang unless I explicitly enabled...  the
always-on clock (or fsleep). Then after I removed the patch that
explicitly enabled the always-on clock everything ran fine. Just
reporting that this happened just in case it's relevant.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/rcar-x5h-ironhide-scmi-cpg-mdlc-remapping-v3
[1] https://git.ideasonboard.com/epaul/linux/src/branch/epaul/v7.3-rc1/x5h/vsp/fcp
[2] https://git.ideasonboard.com/renesas/vsp-tests/commit/900168f58c9d96be0592c2593f4d8f34edc9c69e

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
---
Changes in v2:
- Add FCPVD and VSPD
- Fixed author (I mistakenly overwrote a few when I renamed my email)
- Link to v1: https://lore.kernel.org/r/20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com

---
Laurent Pinchart (4):
      arm64: renesas: r8a78000: Add VSP[BI] nodes
      media: vsp1: Support full VSPB on R-Car M3-W, M3-N and E3
      media: vsp1: Document X5H SoC ID
      [DNI] media: rcar-fcp: Check device revision at probe time

Paul Elder (7):
      [DNI] dt-bindings: clock: renesas,r8a78000-cpg: Add CPG_SGD4_VIO_DP_{TX,OTHER}
      [DNI] clk: renesas: r8a78000: Add clock for FCPV and VSP for SCP FW SDKv4.36
      pmdomain: renesas: r8a78000: Add maps for VIO for SCP FW SDKv4.36
      arm64: renesas: r8a78000: Add FCPV[BI] nodes
      arm64: renesas: r8a78000: Add FCPVD and VSPD nodes
      media: vsp1: Add device info entries for VSPD on X5H
      media: rcar-fcp: Handle resets

 arch/arm64/boot/dts/renesas/r8a78000.dtsi        | 361 +++++++++++++++++++++++
 drivers/clk/renesas/r8a78000-cpg.c               |   2 +
 drivers/media/platform/renesas/rcar-fcp.c        | 158 +++++++++-
 drivers/media/platform/renesas/vsp1/vsp1_drv.c   |  35 ++-
 drivers/media/platform/renesas/vsp1/vsp1_regs.h  |   4 +-
 drivers/pmdomain/renesas/r8a78000-mdlc.c         |  54 +++-
 include/dt-bindings/clock/renesas,r8a78000-cpg.h |   2 +
 7 files changed, 601 insertions(+), 15 deletions(-)
---
base-commit: 02c5d61866607bce0b3271e7c1b838c53dbedc55
change-id: 20260917-epaul-v7-3-rc1-x5h-vsp-fcp-8afdeb2740f7

Best regards,
-- 
Paul Elder <paul.elder+renesas@ideasonboard.com>

