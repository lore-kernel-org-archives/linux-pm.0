Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5783A3033DE;
	Wed,  3 Jun 2026 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509967; cv=none; b=ppSSUR1+x7ApO0admKwxamrIKgmzFPbu8aw5q7JC0E5Zg4pJKr4zipl9k60+q+5pallsnttAyW5W9p6Kn7lxn42Rzx3qCZ/L+42B/GaKWJwzoahchwB7hCWt3m88MMWwXPYo0FZ/0mvv27VGQrR/+vHLnM9F41OWWH+Myutccq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509967; c=relaxed/simple;
	bh=mW+xaqDNXTlMQUworvAQXvJL5yRZV2v+IskzATtrYqs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VmFLKzu7kcmo7g3EM1kjyO0cdCgwlq/7mYNHxklE+1MBjSLEZckrvBtj/GFE/uOPElavMG/H6edpwI+fXzvUvKgNh16Idca0RRg32Ye2bIAVmYgYRgpHstgHKZ7eAWQUHNJLMEK9KKH7c63KsXVA2N1Pbqx86Y/Uw28Jxb5GLCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr7j0KG/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr7j0KG/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D813DC2BCB0;
	Wed,  3 Jun 2026 18:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780509966;
	bh=mW+xaqDNXTlMQUworvAQXvJL5yRZV2v+IskzATtrYqs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=sr7j0KG/T2YZdBekIJlPJWBwJ2HkNybWKdPDZgZCpkxkVFu3eGarbAuVDIha9utCB
	 +pBGG3W5zZED754oUgHb/nIZ9jraLeGplIvmIMh9z7ofYWFUOu3FQ4mVur5QxngVMF
	 2LeVK7PlzWfyrcgyEsHjdFiyGRXqEzLrlekxix9oFABKXR3L2o7fUzq/H9fn8UgErb
	 ubpzqHsJqhvfJZIg7BAAJh4jtfOr7oRp5qoPhROeJpFvqaHl/+qZz0dNm8dm/eVjvf
	 xkJ7MDUqnALRjXFlGaGVNvmhyI4B+SuBCAGmcr5mVjS2kTLlpkBJUTZZN5jwyrJZY+
	 7x6cLE6FQWQfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CFFCD6E55;
	Wed,  3 Jun 2026 18:06:06 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Subject: [PATCH v7 0/8] Add VIM4 MCU/FAN support
Date: Wed, 03 Jun 2026 20:05:22 +0200
Message-Id: <20260603-add-mcu-fan-khadas-vim4-v7-0-594ba8a965d8@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WS3W7bMAyFXyXw9RTon1YwDH2PYRekRC3aYqezn
 aBF0Xcf4xZYmi2Y7ijhfIfi4Us389R47nabl27ic5vbcZQCPm26vMfxO6tWpO6stlF7bRWWooZ
 8UhVH9XOPBWd1boNXmE0mDsHlRJ2oHyeu7Wklf/32Vk/86yQGy9tlRzizysdhaMtuM/LTolYTZ
 +GiH3iecbXfbT6/P0SdbPRha3SQwiijfjQct/vTAw6H4/eWt4L7srrjkverNgYMBWKthaQzh0j
 O9YEohkzagtY+O83AH1XWgY2p16a3sRSHBSqZyOQLlFg8IwXtLfQfVQE4ke4xxR651OBdcUWXE
 HM1GX0hq8miid31dMXs/XfrbCkP3kGwl8kIudGBFcuv0VdI4HB3th9NCZyugb0lNqVPxSTH0aE
 wg08hF6o2QwH6p6nTSlJSbTzjoRX1OB0feVqeFUmUviTnKph3x7+1ZtXK6NUCajwdDmrimSVGi
 rpnqqmg351Nd4l/3+blOD2veyZXl/z/u1Jno7TAjJW5YwbSD9IkH7Z1WpHS1hXG3cdYwYCsTCR
 rvUt4g3FXGAP3MU4wGBFqAE3G0A3GX2GsuY/xgvEejPFo+2rLDSZcY/x9TLh0U3NFMAHIuhtM/
 IMJJt7HRMFkOYmiqT6GK8zr6+tvC1Uf1R8EAAA=
