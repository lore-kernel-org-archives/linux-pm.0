Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4C2D12EC
	for <linux-pm@vger.kernel.org>; Sun,  7 Jun 2026 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780845675; cv=none; b=lGuZvdxnGOSArzG1j3e+TPbggh5Z51ZsAd/0eHMLiKf5M57taapwu30ZQCYV4ScyXC/AMT6R6fKC0AIVrKNmVs33TZO5x3/L0XbiHCxNGjt2saPTHX/djTmdAML5gE3zlZ1b05REOBIwdHAucGz5IfNuyjdU/CsS5nH31/GFv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780845675; c=relaxed/simple;
	bh=UQ1td9OdelFmWTJa7JvEiR3Njg6prNfei0TELsPYflE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tYPQKdgy2bgwiqoS+8Um27j4RtY8gRP6o8fwVja+MGqVZiZ8MCxre+G5z5EC4FQwWfgNZf+YJrmITxfXVIBq+zhuykrQOfFNyFMkAyoWd7i4NJWwAtumqLbDlGiW0s9QXvkZE4mxasY3kaD1p4tKICYvQE0HFPnvyJ5x3pbdngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zg32dyPR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C4aNnyyx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zg32dyPR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C4aNnyyx"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657Elias439834
	for <linux-pm@vger.kernel.org>; Sun, 7 Jun 2026 15:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5ZpU9OC6ER68E5SI93Ra/6
	7P0DLT3HagxFdEGufoOCI=; b=Zg32dyPRgmbzLhJw50c7vyF4VpaHmsfRXoG9NE
	r5FJvGwwKsnxp1YCWPCSUQd4qqsIARfE7Qf6g/UuPSS98UTuV6nd5aEzz5IWxMWW
	92ykUGQO9bfKq50OtQeLwBoTR2OXWRIFDGBfIiWc314Res7sHmqutYQVRNzJEvqI
	Yxh0yCiphYO5Xf7rbB6UZDJBJk/z8gM1Y7wHGWLgEAEZqqB56rxlPHm/HZfDfqu5
	ChbNC65GD1ST4/JXC8P0LNrFZFPP49J5ja95rUyrNL3W0eczk61VWKy+2ekEvUkl
	C405HRDrII+Gv/1kGx4jiDiIhbcpFgxW+bek7sYo4S032Qcw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8uu8c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 15:21:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5176d5d7222so68171331cf.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780845670; x=1781450470; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZpU9OC6ER68E5SI93Ra/67P0DLT3HagxFdEGufoOCI=;
        b=C4aNnyyxTmZKa0jwCenuRXhpav9O43dtD5aamLGAoNxm1rz5GXAbC0HxCgfE2fYEse
         337qU1apaUczKv/Ay9rOLEMa5lY05jIJggjS9ye9Z0QVtaTxdlsAv3E85sHglvzpA8yA
         f71GakquHaN5WqsIbi9H/7a8VDb7b1Hp4jaxnC9SvchyaQVZjjSBUKNJ2nLJlCoXBbNi
         Ype6WX6jLuv7bCPAOE7wolYILqrWzDEh70N6eCGlVDhm2aYwgnke6G5bY7ERfyTlxrqC
         gk5kd/Ctf8kN5B7I0e0VTFL3MPj/bIid578t4H5U6hzQVbUTkPwYrR96ybk0eahF4PCC
         lgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780845670; x=1781450470;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ZpU9OC6ER68E5SI93Ra/67P0DLT3HagxFdEGufoOCI=;
        b=rLtpnFxNYN8Sa3c0H/E5toGjZYEY00YBX9zr3Nw8YXUwO+g8JGDW3sxOKrsjz7n1/O
         VbvCnVO4HkZDzkbOO+JtPhpaEDF8PIb5AP3aGDF9U8suShbf8O9y+GdE23B7NwZOak6g
         vEl7d3m3c/DEQgRRgMsd45eODZWs49a702rJOh5rD4Ab8+ryP6vQhpWDOrq01pMboUnW
         qgTZhzTDVHnrSEclTp2qOUzlFThPsat9FQqDq3Xsk2+Omhf0KnaDIGVtWUpJafvsUJXb
         gisfo0V5+RLKQPYWWOyCz8wEZz+oE27yezzyFvxkX+LPmj4uCjrIKt6YGHqx+vXRKjh0
         23CA==
