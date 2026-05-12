Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076D832E137;
	Tue, 12 May 2026 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563300; cv=none; b=nILe4htDTN598uZSLQjFxL1M/mwncl+0pf5lgpT6QQogPtQWlB/rXEHxu2vrufSplRP8jdo8zCNt1+4sGoFldrUyH/4KX9XeTrhPwNfR6tMrbspOoV4iTRt6sxOzfkRsAUPrembYdg+3+8t+ys19v++LIT4HbBxVEGvriasj8w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563300; c=relaxed/simple;
	bh=P/jMSfPtRFdohnZ2RbfEsPmgWw03TgQcG7fDYV/R02w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c0vqpoddz8lvDsUn0WoPSeOguCuS0ycywzv7O3JW9B9j+xUwZ4r09jhB4fZ/b8hkS0G3JJ79yXsag12SpI1XEjAOcWPKwDqcF9vgFbBV3UEjCULIDqNyFKUezlaVXl3w61wAgL3BqX+hCkzTNF6h358mkUaIg/5U1OLvwbs7HQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg2c0rb9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg2c0rb9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EF4FC2BCB0;
	Tue, 12 May 2026 05:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778563299;
	bh=P/jMSfPtRFdohnZ2RbfEsPmgWw03TgQcG7fDYV/R02w=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Vg2c0rb9AB/F9ZnCCo50AaHEmR41/v00FIMB9J1xy04IvouVoZIKrX1m4H+HFxUUR
	 13AAF6yprSLygajqzZHFZhVozG49SfjCZM0AkJ5ZsXRtKPQ1T1jWjFttp+VUdCsc56
	 drfIPGkzb9SHj8iw4GAqU6amLCNIeD5cGge9QVXt0xox6q/znCqb9qY3NIa1rL87hP
	 ZGMeE0WGh+WdXVwMFepftiURNSeNomFNvCnY+Xlf19fpBfrOWS7S12GmwxR2Qnth8Q
	 i1ANC3ZfzFD4fuKwexRPrrN5HjkU5hbWye9B35hIXFYNB7kpExiflK5ys8AG8V7/9c
	 V8157VjSgEwGA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80277CD4851;
	Tue, 12 May 2026 05:21:39 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH v2 00/16] add AUXADC, EFUSE and thermal drivers for the
 MediaTek mt6323 PMIC
Date: Tue, 12 May 2026 08:18:14 +0300
Message-Id: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWNQQ6CMBBFr0JmbU2ZUhRW3sOwoDCVMUJJW4mGc
 HcBw/Il778/QyDPFKBMZvA0cWA3rICnBJquHh4kuF0ZUGIutUTRx1yhEkVGqcUWa2MUrPLoyfJ
 nD92rP4e3eVITt/VmdByi89/9aUo374hmR3RKhRSXojD6apTW1t5G76Ib+ppf58b1UC3L8gPPy
 SFqswAAAA==
X-Change-ID: 20260502-mt6323-94e1f2d2abb3
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Roman Vivchar <rva333@protonmail.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ben Grisdale <bengris32@protonmail.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778563297; l=4770;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=P/jMSfPtRFdohnZ2RbfEsPmgWw03TgQcG7fDYV/R02w=;
 b=CiMrazcWzqkeUeN4GpsK+aPXiZqRaZvE5U6erqpDpkh3lqXtLpKViX6H2PBX4tNxkpFqGvyex
 d6tQ2/tzsVoAHl2n31m/GrYtnBAEB8ddGN/aQIHsyCvDS/khlpOOHah
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

This series adds support for AUXADC, EFUSE and thermal drivers for the
MediaTek mt6323 PMIC

Usually vendor downstream kernels for devices with mt6323 include various
useful drivers like AUXADC, thermal, fuel gauge etc. Bring it to the
upstream kernel by rewriting some drivers from 3.18 vendor tree.

Currently dt-bindings limit some values like ADC channel count and names
to what mt6323 has, but the drivers were designed in a way to support
other PMICs like mt6358 (which has very similar thermal logic).

