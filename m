Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DC64279F9;
	Fri, 16 Oct 2026 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136603; cv=none; b=NZVz1nIC7/LjTkzOTZYs9OmOtv/X/bls6QfBSZI2Fv4S4fspXkDhoVh1HBz0Uq58yxn0pAkmPetD//ntEW968aBWuxzHzARskniB/sV0DhQx3G5n/yoSkAAtV2cTcbm7xp45geDuh3hgSApSUwWXpn4gQewFgno4Auz5hoMq98o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136603; c=relaxed/simple;
	bh=noP7SLtTy6bRV7+vDOu0XXWL530DjmB63o88p0NEPPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJEsBOCH1wNqXquhrNFQDli+m4j1y9PpyH18oxSp8H1JTXT4cDgi0ViJk1Rw33JfHzN4yx/vnK5V6MCrPSltBfF2anfjBumOV5aYEg6jEuR04fM1j4wdUE9+KgBoJkJj9LG5cz6S90Imt4ekibGQYA5H7fqsX3iDhZnFeDfz+Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVJiNCM/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVJiNCM/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D922C2BCFC;
	Fri, 16 Oct 2026 07:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792136602;
	bh=noP7SLtTy6bRV7+vDOu0XXWL530DjmB63o88p0NEPPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HVJiNCM/quOAbTCBag8x7KJRCIuuuh7euAHOmLlzzRK3GhvOB2+F22QQDE7AaxP3H
	 68frG/FO4VLCqISCwZyv+Ael7Ysyi2VE/i75m/64YEKcR3dM+XajkpgeXvLf4z4kbk
	 69VHTBpewteBk9Ub7hQBjLGxGYyfKDoXuI64q2x1/Srf4ZT5bkNRePx9wvhJyOt/d1
	 YfgL1fGD+rtcOa3rzsFxq71MorCuBwelLyV0PDC9y8CzZLWhZXxMOsxJWowxP5cFd8
	 aCdRTEHXd7m9Q7pWqIFWju0QGgMaAXKNGwDMAjA4hbgV9sKG5ctfWaYX5DLzVvVUeY
	 UAxMLG0HA+v3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C360CC6B38;
	Fri, 16 Oct 2026 07:43:22 +0000 (UTC)
From: Haoning CHENG via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Date: Fri, 16 Oct 2026 15:43:18 +0800
Subject: [PATCH RESEND v11 1/3] dt-bindings: thermal: imx: Document
 calibration offset property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261016-b4-symana21-11221-imx-thermal-support-upstream-6-18-v11-1-b80952ad27d6@cn.bosch.com>
References: <20261016-b4-symana21-11221-imx-thermal-support-upstream-6-18-v11-0-b80952ad27d6@cn.bosch.com>
In-Reply-To: <20261016-b4-symana21-11221-imx-thermal-support-upstream-6-18-v11-0-b80952ad27d6@cn.bosch.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792136598; l=2030;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=Ue37UPF1teuZxiSxC/xhzQKQfZyk1Yq+nuequgJPOG4=;
 b=xymH7t4a1lMCFtRIptL4P675z9HocSCjT4Je85l5feu6a3I94FBxrk73jF9oTG50XXBKLa8Uu
 3WLscEKcsvoAX4JoXCEah7CICWNDagpFnWHoAuQbb8NJCcY1/9wqOlq
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


