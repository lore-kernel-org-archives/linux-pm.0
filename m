Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967D73E866B;
	Thu,  9 Jul 2026 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584628; cv=none; b=poabzCst2p4FrQV3Z1RiMHozAVt/xb+ydtV2U7kGEbFlQYmK+A2DqWhXRK6UrZspmGqz4a/XVf7XzWtRcr3TpjPzVym3NNo5XlcB+Rvl5xFinui8AsWKixL8V4Cw3oPlUUKlX9WW6okS/bZyiwzDeQX+16vMeyjDLiK2SYba+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584628; c=relaxed/simple;
	bh=NXPtnJSElIpKRB1lKI8cYyBmhE5lNVooFcti28hZYio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JVKKQQ1AALalcRktTBM99AWVC1eNJyXwy7eJMCYJj+7d0U/wwIZYSJr8DDstzvuA3MEq4KScca3atpzL2nIYVZ9oYz2nRX/B87sxRTX4hYDsTWVBdelfkoyHhapcVVdVMtc3gBbNr/8KBFslJLGmcAshNSUTJce6zZWlGbpHTdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoK6Xd0p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoK6Xd0p"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 322A8C2BCC7;
	Thu,  9 Jul 2026 08:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783584628;
	bh=NXPtnJSElIpKRB1lKI8cYyBmhE5lNVooFcti28hZYio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BoK6Xd0pM8eop8hVMrtbQAQFiJiwhKrpx2BNxi/nJjkuyzZVCY2MOmUwt/iSMCo6Q
	 dbBsybbzE3ISJadibD/w82vLXGHf13qx38vyujoBnRVyrCUfl4sBWvP58sIvL2lN2p
	 jEs87R4c1C+hsGu/1YaUSSJn8IdKm9sXDq/oy4XDTn3drL6mTeKLrpg3+B1gKItgVL
	 tuUyXjUJi9IrF62yot2yhWpf2MBOQMfcCYwSSEkp4flLoyXVJWBxychZS9gbLmzuLQ
	 XXrg3P+xThloraVniICedArXtVqwj38N1e/HXO1gDXiDFfqluVPEvZ0roRMRYiH4v0
	 j0MjuYoZEGAYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208DCC44501;
	Thu,  9 Jul 2026 08:10:28 +0000 (UTC)
From: HaoNing Cheng via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Date: Thu, 09 Jul 2026 16:10:21 +0800
Subject: [PATCH v2 1/2] dt-bindings: thermal: imx: Document calibration
 offset property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-v2-1-00ff72495e24@cn.bosch.com>
References: <20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-v2-0-00ff72495e24@cn.bosch.com>
In-Reply-To: <20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-v2-0-00ff72495e24@cn.bosch.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Haoning CHENG <Haoning.CHENG@cn.bosch.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783584623; l=1654;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=DKKt2yS4Vd7uuoQbKmjwi1DTXyFYmb5Ugq4J+iX+RsI=;
 b=Qh66sonmy7IwkqL0J84EmMAwlZpycTwQ7sPM/A5AoBKvpKaMAEtczmQPgdHYKWSVXvfLzcuMg
 tf8m9bMmVScAVwzOBFshx74TULMu/oniE5brR4mugWQhAc1pI5KWHSQ
X-Developer-Key: i=Haoning.CHENG@cn.bosch.com; a=ed25519;
 pk=glQGwad/fosRS5gZUJYbLDPPLGe7rFTrTV2VxY/ySdc=
X-Endpoint-Received: by B4 Relay for Haoning.CHENG@cn.bosch.com/20260709
 with auth_id=860
X-Original-From: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
Reply-To: Haoning.CHENG@cn.bosch.com

From: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>

Some boards need a small per-design correction to align the reported CPU
temperature with board-level measurements.

Document the optional fsl,temp-calibration-offset-millicelsius property,
a signed offset in millicelsius that is added to the calculated sensor
temperature. The property is optional and the existing behaviour is kept
when it is omitted.

Update the binding example to show its usage.

Signed-off-by: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
---
 Documentation/devicetree/bindings/thermal/imx-thermal.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
index 949b154856c5..eb7243a7ebaf 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
@@ -59,6 +59,13 @@ properties:
   clocks:
     maxItems: 1
 
+  fsl,temp-calibration-offset-millicelsius:
+    maxItems: 1
+    description:
+      A signed calibration offset, in millicelsius, added to the calculated
+      sensor temperature to compensate for board-level measurement
+      differences. When absent, no offset is applied.
+
   "#thermal-sensor-cells":
     const: 0
 
@@ -109,6 +116,7 @@ examples:
             nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
             nvmem-cell-names = "calib", "temp_grade";
             clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
+            fsl,temp-calibration-offset-millicelsius = <(-6400)>;
             #thermal-sensor-cells = <0>;
         };
     };

-- 
2.43.0


