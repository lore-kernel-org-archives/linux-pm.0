Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00B3C7E19
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769763; cv=none; b=aYlpjDKh4n8RWB48aqU4MPuJCQUcjguDYcpsyKtNkyAmGaTDsOi8qHcj4Aaku0yfsZbPQ1BUfRKjOCnTVrgMFUHvD70/rH0L1AAt8MXD0gGnSOuvzpRgcYrHO5f6UmXDe16Kh9LxkJkIBONMD5sHH+tzsGmic9HX3mrZ51NEDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769763; c=relaxed/simple;
	bh=kEMHPVhKaY97RJNVbyCNGkuUcXWOTpfvD5iOeHK/aRc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Cx38tZsnGeJW3ePHeYJLcwCo2SB0DG0FMrstF9kfUd4FqZMkskgfZ88zBCnCm5ho5E2h6roe4nJ0TimsUS01u84PnCsiFFGxou0p2627yEkfjq6k2xC+zhGsSzo87VxLiM9cVLwUEbSvPQdpJ6skStQpuVGyFwF4sUiidZiNgXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqSH8cNe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqSH8cNe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6341F00AC4
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 18:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787769751;
	bh=N6Hwr22yRm36zz124yMp2U2W2ivdLhYJVTBuxmzuyj8=;
	h=From:Date:Subject:To:Cc;
	b=IqSH8cNeU2fiQs2yvpHKT2MEOy38PtjJhZ7SEWEB6RK0nFLZl9Za/8kud4HX68Cnr
	 nZ5oUiJ1FsuYcr9SCVRqTr2S5Sf7Lets5O916r2Os9+1bDVHMaq650dcTrFBkfNyWS
	 RHMAwTyWSk91QdlQk+OgBR6/B/eBOTvfKLLyA+KIWA+UPbO2vo4yq9aKYJo4SPj1C8
	 sJJojWYRlyBt0FBQoowRZkQjME8/E9f/eKG4KhYV3QbIi+/qWdvP5cAWpSdSyAOd2o
	 9q8WroOSZ0//o+oTsMvFvF4OfydFsznouXdwlagZlxKd87ztD4JDYsP3bq3oWDcefI
	 teELzqsqAi1rQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c95395230so10788661fa.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 11:42:31 -0700 (PDT)
X-Gm-Message-State: AFuF++l0GX2REAhYjz5hhbSh0R7QaFH9Ja9DbBWdFD5ltaEMrxbE3zM5
	Yo99a0lbX4RaE/zh/5lE+yKw4+WhUuJBboCee8L4Mc3Ui2L21nAc93jpPSO6k3leWVvuq7LWHs0
	rZZLT90URJzSZxxuyuzwfxuWnkSJiIHg=
X-Received: by 2002:a05:651c:2108:b0:39a:da70:2c77 with SMTP id
 38308e7fff4ca-3a1fd5ab5a0mr23691831fa.3.1787769749638; Wed, 26 Aug 2026
 11:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 26 Aug 2026 20:41:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g_k+WA+7aKKMw46h25uL0t+1gqQT3DAtgCWX91TcvFRQ@mail.gmail.com>
X-Gm-Features: AcwNN1VTrB2Ji-RJbEhRTCg0uJpi9j2dquRL02QiAu9dW_DI5WQ9DIgskuoSAUo
Message-ID: <CAJZ5v0g_k+WA+7aKKMw46h25uL0t+1gqQT3DAtgCWX91TcvFRQ@mail.gmail.com>
Subject: [GIT PULL] More thermal control updates for 7.3-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-7.3-rc1-2

with top-most commit 79a57e48822a88f082a4dadb366abaf3c0988b5d

 thermal/drivers/qcom-spmi-mbg-tm: Add module namespace import for IIO_CONSUMER

on top of commit 2d5667b6c3d7adf0f8551bbac7c707fb87155611

 Merge branches 'thermal-core', 'thermal-hwmon', 'thermal-intel' and
'thermal-tools'

to receive the second part of thermal control updates for 7.3-rc1.

