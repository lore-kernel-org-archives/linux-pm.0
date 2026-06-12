Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B18038AC92
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286184; cv=none; b=TNWKbFCZs07Lu8BjZ0qUNrCqIlcHwyp5dzxnG/FcOt+AKDuWc5/dNj58iJTIYD7LEk77m5aavff8tAW99gps7ul0Y11nWlYY660FHpBYXhOt75nBKJ4b+KHhmhEDkeYH5bohn+lEl1SsOvxyxssJSHVhUz5MLKnyO8EdwAdL+Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286184; c=relaxed/simple;
	bh=PtFAFCmt02fbXmYJpMB4N8Wu1tDzwc319RGRDW7DpgU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CqVHQYM7LQieFX2hgwvnzJRiYykIUTuwOckFW96EbtTVe8mpkF/wzYEF7n/fhmOGUtsnECqHHa/AeSGKPaeIzbd5of/Uhcjc3Y0WMchFzFsUBmOhh4DxwCiJ382Mi5wMOfe6ygjyN/BJ2fatigwx7BxzMiRWiOZ0EcHPrtANHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNvdaKlH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNvdaKlH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3202B1F00A3A
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 17:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781286183;
	bh=s7kUrardtG+S+UY6NjGt62Mkpr1hGx2P5s2UZvgjnq0=;
	h=From:Date:Subject:To:Cc;
	b=jNvdaKlHrxloiaCCv+1aFb1Z9vcC55rCpdx1sP8vuzNA35ieX/gwbtGPqCSHczOMe
	 ZRFNOSA99i2lXWfLBJIidfhbD6mS40r9y7MuU0xAhl8mmjXX3hD1aXzY+tE+S5mOJE
	 bXD9cYuiJViWXLXx8+LZ6wpMCjI+gYH/ERVPhDJZyRZI0dXjX3uQBcPZnkpLim/qz+
	 0EgoavxwNMu+yH19O38sg+Op+nDyJaFTtsHVAGOCfYbkUrA42Y4cDo/vpiVehCrrMK
	 XeMPN/Saf2WlW+N6YjAejHP8QqN4HSLpS1A2G6RdJTHoouxoc+t9HfT9HqNVJifsGh
	 x+6rntNkOHY7w==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa88b4f792so1685778e87.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 10:43:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YyTJbQt3sp+MEchGTUFG0L/HpqERPIKI2ag248Zvaiu6DN/2vMX
	PrrZeWCsDisTrw5WYVWe3ItiVLMohdJiuhT5XsNLu6uTT2ONVscT3Uvh6ggA4Mv4YscWlA5t5R9
	72B2MYiHcq6n9oVGPe5ZxvLfLdJUuLBw=
X-Received: by 2002:a05:6512:3b85:b0:5aa:7083:51bf with SMTP id
 2adb3069b0e04-5ad2d49fdd8mr964713e87.7.1781286181644; Fri, 12 Jun 2026
 10:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Jun 2026 19:42:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gO6vETP0+054J4pSdPH8ehn_1zY2rRqX2Znc9jeD-4RQ@mail.gmail.com>
X-Gm-Features: AVVi8CcLYv-gTt-CXnqd_Osd9nvER4hDFqdcN_SCT965JAw5fg6OL2-1npx_uf8
Message-ID: <CAJZ5v0gO6vETP0+054J4pSdPH8ehn_1zY2rRqX2Znc9jeD-4RQ@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for 7.2-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This goes early for your convenience.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-7.2-rc1

with top-most commit bc1c872ce0ab3984f5fcefeb952541a802b891e7

 Merge branch 'thermal-testing'

on top of commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d

 Linux 7.1-rc5

to receive thermal control updates for 7.2-rc1.

