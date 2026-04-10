Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC133A75B7
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831362; cv=none; b=B0mXQZImSztJhAjwQVlQFQZy+IEvWzXGLPJfgL7XGCVRgh0BkmscCTGStWW9RWMS/K+gUUs62CQFiD+IKLAptqF+UIgIiVEcbRPKmZmtHYY5bzAn0ntVNGx0OKkr+to+HmvwaKS4FMcf2ISFw3d5+j+BsiUIFogYsJguMkLnPtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831362; c=relaxed/simple;
	bh=zzGuF0UaOz4zc2Tx2JoAd7rOLNvysarfty+eCllRtWo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=huzoofR2EsmT3SnFuBzJPtbtARcU1F2qWPDjaj3C6LCGGu7R40sJpvfeHf+y41IH1gkdsoiqfoMG8xTxDtARbYeFD1wjofBWzPIqREHeIVsr00+Qt21gyJ3Haj1IAIUV+mRazf2FNzb0/LdiZDPBQNUJxjtXWguHna7n1Oa3g0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhVlABOP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhVlABOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22BBC2BCAF
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831361;
	bh=zzGuF0UaOz4zc2Tx2JoAd7rOLNvysarfty+eCllRtWo=;
	h=From:Date:Subject:To:Cc:From;
	b=jhVlABOPCezyF8n0iQ55R2qHNEq1h09JvntisRhL5lqWbHWL4zMObSKK+vJbYFxqA
	 ighesgsaJ4WkTMQlrJMsYQcodszVPvNGT7ZUc5mnyAo529iNd5XULq+NRKP3nRl0Np
	 9VyJajfLj+kVM5CfxUrZQg90gr30Snw/XLaK9FN+VCQfL5OnyUy29Hg3Bz+a3H8NLV
	 3zenTs7qSKOTHDs49GaSPiZtHaVLfxnMNj/LBeb3z4C9WB0sh9b8wCc9x/BVZctfo4
	 ZI9QCjAMmFY1MUdza4WoJSrPpGtiON+lmLW4VqoSqEx7MurYdzjsFnXu9gGw4ASkIf
	 6dob/vhGieLuw==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-470145d7e6fso883790b6e.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 07:29:21 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzw4w7mfyB1fthUA0S/1a9NtgsdwSjnF7MW3t1I8n0mLMDOpdc9
	KxLz1f+YxLdTUaKbdrwzslf0kqpK/nqqR1vvFvDv27IpHgwSzJkZUBvfdFo/yFoi1yDIaQOEmUQ
	Fszxt2cF0IPMYXgFaLr+mabYRcNbQLVw=
X-Received: by 2002:a05:6808:4f4f:b0:464:5f3:ed1 with SMTP id
 5614622812f47-4789fc079d3mr1655023b6e.26.1775831361074; Fri, 10 Apr 2026
 07:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 Apr 2026 16:29:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gi8LtGAC=E16TRqx=gQxTSz2chzt=OmrQf8etnoE_QKA@mail.gmail.com>
X-Gm-Features: AQROBzA5nutQzLxeovgQb-ErVbEpTCH2wt-FcEYpNTQ_OD8jq__bWMOIeljqiFA
Message-ID: <CAJZ5v0gi8LtGAC=E16TRqx=gQxTSz2chzt=OmrQf8etnoE_QKA@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v7.1-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This goes early because I will be traveling next week.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-7.1-rc1

with top-most commit cd1a3b2ff0553e987de71ff0aa675e418de22898

 Merge tag 'thermal-v7.1-rc1' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux

on top of commit 9e07e3b81807edd356e1f794cffa00a428eff443

 thermal: core: Fix thermal zone device registration error path

to receive thermal control updates for 7.1-rc1.

