Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853340801E
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003204; cv=none; b=RPRhzhJdL/Fk+Pw2isvsVxGCQ/Lmk8C4hgbkREZccu+uUSV4LVdmf1Xi958iwnc/bKfh8kFrspxYPZIbp0Yc7r7adQ5N283WR2OBiQjYEiIPE1f+SYv8WUI+1XE5GJQ9QXFmMJ/DivV/AIxL5/+riIKsQXSF+ep/Iy6HnZMTk8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003204; c=relaxed/simple;
	bh=wI5OtR9HR/J0RFCTg/Yk2o4tMSsqJLiSJGZ/bOEkyV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SD76uYJKYUJeDLjHbiYMS6gYNwi4lKLk+xtobzkTEp427kC0UUK/5Kd6T63DjbJGCK/yRwIicDB2/tJSb359VGSi+TXcwtNLpnlN1Ap8BzVLU29H1K/OrufYSmdG+SYQfZatYEjClsfdUMZtPhZFNcwBRdJsfjSAtbXN+YJzvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiZElaLJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiZElaLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715541F000C4
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 18:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792003203;
	bh=h02T4dxmej+7U4k43nmeqwXEyqdw6fkeq/FbO3cSyPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YiZElaLJacR1XjcoXsQ5YAtE+kKxtkSbIVOBNr2AwKzciTPWTLC0gDT+BrygyL9uB
	 yyE6lix+ONFEDHUYpbFgalLOctIHBFvcccr3l5LYCncqQ4eOb2X30rF0wnG1YcOAEC
	 FyL/ozKkJvmn6vgTnZ9q2gau0AkXzKaqgFc5po3Od1IEA+YiyZhy8WfxAuo41+EQ7W
	 1xA8Yracvb+nOGbuc+0bBQQHtGbnFb3s8VJ9H7WRq7cBECI4yGSdhCAjTJci5gbsIQ
	 zQ6q8fYNaVWFSPu9OQmKuG1nolInJK1+EJGbtZH6TTlN6tEnafXXQYhPRuc+j3dvXM
	 65ZalyJj2b93w==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5ba3ec92031so4597270e87.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 11:40:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx5sZrsFYaP52t0GaTV0sIH13MyqHTeuHxQkYYctSv0jpXaDP/pAWBjvycngiXSgX8iDbrfm8hRYQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIZ8KXuk95Dx3+y9tSUrUjK6szFL9medSXqEoVXJXgZJleG61xU
	rW2gj6NqrW9xLpWNXKhluqDn2co4MtBbrsu5rs7jNNcCup/qfHKwSM2B80Iym/G9aiouytNPDqc
	y1sP2F11+aMQA/uAt5hutYfvGQAAyMaM=
X-Received: by 2002:a05:6512:114a:b0:5bc:b375:9dbe with SMTP id
 2adb3069b0e04-5bcde6a96cemr5757469e87.45.1792003201656; Wed, 14 Oct 2026
 11:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dcde6e02-d61f-429f-a9fd-57043c4819f7@oss.qualcomm.com>
In-Reply-To: <dcde6e02-d61f-429f-a9fd-57043c4819f7@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 14 Oct 2026 20:37:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hESvjrYRdVcAb+wQG5tc3wjQyQNongXhwEnh+GiN7Eyw@mail.gmail.com>
X-Gm-Features: AclHuK8sTIQtflGauZ2JnhT2z6w0pBS_TBVqEEPoIfYBjLbQFth6jH8_eEbD3OQ
Message-ID: <CAJZ5v0hESvjrYRdVcAb+wQG5tc3wjQyQNongXhwEnh+GiN7Eyw@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers for v7.4-rc1
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Aryan Sinha <sinha.aryan03@gmail.com>, Bhargav Joshi <j.bhargav.u@gmail.com>, 
	Biju Das <biju.das@bp.renesas.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dhruvin Rajpura <drajpura@qti.qualcomm.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Georgi Djakov <djakov@kernel.org>, 
	Hemanth Selam <hemanth.selam@gmail.com>, Karl Mehltretter <kmehltretter@gmail.com>, 
	liujing <liujing@cmss.chinamobile.com>, Markus Elfring <Markus.Elfring@web.de>, 
	muzafferkadir@mainlining.org, Ovidiu Panait <ovidiu.panait.rb@renesas.com>, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, Priyansh Jain <priyansh.jain@oss.qualcomm.com>, 
	Rob Herring <robh+dt@kernel.org>, Ronald Claveau <linux-kernel-dev@aliel.fr>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Vitaliy Sochnev <sochnev.v.74@gmail.com>, 
	Weigang He <geoffreyhe2@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, Oct 14, 2026 at 4:08=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
