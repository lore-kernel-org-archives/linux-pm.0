Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC24AA414;
	Thu, 15 Oct 2026 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050737; cv=none; b=ilUEE/Pd7rsrAuEJ9ouP/7CIO8iK5g2Ex36KU6to1VYqxVm7nbz3urArvaf9HOAzHedNp/7w/lboQgU44ycqizHOCnczO3yZGQL7XNbhOLgUhNw8i6VYqSvOTOQgaLyZYe/300X2u3czv2jLXpURcrlbxeBlgZkkHruFEUiLMwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050737; c=relaxed/simple;
	bh=oTQCa2YH8eyS9lAOOM+1pO2wTu7sfJ+tBuDE/zbBdnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EN2/BieM/XYxPVM8l/XSN5uGPPU924D0f51RMo5z0nRjHo38EUJH3/CwU9tZDsRbQVwBJ5B57+f8AOZEUE/q3NTOFw42WzBO7X1c+DutSwp54PMYqhJEk0CQLla/Lwfxqxd6nE5u1/mGHX99uiKQKeUITz4AGUP2fOMNzGGbFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fnOFTK2x; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fnOFTK2x"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:6f1c:794c:1e6c:a09b])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E288E2F8;
	Thu, 15 Oct 2026 09:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792050602;
	bh=oTQCa2YH8eyS9lAOOM+1pO2wTu7sfJ+tBuDE/zbBdnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fnOFTK2xkOY5e5oYtZjsH/162SOP/en2Ss2MiFT8WEErs6iYw3eo2fy8Uoe8beQlb
	 fT9horEkxTGbabHKM1wIPrJKOAM0TjMF722Liawxk13x8EIQJwZZVYFyBtng7RQtSw
	 2/Q7WPurvJAgJSeVngduPsnorIfnE05OrRb2b1FU=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 15 Oct 2026 16:51:42 +0900
Subject: [PATCH DNI v3 02/15] clk: renesas: r8a78000: Add clock for FCPV
 and VSP for SCP FW SDKv4.36
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-2-e052903a3832@ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
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

