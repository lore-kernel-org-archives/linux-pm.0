Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9E636F917;
	Tue, 14 Jul 2026 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024927; cv=none; b=o2m1pBfwzCsdoynbw9YSr7M/zfEhairaM6dhufn8h+y5axJvk0PXfl9IL6A20ORPDkgWlkXcAi6FWfaY6+vnRni0FMQPUQA9H11Vf0Vldao8Q+Bc2TkxujOFvV0O6KKI7FHYVorjhJn5/Me2cABUDswb3ZrYMTbvG5s3Wyz+Po4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024927; c=relaxed/simple;
	bh=iYf+yTaMENGjFsDxnE24W2KARirES+DFL3au5+1XiJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y5OhNWTBc4MUaTdQjfgajef4m5GnY5dqR/5nmggj65IcgQr3LuTCL15SjxIIBUWc90Wdu3XaxfYFLK3jAjsIXzfT6vWrbbBjrEY74fjn8vWUMHAoQxeLSalo3i4A6mjXWWtEE2NtgK6WOrKCnRYavIa/D4/6nFZFO0VhEcJLam8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIUHCgSz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIUHCgSz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A820BC2BCB9;
	Tue, 14 Jul 2026 10:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784024926;
	bh=iYf+yTaMENGjFsDxnE24W2KARirES+DFL3au5+1XiJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZIUHCgSzj39tkxHLYUQ4MebnOJLrT/lHqKRaXjRSIlfqNLSAO2tb4Qa1et0dLp/Rq
	 4YiLIVy4W9GWcZjLjCtdflNZQv02J7+T4a4WTGKzhUiLgaqmigxUvWChdjUrmwNl8/
	 m46IDreE217aN9H6WveMlX56oVlgf8HlB4VcA02ubhcOQqzUzQMBoh13zsZMhxTaNu
	 wNdEovr1mVgbkRDZ5rA7/LE0J1Pz7wXAnmiEOMCrYacNCho2ydQfEgxfpeBcVvPllg
	 CFKOJY/29CDjcHFTYhC3iAOimq15pGeeFS14iwOSEOz/gJpNWv3jnjuDl84rAR6ktu
	 wKpO4P5HeX/wQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FA1C43458;
	Tue, 14 Jul 2026 10:28:46 +0000 (UTC)
From: Haoning CHENG via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Date: Tue, 14 Jul 2026 18:28:41 +0800
Subject: [PATCH v8 1/3] dt-bindings: thermal: imx: Document calibration
 offset property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-1-d54d8690e16e@cn.bosch.com>
References: <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-0-d54d8690e16e@cn.bosch.com>
In-Reply-To: <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-0-d54d8690e16e@cn.bosch.com>
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
 linux-kernel@vger.kernel.org, Haoning CHENG <Haoning.CHENG@cn.bosch.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784024921; l=1880;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=nULSe7w+6eN/dShLGlTXQ9Ef2waMpR9fIpFXwVCcgbM=;
 b=XW7laTS3jmFBvwYfw0Vi5xaGOgzpQbSuw20YTRxO7gi2LtZWLpki5zAtjZv6X8rBwGZIWoPyM
 H5/WxyIgczRDrr6mD4hFI/X/Tc1YQnHyQXG44rfb3mfHFaj7mMDYhZB
X-Developer-Key: i=Haoning.CHENG@cn.bosch.com; a=ed25519;
 pk=glQGwad/fosRS5gZUJYbLDPPLGe7rFTrTV2VxY/ySdc=
X-Endpoint-Received: by B4 Relay for Haoning.CHENG@cn.bosch.com/20260709
 with auth_id=860
X-Original-From: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
Reply-To: Haoning.CHENG@cn.bosch.com

From: Haoning CHENG <Haoning.CHENG@cn.bosch.com>

Some boards need a small per-design correction to align the reported CPU
temperature with board-level measurements.

Document the optional fsl,temp-calibration-offset-millicelsius property,
a signed offset in millicelsius that is added to the calculated sensor
temperature. The property is optional and the existing behavior is kept
when it is omitted.

Update the binding example to show its usage.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
---
 Documentation/devicetree/bindings/thermal/imx-thermal.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
index 949b154856c5..44365aac8115 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
@@ -59,6 +59,16 @@ properties:
   clocks:
     maxItems: 1
 
+  fsl,temp-calibration-offset-millicelsius:
+    minimum: -20000
+    maximum: 20000
+    description:
+      A signed calibration offset, in millicelsius, added to the calculated
+      sensor temperature to compensate for board-level measurement
+      differences. The range is limited to ±20 °C because a temperature
+      sensor with such a high deviation would be unusable. When absent,
+      no offset is applied.
+
   "#thermal-sensor-cells":
     const: 0
 
@@ -109,6 +119,7 @@ examples:
             nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
             nvmem-cell-names = "calib", "temp_grade";
             clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
+            fsl,temp-calibration-offset-millicelsius = <(-6400)>;
             #thermal-sensor-cells = <0>;
         };
     };

-- 
2.43.0


