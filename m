Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD866296BCF
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923933; cv=none; b=gTG/lpVlweD17ggK4cdFYYPpNd6662IxzMDupyfDwrCpT5ttsedT26CYZCungsl57dU9PVqEme405m6ryMWxgOirIS2tKE92iZ2J3gTsQCjk7BDkNeFuZleRCHgSl/olzLeJ+BNS1VMkw7FTLRLN7roAabzFhEIi6aW0c7QFHic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923933; c=relaxed/simple;
	bh=bj9uGx2zcaC9MZgj03Wp52zVHxKCHKRbFfbstVt6FMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDRYT85HsTazNrtkzwmKXn/PXpnVYMfBmJ2IFFRTbV63l7JqM/6c8TAnb1Z1kMVr9LKCambx/KbCFfBvqpazdrlhuuo5vNrrMULLT1cUsrbvHWpTf2QsZSsailW6AWUjy9SLvkprhuvD5ATnqvKk0iyfcBq6A2K4NFs9CYnRPWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIcnSXqa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIcnSXqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAF81F008A5
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780923932;
	bh=SboXwzi9OQrRuJu7TDb7TJLyBM1KLCYtEQz5fRdlI/Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UIcnSXqa0MDnNiPuFc8kMRQZM/CRSLbrSs4SqLocKjNS0zBMaNAilVXjrDhWsBVRA
	 9vuGko45T4r4VF50QNj9qF0tZucCfP42rgvrJokj7H3qJ5yBIiOZfkPAnuumqbENgv
	 yYR5JlfJZnHCQkmpTu+9SgrevfwyZqyMNw/tSdELcGNjYUUSfFSoSJqk2I9oi7H93Q
	 wAm5ZoK/NIIhE25kDqhSk+q+gYiX1rCm/RMmxCKYjjRmWC7P+NoVRgPWOJJKX8R6r3
	 EkE5PEfJT13Xs381as0S+apSh1VN23f+EwsVcRSo5rrtzspoprHZS+3qgcZEEl2OUp
	 y1S8MveVuXvsw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-396779b9a7fso35774921fa.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:05:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+bLjPTj7isN636gdYYZ2tek3Nn30h2ugbdoGmir5fDT4pws37+DLNVxraL4gDAIBTAfscrd8cEJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbqfoGLVLm+/w4dsuzORWSm/LH4h9J4gTcLOHQ26j973oc7OMK
	4d+lR84eUAa9ThIwk4NnYDMp8djYUAH3C7RtaekJn4a4caF9nF4ExkO4OlLiO9SGCeDNiSkmkuN
	qkvnTsk6UIhOLhDFyh2o7mxM8Jw8F1/4=
X-Received: by 2002:ac2:5098:0:b0:5aa:2a75:e14b with SMTP id
 2adb3069b0e04-5aa87bc23e7mr3205913e87.18.1780923930715; Mon, 08 Jun 2026
 06:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4f7a64f5-4f58-4552-9fc8-820bc7652c11@oss.qualcomm.com>
In-Reply-To: <4f7a64f5-4f58-4552-9fc8-820bc7652c11@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 15:05:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gO+YBRO4mEbDRdBvc9jirJ94nm+tniUWgNQjdrVAKV7g@mail.gmail.com>
X-Gm-Features: AVVi8Ccid6dv7gAQ3BGJ43TIs3IQeGZOm3uRjVAHArTr9x6xR3I82xbEi6OENKM
Message-ID: <CAJZ5v0gO+YBRO4mEbDRdBvc9jirJ94nm+tniUWgNQjdrVAKV7g@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers for v7.2-rc1
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukasz Luba <Lukasz.Luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, 
	Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, 
	Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>, jacky.baip@gmail.com, 
	Jinseok Kim <always.starving0@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Mayur Kumar <kmayur809@gmail.com>, Priyansh Jain <priyansh.jain@oss.qualcomm.com>, 
	Ronald Claveau <linux-kernel-dev@aliel.fr>, Shuwei Wu <shuwei.wu@mailbox.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Sun, Jun 7, 2026 at 5:21=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
