Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430673;
	b=wJtjXlMfZSRlcTi0C7KH7tI1sxypHx63VNXesxXxF6KUfQdCkUWjsM8xDiwpzUkkGzUM
	 Xms5KMA7taMe7/S/C0eyEfqstXjDWQvGBClMj4SB6lnVb/5Z0J6naDPOvxK1ZtidFb7cp
	 WjEln8p7Roa5QXWSDE2PF5P14kKc7ijxF2dmkg2sMJsokOMCrebJExrQ+d9tFV3/PV7Zn
	 QeCSfaZq6xleH+pG53VgPmJ6MviHADgm9ae0ZZGFCHq4PlqdNx5Tznjlrht9RiulTDk33
	 /iC0SPz4Y9YyLOinVeZMCfE0T/rv18Fl/uwuA7ozROXsDf5lflDDhUmEAdGRKWt6sUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430673;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VbQFUmpVnS2uBP54GsmECYZ69JwncdeB9sR1ssSj0uY=;
	b=CaJkZsaEWLLRnImkoiEGAcSVtOxjMFyapGtnOzxkYWNhXsPZusrG9Mf9PSbh9+AjYun7
	 c4mIyXViFBWap3AwWv7m3dNpmagCqtyrqpYE8mPRvE3WbFBz3kPHjj8YzlwJljREB4/tT
	 t7M9WSL/3QLdsQryvRZo98qaRiOSGmExTCxajf4+u/kNayLYO4LyLERW+RDi2TXLKStLk
	 yvlL567n+ZOFpJXEYdlrdZB40TGqVA8eElmylqiX2icNBumVLs02Z4tbCU941BIy7eoGU
	 HLtH3Yb6h/v3LD1ajRIA04y8ymXU4jy27JDPijZIXM4prw5RbyGyvlj9u76m0zBSa+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfB1FRPp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E9C606A32E
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfB1FRPp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872371F000C5
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 17:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430672;
	bh=VbQFUmpVnS2uBP54GsmECYZ69JwncdeB9sR1ssSj0uY=;
	h=From:Date:Subject:To:Cc;
	b=dfB1FRPpnxUJAt98M1HewsdEkq9qSLBUbtGMiK9MKIBUtauuKAfXTJ/ojG1MMYdCm
	 6Ntahcsdla+x6i7DwLSCIfhPNkvRcJafuI1m54F0KSRNqp4xCbRyBPlVPL9+PWxz0t
	 CQuTKghnPtsfJ0fa6yf0hJqatFQyLW9Jq4B4JYxvOIYYuUiS4nek0gUt+gGGCbSbjW
	 nzJF1tdO/6lodCOJf6H9JqIXUj5WLYjS9aAMABZiozkQVnHciAMOUSdq0cP4QJHmWs
	 YDRXkob9IM6tDsEamOkrniSjJIVSHDxOAF2uMjaIDKxn1cjBIpmtgaM7DChu4nvuDI
	 UuCczTfCHTzrg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bcb0f245e0so1645551e87.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 10:24:32 -0700 (PDT)
X-Gm-Message-State: AFq9FYK1ZP909IIX9LXW1wUHPZzjVUKpdF567XLstWmWF71VV6SXAJ4a
	DS8WPSVlRwar0Zaavg2kQlzujYddvAJ7yU73NULH+irPTIFhJiSuvalyh5Ra+gUH6jiLXwZ4AyA
	n16UUo+08ouDdfF95X3S53wBZgb2gdpw=
X-Received: by 2002:a05:6512:b8e:b0:5b8:99a2:9f2d with SMTP id
 2adb3069b0e04-5be50a6c238mr2508131e87.17.1792430670925; Mon, 19 Oct 2026
 10:24:30 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 19 Oct 2026 19:22:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hEkwqD4znFgQBtXskpiXXo52gNp=KbzbeqOW9g=ZGpuw@mail.gmail.com>
X-Gm-Features: AclHuK-hjvdOv5ET-k1v1tBSwNWdfBk7MUhJOylL6EX5mT0pXoyicdLFn4TInr4
Message-ID: <CAJZ5v0hEkwqD4znFgQBtXskpiXXo52gNp=KbzbeqOW9g=ZGpuw@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for 7.4-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-7.4-rc1

