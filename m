Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007BC51AFC0;
	Fri, 18 Sep 2026 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751252; cv=none; b=pELG7kOk/MtPlg/60tM+lMKDiNrQur4hVGLaiBYusOm6a7xFipBxqqivawGhBUa+XIzazbKpGE/mUBN7XN7Fl5z3VTHisuY6k1VBbnLAKr7i3dseerQjs32pfFN54oSgF/kBCtfN8TXy5ZcJVaH5uXCVr68Lf66mrra/pPPLQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751252; c=relaxed/simple;
	bh=oTQCa2YH8eyS9lAOOM+1pO2wTu7sfJ+tBuDE/zbBdnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=piTD5RD3JsygRtLIUTYt/mMWBeb63I3MdeOnLKQbWtvpUawUMXwDqFE3s1dU3Fjsysr8630h22187F6uAuXZEoDxmxTOMhfKD+y8aYQsvMA7PvWOCYTsMArHdDNYb1uxctqPQIYaBi1587XdrsQfOZeVTlb+0ZEusd4KZiJjZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gROeRlpK; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gROeRlpK"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:e327:a298:3a5b:4b08])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 359D64E46;
	Fri, 18 Sep 2026 19:05:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789751146;
	bh=oTQCa2YH8eyS9lAOOM+1pO2wTu7sfJ+tBuDE/zbBdnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gROeRlpKgKdiZEpFCemCM6Uo4DKDqbQZ41YRig7KhqgbJZWfuDaH4WCVsDIhCkwiy
	 hzRfx+7ufo3g/C11+wRRepE+9f5FFEyVSKEbi0Z2i0aFVIVC6fMSv9CrpnXE1Hp/RP
	 vligDIAWc+rgq0E+fR1p3rpDpANWOPmQNmzLz/cs=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Sat, 19 Sep 2026 02:06:59 +0900
Subject: [PATCH DNI v2 02/11] clk: renesas: r8a78000: Add clock for FCPV
 and VSP for SCP FW SDKv4.36
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-2-dbe9236bfd22@ideasonboard.com>
References: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
In-Reply-To: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
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
 Paul Elder <paul.elder+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

Add clocks for the FCPV{B,D,I} and VSP{B,D, I}. They each have one clock
from an option of two: a 1066MHz and a quarter-divided 266MHz. As we
already have support for the 266MHz one, add just those for now.

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
---
 drivers/clk/renesas/r8a78000-cpg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
index b820d09e1a195068debe8a6eea7a01c534a97b23..17792ff6ab8ae2f7eb5c8f7e3d581b43177e195d 100644
--- a/drivers/clk/renesas/r8a78000-cpg.c
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -326,6 +326,8 @@ static const struct clk_map_in r8a78000_cpg_fw_4_31_0[] = {
 	{ R8A78000_CPG_SGASYNCD16_PERW_BUS,	FIXED_CLK(66M) },
 	{ R8A78000_CPG_S0D4_PERE_MAIN,		FIXED_CLK(200M) },
 	{ R8A78000_CPG_MSOCK_PERW_BUS,		1667 },
+	{ R8A78000_CPG_SGD4_VIO_DP_TX,		FIXED_CLK(266M)},
+	{ R8A78000_CPG_SGD4_VIO_DP_OTHER,	FIXED_CLK(266M)},
 	{ -1 }
 };
 

-- 
2.47.3