X-Forwarded-Encrypted: i=1; AFNElJ+WwOoV62gFogyJqhixaEOaTmxCzgaHXscmx37A8DbVo8RNb/JlFb/C7SExhOpkdDvNP9ajCwqyfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj8652EGnyof8kxT+kVsLO274d8pC0UXWKgwQ7TYlBs35+m1Ak
	hcEshSasAaviiEjJAKcCI7pU9DGdvqckgAt3LJLLP3Az3cY5nFCOO8B8301xPHkW2wQJa+IlsdW
	CW1i1GXejSmO4Z/wh/iZm1mOyNJwoyajopgC67XL6Wpn4bHRiLM/orcDuiTVOPw==
X-Gm-Gg: Acq92OH8oGWdLAUelgdmOJA5kwD0EfARmtOF2mXFcm/wV2q/W9rurEoUwe9UzSvS37w
	Rfa6fAIqDRqj/40G5HRBNXNkCIRt0HOX8Ou76S/fne0ne/Dj5DEcUkh4r6eg3fJpgbliZ0MCwST
	SSUmubQ7EPFWx7UpolZ2j8QXpPL6px6gHhIDAiwFIlHUNC3EQiFdX81/bPdeelorwq+0rrJFlAm
	rIcMrtEwtyimzdMtreMUXXCC/lfRIvHQ6KUh4Ma9CbsT+mSZmCzardP42GR3Jh8GJtkvMxfkN7Q
	9uchJDn8uWGttA9Uu/ZF8Kxg4pTO6nwjxT9CBcGRg4vgZejCstzhxENHNBgRHPbvt3fWQBkpRXv
	WuBipR9RSCurFIp1uerdYnwd/mBwbFBwgx68F/u3ipqdMDArl8gTDCE/Os6f/D978Iu3JXF064T
	KA5zImkE8sjFfqUojtuzo=
X-Received: by 2002:a05:622a:124b:b0:517:88a0:9b2e with SMTP id d75a77b69052e-51795a71255mr171659761cf.4.1780845669564;
        Sun, 07 Jun 2026 08:21:09 -0700 (PDT)