with top-most commit 503bb6e70bbf6304b8113373d09dfffcc4aa9183

 Merge branch 'thermal-drivers'

on top of commit ec0d89150a9381d591344a9f6f5428655c227a7f

 thermal: gov_step_wise: Fix stale mitigation vote with non-zero lower boun=
ds

to receive thermal control updates for 7.4-rc1.

These are mostly updates of thermal drivers including a new Exynos ACPM
thermal driver for Google GS101, new Renesas RZ/G3L thermal sensor support,
new Qualcomm MSM8952 TSENS support, new Qualcomm PMAU0102 Master BandGap
temperature monitor support in DT bindings, and new rugged Panther Lake
support in intel_tcc_cooling.  Moreover, the AN7583 driver is extended
to register separate thermal zones for bandgap, GbE and CPU (its DT
bindings are updated accordingly).

There are also multiple fixes and assorted cleanups, as usual.

Specifics:

 - Make the Intel powerclamp thermal driver reject invalid window_size
   values, drop redundant clamp() from duration_set() in it, and
   simplify 4 functions in it (Thorsten Blum)

 - Add rugged Panther Lake support to the intel_tcc_cooling thermal
   driver (Srinivas Pandruvada)

 - Fix temperature selection around 0 C in the int340x thermal driver,
   drop redundant else from proc_thermal_add() in it, and simplify
   slider_def_*_set() in it (Thorsten Blum)

 - Drop unbalanced paren from cpu-idle-cooling.rst (Manuel Ebner)

 - Use %pe to print error pointers symbolically in the thermal control
   code and fix assorted typos in comments in it (Sumeet Pawnikar and
   Hemanth Selam)

 - Add the Exynos ACPM thermal driver for Google GS101, along with
   DT bindings and a MAINTAINERS entry (Tudor Ambarus)

 - Add Renesas RZ/G3L thermal sensor support and DT bindings, and move
   default calibration values to per-SoC match data (Biju Das)

 - Add Qualcomm MSM8952 TSENS support and the corresponding DT binding
   compatible (Muzaffer Kadir)

 - Document the Qualcomm PMAU0102 Master BandGap temperature monitor
   compatible in the DT bindings (Dhruvin Rajpura)

 - Extend the QCom TSENS v2 trip temperature limits to the hardware
   range of -204=C2=B0C to +204=C2=B0C to prevent interrupt storms when ope=
rating
   beyond the previous software limits (Priyansh Jain)

 - Fix temperature threshold map indexing in the QCom SPMI temperature
   alarm driver to prevent out-of-bounds reads (Georgi Djakov)

 - Describe the additional bus clock required by the Amlogic T7 thermal
   sensor and switch the driver to the clk_bulk API to manage multiple
   clocks (Ronald Claveau)

 - Request the Airoha EN7581 IRQ after thermal zone registration to
   prevent the interrupt handler from accessing an unregistered or
   already freed thermal zone (Vitaliy Sochnev)

 - Fix the Airoha AN7583 ADC mux field mapping, serialize access to the
   shared ADC, and verify mux selection to avoid invalid temperature
   readings and spurious critical shutdowns (Vitaliy Sochnev)

 - Register separate thermal zones for the AN7583 bandgap, GbE and CPU
   sensors, and update the DT bindings to use one thermal sensor cell
   to select the sensor (Vitaliy Sochnev)

 - Fix signed integer overflow in the Renesas RZ/G3E temperature-to-code
   conversion, preserve compare interrupt state across runtime PM,
   and prevent overlapping temperature conversions (Ovidiu Panait)

 - Remove redundant trip window validation and runtime PM
   pm_runtime_mark_last_busy() calls from the Renesas RZ/G3E driver
   (Ovidiu Panait)

 - Propagate reset assertion failures from Renesas RZ/G3E suspend and
   attempt to restore power if the sensor was active (Pengpeng Hou)

 - Stop the TI bandgap alert IRQ before removing sensor interfaces and
   cancel pending alert work to prevent use-after-free on driver removal
   (Weigang He)

 - Validate Spreadtrum sensor IDs read from the device tree before using
   them for register offsets and array indexing (Weigang He)

 - Convert the TI OMAP bandgap DT bindings to schema and document the
   DRA752 compatible and thermal sensor cells (Bhargav Joshi)

 - Use DT property helpers matching the signed temperature and unsigned
   hysteresis types defined by the thermal zone bindings (Rob Herring)

 - Reuse common error handling code in the power allocator governor
   bind callback (Markus Elfring)

 - Constify the thermal zone device operations in the i.MX9 driver
   (Christophe JAILLET)

 - Fix kernel-doc parameter names and firmware node references in the
   cooling device registration helpers (Aryan Sinha)

 - Correct the documented return value of ti_bandgap_get_sensor_data()
   to describe validation errors and potentially NULL stored data
   (Karl Mehltretter)

 - Ensure NUL-termination when copying the cooling device command-line
   argument in tmon and fix the associated string truncation warning
   (Florian Fainelli)

 - Fix undefined behavior caused by a signed shift in the tmon thermal
   zone binding display (Liu Jing)

 - Fix wording in tmon comments (Hemanth Selam)

 - Simplify cpufreq_set_cur_state() in the cpufreq_cooling thermal
   control driver (Thorsten Blum)