X-Change-ID: 20260402-add-mcu-fan-khadas-vim4-ac1cbe553c9b
To: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5648;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=mW+xaqDNXTlMQUworvAQXvJL5yRZV2v+IskzATtrYqs=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ5ZCzs8LqTOF56nYr3y74sTp6qriz1xyUovKE+drPP3vV
 tGlKJbRUcrCIMbFICumyNI/1/LEu8tHz3zdo54CM4eVCWQIAxenAEzk4RRGhu+FFeuzGZOzZ8y9
 eOGwpUtV5guPX1mLGNe/r3mU/938qRMjw6MJm6LWnVx96MD/wEiRc/ZHU2wCkn74fN+jdrLO+UC
 gKR8A
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

The Khadas VIM4 board features a different MCU variant compared to
previous VIM boards.
While it shares the same I2C-based communication model,
it differs in some ways:

  - A distinct register map with its own volatile/writeable register set
  - A fan control with 0–100 levels instead of the 0–3 levels previously
  - A fan power supply gated through a regulator

This series adds support for this new variant by:

  1. Refactoring the khadas-mcu MFD driver to use per-variant data
     structures (regmap config, cells, fan platform data),
     and adding the khadas,vim4-mcu compatible string.

  2. Extending the fan thermal driver to retrieve the fan register
     and maximum level from platform_data,
     and to optionally manage a power regulator for the fan supply.

  3. Adding the corresponding DTS node for the VIM4, wiring the MCU to
     the I2C AO_A bus and exposing it as a thermal cooling device.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
Changes in v7:
- PATCH 3-4: Simplify the per-variant handling by using local variables in khadas_mcu_probe()
             instead of introducing a dedicated data structure. Thanks to Lee's review.
- Link to v6: https://lore.kernel.org/r/20260516-add-mcu-fan-khadas-vim4-v6-0-cccc9b61f465@aliel.fr

Changes in v6:
- PATCH 4: Address Lee's review comments:
  - Use an enum to discriminate between MCU types instead of passing
    MFD data through the DT match table
  - Fix error code from -EINVAL to -ENODEV when no MCU type is matched
  - Make khadas_mcu_fan_cells and khadas_mcu_cells const
  - Use dev_err_probe() for regmap initialization error
  - Document fan speed levels for max_level
- Link to v5: https://lore.kernel.org/r/20260424-add-mcu-fan-khadas-vim4-v5-0-afcfa7157b23@aliel.fr

Changes in v5:
- PATCH 5: Replace devm_regulator_get_optional() with devm_regulator_get()
           to simplify error handling and remove NULL checks, also
           ordering as reverse christmas according to Neil's feedback.
- Link to v4: https://lore.kernel.org/r/20260421-add-mcu-fan-khadas-vim4-v4-0-447114a28f2d@aliel.fr

Changes in v4:
- PATCH 1: limit fan-supply property by compatible according to Conor's feedback.
- Link to v3: https://lore.kernel.org/r/20260417-add-mcu-fan-khadas-vim4-v3-0-a6a7f570b11b@aliel.fr

Changes in v3:
- PATCH 1: adding comment on vim4 compatible saying it is not discoverable,
           thanks to Rob's and Neil's feedback.
- Link to v2: https://lore.kernel.org/r/20260403-add-mcu-fan-khadas-vim4-v2-0-70536b22439a@aliel.fr

Changes in v2:
- PATCH 5: Add regulator_disable on suspend thanks to Neil's feedback.
- Link to v1: https://lore.kernel.org/r/20260402-add-mcu-fan-khadas-vim4-v1-0-2b12eb4ac7b0@aliel.fr