These add new hardware support (i.MX93 TMU, Amlogic T7, Intel Arrow
Lake, QCom Nord, Shikra and Hawi), fix issues in a number of places
in the thermal control core and drivers, clean up code and refactor
it in preparation for future changes:

 - Rework the initialization and cleanup of thermal class cooling
   devices to separate DT-based cooling device registration and
   cooling device registration without DT (Daniel Lezcano, Ovidiu
   Panait)

 - Update the cooling device DT bindings to support 3-cell cooling
   device representation, where the additional cell holds an ID to
   select a cooling mechanism for devices that offer multiple cooling
   mechanisms, and adjust the cooling device registration code
   accordingly (Gaurav Kohli, Daniel Lezcano)

 - Remove dead code from two functions in the thermal core and simplify
   the unregistration of thermal governors (Rafael Wysocki)

 - Fix critical temperature attribute removal handling in the generic
   thermal zone hwmon support code and rework that code to register a
   separate hwmon class device for each thermal zone (instead of using
   one hwmon class device for all thermal zones of the same type) to
   address thermal zone removal deadlocks (Rafael Wysocki)

 - Use attribute groups for adding temperature attributes to hwmon class
   devices associated with thermal zones (Rafael Wysocki)

 - Pass WQ_UNBOUND when allocating the thermal workqueue (Marco
   Crivellari)

 - Fix potential shift overflow in ptc_mmio_write() and improve error
   handling in proc_thermal_ptc_add() in the int340x thermal control
   driver (Aravind Anilraj)

 - Use sysfs_emit() for cpumask printing in the Intel powerclamp thermal
   driver (Yury Norov)

 - Add Arrow Lake CPU models to the intel_tcc_cooling driver (Srinivas
   Pandruvada)

 - Add QCom Nord, Shikra and Hawi temperature sensor DT bindings (Deepti
   Jaggi, Gaurav Kohli, Dipa Ramesh Mantre)

 - Use devm_add_action_or_reset() for clock disable on the NVidia
   soctherm and switch it to devm cooling device registration version
   (Daniel Lezcano)

 - Add the Amlogic T7 thermal sensor along with thermal calibration
   data read from SMC calls (Ronald Claveau)

 - Fix atomic temperature read in the QCom tsens driver to comply with
   hardware documentation (Priyansh Jain)

 - Add SpacemiT K1 thermal sensor support (Shuwei Wu)

 - Add i.MX93 temperature sensor support and filter out the invalid
   temperature (Jacky Bai)

 - Enable by default the TMU (Thermal Monitoring Unit) on Exynos
   platform (Krzysztof Kozlowski)

 - Rework interrupt initialization in the Tsens driver and add the
   optional wakeup source (Priyansh Jain)

 - Fix typo in a comment in the TSens QCom driver (Jinseok Kim)

 - Fix trailing whitespace and repeated word in the OF code, remove
   quoted string splitting across lines from the iMX7 driver, and remove
   a stray space from the thermal_trip_of_attr() macro definition (Mayur
   Kumar)

 - Update the thermal testing facility code to avoid NULL pointer
   dereferences by rejecting missing command arguments and replace
   sscanf() with kstrtoint() or kstrtoul() in that code (Ovidiu Panait,
   Samuel Moelius)

Thanks!


---------------

Aravind Anilraj (2):
      thermal: intel: int340x: Fix potential shift overflow in ptc_mmio_write()
      thermal: intel: int340x: Check return value of ptc_create_groups()

Daniel Lezcano (18):
      thermal/core: Add dedicated release callback for cooling devices
      thermal/core: Add dedicated release callback for thermal zones
      thermal/core: Allocate the thermal class dynamically
      thermal/core: Use the thermal class pointer as init guard
      thermal/core: Split __thermal_cooling_device_register() into two functions
      thermal/drivers/tegra/soctherm: Use devm_add_action_or_reset()
for clock disable
      thermal/drivers/tegra/soctherma: Switch to devm cooling device
registration
      thermal/core: Use devm_add_action_or_reset() when registering a
cooling device
      thermal/core: Introduce non-OF thermal_cooling_device_register()
      thermal/core: Add devm_thermal_cooling_device_register()
      hwmon: Use non-OF thermal cooling device registration API
      thermal/of: Move cooling device OF helpers out of thermal core
      thermal/core: Make cooling device OF node conditional on CONFIG_THERMAL_OF
      thermal/of: Rename the devm_thermal_of_cooling_device_register() function
      thermal/of: Add cooling device ID support
      thermal/of: Pass cdev_id and introduce devm registration helper
      thermal/of: Support cooling device ID in cooling-spec
      thermal/core: Fix missing stub for devm_thermal_cooling_device_register

Deepti Jaggi (1):
      dt-bindings: thermal: qcom-tsens: Document Nord Temperature Sensor

Dipa Ramesh Mantre (1):
      dt-bindings: thermal: qcom-tsens: Document the Hawi Temperature Sensor

Gaurav Kohli (2):
      dt-bindings: thermal: qcom-tsens: Document the Shikra Temperature Sensor
      dt-bindings: thermal: cooling-devices: Update support for 3
cells cooling device

Jacky Bai (3):
      dt-bindings: thermal: qoriq: Add compatible string for imx93
      thermal/drivers/qoriq: Add i.MX93 tmu support
      thermal/driver/qoriq: Workaround unexpected temperature readings from tmu

Jinseok Kim (1):
      thermal/drivers/qcom: Fix typo in comment

Krzysztof Kozlowski (1):
      thermal/drivers/samsung: Enable TMU by default

Marco Crivellari (1):
      thermal: core: Add WQ_UNBOUND to alloc_workqueue() users

Mayur Kumar (3):
      thermal: sysfs: remove space before tab in macro
      thermal/of: Fix trailing whitespace and repeated word
      thermal/drivers/imx: Do not split quoted string across lines

Ovidiu Panait (3):
      thermal/core: Populate max_state before setting up cooling dev sysfs
      thermal: testing: Replace sscanf() with kstrtoint()
      thermal: sysfs: Replace sscanf() with kstrtoul()

Priyansh Jain (3):
      thermal/drivers/qcom/tsens: Atomic temperature read with
hardware-guided retries
      thermal/drivers/qcom/tsens: Switch wake IRQ handling to PM callbacks
      thermal/drivers/qcom/tsens: Disable wakeup interrupt setup on