Thanks!


---------------

Aryan Sinha (1):
      thermal/fw: Fix kernel-doc parameter names

Bhargav Joshi (1):
      dt-bindings: thermal: ti,omap-bandgap: Convert to DT schema

Biju Das (3):
      dt-bindings: thermal: r9a08g045-tsu: Document RZ/G3L TSU
      thermal/drivers/renesas/rzg3s: Convert calibration defaults to
per-SoC match data
      thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU support

Christophe JAILLET (1):
      thermal/drivers/imx9: Constify struct thermal_zone_device_ops

Dhruvin Rajpura (1):
      dt-bindings: thermal: qcom,pm8775-mbg-tm: Document PMAU0102

Florian Fainelli (1):
      tools/thermal/tmon: Fix string truncation warning in optarg copy

Georgi Djakov (1):
      thermal/drivers/qcom-spmi-temp-alarm: Fix temp_map indexing

Hemanth Selam (2):
      tools/thermal: Fix typo "binded" in comments
      thermal: fix assorted typos in comments

Karl Mehltretter (1):
      thermal: ti-soc-thermal: Fix the return value in
ti_bandgap_get_sensor_data() kernel-doc

Liu Jing (1):
      tools/thermal/tmon: Fix signed shift UB in binding display

Manuel Ebner (1):
      thermal: docs: cpu-idle-cooling.rst: Drop unbalanced paren

Markus Elfring (1):
      thermal: gov_power_allocator: Use common error handling code in
power_allocator_bind()

Muzaffer Kadir (2):
      dt-bindings: thermal: tsens: Add MSM8952
      thermal/qcom/tsens: Add support for MSM8952 tsens

Ovidiu Panait (5):
      drivers/thermal/renesas/rzg3e: Fix signed integer overflow in
temp_to_code()
      thermal/drivers/renesas/rzg3e: Fix runtime PM handling of compare irq
      thermal/drivers/renesas/rzg3e: Fix race between set_trips() and get_t=
emp()
      thermal/drivers/renesas/rzg3e: Remove unneeded low/high check in
set_trips()
      thermal/drivers/renesas/rzg3e: Remove redundant
pm_runtime_mark_last_busy() calls

Pengpeng Hou (1):
      thermal/drivers/rzg3e: Propagate reset assertion failure from suspend

Priyansh Jain (1):
      thermal/drivers/qcom/tsens: Widen temperature limits to match
hardware range

Rob Herring (Arm) (2):
      thermal: of: Match trip property helper types
      thermal: of: Match trip property helper types

Ronald Claveau (2):
      dt-bindings: thermal: amlogic: describe bus clock for t7-thermal
      thermal/drivers/amlogic: Switch to clk_bulk API to support multiple c=
locks

Srinivas Pandruvada (1):
      thermal: intel: intel_tcc_cooling: Add rugged Panther Lake support

Sumeet Pawnikar (2):
      thermal: gov_power_allocator: Fix NULL pointer dereference in update_=
tz()
      thermal: Use %pe to print error pointers symbolically