Tested on the MediaTek mt6572 and mt8163 SoCs, both paired with mt6323.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
Changes in v2:
- dt-bindings:
    - Drop Tested-by tags (Krzysztof)
    - AUXADC: drop mt6323 standalone binding and merge into mt6359 (Krzysztof)
    - EFUSE: drop mt6323 standalone binding and merge into mt6397 (Krzysztof)
    - Thermal: drop iio-channel-names, nvmem-cells description, unused label (Rob)
    - Thermal: Merge into mt6397 mfd
- AUXADC driver:
    - Fix formatting for macro, OF table, etc (Andy, Jonathan)
    - Drop dev field from the mt6323_auxadc struct (Andy)
    - Use dt-bindings constants for channels instead of raw numbers
    - Simplify mt6323_auxadc_check_if_stuck implemenetation with iopoll (Andy)
    - Drop untested audio channel support (Andy, Jonathan)
    - Replace check for chan->address with chan->channel to avoid confusion (Jonathan)
    - Replace scoped_guard with guard in mt6323_auxadc_read_raw (Andy)
    - Replace mutex_init with devm helper in probe (Andy)
- EFUSE driver:
    - Add comments about read function (Andy)
    - Use sizeof() (Andy)
- Thermal driver:
    - Rename to mtk_pmic_thermal for proper module name
    - Add module name to Kconfig
    - Use bitfield.h APIs for efuse extraction (Andy)
    - Drop nvmem cell name for consistency with devicetree bindings
    - Replace raw numbers with constants (Andy)
    - Add comments to read function, remove redundant parentheses (Andy)
    - Add comments to precalc function, simplify it for readability (Andy)
    - Reorder struct fields (Andy)
    - Drop cali_val field, since per-PMIC functions are used
    - Use __free for nvmem_cell_read cleanup (Andy)
- Maintainers:
    - Split patch into 3 for different subsystems (Krzysztof)
    - Downgrade to "Odd fixes"
- Note: Signing key has been changed since v1. Sorry for inconvenience
- Link to v1: https://patch.msgid.link/20260504-mt6323-v1-0-799b58b355ff@protonmail.com

---
Roman Vivchar (16):
      dt-bindings: iio: adc: mt6359: generalize description for mt63xx series
      dt-bindings: iio: adc: mt6359: add mt6323 PMIC AUXADC
      dt-bindings: mfd: mediatek: mt6397: add mt6323 PMIC EFUSE
      dt-bindings: mfd: mediatek: mt6397: add mt6323 PMIC thermal
      iio: adc: mediatek: add mt6323 PMIC AUXADC driver
      nvmem: add mt6323 PMIC EFUSE driver
      thermal: mediatek: add PMIC thermal support
      mfd: mt6397-core: add mt6323 AUXADC support
      mfd: mt6397-core: add mt6323 EFUSE support
      mfd: mt6397-core: add mt6323 thermal support
      ARM: dts: mediatek: mt6323: add AUXADC support
      ARM: dts: mediatek: mt6323: add EFUSE support
      ARM: dts: mediatek: mt6323: add thermal support
      MAINTAINERS: add MediaTek mt6323 PMIC AUXADC driver maintainer
      MAINTAINERS: add MediaTek mt6323 PMIC EFUSE driver maintainer
      MAINTAINERS: add MediaTek mt6323 PMIC thermal driver maintainer

 .../bindings/iio/adc/mediatek,mt6359-auxadc.yaml   |   3 +-
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml   |  65 +++++
 MAINTAINERS                                        |  15 +
 arch/arm/boot/dts/mediatek/mt6323.dtsi             |  40 +++
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/mt6323-auxadc.c                    | 319 +++++++++++++++++++++
 drivers/mfd/mt6397-core.c                          |   9 +
 drivers/nvmem/Kconfig                              |  11 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/mt6323-efuse.c                       |  86 ++++++
 drivers/thermal/mediatek/Kconfig                   |  12 +
 drivers/thermal/mediatek/Makefile                  |   1 +
 drivers/thermal/mediatek/mtk_pmic_thermal.c        | 316 ++++++++++++++++++++
 .../dt-bindings/iio/adc/mediatek,mt6323-auxadc.h   |  24 ++
 15 files changed, 914 insertions(+), 1 deletion(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260502-mt6323-94e1f2d2abb3

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


