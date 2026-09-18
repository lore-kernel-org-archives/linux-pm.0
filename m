Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8A51AFC0;
	Fri, 18 Sep 2026 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751291; cv=none; b=PoDD9Cj+EYgtuuHbXbck6G0u/u2jGxK4Laroxq3TK8AZ1PBgeqwhmmpIk6mTd/2xfRHxoe6u71AdcvW4MTIGjjAWvRwjWrfJ2AB3DStM6Z30JFkHVcz1wqgaafvl8MgWkO/qJIlB1Pe91fLJMfghsBsk6h8Qjy7hI0kRBrAvr7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751291; c=relaxed/simple;
	bh=0J98EihxZHd8sllO3NGQvWEDUIxPBQ7w/LkkaW72IfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nsuJSgUA5741qUp+QnVsTWmuUbchx++QwXKo5D8GNO65e9CgJIM23i4pNk2GEQsBSoZFxFdTxYrN7tJIiXdoeYb5trjugQy04luHsX8NrmWzgGZPx5syAxI8nH2pEMRsgDjKxIVpXEI6HX2DG3d29kTjaaxeOaU6agS3Ro2QWBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UD3KSNXS; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UD3KSNXS"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:e327:a298:3a5b:4b08])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 53C88417F;
	Fri, 18 Sep 2026 19:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789751185;
	bh=0J98EihxZHd8sllO3NGQvWEDUIxPBQ7w/LkkaW72IfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UD3KSNXSn6ARr4JdTjZnXfXGTUNBSz64dySRPAzfFNYmc2ZTEdh03iaO8DqdPg7Ja
	 WLwzN/9iTWG6Dd9f0lBmLuez0DDJNddnrq/nvtgBGK/lfXFGzyakrt6LSziiEFFNH7
	 g59q53H2+SLrZpF/695MG3ug9omim/ciOYgk5CGk=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Sat, 19 Sep 2026 02:07:06 +0900
Subject: [PATCH v2 09/11] media: vsp1: Add device info entries for VSPD on
 X5H
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-9-dbe9236bfd22@ideasonboard.com>
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

Add device info entries for the VSPD so that the driver can match on the
VSPD on the X5H and handle it slightly different hardware configuration.

On the X5H there are two variants, the VSPD (a) and VSPD (b). As the (b)
version has a separate version number, add that as well.

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
---
 drivers/media/platform/renesas/vsp1/vsp1_drv.c  | 22 ++++++++++++++++++++++
 drivers/media/platform/renesas/vsp1/vsp1_regs.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drv.c b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
index 5597595414fe787413c7daa5a3142faa9ced8408..627771e3056617daa8e10d1fb68218435cde0a64 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
@@ -860,6 +860,17 @@ static const struct vsp1_device_info vsp1_device_infos[] = {
 		.uif_count = 2,
 		.wpf_count = 2,
 		.num_bru_inputs = 5,
+	}, {
+		.version = VI6_IP_VERSION_MODEL_VSPD_GEN4,
+		.model = "VSP2-D (a)",
+		.soc = VI6_IP_VERSION_SOC_X5H,
+		.gen = 4,
+		.features = VSP1_HAS_BRU | VSP1_HAS_EXT_DL,
+		.lif_count = 1,
+		.rpf_count = 5,
+		.uif_count = 2,
+		.wpf_count = 1,
+		.num_bru_inputs = 5,
 	}, {
 		.version = VI6_IP_VERSION_MODEL_VSPD_GEN4,
 		.model = "VSP2-D",
@@ -870,6 +881,17 @@ static const struct vsp1_device_info vsp1_device_infos[] = {
 		.uif_count = 2,
 		.wpf_count = 1,
 		.num_bru_inputs = 5,
+	}, {
+		.version = VI6_IP_VERSION_MODEL_VSPDB_GEN4,
+		.model = "VSP2-D (b)",
+		.soc = VI6_IP_VERSION_SOC_X5H,
+		.gen = 4,
+		.features = VSP1_HAS_BRU | VSP1_HAS_EXT_DL,
+		.lif_count = 1,
+		.rpf_count = 5,
+		.uif_count = 1,
+		.wpf_count = 1,
+		.num_bru_inputs = 5,
 	}, {
 		.version = VI6_IP_VERSION_MODEL_VSPX_GEN4,
 		.model = "VSP2-X",
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_regs.h b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
index 8abf39bac6c2f333696ebf55de87586d2df3bed0..489d88107d1c17530a74736c40563a93cc17e567 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_regs.h
+++ b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
@@ -800,6 +800,7 @@
 #define VI6_IP_VERSION_MODEL_VSPBS_GEN3	(0x1a << 8)
 #define VI6_IP_VERSION_MODEL_VSPD_GEN4	(0x1c << 8)
 #define VI6_IP_VERSION_MODEL_VSPX_GEN4	(0x1d << 8)
+#define VI6_IP_VERSION_MODEL_VSPDB_GEN4	(0x20 << 8)
 /* RZ/G2L SoCs have no version register, So use 0x80 as the model version */
 #define VI6_IP_VERSION_MODEL_VSPD_RZG2L	(0x80 << 8)
 

-- 
2.47.3