Thorsten Blum (10):
      thermal: intel: powerclamp: Reject invalid window_size values
      thermal: intel: int340x: Drop redundant else in proc_thermal_add()
      thermal: intel: powerclamp: Drop redundant clamp() in duration_set()
      thermal: intel: powerclamp: Simplify check_invalid()
      thermal: intel: int340x: Fix temperature selection around 0 C
      thermal: intel: powerclamp: Simplify idle_inject_update()
      thermal: intel: powerclamp: Simplify duration_get()
      thermal: intel: powerclamp: Simplify max_idle_set()
      thermal: intel: int340x: soc_slider: Simplify slider_def_*_set()
      thermal/cpufreq_cooling: Simplify cpufreq_set_cur_state()

Tudor Ambarus (3):
      dt-bindings: thermal: Add Google GS101 TMU
      thermal/drivers/samsung: Add Exynos ACPM TMU driver GS101
      MAINTAINERS: Add entry for Samsung Exynos ACPM thermal driver

Vitaliy Sochnev (5):
      thermal/drivers/airoha: Request the EN7581 IRQ after zone registratio=
n
      thermal/drivers/airoha: Fix AN7583 ADC mux field mapping
      thermal/drivers/airoha: Serialise access to the shared ADC
      dt-bindings: arm: airoha: Use one thermal sensor cell for AN7583
      thermal/drivers/airoha: Register a thermal zone per AN7583 sensor

Weigang He (2):
      thermal/drivers/ti-soc-thermal: Cancel pending alert work on remove
      thermal/drivers/sprd: validate the sensor id from the device tree

---------------

 .../bindings/arm/airoha,en7581-chip-scu.yaml       |   3 +-
 .../bindings/thermal/amlogic,thermal.yaml          |  29 +-
 .../bindings/thermal/google,gs101-tmu-top.yaml     |  69 +++
 .../bindings/thermal/qcom,pm8775-mbg-tm.yaml       |   7 +-
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 .../bindings/thermal/renesas,r9a08g045-tsu.yaml    |   4 +-
 .../bindings/thermal/ti,omap-bandgap.yaml          | 177 ++++++
 .../devicetree/bindings/thermal/ti_soc_thermal.txt |  88 ---
 .../driver-api/thermal/cpu-idle-cooling.rst        |   2 +-
 MAINTAINERS                                        |   8 +
 drivers/thermal/airoha_thermal.c                   | 179 ++++--
 drivers/thermal/amlogic_thermal.c                  |  14 +-
 drivers/thermal/cpufreq_cooling.c                  |  14 +-
 drivers/thermal/devfreq_cooling.c                  |   4 +-
 drivers/thermal/gov_power_allocator.c              |  18 +-
 drivers/thermal/imx91_thermal.c                    |   2 +-
 .../int340x_thermal/processor_thermal_device.c     |  14 +-
 .../int340x_thermal/processor_thermal_soc_slider.c |  28 +-
 drivers/thermal/intel/intel_powerclamp.c           |  64 +-
 drivers/thermal/intel/intel_tcc_cooling.c          |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   4 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   8 +-
 drivers/thermal/qcom/tsens-v1.c                    |  41 ++
 drivers/thermal/qcom/tsens-v2.c                    |   4 +-
 drivers/thermal/qcom/tsens.c                       |   3 +
 drivers/thermal/qcom/tsens.h                       |   2 +-
 drivers/thermal/renesas/rzg3e_thermal.c            |  45 +-
 drivers/thermal/renesas/rzg3s_thermal.c            |  38 +-
 drivers/thermal/samsung/Kconfig                    |  19 +
 drivers/thermal/samsung/Makefile                   |   2 +
 drivers/thermal/samsung/acpm-tmu.c                 | 651 +++++++++++++++++=
++++
 drivers/thermal/sprd_thermal.c                     |   6 +
 drivers/thermal/thermal_core.c                     |   2 +-
 drivers/thermal/thermal_fw.c                       |   8 +-
 drivers/thermal/thermal_of.c                       |  15 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  22 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   4 +
 include/uapi/linux/thermal.h                       |   8 +-
 tools/thermal/tmon/sysfs.c                         |   2 +-
 tools/thermal/tmon/tmon.c                          |   4 +-
 tools/thermal/tmon/tmon.h                          |   2 +-
 tools/thermal/tmon/tui.c                           |   2 +-
 42 files changed, 1331 insertions(+), 287 deletions(-)
