Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4220363083;
	Wed, 22 Jul 2026 02:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784687945; cv=none; b=paElcX9W8NuZXPUCemRaMEZ9MoI4Mflrk2X5UoqEuQ6MlNYIRNVS65nJq16EWSEC77TF7TPiOgpnDV6MLy/47hd2ltRF2lxL5VpTpk+KzlIs8OwZFzJD+afGak2Iy7iZLiFQZGSRBp+tNNeRytOhGx/40O6zdeiZXljj3BdQWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784687945; c=relaxed/simple;
	bh=noP7SLtTy6bRV7+vDOu0XXWL530DjmB63o88p0NEPPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JyPEQbzD2IMY7vUHMxe5NEccu5A4jY76AXmhxqqRKQwJ/Jpo9vcY3Vu4YVFNkZ+mMCAWPdVjG7Pch2Az+l9nvm/9Pah82/17LID3qwYW0zOvk+pt0XGELUmSsOiLU1KYtVf55I9/XnybhfwtQ5eFjPQMyPbgH0pwDFr93DipN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vChfd3TQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vChfd3TQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6260CC2BCB8;
	Wed, 22 Jul 2026 02:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784687945;
	bh=noP7SLtTy6bRV7+vDOu0XXWL530DjmB63o88p0NEPPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vChfd3TQJdklUQPqg0W0Kz4uVFSoFU/HwVH2NtfPponDBh6pzPhwgn7moELJFigZE
	 MhUBbTgUrV2CWOEhFM3SZd25D7aarp0jcXfuSLRd80yvbVna7O1rD41gsqBxoat/T2
	 LQGlGJTVB7kbKwvucOBGPJhGNFr6/uKw3108CsKlGp15sDAp2L521lqs3EdMTY2eg/
	 XqbFXtcR/C5G1kEvhAvGAuhnTrDA9KtV+HR/9mzEdVlWtRiL7jRvW/SkT3N+jT3m9F
	 SMyT8Gjp8ZvLOUIP1omt8hKBCfON768znuprxLAkyg3PGJT03+tCKco10zb917daaO
	 2PeM7JXEO42ww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0BBC4452D;
	Wed, 22 Jul 2026 02:39:05 +0000 (UTC)
From: Haoning CHENG via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Date: Wed, 22 Jul 2026 10:11:41 +0800
Subject: [PATCH v11 1/3] dt-bindings: thermal: imx: Document calibration
 offset property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260722-b4-symana21-11221-imx-thermal-support-upstream-6-18-v11-1-90e4e46c0a13@cn.bosch.com>
References: <20260722-b4-symana21-11221-imx-thermal-support-upstream-6-18-v11-0-90e4e46c0a13@cn.bosch.com>
In-Reply-To: <20260722-b4-symana21-11221-imx-thermal-support-upstream-6-18-v11-0-90e4e46c0a13@cn.bosch.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784687940; l=2030;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=Ue37UPF1teuZxiSxC/xhzQKQfZyk1Yq+nuequgJPOG4=;
 b=ABwbGlbH3nVJiQM3RU0KiJXtVhO5x9aUjwRw7+Wwy9UUumZfzoR8s6zJYVAQ21SP7ibyoWgQr
 YBxqBfD5SDiDKow5vBJUINNZbcQMtV7XTAus2mhOixYRfral2GmYQAg
X-Developer-Key: i=Haoning.CHENG@cn.bosch.com; a=ed25519;
 pk=glQGwad/fosRS5gZUJYbLDPPLGe7rFTrTV2VxY/ySdc=
X-Endpoint-Received: by B4 Relay for Haoning.CHENG@cn.bosch.com/20260709
 with auth_id=860
X-Original-From: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
Reply-To: Haoning.CHENG@cn.bosch.com

From: Haoning CHENG <Haoning.CHENG@cn.bosch.com>

The TEMPMON sensor reading may deviate from the theoretical SoC
junction temperature. Document the optional
fsl,temp-calibration-offset-millicelsius property, a signed offset
in millicelsius applied to correct the sensor reading toward the
theoretical junction temperature.

The offset is determined through thermal characterization by
comparing the sensor output against the calculated junction
temperature. When absent, the offset is zero.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
---
 Documentation/devicetree/bindings/thermal/imx-thermal.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
index 949b154856c5..503a6e7a2c68 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
@@ -59,6 +59,17 @@ properties:
   clocks:
     maxItems: 1
 
+  fsl,temp-calibration-offset-millicelsius:
+    minimum: -20000
+    maximum: 20000
+    description:
+      A signed offset, in millicelsius, applied to the TEMPMON
+      sensor reading to correct it toward the theoretical SoC
+      junction temperature. The offset is determined through
+      thermal characterization by comparing the sensor output
+      against the calculated junction temperature. The range is
+      limited to ±20 °C. When absent, no offset is applied.
+
   "#thermal-sensor-cells":
     const: 0
 
@@ -109,6 +120,7 @@ examples:
             nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
             nvmem-cell-names = "calib", "temp_grade";
             clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
+            fsl,temp-calibration-offset-millicelsius = <(-6400)>;
             #thermal-sensor-cells = <0>;
         };
     };

-- 
2.43.0