---
Ronald Claveau (8):
      dt-bindings: mfd: khadas: Add new compatible for Khadas VIM4 MCU
      dt-bindings: i2c: amlogic: Add compatible for T7 SOC
      mfd: khadas-mcu: Add per-variant configuration infrastructure and VIM4 support
      mfd: khadas-mcu: Add support for VIM4 MCU variant
      thermal: khadas-mcu-fan: Add fan config from platform data Add regulator support
      arm64: dts: amlogic: t7: Add i2c pinctrl node
      arm64: dts: amlogic: t7: Add i2c controller node
      arm64: dts: amlogic: t7: khadas-vim4: Add i2c MCU fan node

 .../bindings/i2c/amlogic,meson6-i2c.yaml           |  13 ++-
 .../devicetree/bindings/mfd/khadas,mcu.yaml        |  18 ++++
 .../dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts  |  13 +++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        |  20 ++++
 drivers/mfd/khadas-mcu.c                           | 115 ++++++++++++++++++---
 drivers/thermal/khadas_mcu_fan.c                   |  37 +++++--
 include/linux/mfd/khadas-mcu.h                     |  22 ++++
 7 files changed, 211 insertions(+), 27 deletions(-)
---
base-commit: f7b64ed948718290209074a50bb0df17e5944873
change-id: 20260402-add-mcu-fan-khadas-vim4-ac1cbe553c9b
prerequisite-message-id: <20260326092645.1053261-1-jian.hu@amlogic.com>
prerequisite-patch-id: f03a086b4137158412b2d47b3de793b858de8dde
prerequisite-patch-id: 123970c9b29c2090440f2fd71c85d3c6fd8e36de
prerequisite-patch-id: 3e2e56b0926ba327b520f935df4ced5089bbe503
prerequisite-patch-id: 65a5d76ffdbc9b3aab3385bb65cb027004c30e7e
prerequisite-patch-id: 237269801826dd3ad7fb16eb4d7d6d4eab504278
prerequisite-patch-id: 57e9b08a968aedf543d3d0d56cf1ca4db20b2a16
prerequisite-change-id: 20260326-add-bcm43752-compatible-e264a4f7973a:v2
prerequisite-patch-id: cd98b74fa56af72af2553f391c400981d83cd4f4
prerequisite-patch-id: b730f5e42be1d89d193e63a0265495cdbf2c7d7b
prerequisite-change-id: 20260330-fix-invalid-property-bbe54d933f71:v2
prerequisite-patch-id: 8d675e7a239985c762843515b241f0a2f45f9c92
prerequisite-change-id: 20260331-fix-aml-t7-null-reset-2b608ebf9da4:v1
prerequisite-patch-id: 5b5de77af11747ce964404fb827d2ee2bff47ea5
prerequisite-patch-id: 1e37fc75fed1e533adee0f3e7e6ead1f8ff3c55c
prerequisite-patch-id: 65a5d76ffdbc9b3aab3385bb65cb027004c30e7e
prerequisite-patch-id: 2daf583fb5e7449a02bd217d8aca330171b598aa
prerequisite-patch-id: 237269801826dd3ad7fb16eb4d7d6d4eab504278
prerequisite-patch-id: d1ddf9b7710e91f8062de83bd7ba55afb2c4c112
prerequisite-patch-id: 57e9b08a968aedf543d3d0d56cf1ca4db20b2a16
prerequisite-patch-id: cd98b74fa56af72af2553f391c400981d83cd4f4
prerequisite-patch-id: b730f5e42be1d89d193e63a0265495cdbf2c7d7b
prerequisite-patch-id: 9debd88fa60febed9cd7208f86603b4c2d270520
prerequisite-patch-id: 314ef9ff0c4d1d15dab1dea9d92aa065f1eac3e9

Best regards,
-- 
Ronald Claveau <linux-kernel-dev@aliel.fr>


