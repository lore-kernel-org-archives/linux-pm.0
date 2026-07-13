Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF27360EE1;
	Mon, 13 Jul 2026 05:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921899; cv=none; b=rTybV4PJmvJeV9QlYSJV7F4TOkchTHtTXvdmE1LTJggKU09VuzavQyezu14iDF+JN+QDizDFEPSQN3TliwjO7h/uufYQtNtSCqNWSsbcNjfMYQkZ929Sxn5EjKm2CRm3rGtiQMceZ7rMb/j81Jn3fmoMxJrI4nRV6Vz2BnNA4oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921899; c=relaxed/simple;
	bh=oCll8We+b6Ponr2uyiTBpEh+oMTBvWauOBvBly2V1Do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EugUU4e3G957xQ2Waw/MkpZFmJ6hiEg3ydleTfBDN6/RX7TY4h755/INrUC+KU3B7PpetHJbPXbpdn25P8VcyqmNgWieQw0dqW5PkClAOs25W4PM4FoVFaDwH3iV66c0t9dFNvWO/8Rf7SOwT7VoQLYamxQBc1qOHOqfA8cFuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flKIobHQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flKIobHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9240C2BCF4;
	Mon, 13 Jul 2026 05:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783921898;
	bh=oCll8We+b6Ponr2uyiTBpEh+oMTBvWauOBvBly2V1Do=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=flKIobHQqR286Nhgygiour3pDzSDRE9c4oq4767RxopoKJRsEy2gkRM+XiQGpnVav
	 je1ORONca0VMvZpyU1bPlk510M3ACCsoNCX6L8/+wEGPfZtkz7GZdO61KOeO+yCRS0
	 tSd17RZXN+R24LqHGjnP64TOhzSv6eEc+8hx752/rdRZFB6RVoa6orgAkPVH5DSQ28
	 eh2gFaPZBcYgv4Z4cLkXptznXjNrM2QcO8m8WXtzQ7pSVgWUk7CdZ6yj06yar3HJNX
	 dq97N3HDcxW19G0M/Oavl2gCWCyaiQgSPF5hGmpcSY00naMk+bfcqZcm71gehPofSM
	 bxSXzeLuUQG/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D68C44506;
	Mon, 13 Jul 2026 05:51:38 +0000 (UTC)
From: HaoNing Cheng via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Date: Mon, 13 Jul 2026 13:51:33 +0800
Subject: [PATCH v5 1/2] dt-bindings: thermal: imx: Document calibration
 offset property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v5-1-69405c306c6b@cn.bosch.com>
References: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v5-0-69405c306c6b@cn.bosch.com>
In-Reply-To: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v5-0-69405c306c6b@cn.bosch.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783921893; l=1753;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=ZivBI22a3qS0TqHZ23fVePBLGsXub0NAoZFnOZ7FWno=;
 b=Xxio6LCNhOYSAf+kovPkzVuaYHSwWnE3Mn0GO93XO9M7eVk232Zt8Pverwudm2v9b2n+/+pO9
 oHc4DJr+i5RDivNDZhIG+pkRJnL0o/8AeSl4hWm3jwiwu2laFcksLnq
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
---
 Documentation/devicetree/bindings/thermal/imx-thermal.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
index 949b154856c5..b9afffd98f84 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
@@ -59,6 +59,14 @@ properties:
   clocks:
     maxItems: 1
 
+  fsl,temp-calibration-offset-millicelsius:
+    minimum: -28580
+    maximum: 28580
+    description:
+      A signed calibration offset, in millicelsius, added to the calculated
+      sensor temperature to compensate for board-level measurement
+      differences. When absent, no offset is applied.
+
   "#thermal-sensor-cells":
     const: 0
 
@@ -109,6 +117,7 @@ examples:
             nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
             nvmem-cell-names = "calib", "temp_grade";
             clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
+            fsl,temp-calibration-offset-millicelsius = <(-6400)>;
             #thermal-sensor-cells = <0>;
         };
     };

-- 
2.43.0


