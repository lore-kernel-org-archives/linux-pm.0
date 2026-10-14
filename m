Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9DF53E2EA
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986902; cv=none; b=L59aXfeOGKM+jHfqXbcpm4wBCxwori9R0yrTQd3UbrdC6y4lNP6quUijPyJhMRpdVMyC6Dhc8B7jdOhYGWN/gvZ3/4YkQIeZPKrpj4kn7r6utippB7ohQWm3RQxDXV9PlKx403RuPR4UyVrpfxssvzSZJFuUPz3LqYuMetDVSNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986902; c=relaxed/simple;
	bh=sY592CUXRPO5suo9F//HYejBA4k7aIIcVNN3evi8b7c=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cXZXihWvyKWeFOyXV1Htfg/oPJGi0u75fNdR9YIKpRGhs3Yiexo0868k2ooEWdIUtVClObwbJx15q03X/AUpjHBGIDepll3qMyrJzIRRUjamyO44nzsj4iyqWmRpf5Mjp1iMwKVHoCky7rissYvpRANRVxAOEK8MTRsD1o5FCa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F2ViywUH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JASpGUeI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F2ViywUH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JASpGUeI"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EDFO572874286
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=oam5RquUgPNLW/N5nhpho8
	c5yrQywz5VwlW1AZvLTHc=; b=F2ViywUHwJp7WT/LTiy1TgBxjJXWsLT7jGdE0s
	hn/vcrAvdPOHSnxpFCVhXbXm7RsjDXRmyfTQg4QC8u79MpvnSZKkdKyHgXOxuI8h
	WdrM2y7AGWwJ7fnZ71zVrd0bdTW2zuN1MbvCkvPeOwJ8i9danvTt/8xDuvc8wHNu
	l9qrdiHv2uDiO3VsmW/+A+R+bAi94mriaYGIKzt/FqyuQPv9ArOZswM8/SrM+iMg
	MFL/idmpD6pPbsSQ8UeCtR+pu25CnjS5ECpwDh8kL651qCLIrJUFLCkLXNwFhr/c
	cVpmv2hhADvSYBTY41jwjY4QUq8sIelBMf5CMDKIq4VycXnw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9yphjwsg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:08:19 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5e975625ff0so102422e0c.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791986899; x=1792591699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oam5RquUgPNLW/N5nhpho8c5yrQywz5VwlW1AZvLTHc=;
        b=JASpGUeI0L7pvYC7NeUM+t5Dw+CdVdB5AjmHrRq+VdO01cfHhvPgIkS8O0F5I+duFG
         KBlH7YYDDY51VNLWLaLUxzuHOwusi0qBLBG3yycVIdMu8dHweneLv1kpMzhV9kFDOiZf
         jTfOuM83kfAwkirNlU/CZ7K9A0xDt68fVNTXQA3GxmcarWb62jMsK95j1N4oG2rHBVRk
         2lLsZjk+S2fRLKPi6Rx7EvwuuQfXrTZciEJPF/2Y0FM90gr/cVZnaeE6NTHp3rNlReT3
         zWgkSX8rFfWyMZmtzz2OL2ttY94DkLyIhRyjxJkW5lNjqaERmSRNwosS9khLdXApJha4
         FiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791986899; x=1792591699;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oam5RquUgPNLW/N5nhpho8c5yrQywz5VwlW1AZvLTHc=;
        b=E8aN0o8nPYzDJmPob/R7N2Ek/Sp7FKJN7b0vGqW9eq1cJ4VyoEIpveMnVSELyq02WK
         PPEqmtwezvYMzQqExHwt4DcQndvG9VB4VvyudgknGNflyHN05qr/A9Mv6X+MBek52AxH
         y1ZkLVRIvhpjXK4/9avvqcTMDqxKxt0jjx+5CArXzkV4UFheQoLxHHW6Wwm+0nayn1sG
         /5bmLkZZRXXzhZ7Q/WFRn1MXbVjbbJlhxSFovh5zvY1cmN2Ez64KskDJybU81EV3fZP2
         kbMy6HvUaearueDpHXsOxWyq+5wLTWCc1BqBR2W8tERGCHx19JS/Dzj+3ALhcOz7VAfg
         EkQA==
X-Forwarded-Encrypted: i=1; AKwUvBwB8dYjii4i41BDpUl2hTKsWvtVTiz9BuOi4NHATsikpk9tJb9BRRR42Femd3NLgeeTlbmKzg2D8Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYLLdjzGcGbG6kaYOue61BncHbqocab3g9qsilPVP0hnFoWwShEe
	XjEaY8N7ontsFT5coZJOu2xg+mtSThoy3hgv3yt5G6WgU82ojFCBQChey3Hj8eC82bWSri3wXHJ
	t2l2drI33jZo42d5XX2cnSExPGDWbtHBS/23/E4UhP/qzfUE92NItFyTSUt5Tdw==
