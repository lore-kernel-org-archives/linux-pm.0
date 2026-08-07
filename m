Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79641D11B
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786133048; cv=none; b=jTxY2Z7bcxTyj6OIP6hmbkC0tidfxN7zB5KkDyf1cV5mEa6hMqYdG2q33bKKukDbTe32xJEaNKvxkFX1p+qGAgTPXompiCUbYbHGWBYz3ILrToDcSJCXokD8BmxQaSgSUwQksXbHMU9mwe3nTd6vNE5p419O7OeCZEMRO7q+dnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786133048; c=relaxed/simple;
	bh=YhktGsZSyl3pw8vKmz55aHodW+8qoIC+F791+3qIRsQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TMiEUBl+V6UciFsDZPDNm8Ts9S6IpiaaGgZm3cpE7GyqZGDA+TB8d4GrGDdkaSjc5m1q83iD+jbNAC+V86dKG8Jftgxf+L5iAHw+pcy9dNZG6MoQYZ70HDBFFL0wBuaWxvhTMebjuUzFkN5IrVq8m2jE3R2l8MFYnvwvU4MBimQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ArWkX4k3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CUpMmVBi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ArWkX4k3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CUpMmVBi"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677ImFJD1474004
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 20:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YAHTsN1SxcEB9glrMdNJNx
	I2xfAf21NmyL4IW+ixmjY=; b=ArWkX4k3wtfCGqcQJxXN1NhB0hhVLaoVZ+0Q20
	JM8chgRi+m1u6GJnaPY9z8SbG8ZHn8k08dSpm9/T3NKjwpfdq+Tl5eqqWQ1sxMBk
	qGSt2H4My1faq5Tna5u1fWLwoEyr+sRooo1h8Fl7fUcYfA4Xk1/BRC1UlK3QvQ3U
	+IN4nShoDz6srGmUrgfbTYWjbxkg+Dgb5/xqmIQgMFr1rrohCnB2CWMJV0KlJk5T
	+89iL+h9pdsW3Z0o7OaLvYDf1Bpb5CPqyAEp9tgCxb8F5Exia8VN3ZENNGfc1fux
	XWbArWLGoyuvR34GVUOewqDX6dd1o3CzLg4U22O5ArOVGN/A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwhk3ha9u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 20:04:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c20762d21so44387471cf.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 13:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786133045; x=1786737845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YAHTsN1SxcEB9glrMdNJNxI2xfAf21NmyL4IW+ixmjY=;
        b=CUpMmVBitoGh6ezexEPzx1crY9hI9VMtipZOLYMaPLvQNmpVGNclVPBXljTMC8WYdD
         W4CzAGH/FNg38Px4ekFKvzgZmTX15S28zgAWSy450vL4Ppt5nCZOjHvyCuBfOZkb1+dC
         faLghOAmYtZKOUuv3/jPiq4wnPRGp+cvj57whrSFaWsU9m6Cv/es7uIND/TQfQTDWj9B
         y4sQsTWOP/67K8ef5BHn8alJdOnnEYgmXkcv28Gz25E0YDR+gGdv7TDfkgs0NFrOnX7n
         aCBn4hpb36th2M6JDI6sVofEBkjD+6HezBfyoFKLzl9kl6BTDrBt+/n9GG7y2wOridsd
         2jnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786133045; x=1786737845;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YAHTsN1SxcEB9glrMdNJNxI2xfAf21NmyL4IW+ixmjY=;
        b=n+VhjoZX4uSj3xDhydzBz2yPxph8bLYoLyWkH+IbuggpywzqzPpuxV40Ws1YbcmWbc
         LXIulR6q6rQN1wBmevp0w2jR33xPOaIVCyiHrE6Xd7Kka4sNV2ZokqHwtKMrfJcVrfJq
         9nKkYRJNZSmE3tnBUdnQ7lCorLKwGVpok2kWrDvfmvEafvpAlmCn9NgpglsMo6mYOXus
         AdE7MpdXw8V85HAZZZvpX77fvEMumlnu4V8AHNLwQDXEI8GWaJzZAS6yVEWBmFeiSKlk
         9CS3piRChESY4oxSi3LoqCWXqmOxUXJiNWI/rqhAcpLccyEP+9j17PFyiTh5fAXrcBFy
         m4ig==
