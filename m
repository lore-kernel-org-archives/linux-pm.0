Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E2318EE2;
	Mon, 13 Apr 2026 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077796; cv=none; b=Y5iGMPl7X8AET2tKnaIxkI/oPHTVMcjKBveKU3bEFn+pDq3VKyayIXp5pyViCQHCKmkBq+DcmtfHFDlU8gdeq754Ssg87DUFn4qR6wkIv3+gb5EpD+VVywtIAC01wC/AApw/BLqY8G/bhEWhlY+b5Kn30glZI4RMyUR2cNqW8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077796; c=relaxed/simple;
	bh=VH/voXByB5HtcB/2r/SxeBGsrj4jRhHLjfwo5awLI+E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ueiCVKaebZ+pXI/dwww7o79vQbaXF6BSNmRVSSMM9q8sMsG6QKX35Gl78iqYzAYKQpRXjQvOIqZQGjKwxoajE9p/kUS5JSZDakxS7X20ptsmNZ3ahjDWCBAnvAXUWLxwA8grrvXAaJuxPwKf62AxEXxrvuzAvuA26yInPOr8560=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=LuQrh8R0; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="LuQrh8R0"
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1776077792;
	bh=VH/voXByB5HtcB/2r/SxeBGsrj4jRhHLjfwo5awLI+E=;
	h=From:Subject:Date:To:Cc;
	b=LuQrh8R0ELHCVZfe5/zqqS1C9CUwyY2Jrs0tsOXwuK0C1VXq+A8QovHHIQs5jbyt/
	 fJ54lrzLcAnluI4bijG4C5j3PJPMJEsfzQZZMSC9ol8hQ/X7rhksUUrm2PAZCEiKFC
	 QvtU/oJGzYmhovPzZ/Piz7bbtwOCgTg9VrJXjdSo=
Subject: [PATCH v2 0/8] arm64: amlogic: T7 thermal support
Date: Mon, 13 Apr 2026 12:52:41 +0200
Message-Id: <20260413-add-thermal-t7-vim4-v2-0-1002d90a0602@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/31Sy27bMBD8FUPn0uCbolEU+Y8gh13uMmIjyY4kC
 wkC/3tp2YcaDXrgYQnMDObx1cw8FZ6bw+6rmXgtczmO9dA/dk3qYHxlUajejZbaS6ukACKxdDw
 N0IsliLUMVkjJLigESkk1FXmaOJePjfX55XZP/H6u5Mvtsxl4nmEjP+x+btymvqi9dXslXT2UU
 OJ3gXHfnZ9g6I+vJe3Tcfi18cOSug3rHTgKPmfCFNEAoDGtQ/QuodRBSpuM5MCPKG2C9rGVqtW
 eyACFjMozWgrkyTKgk1aH9hHlAkeULUTfAlN21pAhSc6nrBJYQi1Rg/LN39lVsbu7LTlMgzXBa
 VGtVOaCPQuursHmEIOBw6ofRTEYmR1bjayojaSiYW+gcjobXSLMOgUK+K2okaL2IMq4Ql9InKb
 jiaflUyCysxSNyUHdFf/Fqg1bo7/WPJ77Xkw88yI0etky5khgD6v6Dmyl3twO6SwyjOKtA4L5t
 hVIKlV5Z2pfd22Ema+BDGU57Eb+qBq3zEJzXU9X5uU4fW4TrXrX+fx3jasSUqiYNbYEoXb6VN1
 zv89T83K5XP4APzABivMCAAA=
X-Change-ID: 20260410-add-thermal-t7-vim4-00e571badcc1
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1776077788; l=5536;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=VH/voXByB5HtcB/2r/SxeBGsrj4jRhHLjfwo5awLI+E=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QI9Kcp7fysQlVZVvMcg6K6TWQFUp6iYfci2zxdto5lYVPWlnkIdx+Z32YaDSz5jiGLl8XIVpg7P
 eWihqS7SvlQA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs

This series adds thermal monitoring support for the Amlogic T7 SoC,
used on the Khadas VIM4 board.

The T7 exposes six thermal sensors (a53, a73, gpu, nna, vpu, hevc),
each accessible through the secure monitor firmware interface rather
than a directly mapped eFuse register as on older SoCs.

The series is organized as follows:

- Patch 1 extends the amlogic,t7-thermal DT binding to describe the
  new amlogic,secure-monitor property.