X-Gm-Gg: AYBFou1rDIwrNc/IA8wajF2iu3t5PPubuyfI18dcYB/Z/6yFu/Q3ABVXCR1e54u82Y1
	pBo7hm9E85IRTiqUbq5qXVS7Q6L2gjnLEshImxRYQdsx4GMc1WtChTZ9W01t/5lAc6dJSO6m3fx
	zf//pIGZwSF2BNf+BuaWm5L2ilZPFLQl7GxGjKyY2KP3L0bKgxkKs9mSeZcXB88zUqYsZeuFLqq
	jjtWuwrZHRpRsmZO498sfpP5AcDqACzPmbHbmR3p5NI0rAkIZ4AGz26hez1XpNNb6ABiulsDMaY
	ongzvbATlR/SePBsU7JEI6WAG+xlLIOUlthY4LqaVUBahmZFzLXH0cZKA8QvzoKVsrzT0Fop1j2
	0ZpQpZMaRVUaGfNlFaFyq0AGaY1a1JGXNZj8ujoOt0VOAxa33kLa18n6Jv36qjQ==
X-Received: by 2002:a05:6122:e227:b0:5d7:2918:c644 with SMTP id 71dfb90a1353d-5e91f467355mr4514090e0c.7.1791986898594;
        Wed, 14 Oct 2026 07:08:18 -0700 (PDT)
X-Received: by 2002:a05:6122:e227:b0:5d7:2918:c644 with SMTP id 71dfb90a1353d-5e91f467355mr4514043e0c.7.1791986897980;
        Wed, 14 Oct 2026 07:08:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd04e9fesm2136375e9.7.2026.10.14.07.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 07:08:17 -0700 (PDT)
Message-ID: <f902a563-1e8f-4ff1-8463-f676775b75b7@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 16:08:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aryan Sinha <sinha.aryan03@gmail.com>,
        Bhargav Joshi
 <j.bhargav.u@gmail.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dhruvin Rajpura <drajpura@qti.qualcomm.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Georgi Djakov <djakov@kernel.org>,
        Hemanth Selam <hemanth.selam@gmail.com>,
        Karl Mehltretter <kmehltretter@gmail.com>,
        liujing <liujing@cmss.chinamobile.com>,
        Markus Elfring <Markus.Elfring@web.de>, muzafferkadir@mainlining.org,
        Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
        Pengpeng Hou <pengpeng@iscas.ac.cn>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ronald Claveau
 <linux-kernel-dev@aliel.fr>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Vitaliy Sochnev <sochnev.v.74@gmail.com>,
        Weigang He
 <geoffreyhe2@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Subject: [GIT PULL] thermal drivers for v7.4-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: V_anVSIJ4IFY-QP0fUHiFiYeuE-Wrf7S
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX9NMqVF+uRdbW
 VyHpz+JSPQvB94S69HUs2JTWkNPzRHTleNOB4m44bYe/g5ZW0AjmgTfeF5PTv3uML2Lr5Hrt5HA
 RzFShV/jTWU5kNB1LHL73e8b0QTwrhY=
X-Proofpoint-ORIG-GUID: V_anVSIJ4IFY-QP0fUHiFiYeuE-Wrf7S
X-Authority-Analysis: v=2.4 cv=Uv72pOwB c=1 sm=1 tr=0 ts=6acf8cd3 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=-m7sRFRlS3AYhyV2FnQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfXw0qhmcUSPIhi
 VDuft+WH3OposvzhMvbfH8x+tSfj61lYMVPp7hDONizJzcPTNckLsmrdNdgnXl7mQYd1MqTHKIW
 Pk0OsGxSK9wDrxplYZ8Sv0Skx9lLAjlF0X3iyQML/nib0+7xYf2mC4CiMjKvvLfdyJo09Ue+2dl
 6xDdsREHKMg7DLBH0BwKpD23FOAIpeVc/8zFujxFxS6zME24Hz7TO+gdTvUITzfEyR41H4lKPkx
 gUlnsPN6LGoqPY7/gXawJ8G8U7TJP7TOHm6BF7rBjGw7YvVYpFFG4GIdtnLc4eOS398kBQuqVZH
 u4gcHv1ePsHHrokgugge1wG8C8O6f0BGCexdHw/Z8yRUghFUud+4BhjfqWoG92/GE3jVcMmHOlH
 F3/NrShoFhHzeeN2JmXS4tKgTBw+hYsFDfDY21alG9XB7REUlMmS0GvsLqVxLb8183TPBIlyOZ3
 1Q2C+bg4ePbs0vZlc4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140056


Hi Rafael,


The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

   Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v7.4-rc1

for you to fetch changes up to 2dc1f296b5754dd2441fc8b6613a362a47f6b98f:

   thermal/drivers/rzg3e: Propagate reset assertion failure from suspend 
(2026-10-14 09:46:07 +0200)

----------------------------------------------------------------
- Add the Exynos ACPM thermal driver for Google GS101, along with
   DT bindings and a MAINTAINERS entry (Tudor Ambarus)

- Add Renesas RZ/G3L thermal sensor support and DT bindings, and move
   default calibration values to per-SoC match data (Biju Das)