X-Forwarded-Encrypted: i=1; AHgh+RqPUOV7CKmV6Ww0TdqWf6rLEojiqEzw0Yr/JKL9DjOnFoAPG095T3ZJGj1UsgU7v3OhXURAM7Mq+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFKg3PhI7Nhyur5jnPtyBj4Zt4Irh+hluZ7F+5d3nUxSZW3jkO
	nTyBfPnuO8ELMItatCtC/KZ1LoClfFVqa441F6jGLV4mhlW+QOMXDoYyR4xDfYCHhgZKEjKlEFq
	b20nybPx13V/E+UI2OQAMwGWJCNmJty2sifeVbghS2rT4jYzp7EIBrrdyhq5hDw==
X-Gm-Gg: AR+sD10yfMSFuLJdRfdwC/vteU30zSYvGSo56MmCjNJm/d8svrTMk/8K6B4p1D0xMTE
	de7KA38NeCcHkF+162RoAaGPY0tPauKFmyw0KRR/RVvhBA1Kd54tyK23MfMcfOwNMqgfZkh7YC/
	VTh6IjpYiubJH3tHGUKjRU5VlduOwUBXxU/z+8QQD2juF/JhcTLB8kA4MxIPZ3skH38qxAwwMBa
	vFJXC339sJbZ4RCu/+fDr4R9+OcV9JX9YHzgrER2X/kcTJl64di8b+tS9VMJSI6B1Z5JkzQCDlk
	ftwj8WEJxoUUAdiJa/M2NHt3dT6MDGdqZueb5/jf6pOAxOOxmQ3691xo9PPpVHeMc1lJY1mKVBq
	d/Q5eF9TRzANMN68hSz5BolmxvNYBk+z3BbJHbtOsTxfc7A==
X-Received: by 2002:a05:622a:480f:b0:52b:581e:1274 with SMTP id d75a77b69052e-52d18ec82e0mr78363441cf.19.1786133044748;
        Fri, 07 Aug 2026 13:04:04 -0700 (PDT)
X-Received: by 2002:a05:622a:480f:b0:52b:581e:1274 with SMTP id d75a77b69052e-52d18ec82e0mr78362521cf.19.1786133044238;
        Fri, 07 Aug 2026 13:04:04 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002150952sm7544093f8f.15.2026.08.07.13.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 13:04:03 -0700 (PDT)
Message-ID: <7d85c5c6-3ee3-4ce6-aeeb-e4f15cb57b32@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 22:03:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <Lukasz.Luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bryan B. Lima" <bblima@usp.br>, Dan Carpenter <error27@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Can Peng <pengcan@kylinos.cn>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Haritha S K <haritha.k@oss.qualcomm.com>,
        Pei Xiao <xiaopei01@kylinos.cn>, marek.vasut+renesas@gmail.com,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Andreas Haufler <andreas@haufler.info>,
        Pan Chuang <panchuang@vivo.com>, surendra <kr494167@gmail.com>
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Subject: [GIT PULL] thermal drivers for v7.3-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RKaD2Yi+ c=1 sm=1 tr=0 ts=6a763a35 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=uyM6vb5DrBnEitOwxxEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE1NiBTYWx0ZWRfX65jDoxTAXJXd
 42MAcWXJDgN3aYlECwINCdMaw4ASCeXe+DPOd4JT7dHaUuH5XyTYRh1nhuKhbgI0vqwvFWUjFa1
 TnoKhKEPi7qKLjqyNRXeEXGTrZYrHVE=