X-Received: by 2002:a05:622a:124b:b0:517:88a0:9b2e with SMTP id d75a77b69052e-51795a71255mr171659371cf.4.1780845669066;
        Sun, 07 Jun 2026 08:21:09 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ce9e:f8b6:20af:d01d? ([2a05:6e02:1041:c10:ce9e:f8b6:20af:d01d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35eae5sm44618256f8f.33.2026.06.07.08.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 08:21:08 -0700 (PDT)
Message-ID: <4f7a64f5-4f58-4552-9fc8-820bc7652c11@oss.qualcomm.com>
Date: Sun, 7 Jun 2026 17:21:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lukasz Luba <Lukasz.Luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>,
        jacky.baip@gmail.com, Jinseok Kim <always.starving0@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mayur Kumar <kmayur809@gmail.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Ronald Claveau <linux-kernel-dev@aliel.fr>,
        Shuwei Wu
 <shuwei.wu@mailbox.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Subject: [GIT PULL] thermal drivers for v7.2-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DgF3ZqQXVAN--P1m-eQ-v4gVJ2TBfnqC
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a258c69 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=C15exOp2nNw1rQcZD-AA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE1MiBTYWx0ZWRfX2GhUhdHiMdfX
 RopAwPsXjgxImDoDbhhYzHFC0m9+jX7oqrO8p/8pUlgML1kzersoGEZTDt3g3Buva8Lq2A27QBe
 xJNBJAgzlK9Q4COpw4MN/KIyA26llYorFLcYiH2jxh5QvvnI6MGeW6WtbutuxybsZJ/w4SrqwYv
 fihmJVuWqO8o6B/Azjq6J2AmV2LX8eWjbGQka7wvaiU2YxnQirX10dxKIhhmNsH+0mmyEFCyopB
 c+Hn4J5/5x2a2Bk1s0xAulyIJOAB0UjvVI5TjSoYzaSt2ra2Qo30UoK2zQOqkNsSd+P0zo85WrF
 878t5aMnAQTMySfsgj/aXHam1FkU6yi0k+fs3JmLTlTOzp1JbMTxnh6YnSIZ7/rBcDF2yZ3GgKd
 p8XDM/B7D71VFPDNBK/mGdixtAZWor1L1oo3h/uSZvXlM8WCMT4XZwJpVdjtq24wTKggbp10uY2
 Dorg/5EZ3s9MA8kWg2Q==
X-Proofpoint-GUID: DgF3ZqQXVAN--P1m-eQ-v4gVJ2TBfnqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070152


Hi Rafael,

please consider the following changes since commit 
21c315342b81526874acfa311f11b3f72bed4e14:

   thermal: sysfs: remove space before tab in macro (2026-05-22 18:55:08 
+0200)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v7.2-rc1

for you to fetch changes up to 968098b4ca5219b0d2e0a981aed1dacfbd5adc69:

   thermal/drivers/qcom/tsens: Disable wakeup interrupt setup on 
automotive targets (2026-06-03 09:13:04 +0200)

----------------------------------------------------------------
- Add the QCom Nord temperature sensor DT bindings (Deepti Jaggi)

- Use devm_add_action_or_reset() for clock disable on the NVidia
   soctherm and switch to devm cooling device registration version
   (Daniel Lezcano)

- Replace the devm version implementation by the helper doing the same
   thing (Daniel Lezcano)

- Add the Amlogic T7 thermal sensor along with thermal calibration
   data read from SMC calls (Ronald Claveau)

- Fix typo in comment, "uppper" with "upper" in the TSens QCom driver
   (Jinseok Kim)

- Add the QCom Shikra temperature sensor DT bindings (Gaurav Kohli)

- Add the QCom Hawi temperature sensor DT bindings (Dipa Ramesh Mantre)

- Fix atomic temperature read in the QCom tsens to comply with
   hardware documentation (Priyansh Jain)

- Fix trailing whitespace and repeated word in the OF code. Do not
   split quoted string across lines in the iMX7 driver (Mayur Kumar)

- Add SpacemiT K1 thermal sensor support (Shuwei Wu)

- Add the i.MX93 temperature sensor support and filter out the invalid
   temperature (Jacky Bai)

- Enable by default the TMU (Thermal Monitoring Unit) on Exynos
   platform (Krzysztof Kozlowski)

- Split the core code and the OF which are interleaved. Add the
   cooling device per index registration in order to support dedicated
   cooling devices controller (Daniel Lezcano)

- Add DT binding to specify an index in the cooling device map (Gaurav
   Kohli)

- Rework interrupt initialization in the Tsens driver and add the
   optional wakeup source (Priyansh Jain)

----------------------------------------------------------------
Daniel Lezcano (13):
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
       thermal/core: Make cooling device OF node conditional on 
CONFIG_THERMAL_OF
       thermal/of: Rename the devm_thermal_of_cooling_device_register() 
function
       thermal/of: Add cooling device ID support
       thermal/of: Pass cdev_id and introduce devm registration helper
       thermal/of: Support cooling device ID in cooling-spec
       thermal/core: Fix missing stub for 
devm_thermal_cooling_device_register

Deepti Jaggi (1):
       dt-bindings: thermal: qcom-tsens: Document Nord Temperature Sensor

Dipa Ramesh Mantre (1):
       dt-bindings: thermal: qcom-tsens: Document the Hawi Temperature 
Sensor

Gaurav Kohli (2):
       dt-bindings: thermal: qcom-tsens: Document the Shikra Temperature 
Sensor
       dt-bindings: thermal: cooling-devices: Update support for 3 cells 
cooling device

Jacky Bai (3):
       dt-bindings: thermal: qoriq: Add compatible string for imx93
       thermal/drivers/qoriq: Add i.MX93 tmu support
       thermal/driver/qoriq: Workaround unexpected temperature readings 
from tmu

Jinseok Kim (1):
       thermal/drivers/qcom: Fix typo in comment

Krzysztof Kozlowski (1):
       thermal/drivers/samsung: Enable TMU by default

Mayur Kumar (2):
       thermal/of: Fix trailing whitespace and repeated word
       thermal/drivers/imx: Do not split quoted string across lines

Priyansh Jain (3):
       thermal/drivers/qcom/tsens: Atomic temperature read with 
hardware-guided retries
       thermal/drivers/qcom/tsens: Switch wake IRQ handling to PM callbacks
       thermal/drivers/qcom/tsens: Disable wakeup interrupt setup on 
automotive targets

Ronald Claveau (5):
       dt-bindings: thermal: amlogic: Add support for T7
       firmware: meson: sm: Thermal calibration read via secure monitor
       firmware: meson: sm: Add thermal calibration SMC call
       thermal/drivers/amlogic: Add missing dependency on MESON_SM
       thermal/drivers/amlogic: Add support for secure monitor 
calibration readout

Shuwei Wu (2):
       dt-bindings: thermal: Add SpacemiT K1 thermal sensor
       thermal/drivers/spacemit/k1: Add thermal sensor support

  .../devicetree/bindings/hwmon/pwm-fan.yaml         |   3 +-
  .../bindings/thermal/amlogic,thermal.yaml          |  37 ++-
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |   3 +
  .../devicetree/bindings/thermal/qoriq-thermal.yaml |   1 +
  .../bindings/thermal/spacemit,k1-tsensor.yaml      |  76 ++++++
  .../bindings/thermal/thermal-cooling-devices.yaml  |   8 +-
  .../devicetree/bindings/thermal/thermal-zones.yaml |   3 +-
  drivers/firmware/meson/meson_sm.c                  |  28 ++-
  drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |   5 +-
  drivers/hwmon/amc6821.c                            |   2 +-
  drivers/hwmon/aspeed-pwm-tacho.c                   |   5 +-
  drivers/hwmon/cros_ec_hwmon.c                      |   4 +-
  drivers/hwmon/dell-smm-hwmon.c                     |   4 +-
  drivers/hwmon/emc2305.c                            |   6 +-
  drivers/hwmon/gpio-fan.c                           |   6 +-
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
  drivers/thermal/amlogic_thermal.c                  | 112 ++++++---
  drivers/thermal/cpufreq_cooling.c                  |   2 +-
  drivers/thermal/cpuidle_cooling.c                  |   2 +-
  drivers/thermal/devfreq_cooling.c                  |   2 +-
  drivers/thermal/imx_thermal.c                      |   4 +-
  drivers/thermal/khadas_mcu_fan.c                   |   7 +-
  drivers/thermal/qcom/tsens-v2.c                    |   9 +-
  drivers/thermal/qcom/tsens.c                       | 183 ++++++++++----
  drivers/thermal/qcom/tsens.h                       |  24 +-
  drivers/thermal/qoriq_thermal.c                    |  71 +++++-
  drivers/thermal/samsung/Kconfig                    |   1 +
  drivers/thermal/spacemit/Kconfig                   |  19 ++
  drivers/thermal/spacemit/Makefile                  |   3 +
  drivers/thermal/spacemit/k1_tsensor.c              | 280 
+++++++++++++++++++++
  drivers/thermal/tegra/soctherm.c                   |  34 +--
  drivers/thermal/thermal_core.c                     | 111 ++------
  drivers/thermal/thermal_core.h                     |   5 +
  drivers/thermal/thermal_of.c                       | 152 ++++++++++-
  include/linux/firmware/meson/meson_sm.h            |   3 +
  include/linux/thermal.h                            |  71 ++++--
  45 files changed, 1070 insertions(+), 258 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/thermal/spacemit,k1-tsensor.yaml
  create mode 100644 drivers/thermal/spacemit/Kconfig
  create mode 100644 drivers/thermal/spacemit/Makefile
  create mode 100644 drivers/thermal/spacemit/k1_tsensor.c
