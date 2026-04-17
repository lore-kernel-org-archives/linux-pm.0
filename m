Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DA12253B0;
	Fri, 17 Apr 2026 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776443824; cv=none; b=slEggSWkoCV6Wiv6U1jWU+R7y395TgoUAZ0PUfjChUfCKVAvOzyIerKRsnZN1fXIzTKDN90bPY1wmzZ2IZrUCvVd/Fa61gy78miXU3Zud5OvgABE2rmw/iVANbZW71Kx5iuslpyqCwN4r30ZXVSqgFQB9fV6mqseYQMuov1dASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776443824; c=relaxed/simple;
	bh=uS2szcV8ZT3F8/LCPh0bI6HAteL/Y/XquZjtlV5xxe8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kEl+bhSCNOh0ypHHh/8xmq5mNSezUA+8wV5+jCAIwYg5hYi8k5jw1Wv26nimN98Y8EBdPr/Fib65kqxhXLOtitC9CPYtinQvzIO/6H6RTc9Xo3cbdEE1UlpJ9sWug+14lXyBHw5UyNIF7JJoqmvCGZoQjTfEb4gr2ObLPh+wp10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=vbc1gMEr; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="vbc1gMEr"
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1776443819;
	bh=uS2szcV8ZT3F8/LCPh0bI6HAteL/Y/XquZjtlV5xxe8=;
	h=From:Subject:Date:To:Cc;
	b=vbc1gMErmKFycyh29jUEKEFP9DZou2BDzG8KHpQV3wUyru7Crjp50gpvj3ibr70L1
	 3u9ZGtgJ7hnIazfEGMYe/dbPueVav+0PW4SiB7HUNHAoWka1u+9a/z1QgM7Qkq1wgM
	 Hub0UobjOTSiwHH/4bck6bcG+BEp4f/9IQj904JU=
Subject: [PATCH v3 0/8] Add VIM4 MCU/FAN support
Date: Fri, 17 Apr 2026 18:27:16 +0200
Message-Id: <20260417-add-mcu-fan-khadas-vim4-v3-0-a6a7f570b11b@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WS3W7bMAyFXyXw9RToX5YxDH2PYhekSDVabSe1H
 aNFkXef4uYiwTbskhLOd8hDfjYzT4Xnptt9NhOvZS7HsRbm265JBxhfWBSqdaOl9tJKLYBIDOk
 sMozi9QAEs1jLYAUklZCdMyliU9WniXN538jPP7/qid/O1WD5emwQZhbpOAxl6XYjvy9iMzE6X
 PUDzzNs9t3u++3Dy6i9dXslXS2UUOJXgXF/OD/B0B9fStpX3I/NHZZ02LTegaPgcyasnRkANKZ
 1iN4llDpIaZORHPhRpU3QPrZStdoTGaCQUXlGS4E8WQZ00urQPqpc4IiyhehbYMrOGjIkyfmUV
 QJLqCVqUL65T7ea3abbssU0WBOcviZTyQV7FlynBptDDAa6VT+aYjAyO7YaWVEbSUXD3kBlOht
 dIsw6BQr4V1MjRd2SKOMKfSFxmo4nnpYPgXWVlqIxOaib459atWlr9GIJYjz3vZh45rpG9LJlz
 JHAdqtqrus/lHk5Th/bndWn6/7/e1KrErLClK65Qwoon2qT3O/ztCFrW3cY82+MrphQT8aj1tZ
 EuMNcLpffN5RUPgMDAAA=
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
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1776443815; l=4307;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=uS2szcV8ZT3F8/LCPh0bI6HAteL/Y/XquZjtlV5xxe8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QP3yXGDMzYPLm6aT9Wmu5TjhkeYr8dxMrjRTyQnh+FJjS/xvjLT+ClwabRCWo7jzMkzH81hRXC3
 2vBUNknyNKgI=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs

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
 .../devicetree/bindings/mfd/khadas,mcu.yaml        |   5 +
 .../dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts  |  13 +++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        |  20 ++++
 drivers/mfd/khadas-mcu.c                           | 106 ++++++++++++++++++---
 drivers/thermal/khadas_mcu_fan.c                   |  49 ++++++++--
 include/linux/mfd/khadas-mcu.h                     |  39 +++++++-
 7 files changed, 222 insertions(+), 23 deletions(-)
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

