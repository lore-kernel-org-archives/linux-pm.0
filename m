Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B5C4A99C9;
	Thu, 15 Oct 2026 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050731; cv=none; b=oVh8vD/SPHGr3JVAnK+wSwWPb6RK6xOETWKBLwYKHynl2A/h5mkDb2ZU6d+0nAwQAFgISlv/+VB+wadBH1YIQ9fjqnILHgRYy1J5Qn2fzc4CKV4FgogNNTpPdRQVrrRZ+/bZ1guphA532LVA1Iq8kyHwZms9zKvddPQUATX8U+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050731; c=relaxed/simple;
	bh=LNxO7ibG6YeaI13CRObbaUiHj3ct8jM01RLk+F4ZVfg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sdKJ3SB3mF9ilpBiOA5RgpBnW5QWnl5j+uhxCQ+cJ9siBUKc23/32lKKRAyWW8zpNJFgzT2H2NktLc3wdxvomWxSAdsu2UQ6Ide0yipaoRyNQRRUZGFbUF7NfTGOTeJr1sVJH1PFCa1EW893NZvdnp2ORJup5Oblqqcikky/U+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=J+SVfib5; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="J+SVfib5"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:6f1c:794c:1e6c:a09b])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3ECDC1F8;
	Thu, 15 Oct 2026 09:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792050591;
	bh=LNxO7ibG6YeaI13CRObbaUiHj3ct8jM01RLk+F4ZVfg=;
	h=From:Subject:Date:To:Cc:From;
	b=J+SVfib5qK/A+VSOC17r85IjfVDLqccWJZ+ZjBjcXiPW5gdC5hZ0W/mzgMCv9jnRJ
	 vCQI/LBucELy/rPchr7jrFbecT1o8suhBG7VzZ1c/O/h14Ivw8yf25+pUV1A1WismY
	 eJtuDAT3kW4S064Xok+QHyDVwd6A8F85s0ypCPEE=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Subject: [PATCH DNI v3 00/15] media: rcar-fcp, vsp1: Enable on R-Car X5H
Date: Thu, 15 Oct 2026 16:51:40 +0900
Message-Id: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA2G0GoC/43NQQ7CIBCF4asY1o6h01qsK+9hXFBmsCRaCCipa
 Xp30ZULY1z+b/G9WSSOjpPYr2YRObvk/FiiXq+EGfR4ZnBUWqDEVnaVAg76foGsoIZoKpi2A+Q
 UwJoAO22Je1SNtEoUIES2bnrjx1PpwaWbj4/3V65e619srkBCYxRSw3LXEh0csU5+7L2OtDH+K
 l56xk+x+yliEannDuu2t4T4RVyW5Qktk71pHQEAAA==
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
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Phong Hoang <phong.hoang.wz@renesas.com>, 
 Paul Elder <paul.elder@ideasonboard.com>
X-Mailer: b4 0.14.2

This series is based on Geert's
"topic/rcar-x5h-ironhide-scmi-cpg-mdlc-remapping-v3" branch [0]. A
branch including this series is available here [1].

This series enables the FCPV{B,I,D} and the VSP{B,I,D} blocks on the Renesas
R-Car X5H SoC.

This has been tested on an Ironhide with the vsp-tests test suite [2].