X-Proofpoint-ORIG-GUID: ke_IZf-e-Nm7aCUdMOMFEmt4kb0CO7H7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE1NiBTYWx0ZWRfXz9Sy80o1mPGf
 L70kGnn0VFHjekHJ7smN3St0B3vzwpwVohfsHiKlkiufTIENB8PuclalrFN9MjQLWmq3MxA6gJN
 fj8BgSr6xYq6YqbTxigxBtK70Sw9p6DRuUyoeHqcnsm40S8Lq72NUeQsVIT+MiZTEdghcN84GVC
 igb7ztpN6ZepSvgEflvFwyt1TBxb4ko66gCzh10cnVWfDXv7I6Xvy1zD60V+1nAh3giCGXBWM5f
 Snxekkgpl5T+Ph5OOtS69k97YhmvTZIk//nRqCIjWjSiXnTMK3sZ//FnrWJpP9K/oTAZ2Fe0Lu4
 Uyr+FVhOULDfblePmj0figZMpQyuQ8z/BaqgSt7w3igx8qrCLsPhG5hgaUVh2y2cDFT1wPvEqvY
 ULmV5bB+cdcJBmaZOpaYiq2QSPwXlyNN2EJLsEFfQXJpTtTm5M+EOMU+X0AtEdVR9JPwx2lNNZH
 l5TTjcc/vgZKELxmYWg==
X-Proofpoint-GUID: ke_IZf-e-Nm7aCUdMOMFEmt4kb0CO7H7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070156


Hi Rafael,

please consider the following changes since commit 
8cdeaa50eae8dad34885515f62559ee83e7e8dda:

   Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v7.3-rc1

for you to fetch changes up to 55c16e15ff9f91bc994a20124b83faf27f0e3690:

   thermal/drivers: Remove redundant error messages on IRQ request 
failure (2026-08-07 17:27:28 +0200)

----------------------------------------------------------------
- Move thermal_zone_device_enable() to the right place in order to
   prevent calling it if the thermal zone registration failed (Dan
   Carpenter)

- Improve bitfield manipulations on Armada (Bryan B. Lima)

- Remove unneeded 'fast_io' on Sun8i and Armada (Wolfram Sang)

- Fix wrong boundary when clamping the low values in the set_trips()
   callback and fix wrong mask when setting the temperature interval on
   Airoha (Christian Marangi)

- Make use of the regmap API in order to support the Airoha AN7583
   (Christian Marangi)

- Fix adc_tm5_get_temp() return check value on the QCom SPMI ADC
   sensor (Rakesh Kota)

- Fix unbalanced clock enablement when the resume fails on the iMX
   driver (Can Peng)

- Add Qualcomm Master BandGap thermal monitor support (Satya Priya
   Kakitapalli)

- Add Maili Temperature bindings compatible (Haritha S K)

- Add a devm action to clean hardware interrupts, sampling, and
   control registers on Spacemit K1 (Pei Xiao)

- Fix trivial typo in an OF code comment (Marek Vasut)

- Remove unecessary print on Qcom SPMI ADC driver when a call to
   devm_request_threaded_irq() fails as this one already prints a
   message (Jishnu Prakash)

- Add support for QCom PMIC5 Gen3 ADC by using auxialiary driver and
   shared interrupt with the IIO driver (Jishnu Prakash)

- Make resets optional on MT8196 and add the corresponding property in
   the DT bindings (AngeloGioacchino Del Regno)

- Fix clock staying enabled with the resume operation fails on Qoriq
   (Can Peng)

- Fix wrong closing brace position in thermal library header (Andreas
   Haufler)

- Fix low and high trip point validation by moving the check after the
   clamp on the spacemit driver (surendra)

- Remove redundant error messages on IRQ request failure (Pan Chuang)

----------------------------------------------------------------
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
       thermal/drivers/airoha: Generalize get_thermal_ADC and set_mux 
function
       dt-bindings: arm: airoha: Add the chip-scu node for AN7583 SoC
       thermal/drivers/airoha: Add support for AN7583 Thermal Sensor

