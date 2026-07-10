Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABF279DA;
	Fri, 10 Jul 2026 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651859; cv=none; b=TATD4qhvIUYz8BNpyvebz7vzoDwa5s62xL7KLj8jdeH0mfS69slbvDN3qimVOZOu15nPN8VmjERVHJvLMrxduqCvPSg6pGRAsjOAeumA5bq7ltGEkjq82rceeE8yLms7M/MAsGAroznb+0Kxw0jD4H7Eq8SO2j0/O3G2n6pCNdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651859; c=relaxed/simple;
	bh=3t+IwPNjchGwRw8aPRco1AcIAze6OzD8uBa6XiV4+D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3m/2TmQm3LES6VIZntRRe1VNCAUweOBzSpo9RWmAqYGx0wk2tyk92BL/c+sdT4PN/W21O0D6Z3e/ZGh+iAtpR1/yLbLyYMmUKeNpmSl7gCzEWerq+A07fanAm1tX4njVQIwa24Pf/myYf1TI5LipFpY0AeLCo5TvM4s8o5v+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYKHKw5H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYKHKw5H"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C40A3C2BCC6;
	Fri, 10 Jul 2026 02:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783651858;
	bh=3t+IwPNjchGwRw8aPRco1AcIAze6OzD8uBa6XiV4+D0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JYKHKw5Hpy1pZ/NyI+757U62Argk7txP87Sm7EoqZPhFRZKcBDDAYLx4bUMUnwB1W
	 KYvvolQgXKb9awWHjmnNrMeEUO5fk8Wa6c/FmtJIdEc6dvKjr5j/UwTxhsaaTFfmQ3
	 pOyVuLTduLeGyO0uT1jGBa8uUEPTf67npr8tXuVBWI4XzA7l41hreM8w7FAs+L9J5l
	 WM9l+v4ZLXRgCESSzZmX5ApNs0uEgL6tbZiQSA/gzIjd/+AECH4U5yB8yqfgKn2UiJ
	 wsRwG2CxJGTBGTH4Vls+w/w5MYLMhAcSB8pw/wC40Bk4xXSx4i6vju8VjbNSL26t2z
	 Xmx/HK8sTWOVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57A5C44501;
	Fri, 10 Jul 2026 02:50:58 +0000 (UTC)
From: HaoNing Cheng via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Date: Fri, 10 Jul 2026 10:50:40 +0800
Subject: [PATCH v3 1/2] dt-bindings: thermal: imx: Document calibration
 offset property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-b4-symana21-11221-imx-thermal-support-upstream-6-18-v3-1-db9fc2947c55@cn.bosch.com>
References: <20260710-b4-symana21-11221-imx-thermal-support-upstream-6-18-v3-0-db9fc2947c55@cn.bosch.com>
In-Reply-To: <20260710-b4-symana21-11221-imx-thermal-support-upstream-6-18-v3-0-db9fc2947c55@cn.bosch.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783651853; l=1701;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=WG7m2ewau975nWzQXBSSwPCqnASh0rwyMkTjPm4T6VA=;
 b=lLDZAoJCUsyWvtYba3lIKK493xDvZUQOlG1N3cy82958lQRKrulD8XmbQCO/ZWa8q+WgA/Ptq
 0zuw2J7+pN6B7933X+zYjI4dUhlLQTsFSIQjOpmK+tby59kPBPoaAYb
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
 Documentation/devicetree/bindings/thermal/imx-thermal.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
index 949b154856c5..704bf2fa48cf 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
@@ -59,6 +59,15 @@ properties:
   clocks:
     maxItems: 1
 
+  fsl,temp-calibration-offset-millicelsius:
+    maxItems: 1
+    description:
+      A signed calibration offset, in millicelsius, added to the calculated
+      sensor temperature to compensate for board-level measurement
+      differences. When absent, no offset is applied.
+    minimum: -28580
+    maximum: 28580
+
   "#thermal-sensor-cells":
     const: 0
 
@@ -109,6 +118,7 @@ examples:
             nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
             nvmem-cell-names = "calib", "temp_grade";
             clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
+            fsl,temp-calibration-offset-millicelsius = <(-6400)>;
             #thermal-sensor-cells = <0>;
         };
     };

-- 
2.43.0