>
> Hi Rafael,
>
> please consider the following changes since commit
> 21c315342b81526874acfa311f11b3f72bed4e14:
>
>    thermal: sysfs: remove space before tab in macro (2026-05-22 18:55:08
> +0200)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v7.2-rc1
>
> for you to fetch changes up to 968098b4ca5219b0d2e0a981aed1dacfbd5adc69:
>
>    thermal/drivers/qcom/tsens: Disable wakeup interrupt setup on
> automotive targets (2026-06-03 09:13:04 +0200)
>
> ----------------------------------------------------------------
> - Add the QCom Nord temperature sensor DT bindings (Deepti Jaggi)
>
> - Use devm_add_action_or_reset() for clock disable on the NVidia
>    soctherm and switch to devm cooling device registration version
>    (Daniel Lezcano)
>
> - Replace the devm version implementation by the helper doing the same
>    thing (Daniel Lezcano)
>
> - Add the Amlogic T7 thermal sensor along with thermal calibration
>    data read from SMC calls (Ronald Claveau)
>
> - Fix typo in comment, "uppper" with "upper" in the TSens QCom driver
>    (Jinseok Kim)
>
> - Add the QCom Shikra temperature sensor DT bindings (Gaurav Kohli)
>
> - Add the QCom Hawi temperature sensor DT bindings (Dipa Ramesh Mantre)
>
> - Fix atomic temperature read in the QCom tsens to comply with
>    hardware documentation (Priyansh Jain)
>
> - Fix trailing whitespace and repeated word in the OF code. Do not
>    split quoted string across lines in the iMX7 driver (Mayur Kumar)
>
> - Add SpacemiT K1 thermal sensor support (Shuwei Wu)
>
> - Add the i.MX93 temperature sensor support and filter out the invalid
>    temperature (Jacky Bai)
>
> - Enable by default the TMU (Thermal Monitoring Unit) on Exynos
>    platform (Krzysztof Kozlowski)
>
> - Split the core code and the OF which are interleaved. Add the
>    cooling device per index registration in order to support dedicated
>    cooling devices controller (Daniel Lezcano)
>
> - Add DT binding to specify an index in the cooling device map (Gaurav
>    Kohli)
>
> - Rework interrupt initialization in the Tsens driver and add the
>    optional wakeup source (Priyansh Jain)
>
> ----------------------------------------------------------------
> Daniel Lezcano (13):
>        thermal/drivers/tegra/soctherm: Use devm_add_action_or_reset()
> for clock disable
>        thermal/drivers/tegra/soctherma: Switch to devm cooling device
> registration
>        thermal/core: Use devm_add_action_or_reset() when registering a
> cooling device
>        thermal/core: Introduce non-OF thermal_cooling_device_register()
>        thermal/core: Add devm_thermal_cooling_device_register()
>        hwmon: Use non-OF thermal cooling device registration API
>        thermal/of: Move cooling device OF helpers out of thermal core
>        thermal/core: Make cooling device OF node conditional on
> CONFIG_THERMAL_OF
>        thermal/of: Rename the devm_thermal_of_cooling_device_register()
> function
>        thermal/of: Add cooling device ID support
>        thermal/of: Pass cdev_id and introduce devm registration helper
>        thermal/of: Support cooling device ID in cooling-spec
>        thermal/core: Fix missing stub for
> devm_thermal_cooling_device_register
>
> Deepti Jaggi (1):
>        dt-bindings: thermal: qcom-tsens: Document Nord Temperature Sensor
>
> Dipa Ramesh Mantre (1):
>        dt-bindings: thermal: qcom-tsens: Document the Hawi Temperature
> Sensor
>
> Gaurav Kohli (2):
>        dt-bindings: thermal: qcom-tsens: Document the Shikra Temperature
> Sensor
>        dt-bindings: thermal: cooling-devices: Update support for 3 cells
> cooling device
>
> Jacky Bai (3):
>        dt-bindings: thermal: qoriq: Add compatible string for imx93
>        thermal/drivers/qoriq: Add i.MX93 tmu support
>        thermal/driver/qoriq: Workaround unexpected temperature readings
> from tmu
>
> Jinseok Kim (1):
>        thermal/drivers/qcom: Fix typo in comment
>
> Krzysztof Kozlowski (1):
>        thermal/drivers/samsung: Enable TMU by default
>
> Mayur Kumar (2):
>        thermal/of: Fix trailing whitespace and repeated word
>        thermal/drivers/imx: Do not split quoted string across lines
>
> Priyansh Jain (3):
>        thermal/drivers/qcom/tsens: Atomic temperature read with
> hardware-guided retries
>        thermal/drivers/qcom/tsens: Switch wake IRQ handling to PM callbac=
ks
>        thermal/drivers/qcom/tsens: Disable wakeup interrupt setup on
> automotive targets
>
> Ronald Claveau (5):
>        dt-bindings: thermal: amlogic: Add support for T7
>        firmware: meson: sm: Thermal calibration read via secure monitor
>        firmware: meson: sm: Add thermal calibration SMC call
>        thermal/drivers/amlogic: Add missing dependency on MESON_SM
>        thermal/drivers/amlogic: Add support for secure monitor
> calibration readout
>
> Shuwei Wu (2):
>        dt-bindings: thermal: Add SpacemiT K1 thermal sensor
>        thermal/drivers/spacemit/k1: Add thermal sensor support
>
>   .../devicetree/bindings/hwmon/pwm-fan.yaml         |   3 +-
>   .../bindings/thermal/amlogic,thermal.yaml          |  37 ++-
>   .../devicetree/bindings/thermal/qcom-tsens.yaml    |   3 +
>   .../devicetree/bindings/thermal/qoriq-thermal.yaml |   1 +
>   .../bindings/thermal/spacemit,k1-tsensor.yaml      |  76 ++++++
>   .../bindings/thermal/thermal-cooling-devices.yaml  |   8 +-
>   .../devicetree/bindings/thermal/thermal-zones.yaml |   3 +-
>   drivers/firmware/meson/meson_sm.c                  |  28 ++-
>   drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |   5 +-
>   drivers/hwmon/amc6821.c                            |   2 +-
>   drivers/hwmon/aspeed-pwm-tacho.c                   |   5 +-
>   drivers/hwmon/cros_ec_hwmon.c                      |   4 +-
>   drivers/hwmon/dell-smm-hwmon.c                     |   4 +-
>   drivers/hwmon/emc2305.c                            |   6 +-
>   drivers/hwmon/gpio-fan.c                           |   6 +-
>   drivers/hwmon/max6650.c                            |   6 +-
>   drivers/hwmon/mlxreg-fan.c                         |   4 +-
>   drivers/hwmon/npcm750-pwm-fan.c                    |   6 +-
>   drivers/hwmon/pwm-fan.c                            |   5 +-
>   drivers/hwmon/qnap-mcu-hwmon.c                     |   6 +-
>   drivers/hwmon/tc654.c                              |   5 +-
>   drivers/memory/tegra/tegra210-emc-core.c           |   4 +-
>   drivers/soc/qcom/qcom_aoss.c                       |   2 +-
>   drivers/thermal/Kconfig                            |   3 +
>   drivers/thermal/Makefile                           |   1 +
>   drivers/thermal/amlogic_thermal.c                  | 112 ++++++---
>   drivers/thermal/cpufreq_cooling.c                  |   2 +-
>   drivers/thermal/cpuidle_cooling.c                  |   2 +-
>   drivers/thermal/devfreq_cooling.c                  |   2 +-
>   drivers/thermal/imx_thermal.c                      |   4 +-
>   drivers/thermal/khadas_mcu_fan.c                   |   7 +-
>   drivers/thermal/qcom/tsens-v2.c                    |   9 +-
>   drivers/thermal/qcom/tsens.c                       | 183 ++++++++++----
>   drivers/thermal/qcom/tsens.h                       |  24 +-
>   drivers/thermal/qoriq_thermal.c                    |  71 +++++-
>   drivers/thermal/samsung/Kconfig                    |   1 +
>   drivers/thermal/spacemit/Kconfig                   |  19 ++
>   drivers/thermal/spacemit/Makefile                  |   3 +
>   drivers/thermal/spacemit/k1_tsensor.c              | 280
> +++++++++++++++++++++
>   drivers/thermal/tegra/soctherm.c                   |  34 +--
>   drivers/thermal/thermal_core.c                     | 111 ++------
>   drivers/thermal/thermal_core.h                     |   5 +
>   drivers/thermal/thermal_of.c                       | 152 ++++++++++-
>   include/linux/firmware/meson/meson_sm.h            |   3 +
>   include/linux/thermal.h                            |  71 ++++--
>   45 files changed, 1070 insertions(+), 258 deletions(-)
>   create mode 100644
> Documentation/devicetree/bindings/thermal/spacemit,k1-tsensor.yaml
>   create mode 100644 drivers/thermal/spacemit/Kconfig
>   create mode 100644 drivers/thermal/spacemit/Makefile
>   create mode 100644 drivers/thermal/spacemit/k1_tsensor.c

Pulled and added to linux-pm.git/linux-next, thanks!
