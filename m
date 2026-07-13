Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FCC3624C2;
	Mon, 13 Jul 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938182; cv=none; b=EHS64jk8nuQPtbzoLpSH+ueajjuB7ZhydZ/Q0BqyuI9Tu43xOUQQfDvJrEtl8iGywyGYEmBUEyKCpGOf290CGmlJeLkqBIY/x9lSJCcchjh2cXPQnXcgVPXUIgGpgI/VlbJeahmkJ1EwsnIdvYZXukC38ZCnlA1SY5pPjDrZuUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938182; c=relaxed/simple;
	bh=5R5wab56J1UaNbgqfoC2zM6MpZsUaaP2yXp95KCdfi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cLj410N8XX9rvLICy0zZAUxnroL3BpEP/YTLmHBE5QmOfMQAxCuJaod8z24yzviqyMdzgdDJQbM5CXJj5q2OUR7Wpve2yhfckrha/hhxqv3UdlCRLLpXqUDb/OW7rEQ3BM8xjOqXOQ1sCwAd2vOFlbrJQtNxsjtU/CBzvcSrPz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/Mnx81U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/Mnx81U"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3306C2BCB8;
	Mon, 13 Jul 2026 10:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783938181;
	bh=5R5wab56J1UaNbgqfoC2zM6MpZsUaaP2yXp95KCdfi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=h/Mnx81UK08Rxz96ml0YOyYwBI/NT5+dADjHMQtiN916dQK0RwiJXhPKjpVuaA7OH
	 WTUHean/NkLM5MZ5gWoNNT8jYa5aaTalTGGShp73+3GCG3eP9636M5INhj4i9nz8S+
	 vtq/fahrisMdGH23IuEZ27UdBMEKDN7rWSLwHbqpAzzTJT/cBR0VaPy5Dk20aTuYv8
	 i1v3wzj/rVxr0f8bG8epN54xYY7dWR9kit+nlcriOgG2sNaXGaRUxtdzr/ssVxNrHM
	 Dw/PafktDgj+7cXuIjqu/Gp3orPs2MTuH0w29PFeWfIH9MSoiYTC+e4Lm67cTSTgJn
	 LAN2+ffzFgncQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4327C44501;
	Mon, 13 Jul 2026 10:23:01 +0000 (UTC)
From: Haoning CHENG via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Date: Mon, 13 Jul 2026 18:22:56 +0800
Subject: [PATCH v7 1/2] dt-bindings: thermal: imx: Document calibration
 offset property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v7-1-09b6b7669be1@cn.bosch.com>
References: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v7-0-09b6b7669be1@cn.bosch.com>
In-Reply-To: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v7-0-09b6b7669be1@cn.bosch.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783938176; l=1753;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=ZivBI22a3qS0TqHZ23fVePBLGsXub0NAoZFnOZ7FWno=;
 b=7Tx/FalTg2xObW+sDv69BZgEXPHmUmkiLXDHlLVI7bkqm1MzRVPqs3jy6BjeiVzoL5igYQe41
 rr0DNCyyZL7DQpaitC/tBlR4eiZY/Pm3Gj73mdLC5Vxi0WZAhGD13RU
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