- Patches 2-3 extend the Meson secure monitor driver to expose a
  thermal calibration read command (SMC ID 0x82000047).
- Patch 4 adds the secure monitor readout path to the amlogic thermal
  driver and introduces the amlogic,t7-thermal compatible.
- Patches 5-7 wire up the T7 DTSI with CPU cooling cells, sensor
  nodes, and thermal zones.
- Patch 8 extends the Khadas VIM4 DTS to map all thermal zones to the
  on-board MCU fan controller (states 30–100, corresponding to the
  FAN_CTRL register range 0x1E–0x64).

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
Changes in v2:
- PATCH 1: change two const entries to enum, explain why sensor index is needed
  reorder conditional compatible for required, and fallback only according to
  Krzysztof's feedback.
- PATCH 3: Add kerneldoc for meson_sm_get_thermal_calib exported function
  according to Krzysztof's feedback.
- Link to v1: https://lore.kernel.org/r/20260410-add-thermal-t7-vim4-v1-0-19f2b8da74d7@aliel.fr

---
Ronald Claveau (8):
      dt-bindings: thermal: amlogic: Add support for T7
      firmware: meson: sm: Thermal calibration read via secure monitor
      firmware: meson: sm: Add thermal calibration SMC call
      thermal: amlogic: Add support for secure monitor calibration readout
      arm64: dts: amlogic: t7: Add cooling cells to all CPUs
      arm64: dts: amlogic: t7: Add thermal sensor nodes
      arm64: dts: amlogic: t7: Add thermal zones
      arm64: dts: amlogic: t7: khadas-vim4: Add fan cooling to thermal zones

 .../bindings/thermal/amlogic,thermal.yaml          |  42 +++-
 .../dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts  | 102 +++++++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        | 245 +++++++++++++++++++++
 drivers/firmware/meson/meson_sm.c                  |  29 ++-
 drivers/thermal/amlogic_thermal.c                  |  58 ++++-
 include/linux/firmware/meson/meson_sm.h            |   3 +
 6 files changed, 467 insertions(+), 12 deletions(-)
---
base-commit: f7b64ed948718290209074a50bb0df17e5944873
change-id: 20260410-add-thermal-t7-vim4-00e571badcc1
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
prerequisite-change-id: 20260402-add-mcu-fan-khadas-vim4-ac1cbe553c9b:v2
prerequisite-patch-id: f03a086b4137158412b2d47b3de793b858de8dde
prerequisite-patch-id: 123970c9b29c2090440f2fd71c85d3c6fd8e36de
prerequisite-patch-id: 3e2e56b0926ba327b520f935df4ced5089bbe503
prerequisite-patch-id: 65a5d76ffdbc9b3aab3385bb65cb027004c30e7e
prerequisite-patch-id: 237269801826dd3ad7fb16eb4d7d6d4eab504278
prerequisite-patch-id: 57e9b08a968aedf543d3d0d56cf1ca4db20b2a16
prerequisite-patch-id: cd98b74fa56af72af2553f391c400981d83cd4f4
prerequisite-patch-id: b730f5e42be1d89d193e63a0265495cdbf2c7d7b
prerequisite-patch-id: 8d675e7a239985c762843515b241f0a2f45f9c92
prerequisite-patch-id: 9debd88fa60febed9cd7208f86603b4c2d270520
prerequisite-patch-id: 314ef9ff0c4d1d15dab1dea9d92aa065f1eac3e9
prerequisite-patch-id: 34a2bbfe3ce30c530e69af5083aa26534b2c2560
prerequisite-patch-id: 406f88d7dabd3a870b358fb53c21686f29eb32b7
prerequisite-patch-id: d7a75ae3be0f54e0a7e81ccb0043a2f05423c9d0
prerequisite-patch-id: 5e19dc5ace12b532284246f5c2ff3f214d8a9c4f
prerequisite-patch-id: d6a87ebcf5246eb67b94ca0908afa3df9f9383fe
prerequisite-patch-id: 4809bbedf79f59e1abc52c17cffc0b1bbb43d365
prerequisite-patch-id: c050e8bac4b5491f6c7008a5ccb26f20fad38b46
prerequisite-patch-id: 30677db8fc57270787245103c0d5acf8791307b0

Best regards,
-- 
Ronald Claveau <linux-kernel-dev@aliel.fr>