- Add Qualcomm MSM8952 TSENS support and the corresponding DT binding
   compatible (Muzaffer Kadir)

- Document the Qualcomm PMAU0102 Master BandGap temperature monitor
   compatible in the DT bindings (Dhruvin Rajpura)

- Extend the QCom TSENS v2 trip temperature limits to the hardware
   range of -204°C to +204°C to prevent interrupt storms when operating
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

----------------------------------------------------------------
Andy Shevchenko (1):
       thermal: sysfs: switch to use scnprintf() to suppress truncation 
warning

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

Hemanth Selam (1):
       tools/thermal: Fix typo "binded" in comments

Karl Mehltretter (1):
       thermal: ti-soc-thermal: Fix the return value in 
ti_bandgap_get_sensor_data() kernel-doc

Liu Jing (1):
       tools/thermal/tmon: Fix signed shift UB in binding display

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
       thermal/drivers/renesas/rzg3e: Fix race between set_trips() and 
get_temp()
       thermal/drivers/renesas/rzg3e: Remove unneeded low/high check in 
set_trips()
       thermal/drivers/renesas/rzg3e: Remove redundant 
pm_runtime_mark_last_busy() calls

Pengpeng Hou (1):
       thermal/drivers/rzg3e: Propagate reset assertion failure from suspend

Priyansh Jain (1):
       thermal/drivers/qcom/tsens: Widen temperature limits to match 
hardware range

Rob Herring (Arm) (1):
       thermal: of: Match trip property helper types

Ronald Claveau (2):
       dt-bindings: thermal: amlogic: describe bus clock for t7-thermal
       thermal/drivers/amlogic: Switch to clk_bulk API to support 
multiple clocks

Tudor Ambarus (3):
       dt-bindings: thermal: Add Google GS101 TMU
       thermal/drivers/samsung: Add Exynos ACPM TMU driver GS101
       MAINTAINERS: Add entry for Samsung Exynos ACPM thermal driver

Vitaliy Sochnev (5):
       thermal/drivers/airoha: Request the EN7581 IRQ after zone 
registration
       thermal/drivers/airoha: Fix AN7583 ADC mux field mapping
       thermal/drivers/airoha: Serialise access to the shared ADC
       dt-bindings: arm: airoha: Use one thermal sensor cell for AN7583
       thermal/drivers/airoha: Register a thermal zone per AN7583 sensor

Weigang He (2):
       thermal/drivers/ti-soc-thermal: Cancel pending alert work on remove
       thermal/drivers/sprd: validate the sensor id from the device tree

  .../bindings/arm/airoha,en7581-chip-scu.yaml       |   3 +-
  .../bindings/thermal/amlogic,thermal.yaml          |  29 +-
  .../bindings/thermal/google,gs101-tmu-top.yaml     |  69 +++
  .../bindings/thermal/qcom,pm8775-mbg-tm.yaml       |   7 +-
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
  .../bindings/thermal/renesas,r9a08g045-tsu.yaml    |   4 +-
  .../bindings/thermal/ti,omap-bandgap.yaml          | 177 ++++++
  .../devicetree/bindings/thermal/ti_soc_thermal.txt |  88 ---
  MAINTAINERS                                        |   8 +
  drivers/thermal/airoha_thermal.c                   | 179 ++++--
  drivers/thermal/amlogic_thermal.c                  |  14 +-
  drivers/thermal/gov_power_allocator.c              |  11 +-
  drivers/thermal/imx91_thermal.c                    |   2 +-
  drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   8 +-
  drivers/thermal/qcom/tsens-v1.c                    |  41 ++
  drivers/thermal/qcom/tsens-v2.c                    |   4 +-
  drivers/thermal/qcom/tsens.c                       |   3 +
  drivers/thermal/qcom/tsens.h                       |   2 +-
  drivers/thermal/renesas/rzg3e_thermal.c            |  45 +-
  drivers/thermal/renesas/rzg3s_thermal.c            |  38 +-
  drivers/thermal/samsung/Kconfig                    |  19 +
  drivers/thermal/samsung/Makefile                   |   2 +
  drivers/thermal/samsung/acpm-tmu.c                 | 651 
+++++++++++++++++++++
  drivers/thermal/sprd_thermal.c                     |   6 +
  drivers/thermal/thermal_fw.c                       |   8 +-
  drivers/thermal/thermal_of.c                       |  11 +-
  drivers/thermal/thermal_sysfs.c                    |  12 +-
  drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  10 +-
  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   4 +
  tools/thermal/tmon/sysfs.c                         |   2 +-
  tools/thermal/tmon/tmon.c                          |   4 +-
  tools/thermal/tmon/tmon.h                          |   2 +-
  tools/thermal/tmon/tui.c                           |   2 +-
  33 files changed, 1262 insertions(+), 204 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
  create mode 100644 
Documentation/devicetree/bindings/thermal/ti,omap-bandgap.yaml
  delete mode 100644 
Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
  create mode 100644 drivers/thermal/samsung/acpm-tmu.c