Full summary:
/dev/media0 (VSP2-D (a)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media1 (VSP2-D (a)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media10 (VSP2-I): 157 tests: 150 passed, 0 failed, 7 skipped
/dev/media11 (VSP2-I): 157 tests: 150 passed, 0 failed, 7 skipped
/dev/media12 (VSP2-I): 157 tests: 150 passed, 0 failed, 7 skipped
/dev/media13 (VSP2-I): 157 tests: 150 passed, 0 failed, 7 skipped
/dev/media14 (VSP2-B): 127 tests: 116 passed, 0 failed, 11 skipped
/dev/media15 (VSP2-B): 127 tests: 116 passed, 0 failed, 11 skipped
/dev/media16 (VSP2-B): 127 tests: 116 passed, 0 failed, 11 skipped
/dev/media17 (VSP2-B): 127 tests: 116 passed, 0 failed, 11 skipped
/dev/media18 (VSP2-B): 127 tests: 116 passed, 0 failed, 11 skipped
/dev/media2 (VSP2-D (a)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media3 (VSP2-D (a)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media4 (VSP2-D (a)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media5 (VSP2-D (b)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media6 (VSP2-D (b)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media7 (VSP2-D (b)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media8 (VSP2-D (b)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media9 (VSP2-D (b)): 114 tests: 99 passed, 0 failed, 15 skipped

The first couple patches add clocks that are used by the FCP and VSP,
but as the upstream X5H CPG driver is barebones at the moment and we
don't yet ensure that the parents are enabled, these are marked as DNI
for the moment.

The last patch checks the device revision and prints it, which is useful
for debugging but is unnecessary processing for driver operation so it
is marked as DNI as well.

In v3, most of the patches have become DNI because they depend on wip
cpg and mdlc driver work. The non-DNI patches are targets for immediate
upstreaming though.

There was some odd behavior with the clocks, where from what I
understood was that the clocks for the FCPV{B,I} and VSP{B,I} are
always-on, but the tests would hang unless I explicitly enabled...  the
always-on clock (or fsleep). Then after I removed the patch that
explicitly enabled the always-on clock everything ran fine. Just
reporting that this happened just in case it's relevant.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/rcar-x5h-ironhide-scmi-cpg-mdlc-remapping-v3
[1] https://git.ideasonboard.com/epaul/linux/src/branch/epaul/v7.3-rc1/x5h/vsp/fcp-v3
[2] https://git.ideasonboard.com/renesas/vsp-tests/src/branch/epaul/fix

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
---
Changes in v3:
- Added a couple bsp patches for upstreaming
- Marked dt patches as DNI
- Fix some VSPD instances hanging
- Update dt-bindings documentation for the expanded module identifier
  bit width
- Link to v2: https://lore.kernel.org/r/20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com

Changes in v2:
- Add FCPVD and VSPD
- Fixed author (I mistakenly overwrote a few when I renamed my email)
- Link to v1: https://lore.kernel.org/r/20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com

---
Laurent Pinchart (3):
      [DNI] arm64: renesas: r8a78000: Add VSP[BI] nodes
      media: vsp1: Support full VSPB on R-Car M3-W, M3-N and E3
      [DNI] media: rcar-fcp: Check device revision at probe time

Paul Elder (9):
      [DNI] dt-bindings: clock: renesas,r8a78000-cpg: Add CPG_SGD4_VIO_DP_{TX,OTHER}
      [DNI] clk: renesas: r8a78000: Add clock for FCPV and VSP for SCP FW SDKv4.36
      [DNI] pmdomain: renesas: r8a78000: Add maps for VIO for SCP FW SDKv4.36
      [DNI] arm64: renesas: r8a78000: Add FCPV[BI] nodes
      [DNI] arm64: renesas: r8a78000: Add FCPVD and VSPD nodes
      media: vsp1: Add device info entries for VSPD on X5H
      media: rcar-fcp: Handle resets
      dt-bindings: Increase Renesas X5H MDLC PD specifier bit width
      media: vsp1: Complete buffers as queued in start_streaming error path

Phong Hoang (3):
      media: vsp1: Fix access to reserved registers
      media: vsp1: Fix du_complete race condition issue
      media: vsp1: Fix setting control register by display list

 .../bindings/power/renesas,r8a78000-mdlc.yaml      |   7 +-
 arch/arm64/boot/dts/renesas/r8a78000.dtsi          | 361 +++++++++++++++++++++
 drivers/clk/renesas/r8a78000-cpg.c                 |   2 +
 drivers/media/platform/renesas/rcar-fcp.c          | 158 ++++++++-
 drivers/media/platform/renesas/vsp1/vsp1_drm.c     |  10 +-
 drivers/media/platform/renesas/vsp1/vsp1_drv.c     |  74 ++++-
 drivers/media/platform/renesas/vsp1/vsp1_regs.h    |   4 +-
 drivers/media/platform/renesas/vsp1/vsp1_video.c   |   9 +-
 drivers/media/platform/renesas/vsp1/vsp1_wpf.c     |   5 +-
 drivers/pmdomain/renesas/r8a78000-mdlc.c           |  54 ++-
 include/dt-bindings/clock/renesas,r8a78000-cpg.h   |   2 +
 11 files changed, 647 insertions(+), 39 deletions(-)
---
base-commit: b97eed181007d4d71116add157a5dfa50c76dc72
change-id: 20260917-epaul-v7-3-rc1-x5h-vsp-fcp-8afdeb2740f7

Best regards,
-- 
Paul Elder <paul.elder+renesas@ideasonboard.com>

