Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB7B272816;
	Mon, 20 Jul 2026 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513989; cv=none; b=L7R/fVMcfBd/5max1CuoWiH2kESR4k57+fHroUjU6TsmqD3nz10DGcBPGpLkttdlGx8b6dkeUTRg2sPLH8N0JoEFbtD9n1u0yk2wnWkU6f14eWiXJV4eoWQ8i2bhzzEXJqN8zt9ExpetxfcXA98E798siM1Opt17IfTBjH2I1Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513989; c=relaxed/simple;
	bh=noP7SLtTy6bRV7+vDOu0XXWL530DjmB63o88p0NEPPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AIv3R5SaLqiRPYIPsNImpPuu/PnJnu+IZef+4lHGtI9wxB63MFg0EI5ariJNWvWJmoNe94pQ9r30kRSrzcfn67U6fEVFIW2rSZWwBiv1w8BoeiosmfJaRbkcgE8WcPROkYG2/SjRTIk0vneiTuqtexGkKnWwqWInrcAxnMQDQCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKEry9u9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKEry9u9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D6B4C2BCF7;
	Mon, 20 Jul 2026 02:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784513989;
	bh=noP7SLtTy6bRV7+vDOu0XXWL530DjmB63o88p0NEPPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cKEry9u9DuboHksYUfma7rnlJXxnPFSPfX50DzNFYjxS01yo/BU2UOHDbO9kIW62U
	 eki3dMZnfeOMqkb1kic/h2O/sVeySNAL/Lw1bItE+sdaQciE5lPMD73rkKM9S3jubJ
	 f9ggid+t5cT1xUSrikslYN9abIq5wViXI17qof1RfFDnEcXLkHBXJWtT1fGCw9bwY1
	 RifOogyeE5dPrpHF+xF2dN+BED35OLIZlpCQFtYMIKJ+lPbCI5lLbYOPC8/7DLMK9B
	 klZjN37o5Md2imggTWx+COtXP6uT/nohsun0SA3NPRCz0Sorqmei688VJE26HtzEQG
	 TAFGmK2tob7Mg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CB1C44512;
	Mon, 20 Jul 2026 02:19:49 +0000 (UTC)
From: Haoning CHENG via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Date: Mon, 20 Jul 2026 10:19:40 +0800
Subject: [PATCH v10 1/3] dt-bindings: thermal: imx: Document calibration
 offset property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-b4-symana21-11221-imx-thermal-support-upstream-6-18-v10-1-f8c3dcd9a57e@cn.bosch.com>
References: <20260720-b4-symana21-11221-imx-thermal-support-upstream-6-18-v10-0-f8c3dcd9a57e@cn.bosch.com>
In-Reply-To: <20260720-b4-symana21-11221-imx-thermal-support-upstream-6-18-v10-0-f8c3dcd9a57e@cn.bosch.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784513984; l=2030;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=Ue37UPF1teuZxiSxC/xhzQKQfZyk1Yq+nuequgJPOG4=;
 b=jxz6ca8ybOk3Ed5IQc6Kz7G2jIX9lX2YRBEq3bn259hBuDSVo5LBshXKXZ7SLa+XfkBsORtV6
 lS0+UAwP1xZABeGB+nnXN97wzLoDjJHv4Kywp8wKeWfJD48+kN8LEQ6
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


