Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DDF3E2754;
	Mon, 13 Jul 2026 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783937584; cv=none; b=kanK6PjVA2w7l3D875JYj7ZJWjmVS9cdzgVTKt2hg50u6oD0A9MtDZZoYwbcylfky7w3c+Pr83oI7FsjmS0kVFQHzyNKl/7AiZTbOzN696DRU8QvMqRkPyXOL67PCYEc/4TrCz0lDiBv7xxQZwlA3MKu3PNJr/R3ZKdPfdFIg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783937584; c=relaxed/simple;
	bh=5R5wab56J1UaNbgqfoC2zM6MpZsUaaP2yXp95KCdfi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=emmrPoOrJr4VidvTugQrDPhUvKSXR5GYerfye1t1i7Ij9sdWKrmmDtPhBP6tSJYLFSt7nY9E8VIp3DlyDSLSjtTrRV0+Xpjh8S+JHpOz2d8tjkaCib9glvaoqSJdVUZ6hdNtTIJ4JBK9Dk5bicOuDGjkGEi742hss7IjEKpejfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX/sAqrP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX/sAqrP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85AA4C2BCF5;
	Mon, 13 Jul 2026 10:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783937584;
	bh=5R5wab56J1UaNbgqfoC2zM6MpZsUaaP2yXp95KCdfi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eX/sAqrPjZAODzDI74j6Xz9vi+14/HUwmCT/XXGOV/XO9sl4jFy1PeBGUxV6hM3Fh
	 LjhVokG1S+j2v3G2S28sN575hI73JyTucLeIyqqXYmB+wMX3F8rxu0gpKG1jaaYBTp
	 ++WAERUonlSk7A5s0SnbZbtRAwACIsjLITziH3Y4rbiMzgVctTfPcqmVQNh5CKM+VA
	 Kbvd5BFiUnybs4525W59zAJQ7C+nkopHXnfOQdLanJyJLBucv4blRCEOOA3MyctQd4
	 QREz9fO2dWsWBLuQPjN34M2aA0A6BF6E2MvHKxCCwrN/JRewQiVRWoPcL0hcB88KxK
	 Gl+Jfe8f43jXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F70C44507;
	Mon, 13 Jul 2026 10:13:04 +0000 (UTC)
From: Haoning CHENG via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Date: Mon, 13 Jul 2026 18:12:39 +0800
Subject: [PATCH v6 1/2] dt-bindings: thermal: imx: Document calibration
 offset property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v6-1-88a378faeca5@cn.bosch.com>
References: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v6-0-88a378faeca5@cn.bosch.com>
In-Reply-To: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v6-0-88a378faeca5@cn.bosch.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783937579; l=1753;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=ZivBI22a3qS0TqHZ23fVePBLGsXub0NAoZFnOZ7FWno=;
 b=7nYw10WjTXIQsaivz4U+/bx+VnMUEcRHtDvUNgpSmh1AQCcCGHQgjAF/Lw4+oMcvTsXSzcOLF
 jwfptF1qozvBltJt0qJZnPPahe7RCt0XMfEo89EZP6eK4767jRXXM0A
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


