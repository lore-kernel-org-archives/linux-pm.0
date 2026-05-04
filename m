Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13223E5583;
	Mon,  4 May 2026 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919098; cv=none; b=YZeiuBJGIg7m7j9n1/HpewHz+mZUZIvtkpDVaGuuwqAt1u48Du5RE7Pco9SPhquQ91SRTOMNNWXf3md4S/KtF5pLzxki8mpqh7qhktBodYfEx1R3LQwa8HSy30I0ZIh8ryjqpqojCV5+8HZxXuR59mbTjqM3sZ2aiVjjVRVSChg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919098; c=relaxed/simple;
	bh=QYhlAZ3CmOdhVVfeWniyHMUkBmi9/VkBz61p37XrddE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IofXtBeGLcabf/58sptCLdOty3o+xzNh6foTMCjnO4SYMd6Q9qpGDH1TRmSfWSkDFJp+Z5SH+B0jzvXV1kVK6V5ujgdfSx5GS7sn+ymz73GmY/nYjF4SAqahl66LjyNzr+z28iRH1X7amCoS7FZ8pBnFTYFdomLSX8bOEdd9KYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu7pVB5Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu7pVB5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78D87C2BCB8;
	Mon,  4 May 2026 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777919098;
	bh=QYhlAZ3CmOdhVVfeWniyHMUkBmi9/VkBz61p37XrddE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qu7pVB5Z+Fti0eh5R7o4ePLqloDkhg/rPuNC+jm++mu5LEGORB67ThZlaB4Ri6REd
	 h9k3PZDK50VzbGjjW6to0CZ3WYG0JKpKddijq3iBM/j6MUBj6IS8JeP2QGBV/AmJ/f
	 opBFVbpeJQwBStAro4VeWFGJi7YCpHj639JioMKBtknoJcM+/nAT1OknxZbHmuhOo8
	 g5FRyEkINzqEhfHst5RqbQN1DzzxF9nv8pANcmBAq/erH8+f9Z/ucGfsZPMRJsIYkJ
	 MOTHJyj0MIwgo8a09bKuJelLt2gmZ4rLYLlnREHi3n7hdc/WGqlT/+WWEa1H77BwF5
	 4vjunr/b3eLzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452C2CD342F;
	Mon,  4 May 2026 18:24:58 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH 00/13] add AUXADC, EFUSE and thermal drivers for the
 MediaTek mt6323 PMIC
Date: Mon, 04 May 2026 21:24:52 +0300
Message-Id: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwMj3dwSM2MjY11Lk1TDNKMUo8SkJGMloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AsRoavGoAAAA=
X-Change-ID: 20260502-mt6323-94e1f2d2abb3
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777919095; l=2679;
 i=rva333@protonmail.com; s=20260325; h=from:subject:message-id;
 bh=QYhlAZ3CmOdhVVfeWniyHMUkBmi9/VkBz61p37XrddE=;
 b=HnPIZLJxYhQb7c7hv5WLcTV2Su7mCxPFsQG4AYkl+FX9MpAm+P9sqwlSxYaIA8rUnf5jsv0hA
 hEI5QMSVOeAAjC+pse0XZEk6Ve0do2DE/vjHgpCOLUXF/3zs0ZaWYhy
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=euuVBZGtA2Cqb8Dju84qpQPhvwxyUirJlXpqEPQWKBM=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260325 with
 auth_id=695
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
Roman Vivchar (13):
      dt-bindings: iio: adc: add mt6323 PMIC AUXADC
      dt-bindings: nvmem: add mt6323 PMIC EFUSE
      dt-bindings: thermal: add mt6323 PMIC thermal
      iio: adc: mediatek: add mt6323 PMIC AUXADC driver
      nvmem: add mt6323 PMIC EFUSE driver
      thermal: mediatek: add pmic thermal support
      mfd: mt6397-core: add mt6323 AUXADC support
      mfd: mt6397-core: add support for mt6323 efuse
      mfd: mt6397-core: add support for mt6323 thermal
      ARM: dts: mediatek: mt6323: add support for AUXADC
      ARM: dts: mediatek: mt6323: add support for EFUSE
      ARM: dts: mediatek: mt6323: add support for thermal
      MAINTAINERS: add mt6323 drivers maintainer

 .../bindings/iio/adc/mediatek,mt6323-auxadc.yaml   |  39 +++
 .../bindings/nvmem/mediatek,mt6323-efuse.yaml      |  42 +++
 .../bindings/thermal/mediatek,mt6323-thermal.yaml  |  63 ++++
 MAINTAINERS                                        |  18 +
 arch/arm/boot/dts/mediatek/mt6323.dtsi             |  42 +++
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/mt6323-auxadc.c                    | 372 +++++++++++++++++++++
 drivers/mfd/mt6397-core.c                          |   9 +
 drivers/nvmem/Kconfig                              |  11 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/mt6323-efuse.c                       |  86 +++++
 drivers/thermal/mediatek/Kconfig                   |   9 +
 drivers/thermal/mediatek/Makefile                  |   1 +
 drivers/thermal/mediatek/pmic_thermal.c            | 274 +++++++++++++++
 .../dt-bindings/iio/adc/mediatek,mt6323-auxadc.h   |  16 +
 16 files changed, 996 insertions(+)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260502-mt6323-94e1f2d2abb3

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