>
> Hi Rafael,
>
>
> The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b9=
35:
>
>    Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v7.4-rc1
>
> for you to fetch changes up to 2dc1f296b5754dd2441fc8b6613a362a47f6b98f:
>
>    thermal/drivers/rzg3e: Propagate reset assertion failure from suspend
> (2026-10-14 09:46:07 +0200)
>
> ----------------------------------------------------------------
> - Add the Exynos ACPM thermal driver for Google GS101, along with
>    DT bindings and a MAINTAINERS entry (Tudor Ambarus)
>
> - Add Renesas RZ/G3L thermal sensor support and DT bindings, and move
>    default calibration values to per-SoC match data (Biju Das)
>
> - Add Qualcomm MSM8952 TSENS support and the corresponding DT binding
>    compatible (Muzaffer Kadir)
>
> - Document the Qualcomm PMAU0102 Master BandGap temperature monitor
>    compatible in the DT bindings (Dhruvin Rajpura)
>
> - Extend the QCom TSENS v2 trip temperature limits to the hardware
>    range of -204=C2=B0C to +204=C2=B0C to prevent interrupt storms when o=
perating
>    beyond the previous software limits (Priyansh Jain)
>
> - Fix temperature threshold map indexing in the QCom SPMI temperature
>    alarm driver to prevent out-of-bounds reads (Georgi Djakov)
>
> - Describe the additional bus clock required by the Amlogic T7 thermal
>    sensor and switch the driver to the clk_bulk API to manage multiple
>    clocks (Ronald Claveau)
>
> - Request the Airoha EN7581 IRQ after thermal zone registration to
>    prevent the interrupt handler from accessing an unregistered or
>    already freed thermal zone (Vitaliy Sochnev)
>
> - Fix the Airoha AN7583 ADC mux field mapping, serialize access to the
>    shared ADC, and verify mux selection to avoid invalid temperature
>    readings and spurious critical shutdowns (Vitaliy Sochnev)
>
> - Register separate thermal zones for the AN7583 bandgap, GbE and CPU
>    sensors, and update the DT bindings to use one thermal sensor cell
>    to select the sensor (Vitaliy Sochnev)
>
> - Fix signed integer overflow in the Renesas RZ/G3E temperature-to-code
>    conversion, preserve compare interrupt state across runtime PM,
>    and prevent overlapping temperature conversions (Ovidiu Panait)
>
> - Remove redundant trip window validation and runtime PM
>    pm_runtime_mark_last_busy() calls from the Renesas RZ/G3E driver
>    (Ovidiu Panait)
>
> - Propagate reset assertion failures from Renesas RZ/G3E suspend and
>    attempt to restore power if the sensor was active (Pengpeng Hou)
>
> - Stop the TI bandgap alert IRQ before removing sensor interfaces and
>    cancel pending alert work to prevent use-after-free on driver removal
>    (Weigang He)
>
> - Validate Spreadtrum sensor IDs read from the device tree before using
>    them for register offsets and array indexing (Weigang He)
>
> - Convert the TI OMAP bandgap DT bindings to schema and document the
>    DRA752 compatible and thermal sensor cells (Bhargav Joshi)
>
> - Use DT property helpers matching the signed temperature and unsigned
>    hysteresis types defined by the thermal zone bindings (Rob Herring)
>
> - Reuse common error handling code in the power allocator governor
>    bind callback (Markus Elfring)
>
> - Constify the thermal zone device operations in the i.MX9 driver
>    (Christophe JAILLET)
>
> - Fix kernel-doc parameter names and firmware node references in the
>    cooling device registration helpers (Aryan Sinha)
>
> - Correct the documented return value of ti_bandgap_get_sensor_data()
>    to describe validation errors and potentially NULL stored data
>    (Karl Mehltretter)
>
> - Ensure NUL-termination when copying the cooling device command-line
>    argument in tmon and fix the associated string truncation warning
>    (Florian Fainelli)
>
> - Fix undefined behavior caused by a signed shift in the tmon thermal
>    zone binding display (Liu Jing)
>
> - Fix wording in tmon comments (Hemanth Selam)
>
> ----------------------------------------------------------------
> Andy Shevchenko (1):
>        thermal: sysfs: switch to use scnprintf() to suppress truncation
> warning
>
> Aryan Sinha (1):
>        thermal/fw: Fix kernel-doc parameter names
>
> Bhargav Joshi (1):
>        dt-bindings: thermal: ti,omap-bandgap: Convert to DT schema
>
> Biju Das (3):
>        dt-bindings: thermal: r9a08g045-tsu: Document RZ/G3L TSU
>        thermal/drivers/renesas/rzg3s: Convert calibration defaults to
> per-SoC match data
>        thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU support
>
> Christophe JAILLET (1):
>        thermal/drivers/imx9: Constify struct thermal_zone_device_ops
>
> Dhruvin Rajpura (1):
>        dt-bindings: thermal: qcom,pm8775-mbg-tm: Document PMAU0102
>
> Florian Fainelli (1):
>        tools/thermal/tmon: Fix string truncation warning in optarg copy
>
> Georgi Djakov (1):
>        thermal/drivers/qcom-spmi-temp-alarm: Fix temp_map indexing
>
> Hemanth Selam (1):
>        tools/thermal: Fix typo "binded" in comments
>
> Karl Mehltretter (1):
>        thermal: ti-soc-thermal: Fix the return value in
> ti_bandgap_get_sensor_data() kernel-doc
>
> Liu Jing (1):
>        tools/thermal/tmon: Fix signed shift UB in binding display
>
> Markus Elfring (1):
>        thermal: gov_power_allocator: Use common error handling code in
> power_allocator_bind()
>
> Muzaffer Kadir (2):
>        dt-bindings: thermal: tsens: Add MSM8952
>        thermal/qcom/tsens: Add support for MSM8952 tsens
>
> Ovidiu Panait (5):
>        drivers/thermal/renesas/rzg3e: Fix signed integer overflow in
> temp_to_code()
>        thermal/drivers/renesas/rzg3e: Fix runtime PM handling of compare =
irq
>        thermal/drivers/renesas/rzg3e: Fix race between set_trips() and
> get_temp()
>        thermal/drivers/renesas/rzg3e: Remove unneeded low/high check in
> set_trips()
>        thermal/drivers/renesas/rzg3e: Remove redundant
> pm_runtime_mark_last_busy() calls
>
> Pengpeng Hou (1):
>        thermal/drivers/rzg3e: Propagate reset assertion failure from susp=
end
>
> Priyansh Jain (1):
>        thermal/drivers/qcom/tsens: Widen temperature limits to match
> hardware range
>
> Rob Herring (Arm) (1):
>        thermal: of: Match trip property helper types
>
> Ronald Claveau (2):
>        dt-bindings: thermal: amlogic: describe bus clock for t7-thermal
>        thermal/drivers/amlogic: Switch to clk_bulk API to support
> multiple clocks
>
> Tudor Ambarus (3):
>        dt-bindings: thermal: Add Google GS101 TMU
>        thermal/drivers/samsung: Add Exynos ACPM TMU driver GS101
>        MAINTAINERS: Add entry for Samsung Exynos ACPM thermal driver
>
> Vitaliy Sochnev (5):
>        thermal/drivers/airoha: Request the EN7581 IRQ after zone
> registration
>        thermal/drivers/airoha: Fix AN7583 ADC mux field mapping
>        thermal/drivers/airoha: Serialise access to the shared ADC
>        dt-bindings: arm: airoha: Use one thermal sensor cell for AN7583
>        thermal/drivers/airoha: Register a thermal zone per AN7583 sensor
>
> Weigang He (2):
>        thermal/drivers/ti-soc-thermal: Cancel pending alert work on remov=
e
>        thermal/drivers/sprd: validate the sensor id from the device tree
>
>   .../bindings/arm/airoha,en7581-chip-scu.yaml       |   3 +-
>   .../bindings/thermal/amlogic,thermal.yaml          |  29 +-
>   .../bindings/thermal/google,gs101-tmu-top.yaml     |  69 +++
>   .../bindings/thermal/qcom,pm8775-mbg-tm.yaml       |   7 +-
>   .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
>   .../bindings/thermal/renesas,r9a08g045-tsu.yaml    |   4 +-
>   .../bindings/thermal/ti,omap-bandgap.yaml          | 177 ++++++
>   .../devicetree/bindings/thermal/ti_soc_thermal.txt |  88 ---
>   MAINTAINERS                                        |   8 +
>   drivers/thermal/airoha_thermal.c                   | 179 ++++--
>   drivers/thermal/amlogic_thermal.c                  |  14 +-
>   drivers/thermal/gov_power_allocator.c              |  11 +-
>   drivers/thermal/imx91_thermal.c                    |   2 +-
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   8 +-
>   drivers/thermal/qcom/tsens-v1.c                    |  41 ++
>   drivers/thermal/qcom/tsens-v2.c                    |   4 +-
>   drivers/thermal/qcom/tsens.c                       |   3 +
>   drivers/thermal/qcom/tsens.h                       |   2 +-
>   drivers/thermal/renesas/rzg3e_thermal.c            |  45 +-
>   drivers/thermal/renesas/rzg3s_thermal.c            |  38 +-
>   drivers/thermal/samsung/Kconfig                    |  19 +
>   drivers/thermal/samsung/Makefile                   |   2 +
>   drivers/thermal/samsung/acpm-tmu.c                 | 651
> +++++++++++++++++++++
>   drivers/thermal/sprd_thermal.c                     |   6 +
>   drivers/thermal/thermal_fw.c                       |   8 +-
>   drivers/thermal/thermal_of.c                       |  11 +-
>   drivers/thermal/thermal_sysfs.c                    |  12 +-
>   drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  10 +-
>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   4 +
>   tools/thermal/tmon/sysfs.c                         |   2 +-
>   tools/thermal/tmon/tmon.c                          |   4 +-
>   tools/thermal/tmon/tmon.h                          |   2 +-
>   tools/thermal/tmon/tui.c                           |   2 +-
>   33 files changed, 1262 insertions(+), 204 deletions(-)
>   create mode 100644
> Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
>   create mode 100644
> Documentation/devicetree/bindings/thermal/ti,omap-bandgap.yaml
>   delete mode 100644
> Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
>   create mode 100644 drivers/thermal/samsung/acpm-tmu.c

Pulled and added to linux-pm.git/linux-next, thanks!
