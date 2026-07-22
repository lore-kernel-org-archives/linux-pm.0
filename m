Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB53836F8FE;
	Wed, 22 Jul 2026 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709576; cv=none; b=Ynq0IAt2oqDg+YO4CxtlKYWnclk1QZL/TdBlSpGLhcEm6r1+NpUkxzoSzlfqO4C3Ooe6JeeTEdRbZV0N1rSJ6EfjpohQ406a0iI3P9WkzgCOZe9ZmXxirQFK49EsG1VQhabprMUyZcNU5DS+nK5F6Sw6SfIs5D15FUE8TyxE42U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709576; c=relaxed/simple;
	bh=/CtfcRiNZmIDjw0LmLMal82IJMGbUeAVONk2Kky6N14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nqhhUm9kpDJoWrtQt6h0mis7BAyXGBunu6GBXXY5nLQO9bi8ugho9FTTm/o0oQc6DdprruKtz2n+i7K4wNUJarnjTbV5+pFZA0VrDQzSYsC0B/fbq+ZHR8Lac1E+1QMUWnBAxhyS2hbYO3sPmbr6Cj+40qTwIu2HCmYYlnBaLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNHdOlra; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNHdOlra"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A69C0C2BD00;
	Wed, 22 Jul 2026 08:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784709576;
	bh=/CtfcRiNZmIDjw0LmLMal82IJMGbUeAVONk2Kky6N14=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oNHdOlraHo+Y14/Ovs6YzBJBV36uW+MUta/e+nK4VatrdD1OCMINZDd6AsESFUjW4
	 R+lrppCBOUs2iXb0NLZWzyFhD+emjmGeAgN9vbA/fMCiAzjW62BegG+fQKW2p8pdWE
	 gEQqCzG+e7BvVjhpWbAXExzzyWT7Cg+UPF8CqgzrFtFq3iH5f7e2/fJ9vZEM+LdLzQ
	 o7c1/FtRL9j3Ww5Z+WYF87rGro3tXesyn0+DoobiNzixatFX81XrfAbT7v8KA+MvEl
	 fLsLG28Rv3ZYj0R5cqXPUGPX2kvF/iBm8DyKC2D3SuMUbcFxTgmTUesm8JjbcoxfXj
	 kyg50pSITti6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9299FC44533;
	Wed, 22 Jul 2026 08:39:36 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 22 Jul 2026 08:39:33 +0000
Subject: [PATCH 3/3] arm64: dts: amlogic: a9: Add power domain controller
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-a9-pm-v1-3-1fe20a44bf2d@amlogic.com>
References: <20260722-a9-pm-v1-0-1fe20a44bf2d@amlogic.com>
In-Reply-To: <20260722-a9-pm-v1-0-1fe20a44bf2d@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784709572; l=1059;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=xo1Aubxoy/JqFSkmWDscfP/W3QukIsgCeqLnk3l3H2c=;
 b=8m2xj7Wdhudv3R9CMZS9z6M+V7M9mHlKRD7/9v7ugrfgIHOsm2Z43TnkReKOjQANfg6+hGJW7
 CJVRk7lvnCpBLpygK1jOTD3xy+wTNafcwO0b2uGVTJhA5kLx7f2QAbf
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add power domain controller node for Amlogic A9 SoC.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi
index b0e0fadeed82..3652b2034c96 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/amlogic,pinctrl.h>
+#include <dt-bindings/power/amlogic,a9-pwrc.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -72,6 +73,15 @@ cpu7: cpu@700 {
 		};
 	};
 
+	sm: secure-monitor {
+		compatible = "amlogic,meson-gxbb-sm";
+
+		pwrc: power-controller {
+			compatible = "amlogic,a9-pwrc";
+			#power-domain-cells = <1>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,

-- 
2.52.0


