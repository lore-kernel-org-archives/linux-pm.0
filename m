Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B989470E85;
	Thu, 17 Sep 2026 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646719; cv=none; b=pHwRcFweaioW7B485s7XQWzkp6SS8FnCDyvea8WUZlkS30tR7PrfdmBGDhF047dVurNUCXEeFsc3EM2cV4TFhOx6xkJMTSUyRWj5WBVPd0N+nWtrdve0J0CnO3am5OzkD53KTwQBEzE9G5ZappHSBulmdaxCRNsGtKIozh1Zq/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646719; c=relaxed/simple;
	bh=+c6MUVzqCSojvrVGRFKwYwpQJt6UNDpnaDyo08CazqM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QRM/WATDmRHYb/T92YzdevbwOJpykvJfxEzqaJdycOcPdUqJokdPFkXswQ/twztGblYt2qvmj/GjEZrLy2W7kMBbAgsqH1JlIem8SUfrcbhxzPTIO4ZCqjJqk/z/4zVGiOFX+svxqe3vokIaGou8zoCVj7Y0wDxlFcefDn/li+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=v0NC/dCi; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="v0NC/dCi"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:a4f1:7e05:2192:a835])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 01EDC2EC;
	Thu, 17 Sep 2026 14:03:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789646599;
	bh=+c6MUVzqCSojvrVGRFKwYwpQJt6UNDpnaDyo08CazqM=;
	h=From:Subject:Date:To:Cc:From;
	b=v0NC/dCionvRi5La/89prc2TfwM7LKZ+tof0wyQp+2Bn5L0Y6ZsHZ4QnU6AsvnHJL
	 dsLCxSrQ0N2Fs2m+U6wrlHh1C4uJOIh6dG2EXII+KQoLz+yPT9LWBs9Bijogd4q9Ek
	 wocfAg4eGwmpgoXhcT+Ei5sunpd4OWqBZv04XFJ8=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Subject: [PATCH 00/10] media: rcar-fcp, vsp1: Enable on R-Car X5H
Date: Thu, 17 Sep 2026 21:04:39 +0900
Message-Id: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFfXq2oC/x3MQQqDMBAF0KvIrP2QRNtYr1K6iHFSB8SGBIMg3
 t3Q5du8kzIn4Uxjc1LiIll+W4VuG/KL274MmavJKPNUL23B0e0rikWH5DWOx4KSI4KPGFyYeTK
 2V8FSDWLiIMc/f3+u6wbwIMvwbAAAAA==
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

This series enables the FCPV[BI] and the VSP[BI] blocks on the Renesas
R-Car X5H SoC.

This has been tested on an Ironhide with the vsp-tests test suite [2]:
148 tests: 142 passed, 0 failed, 6 skipped

There was some odd behavior with the clocks, where from what I
understood was that the clocks for the FCPV[BI] and VSP[BI] are
always-on, but the tests would hang unless I explicitly enabled...  the
always-on clock (or fsleep). Then after I removed the patch that
explicitly enabled the always-on clock everything ran fine. Just
reporting that this happened just in case it's relevant.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/rcar-x5h-ironhide-scmi-cpg-mdlc-remapping-v3
[1] https://git.ideasonboard.com/epaul/linux/src/branch/epaul/v7.3-rc1/x5h/vsp/fcp
[2] https://git.ideasonboard.com/renesas/vsp-tests/commit/900168f58c9d96be0592c2593f4d8f34edc9c69e

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
---
Paul Elder (10):
      dt-bindings: clock: renesas,r8a78000-cpg: Add CPG_SGD4_VIO_DP_{TX,OTHER}
      clk: renesas: r8a78000: Add clock for FCPV and VSP for SCP FW SDKv4.36
      pmdomain: renesas: r8a78000: Add maps for VIO for SCP FW SDKv4.36
      arm64: renesas: r8a78000: Add FCPV[BI] nodes
      arm64: renesas: r8a78000: Add VSP[BI] nodes
      media: rcar-fcp: Check device revision at probe time
      media: rcar-fcp: Handle resets
      media: vsp1: Support full VSPB on R-Car M3-W, M3-N and E3
      media: vsp1: Document X5H SoC ID
      media: rcar-fcp: Add R-Car X5H support

 arch/arm64/boot/dts/renesas/r8a78000.dtsi        | 171 +++++++++++++++++++++++
 drivers/clk/renesas/r8a78000-cpg.c               |   2 +
 drivers/media/platform/renesas/rcar-fcp.c        | 162 +++++++++++++++++++--
 drivers/media/platform/renesas/vsp1/vsp1_drv.c   |  13 +-
 drivers/media/platform/renesas/vsp1/vsp1_regs.h  |   3 +-
 drivers/pmdomain/renesas/r8a78000-mdlc.c         |  34 ++++-
 include/dt-bindings/clock/renesas,r8a78000-cpg.h |   2 +
 7 files changed, 372 insertions(+), 15 deletions(-)
---
base-commit: 02c5d61866607bce0b3271e7c1b838c53dbedc55
change-id: 20260917-epaul-v7-3-rc1-x5h-vsp-fcp-8afdeb2740f7

Best regards,
-- 
Paul Elder <paul.elder+renesas@ideasonboard.com>