This mostly consists of assorted updates of thermal drivers, including
new hardware support (Airoha AN7583, Qualcomm Master BandGap thermal
monitor, QCom PMIC5 Gen3 ADC), but it also includes two reverts of
recent cosmetic thermal core updates that went against driver core
plans to eliminate class_create():

 - Fix missing bitfield include headers in Armada and QCom SPM BMG
   drivers (Daniel Lezcano)

 - Fix missed file when manually applying a change after a conflict
   resolution for the QCom SPMI ADC TM5 Gen3 (Daniel Lezcano)

 - Move thermal_zone_device_enable() to the right place in order to
   prevent calling it if the thermal zone registration failed (Dan
   Carpenter)

 - Improve bitfield manipulations on Armada (Bryan B. Lima)

 - Remove unneeded 'fast_io' on Sun8i and Armada (Wolfram Sang)

 - Fix wrong boundary when clamping the low values in the set_trips()
   callback and fix wrong mask when setting the temperature interval on
   Airoha (Christian Marangi)

 - Make use of the regmap API to support Airoha AN7583 (Christian
   Marangi)

 - Fix adc_tm5_get_temp() return check value on the QCom SPMI ADC
   sensor (Rakesh Kota)

 - Fix unbalanced clock enablement when the resume fails on the iMX
   driver (Can Peng)

 - Add Qualcomm Master BandGap thermal monitor support (Satya Priya
   Kakitapalli)

 - Add Maili Temperature bindings compatible (Haritha S K)

 - Add a devm action to clean hardware interrupts, sampling, and
   control registers on Spacemit K1 (Pei Xiao)

 - Fix trivial typo in a thermal OF code comment (Marek Vasut)

 - Remove unnecessary print on Qcom SPMI ADC driver when a call to
   devm_request_threaded_irq() fails as this one already prints a
   message (Jishnu Prakash)

 - Add support for QCom PMIC5 Gen3 ADC by using auxiliary driver and
   shared interrupt with the IIO driver (Jishnu Prakash)

 - Make resets optional on MT8196 and add the corresponding property in
   the DT bindings (AngeloGioacchino Del Regno)

 - Fix clock staying enabled on failing resume operation on Qoriq (Can
   Peng)

 - Fix wrong closing brace position in thermal library header (Andreas
   Haufler)

 - Fix low and high trip point validation by moving the check after the
   clamp on the spacemit driver (surendra)

 - Remove redundant error messages on IRQ request failure (Pan Chuang)

 - Add IIO_CONSUMER namespace import to the qcom-spmi-mbg-tm thermal
   driver to avoid modpost warnings that would appear after merging the
   iio tree against the thermal updates (Nathan Chancellor)

 - Revert two recent cosmetic updates of the thermal core conflicting
   with driver core plans to eliminate class_create() (Rafael Wysocki)

Thanks!


---------------

Andreas Haufler (1):
      tools/lib/thermal: Fix misplaced extern "C" closing brace

AngeloGioacchino Del Regno (2):
      dt-bindings: thermal: mediatek: Make resets optional for MT8196
      thermal/drivers/mediatek/lvts_thermal: Make reset optional for MT8196

Bryan B. Lima (1):
      thermal/drivers/armada: Use bitfield and bitmask macros

Can Peng (2):
      thermal/drivers/imx: Disable clock on runtime resume failure
      thermal/drivers/qoriq: Disable clock on resume failure

Christian Marangi (7):
      thermal/drivers/airoha: Fix copy paste error on clamp_t low temp
      thermal/drivers/airoha: Fix copy paste error for sen internal
      thermal/drivers/airoha: Convert to regmap API
      thermal/drivers/airoha: Generalize probe function
      thermal/drivers/airoha: Generalize get_thermal_ADC and set_mux function
      dt-bindings: arm: airoha: Add the chip-scu node for AN7583 SoC
      thermal/drivers/airoha: Add support for AN7583 Thermal Sensor

Dan Carpenter (1):
      thermal/drivers/rcar: Fix error checking in probe()

Daniel Lezcano (2):
      thermal/drivers/qcom/spm mbg tm: Fix missing bitfield header
      thermal/drivers/armada: Fix missing bitfields include

Haritha S K (1):
      dt-bindings: thermal: qcom-tsens: Document the Maili Temperature Sensor

Jishnu Prakash (4):
      iio: adc: qcom-spmi-adc5-gen3: Remove an unnecessary print
      iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ with ADC_TM