These include thermal core fixes and simplifications, driver fixes and
new hardware support (SDM670, Eliza SoC), new driver features (hwmon
support in imx91, DDR data rate on Nova Lake in int340x), and a handful
of cleanups:

 - Fix thermal core issues related to thermal zone removal and
   registration errors that may lead to a use-after-free or a memory
   leak in some cases (Rafael Wysocki)

 - Drop a redundant check from thermal_zone_device_update(), adjust
   thermal workqueue allocation flags, and switch over thermal_class
   allocation to static (Rafael Wysocki)

 - Relocate the suspend and resume of thermal zones closer to the
   suspend and resume of devices, respectively (Rafael Wysocki)

 - Remove a pointless variable used in the thermal core when
   registering a cooling device (Daniel Lezcano)

 - Replace sprintf() in thermal_bind_cdev_to_trip() and use
   str_enabled_disabled() helper in mode_show() (Thorsten Blum)

 - Replace cpumask_weight() in intel_hfi_offline() with cpumask_empty()
   which is generally more efficient (Yury Norov)

 - Add support for reading DDR data rate from PCI config space on Nova
   Lake platforms to the int340x thermal driver (Srinivas Pandruvada)

 - Add an OF node address to output message to make sensor names more
   distinguishable (Alexander Stein)

 - Add hwmon support for the i.MX97 thermal sensor (Alexander Stein)

 - Clamp correctly the results when doing value/temperature conversion
   in the Spreadtrum driver (Thorsten Blum)

 - Add SDM670 compatible DT bindings for the Tsens and the lMH thermal
   drivers (Richard Acayan)

 - Add SM8750 compatible DT bindings for the Tsens thermal driver (Manaf
   Meethalavalappu Pallikunhi)

 - Add Eliza SoC compatible DT bindings for the Tsens driver (Krzysztof
   Kozlowski)

 - Fix inverted condition check on error in the Spear thermal control
   driver (Gopi Krishna Menon)

 - Convert DT bindings documentation into DT schema (Gopi Krishna Menon)

 - Use max() macro to increase readability in the Broadcom STB thermal
   sensor (Thorsten Blum)

 - Remove a stale @trim_offset kernel-doc entry (John Madieu)

Thanks!


---------------

Alexander Stein (2):
      thermal/of: Add OF node address to output message
      thermal/drivers/imx91: Add hwmon support

Anas Iqbal (1):
      thermal: devfreq_cooling: avoid unnecessary kfree of freq_table

Daniel Lezcano (1):
      thermal/core: Remove pointless variable when registering a cooling device

Gopi Krishna Menon (2):
      thermal/drivers/spear: Fix error condition for reading st,thermal-flags
      dt-bindings: thermal: st,thermal-spear1340: convert to dtschema

John Madieu (1):
      thermal: renesas: rzg3e: Remove stale @trim_offset kernel-doc entry

Krzysztof Kozlowski (1):
      dt-bindings: thermal: qcom-tsens: Add Eliza SoC TSENS

Manaf Meethalavalappu Pallikunhi (1):
      dt-bindings: thermal: qcom-tsens: Document the SM8750 Temperature Sensor

Rafael J. Wysocki (6):
      thermal: core: Fix thermal zone governor cleanup issues
      thermal: core: Free thermal zone ID later during removal
      thermal: core: Drop redundant check from thermal_zone_device_update()
      thermal: core: Adjust thermal_wq allocation flags
      thermal: core: Allocate thermal_class statically
      thermal: core: Suspend thermal zones later and resume them earlier

Richard Acayan (2):
      dt-bindings: thermal: tsens: add SDM670 compatible
      dt-bindings: thermal: lmh: Add SDM670 compatible

Srinivas Pandruvada (1):
      thermal: intel: int340x: Read DDR data rate for Nova Lake

Thorsten Blum (6):
      thermal: core: Replace sprintf() in thermal_bind_cdev_to_trip()
      thermal/drivers/sprd: Fix temperature clamping in sprd_thm_temp_to_rawdata
      thermal/drivers/sprd: Fix raw temperature clamping in
sprd_thm_rawdata_to_temp
      thermal/drivers/sprd: Use min instead of clamp in sprd_thm_temp_to_rawdata
      thermal: sysfs: Use str_enabled_disabled() helper in mode_show()
      thermal/drivers/brcmstb_thermal: Use max to simplify brcmstb_get_temp

Yury Norov (1):
      thermal: intel: hfi: use cpumask_empty() in intel_hfi_offline()

---------------

 .../devicetree/bindings/thermal/qcom-lmh.yaml      |   3 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   3 +
 .../devicetree/bindings/thermal/spear-thermal.txt  |  14 ---
 .../bindings/thermal/st,thermal-spear1340.yaml     |  36 ++++++
 drivers/base/power/main.c                          |   5 +
 drivers/thermal/broadcom/brcmstb_thermal.c         |   8 +-
 drivers/thermal/devfreq_cooling.c                  |   3 +-
 drivers/thermal/imx91_thermal.c                    |   4 +
 .../intel/int340x_thermal/processor_thermal_rfim.c |  25 ++++-
 drivers/thermal/intel/intel_hfi.c                  |   2 +-
 drivers/thermal/renesas/rzg3e_thermal.c            |   1 -
 drivers/thermal/spear_thermal.c                    |   2 +-
 drivers/thermal/sprd_thermal.c                     |   6 +-
 drivers/thermal/thermal_core.c                     | 121 ++++++++-------------
 drivers/thermal/thermal_of.c                       |  20 ++--
 drivers/thermal/thermal_sysfs.c                    |   7 +-
 include/linux/thermal.h                            |   6 +
 17 files changed, 143 insertions(+), 123 deletions(-)
