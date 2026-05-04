Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADA53E63A5;
	Mon,  4 May 2026 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919098; cv=none; b=GgWqhyKJl+sCetgNPiuGcgwLzumda9RUoIGHVaDMjqQ8lEe2PuPHvtNoy9SB0SxFPwB2dHV2D7ggsfs9zVtd6gQ0YVSQazcs0VVX4T8tvoXBzGFtRraCF43KoNEpwGc2eRz83Oj55FEJXBRiVQ/KGMKbBnWnRcys86OaGT2MDKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919098; c=relaxed/simple;
	bh=KLZKepons1ktWUi2cBQErmKekVgkW3Se0X3Vct8Tzv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VmoBRfGt8MWD+iq0tFcKChoFrLEoLVaSz/tNwsh3QJ1kj2AnVigEr3Ne08kla1qNtsjA2sAOlaFP/SdUpyNOaQ6pr6SzRQVs/bIC9UJGNqhxT1+mIWBjn60euk5nAerlIxjg1Gx97iILrQabpQ3sjENjE8g6kC4uL4z7mlMjTHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1mO8BP2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1mO8BP2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A81A2C2BCF5;
	Mon,  4 May 2026 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777919098;
	bh=KLZKepons1ktWUi2cBQErmKekVgkW3Se0X3Vct8Tzv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=B1mO8BP2bXa0mSeeC6gqwke9UdeoBN4BX+2IJ0Ya0DQQdDwzhTvNxMSxEcqmuShAA
	 7/gQmd3onHmtystCjQTzrBC5Wh84Y50FyLiMjuzDO0eza1GZkezcC6LNjR4gC0lI6v
	 kttLs6lSd8EyfMWpQ9Lq06Um+fVa4/3Fo+i2Fj41I2/wKxyLBDlUtBkA/f6tJZWal2
	 jXJ5IuDxU3a7vax+fDKwFePN5W9ZalBC3MhIUENFxm2BopTB2YHqHVIPsKHoRj06MP
	 9PXZ8b32WDLBKsOifR5sd8yV2zZ95ICRc/MuxcHgaAAqBeV8atQ/sTwtdhOztO7McP
	 6WXhao6WeLE7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D107FF885A;
	Mon,  4 May 2026 18:24:58 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Mon, 04 May 2026 21:24:55 +0300
Subject: [PATCH 03/13] dt-bindings: thermal: add mt6323 PMIC thermal
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-mt6323-v1-3-799b58b355ff@protonmail.com>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
In-Reply-To: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ben Grisdale <bengris32@protonmail.ch>, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777919095; l=2523;
 i=rva333@protonmail.com; s=20260325; h=from:subject:message-id;
 bh=Y0jGUqql3soeCei8ikkZ/UAUGnGbcX1Kt0zfmNLXZe4=;
 b=lQx9pnqPRHZhANCq6Fot6muIYsncfpNjwFildJFkPJyUUmvivT5WyxPskKeUZyyj05VzSA3s8
 QsmJn2RmGknDE3xVFJJ7MX3q+cv0iIOMyuptPHzDdSNh8XjAkhcp4/S
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=euuVBZGtA2Cqb8Dju84qpQPhvwxyUirJlXpqEPQWKBM=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260325 with
 auth_id=695
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

The MediaTek mt6323 PMIC temperature can be read using AUXADC channel.

Add the devicetree binding documentation for the MediaTek mt6323 thermal.
Due similarities with newer PMICs like mt6358, which include more than
one thermal sensor, the #thermal-sensor-cells should be set to 1, to
avoid breaking devicetree ABI in future.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 .../bindings/thermal/mediatek,mt6323-thermal.yaml  | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,mt6323-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,mt6323-thermal.yaml
new file mode 100644
index 000000000000..1882816ba274
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek,mt6323-thermal.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/mediatek,mt6323-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek PMIC thermal
+
+maintainers:
+  - Roman Vivchar <rva333@protonmail.com>
+
+description:
+  The MediaTek PMIC thermal sensor uses an AUXADC channel to read raw
+  temperature data and applies calibration data from NVMEM.
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: mediatek,mt6323-thermal
+
+  io-channels:
+    description: >
+      IIO channel for the AUXADC to read raw data from.
+    maxItems: 1
+
+  io-channel-names:
+    const: vts
+
+  nvmem-cells:
+    description: >
+      NVMEM cell with phandle to the calibration data provided by the
+      NVMEM device. If unspecified default values will be used.
+    maxItems: 1
+
+  nvmem-cell-names:
+    const: calibration-data
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - io-channels
+  - io-channel-names
+  - "#thermal-sensor-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/iio/adc/mediatek,mt6323-auxadc.h>
+
+    mt6323_thermal: thermal {
+      compatible = "mediatek,mt6323-thermal";
+      nvmem-cells = <&mt6323_thermal_calibration_data>;
+      nvmem-cell-names = "calibration-data";
+
+      io-channels = <&mt6323_adc MT6323_AUXADC_CHIP_TEMP>;
+      io-channel-names = "vts";
+      #thermal-sensor-cells = <1>;
+    };

-- 
2.53.0