auxiliary driver
      thermal/drivers/qcom: add support for PMIC5 Gen3 ADC thermal monitoring
      thermal/drivers/qcom: Fix missing spmi adc tm5 gen3 file

Marek Vasut (1):
      thermal/of: Fix trivial enabled typo

Nathan Chancellor (1):
      thermal/drivers/qcom-spmi-mbg-tm: Add module namespace import
for IIO_CONSUMER

Pan Chuang (1):
      thermal/drivers: Remove redundant error messages on IRQ request failure

Pei Xiao (1):
      thermal/drivers/spacemit/k1: Add shutdown action and reorder
registration order

Rafael J. Wysocki (2):
      Revert "thermal/core: Use the thermal class pointer as init guard"
      Revert "thermal/core: Allocate the thermal class dynamically"

Rakesh Kota (1):
      thermal/drivers/qcom-spmi-adc-tm5: Drop IIO_VAL_INT check in
adc_tm5_get_temp

Satya Priya Kakitapalli (2):
      dt-bindings: thermal: Add Qualcomm MBG thermal monitor support
      thermal/drivers/qcom: Add support for Qualcomm MBG thermal monitoring

Wolfram Sang (1):
      thermal: Remove unneeded 'fast_io' parameter in regmap_config

surendra (1):
      thermal/drivers/spacemit: Validate clamped trip thresholds

---------------

 .../bindings/arm/airoha,en7581-chip-scu.yaml       |  14 +
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   4 +
 .../bindings/thermal/mediatek,lvts-thermal.yaml    |  13 +-
 .../bindings/thermal/qcom,pm8775-mbg-tm.yaml       |  72 ++++
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 drivers/iio/adc/qcom-spmi-adc5-gen3.c              |  69 +---
 drivers/thermal/airoha_thermal.c                   | 382 ++++++++++++++----
 drivers/thermal/armada_thermal.c                   | 107 +++--
 drivers/thermal/broadcom/brcmstb_thermal.c         |   3 +-
 drivers/thermal/db8500_thermal.c                   |   8 +-
 drivers/thermal/hisi_thermal.c                     |   4 +-
 drivers/thermal/imx91_thermal.c                    |   2 +-
 drivers/thermal/imx_thermal.c                      |  13 +-
 drivers/thermal/loongson2_thermal.c                |   2 +-
 drivers/thermal/max77620_thermal.c                 |   8 +-
 drivers/thermal/mediatek/lvts_thermal.c            |  17 +-
 drivers/thermal/qcom/Kconfig                       |  23 ++
 drivers/thermal/qcom/Makefile                      |   2 +
 drivers/thermal/qcom/lmh.c                         |   1 -
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c      | 434 +++++++++++++++++++++
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   3 -
 drivers/thermal/qcom/qcom-spmi-mbg-tm.c            | 257 ++++++++++++
 drivers/thermal/qcom/tsens.c                       |   5 +-
 drivers/thermal/qoriq_thermal.c                    |  13 +-
 drivers/thermal/renesas/rcar_thermal.c             |  19 +-
 drivers/thermal/renesas/rzg3e_thermal.c            |   4 +-
 drivers/thermal/rockchip_thermal.c                 |   3 +-
 drivers/thermal/samsung/exynos_tmu.c               |   4 +-
 drivers/thermal/spacemit/k1_tsensor.c              |  78 +++-
 drivers/thermal/st/st_thermal_memmap.c             |   4 +-
 drivers/thermal/st/stm_thermal.c                   |   5 +-
 drivers/thermal/sun8i_thermal.c                    |   1 -
 drivers/thermal/tegra/soctherm.c                   |   8 +-
 drivers/thermal/tegra/tegra30-tsensor.c            |   3 +-
 drivers/thermal/thermal-fw.c                       |  12 +
 drivers/thermal/thermal_core.c                     |  27 +-
 drivers/thermal/thermal_fw.c                       |  97 +++++
 drivers/thermal/thermal_of.c                       |   2 +-
 include/linux/iio/adc/qcom-adc5-gen3-common.h      |   2 -
 tools/lib/thermal/include/thermal.h                |   4 +-
 40 files changed, 1442 insertions(+), 288 deletions(-)