Dan Carpenter (1):
       thermal/drivers/rcar: Fix error checking in probe()

Haritha S K (1):
       dt-bindings: thermal: qcom-tsens: Document the Maili Temperature 
Sensor

Jishnu Prakash (3):
       iio: adc: qcom-spmi-adc5-gen3: Remove an unnecessary print
       iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ with ADC_TM 
auxiliary driver
       thermal/drivers/qcom: add support for PMIC5 Gen3 ADC thermal 
monitoring

Marek Vasut (1):
       thermal/of: Fix trivial enabled typo

Pan Chuang (1):
       thermal/drivers: Remove redundant error messages on IRQ request 
failure

Pei Xiao (1):
       thermal/drivers/spacemit/k1: Add shutdown action and reorder 
registration order

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

  .../bindings/arm/airoha,en7581-chip-scu.yaml       |  14 +
  .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   4 +
  .../bindings/thermal/mediatek,lvts-thermal.yaml    |  13 +-
  .../bindings/thermal/qcom,pm8775-mbg-tm.yaml       |  72 ++++
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
  drivers/iio/adc/qcom-spmi-adc5-gen3.c              |  69 +---
  drivers/thermal/airoha_thermal.c                   | 382 
+++++++++++++++++----
  drivers/thermal/armada_thermal.c                   | 106 +++---
  drivers/thermal/broadcom/brcmstb_thermal.c         |   3 +-
  drivers/thermal/db8500_thermal.c                   |   8 +-
  drivers/thermal/hisi_thermal.c                     |   4 +-
  drivers/thermal/imx91_thermal.c                    |   2 +-
  drivers/thermal/imx_thermal.c                      |  13 +-
  .../int340x_thermal/processor_thermal_device_pci.c |   8 +-
  drivers/thermal/intel/intel_bxt_pmic_thermal.c     |   4 +-
  drivers/thermal/loongson2_thermal.c                |   2 +-
  drivers/thermal/max77620_thermal.c                 |   8 +-
  drivers/thermal/mediatek/lvts_thermal.c            |  17 +-
  drivers/thermal/qcom/Kconfig                       |  23 ++
  drivers/thermal/qcom/Makefile                      |   2 +
  drivers/thermal/qcom/lmh.c                         |   1 -
  drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   3 -
  drivers/thermal/qcom/qcom-spmi-mbg-tm.c            | 256 ++++++++++++++
  drivers/thermal/qcom/tsens.c                       |   5 +-
  drivers/thermal/qoriq_thermal.c                    |  13 +-
  drivers/thermal/renesas/rcar_thermal.c             |  19 +-
  drivers/thermal/renesas/rzg3e_thermal.c            |   4 +-
  drivers/thermal/rockchip_thermal.c                 |   3 +-
  drivers/thermal/samsung/exynos_tmu.c               |   4 +-
  drivers/thermal/spacemit/k1_tsensor.c              |  78 ++++-
  drivers/thermal/st/st_thermal_memmap.c             |   4 +-
  drivers/thermal/st/stm_thermal.c                   |   5 +-
  drivers/thermal/sun8i_thermal.c                    |   1 -
  drivers/thermal/tegra/soctherm.c                   |   8 +-
  drivers/thermal/tegra/tegra30-tsensor.c            |   3 +-
  drivers/thermal/thermal-fw.c                       |  12 +
  drivers/thermal/thermal_fw.c                       |  97 ++++++
  drivers/thermal/thermal_of.c                       |   2 +-
  include/linux/iio/adc/qcom-adc5-gen3-common.h      |   2 -
  tools/lib/thermal/include/thermal.h                |   4 +-
  40 files changed, 995 insertions(+), 284 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml
  create mode 100644 drivers/thermal/qcom/qcom-spmi-mbg-tm.c
  create mode 100644 drivers/thermal/thermal-fw.c
  create mode 100644 drivers/thermal/thermal_fw.c