automotive targets

Rafael J. Wysocki (5):
      thermal: core: Remove dead code from two functions
      thermal: core: Simplify unregistration of governors
      thermal: hwmon: Fix critical temperature attribute removal
      thermal: hwmon: Register a hwmon device for each thermal zone
      thermal: hwmon: Use extra_groups for adding temperature attributes

Ronald Claveau (5):
      dt-bindings: thermal: amlogic: Add support for T7
      firmware: meson: sm: Thermal calibration read via secure monitor
      firmware: meson: sm: Add thermal calibration SMC call
      thermal/drivers/amlogic: Add missing dependency on MESON_SM
      thermal/drivers/amlogic: Add support for secure monitor
calibration readout

Samuel Moelius (1):
      thermal: testing: reject missing command arguments

Shuwei Wu (2):
      dt-bindings: thermal: Add SpacemiT K1 thermal sensor
      thermal/drivers/spacemit/k1: Add thermal sensor support

Srinivas Pandruvada (1):
      thermal: intel: intel_tcc_cooling: Add Arrow Lake CPU models

Yury Norov (1):
      thermal: intel: Use sysfs_emit() for powerclamp cpumask

---------------

 .../devicetree/bindings/hwmon/pwm-fan.yaml         |   3 +-
 .../bindings/thermal/amlogic,thermal.yaml          |  37 ++-
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   3 +
 .../devicetree/bindings/thermal/qoriq-thermal.yaml |   1 +
 .../bindings/thermal/spacemit,k1-tsensor.yaml      |  76 +++++
 .../bindings/thermal/thermal-cooling-devices.yaml  |   8 +-
 .../devicetree/bindings/thermal/thermal-zones.yaml |   3 +-
 drivers/firmware/meson/meson_sm.c                  |  28 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |   5 +-
 drivers/hwmon/amc6821.c                            |   2 +-
 drivers/hwmon/aspeed-pwm-tacho.c                   |   5 +-
 drivers/hwmon/cros_ec_hwmon.c                      |   4 +-
 drivers/hwmon/dell-smm-hwmon.c                     |   4 +-
 drivers/hwmon/emc2305.c                            |   6 +-
 drivers/hwmon/gpio-fan.c                           |   6 +-
 drivers/hwmon/hwmon.c                              |   6 +-
 drivers/hwmon/max6650.c                            |   6 +-
 drivers/hwmon/mlxreg-fan.c                         |   4 +-
 drivers/hwmon/npcm750-pwm-fan.c                    |   6 +-
 drivers/hwmon/pwm-fan.c                            |   5 +-
 drivers/hwmon/qnap-mcu-hwmon.c                     |   6 +-
 drivers/hwmon/tc654.c                              |   5 +-
 drivers/memory/tegra/tegra210-emc-core.c           |   4 +-
 drivers/soc/qcom/qcom_aoss.c                       |   2 +-
 drivers/thermal/Kconfig                            |   3 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/amlogic_thermal.c                  | 112 +++++--
 drivers/thermal/cpufreq_cooling.c                  |   2 +-
 drivers/thermal/cpuidle_cooling.c                  |   2 +-
 drivers/thermal/devfreq_cooling.c                  |   2 +-
 drivers/thermal/imx_thermal.c                      |   4 +-
 .../int340x_thermal/platform_temperature_control.c |  12 +-
 drivers/thermal/intel/intel_powerclamp.c           |   2 +-
 drivers/thermal/intel/intel_tcc_cooling.c          |   3 +
 drivers/thermal/khadas_mcu_fan.c                   |   7 +-
 drivers/thermal/qcom/tsens-v2.c                    |   9 +-
 drivers/thermal/qcom/tsens.c                       | 183 ++++++++---
 drivers/thermal/qcom/tsens.h                       |  24 +-
 drivers/thermal/qoriq_thermal.c                    |  71 ++++-
 drivers/thermal/samsung/Kconfig                    |   1 +
 drivers/thermal/spacemit/Kconfig                   |  19 ++
 drivers/thermal/spacemit/Makefile                  |   3 +
 drivers/thermal/spacemit/k1_tsensor.c              | 280 +++++++++++++++++
 drivers/thermal/tegra/soctherm.c                   |  34 +-
 drivers/thermal/testing/command.c                  |  12 +
 drivers/thermal/testing/zone.c                     |  12 +-
 drivers/thermal/thermal_core.c                     | 347 ++++++++-------------
 drivers/thermal/thermal_core.h                     |   7 +-
 drivers/thermal/thermal_hwmon.c                    | 220 ++++---------
 drivers/thermal/thermal_of.c                       | 152 ++++++++-
 drivers/thermal/thermal_sysfs.c                    |  10 +-
 include/linux/firmware/meson/meson_sm.h            |   3 +
 include/linux/hwmon.h                              |   3 +-
 include/linux/thermal.h                            |  71 +++--
 54 files changed, 1279 insertions(+), 567 deletions(-)
