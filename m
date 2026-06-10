Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A16DF9E8
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120384; cv=none; b=a9e4bJh/LkSjth9QegXcbZJDN1jyo+nmSsxT4by6zgTC2jYhZQuXKa3nwQDmRfCg8oKxejACAJoVhAFHoYehiCLAxtqswCvQQ/JO9Wnq5nQz0lm4H3zfpIKPHZe+EXw1tpXEdlAONzZPQBsWBQ/wbde8u9277AjH0ShiPUM3xko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120384; c=relaxed/simple;
	bh=g5/Ofsl03+8N0WvSMiLEwq5x8smVDUw0THHJiGfC8jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0ygmZ3thtYtIKp8Mk2YRuKcHpv8JFfShFT2aZPsRiMDgkYyxl7F9lSgjJMaMJOZeK/o4L88MMNGmvvI80Lxbv9WfXvDy4A1Xfv3ww7cFdFKQugDLF94MHwS/I1p6TVe8H9k0VTh6Yt/j/5z1VYeWCOZqt04EnkNrcNR90zucqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j01KYfzd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KdZzZfaC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j01KYfzd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KdZzZfaC"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJYgpD2472071
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 19:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7SUFEKWjPsAnYpOR216K/K8sFu8L1tKoAtfRugZJ46k=; b=j01KYfzdPTEEOwRX
	Jb2QeJdNzuIHGh/9lf7iopypRa3CCk3jiuXdfnKLVR+0BFBW34tF+3R3jFSLYhBV
	vMOE8zjHR71ZRI3lwIGRVccVrqnOu+fnleUCJmShEFKfelncb3WuUk/fc0sZT4Rj
	z/2kIPNn246qPh8M9EI7rpIB1PBSwrwZSQoE8Z5lhdqBOUDPaIap4J9mlKIsGD3V
	k/qurQnA6JxkjX8gQI5ZiQLKJBl8Gh3PGMhXcfYZhOxFYlyVbXjpLRoIHdScGzbq
	h8i4OHsfnXP+rmqkAPv8EUpx1eBi7mIxk86ycamqrpg9XysiLYPP3btSHCMFgiQ9
	UJiEWw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u80k9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 19:39:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3075fa5a407so12949179eec.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781120380; x=1781725180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7SUFEKWjPsAnYpOR216K/K8sFu8L1tKoAtfRugZJ46k=;
        b=KdZzZfaCY+kD0wpVY3QgkG56Zn8Le6cgimscWJfh+aCxUVoqHesdVC2fZDymlZq9Lo
         52aqt7hdxgWuXBzsKa+dKUnPrs+PoI84fB89lt6bSLJEB3+jNphIDFGRhLxHwT7CIAyW
         5jOupSJOW8OCXP2y+D7/gVLWWDu1QI7io1cIvKUYFur4iTEYN1klhT2x+d5GA9NFuPyw
         uQSLmbYKytJ24z3oAn5JxS73r892BLcC3sSYUjnfMXT+Jkpop7H183CjVap1gsvsE5xf
         QmiW5CCoL1Vo53weV2xoidzpwrS5zMT0ltNmoPP9WTqDxEB62QkrWu9qY84jMH82OnTv
         Tz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781120380; x=1781725180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SUFEKWjPsAnYpOR216K/K8sFu8L1tKoAtfRugZJ46k=;
        b=MASrtr552dq5woxG331YeN0PIc7lHZ3Vxgo4R63/Iut7lTQqmQijNcOdglA6xDQk4j
         LC9tUkiVk9Kt6XSwVgTifYhy85BfiQg7cFydmxi3fw4afLUk5QEuJlkowEyuy91XkV5K
         bWfLzzTQ4aYEMN55f6j/Xf5vLO8fGBcRjeLuUGGx/Jz6KiG6w4NZ0FdRHWKT1FS+uEvk
         OB1/oC2Jv29RgO2SlHg5YQeuKSd0Z/9ORpGzzQFpPv4N47IiUohjTFbCumx318tTlqHs
         Rp4oHNrf8nasvLXkySBPXW6hQi1kLn3LBzEGZuR5sd3rcMhW99fj5A4w+zjWmBAdTnpq
         HYkg==
X-Forwarded-Encrypted: i=1; AFNElJ9IFytFCE8odvhMBRM77eJuVy5m+7013nLGBmyRXMPvn0dS89+FmjFLMQBlxfsstRbRKrjFtGWGFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQBDazHSH0ze+ebHC+y7v4lb4GZQpqbUJq/A2H32DPtG8bJ2J
	SshDCxWDi1H8I1uXcbzs4GQIMLgfNJTAvMK/sRm3nGYL/zcCdAIsQYqjqSrBherISo4ECsnk9ff
	EGE88DEJRXZnuNwTdlZI6HCg8QELFvk/yP4sYaS+A/wkgzcwV7GSabRjPbq241w==
X-Gm-Gg: Acq92OHZ8Zeq8x5P12G91zZY1nszqNUjNOFgfLtk9ptEybsa4293msRgx7z74GR3VRc
	QOsd7CP7s1U7PSrBV3BKjicnFRN3fmUiWyi5RxKelBsUynP8CYUOSd3Fd4L1cerbrdHZDVAaish
	ZmM1E5V1zRyHyJ7pJq55+k11miU0aX5ECn08KbEO5VKNXgyyilbmVNx3Yucg4pW4FZe7JrgxU3s
	9oU8KzY1JSfkeFs5OxSJGVnbIBoeQI5Ks4auS64vNyzzym2usO9ITtp98/V5dOxdAuFX+Gbg3u0
	kU75swQw0ojQn+OqrgInJsX9iEDAJAwGNInf46QwZepXQfz/rHUUEI2pBHTBAMdiDbLXLMpiwx5
	MsAZRw6rsrCLLU4M6O8DOrovL6j7YIGqGJxEM0pi/U4QWGpgccYwDV/pEOy6HTZsL
X-Received: by 2002:a05:6a20:6a20:b0:398:837a:7af0 with SMTP id adf61e73a8af0-3b4ccf82d99mr31713261637.30.1781120008708;
        Wed, 10 Jun 2026 12:33:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a20:b0:398:837a:7af0 with SMTP id adf61e73a8af0-3b4ccf82d99mr31713213637.30.1781120007955;
        Wed, 10 Jun 2026 12:33:27 -0700 (PDT)
Received: from [192.168.2.6] ([49.204.16.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c864874da11sm2947108a12.20.2026.06.10.12.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 12:33:27 -0700 (PDT)
Message-ID: <4417c3f9-854a-4613-bf14-777181daeff3@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 01:03:21 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] powercap: qcom: Add SPEL powercap driver
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
References: <20260519-qcom_spel_driver_upstream-v1-0-75356d1b7f94@oss.qualcomm.com>
 <20260519-qcom_spel_driver_upstream-v1-2-75356d1b7f94@oss.qualcomm.com>
 <a1b599f9-44a8-4cd6-b4ea-5c28eef9f221@oss.qualcomm.com>
Content-Language: en-US
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
In-Reply-To: <a1b599f9-44a8-4cd6-b4ea-5c28eef9f221@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDE4NyBTYWx0ZWRfX8EntasJIOT7P
 KVvvTZrT5ntYg1oj4vTyS4NlZhAa5RpMMe/FYkE0jXWgJt6RvoMQKMxMLDS/LiMqVuLtqICqHJh
 sZdoGKrszV0wftX8TlkQ+C4kzcZRkOU=
X-Authority-Analysis: v=2.4 cv=atOCzyZV c=1 sm=1 tr=0 ts=6a29bd7d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=80DA36llApf5Npk0Bpmn+g==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=XCvaPOw2vJVSrvyNqp8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE4NyBTYWx0ZWRfXwmYG2EMKP2ZI
 BGSDAbeYntCm5dHa5Mu0SfLjATq05uSIRVsxyyGUDLhnIzK7KU16Q/HtJxe8LTV3mDIJAxGCrb4
 Z7ZXeN4Y+77IgszXAHU8x3cX7sdUlXap8pZk+uIZQTd5VgdHTiL01o8TI9mJVmqexXI7LG7Y1wT
 W7P75KgRSOoSjhVBNkK8qkjXiLiQfOeX/6NF8dc7jxzAynQVTsWPqAeVjao9J3YLblp0/W8jvcz
 5k84rc4reYu73tT5kRJp6LigGfn1MKAqmYXey9EQwhnyEvico68yUL552AOrNUUHHt9QKBCyccy
 PQIlUWGkzyopYR8hvBoebd5c+q3L/L9reCAm3IkD/nPemDd90f0YHxRa0RXpQZaevEs+DgGNDLF
 l7pRpKJDpGzMhxcXjh2baFIeIJvs0g==
X-Proofpoint-GUID: jbOsHdFMBBwcBAfiGN0XhPoPvCV_lbDZ
X-Proofpoint-ORIG-GUID: jbOsHdFMBBwcBAfiGN0XhPoPvCV_lbDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606040000 definitions=main-2606100187

Hi Daniel,


On 5/27/2026 12:06 AM, Daniel Lezcano wrote:
> On 5/19/26 12:49, Manaf Meethalavalappu Pallikunhi wrote:
>> The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
>> based power monitoring and limiting capabilities for various power
>> domains including System, SoC, CPU clusters, GPU, and various other
>> subsystems.
>>
>> The driver integrates with the Linux powercap framework, exposing SPEL
>> capabilities through powercap sysfs interfaces.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi 
>> <manaf.pallikunhi@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                  |   1 +
>>   drivers/powercap/Kconfig     |  13 +
>>   drivers/powercap/Makefile    |   1 +
>>   drivers/powercap/qcom_spel.c | 787 +++++++++++++++++++++++++++++++++ 
>> ++++++++++
>>   4 files changed, 802 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c63f147e8c54..5c7542754ab6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22238,6 +22238,7 @@ M:    Manaf Meethalavalappu Pallikunhi 
>> <manaf.pallikunhi@oss.qualcomm.com>
>>   L:    linux-arm-msm@vger.kernel.org
>>   S:    Maintained
>>   F:    Documentation/devicetree/bindings/power/limits/qcom,spel.yaml
>> +F:    drivers/powercap/qcom_spel.c
>>   QUALCOMM PPE DRIVER
>>   M:    Luo Jie <quic_luoj@quicinc.com>
>> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
>> index 03c4c796d993..e3a47c653499 100644
>> --- a/drivers/powercap/Kconfig
>> +++ b/drivers/powercap/Kconfig
>> @@ -93,4 +93,17 @@ config DTPM_DEVFREQ
>>       help
>>         This enables support for device power limitation based on
>>         energy model.
>> +
>> +config QCOM_SPEL
>> +    tristate "Qualcomm SPEL Powercap driver"
>> +    depends on ARM64 || COMPILE_TEST
>> +    help
>> +      This enables support for the Qualcomm SoC Power and Electrical
>> +      Limits (SPEL) hardware, which allows power limits to be
>> +      enforced and monitored on Qualcomm SoCs.
>> +
>> +      SPEL provides energy monitoring and power capping for multiple
>> +      domains including system, SoC, CPU clusters, GPU, and various
>> +      other subsystems.
>> +
>>   endif
>> diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
>> index 5ab0dce565b9..8235fb9d3df6 100644
>> --- a/drivers/powercap/Makefile
>> +++ b/drivers/powercap/Makefile
>> @@ -8,3 +8,4 @@ obj-$(CONFIG_INTEL_RAPL) += intel_rapl_msr.o
>>   obj-$(CONFIG_INTEL_RAPL_TPMI) += intel_rapl_tpmi.o
>>   obj-$(CONFIG_IDLE_INJECT) += idle_inject.o
>>   obj-$(CONFIG_ARM_SCMI_POWERCAP) += arm_scmi_powercap.o
>> +obj-$(CONFIG_QCOM_SPEL) += qcom_spel.o
>> diff --git a/drivers/powercap/qcom_spel.c b/drivers/powercap/qcom_spel.c
>> new file mode 100644
>> index 000000000000..fed5647959a5
>> --- /dev/null
>> +++ b/drivers/powercap/qcom_spel.c
>> @@ -0,0 +1,787 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Qualcomm SPEL (SoC Power and Electrical Limits) Driver
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/bitmap.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/powercap.h>
>> +#include <linux/slab.h>
>> +#include <linux/types.h>
>> +
>> +/* SPEL register bitmasks */
>> +#define ENERGY_STATUS_MASK        0xFFFFFFFF
>> +
>> +#define POWER_LIMIT_MASK        0x00007FFF
>> +#define POWER_LIMIT_ENABLE        BIT(31)
>> +
>> +#define TIME_WINDOW_MASK_L        0x00007FFF    /* bits [14:0] */
>> +#define TIME_WINDOW_MASK_H        0x007F0000    /* bits [22:16] */
>> +
>> +#define ENERGY_UNIT_OFFSET        16
>> +#define ENERGY_UNIT_MASK        0xF0000
>> +
>> +#define TIME_UNIT_OFFSET        8
>> +#define TIME_UNIT_MASK            0xF00
>> +
>> +#define POWER_UNIT_OFFSET        0
>> +#define POWER_UNIT_MASK            0x7
>> +
>> +#define LIMITS_CAPABILITY_OFFSET    0x20
>> +#define ENERGY_RPT_UNIT_OFFSET        0x04
>> +
>> +#define ENERGY_UNIT_SCALE        1000
>> +
>> +#define SPEL_DOMAIN_NAME_LENGTH        16
>> +
>> +/* Domain types */
>> +enum spel_domain_type {
>> +    SPEL_DOMAIN_SYS,
>> +    SPEL_DOMAIN_SOC,
>> +    SPEL_DOMAIN_CL0,
>> +    SPEL_DOMAIN_CL1,
>> +    SPEL_DOMAIN_CL2,
>> +    SPEL_DOMAIN_IGPU,
>> +    SPEL_DOMAIN_DGPU,
>> +    SPEL_DOMAIN_NSP,
>> +    SPEL_DOMAIN_MMCX,
>> +    SPEL_DOMAIN_INFRA,
>> +    SPEL_DOMAIN_DRAM,
>> +    SPEL_DOMAIN_MDM,
>> +    SPEL_DOMAIN_WLAN,
>> +    SPEL_DOMAIN_USB1,
>> +    SPEL_DOMAIN_USB2,
>> +    SPEL_DOMAIN_USB3,
>> +    SPEL_DOMAIN_MAX,
>> +};
>> +
>> +/* Power limit IDs */
>> +enum spel_power_limit_id {
>> +    POWER_LIMIT1,
>> +    POWER_LIMIT2,
>> +    POWER_LIMIT3,
>> +    POWER_LIMIT4,
>> +    NR_POWER_LIMITS,
>> +};
>> +
>> +/* Unit types for conversion */
>> +enum unit_type {
>> +    POWER_UNIT,
>> +    ENERGY_UNIT,
>> +    TIME_UNIT,
>> +};
>> +
>> +/* Power limit operation types */
>> +enum pl_ops_type {
>> +    PL_LIMIT,
>> +    PL_TIME_WINDOW,
>> +};
>> +
>> +static const char *pl_names[NR_POWER_LIMITS] = {
>> +    [POWER_LIMIT1] = "pl1",
>> +    [POWER_LIMIT2] = "pl2",
>> +    [POWER_LIMIT3] = "pl3",
>> +    [POWER_LIMIT4] = "pl4",
>> +};
> 
> Do you want to use NR_POWER_LIMITS instead of ARRAY_SIZE() ?

ACK, I will move to ARRAY_SIZE>
> Please unify the naming NR_POWER_LIMITS -> POWER_LIMITS_MAX

ACK

> 
>> +static const char *const spel_domain_names[] = {
>> +    "sys", "soc", "cl0", "cl1", "cl2", "igpu", "dgpu", "nsp",
>> +    "mmcx", "infra", "dram", "mdm", "wlan", "usb1", "usb2", "usb3",
>> +};
>> +
>> +/* Domain register offsets in node base */
>> +static const u32 domain_offsets[SPEL_DOMAIN_MAX] = {
>> +    [SPEL_DOMAIN_SYS]    = 0x40,
>> +    [SPEL_DOMAIN_SOC]    = 0x00,
>> +    [SPEL_DOMAIN_CL0]    = 0x5C,
>> +    [SPEL_DOMAIN_CL1]    = 0x60,
>> +    [SPEL_DOMAIN_CL2]    = 0x64,
>> +    [SPEL_DOMAIN_IGPU]    = 0x08,
>> +    [SPEL_DOMAIN_DGPU]    = 0x44,
>> +    [SPEL_DOMAIN_NSP]    = 0x0C,
>> +    [SPEL_DOMAIN_MMCX]    = 0x10,
>> +    [SPEL_DOMAIN_INFRA]    = 0x18,
>> +    [SPEL_DOMAIN_DRAM]    = 0x1C,
>> +    [SPEL_DOMAIN_MDM]    = 0x48,
>> +    [SPEL_DOMAIN_WLAN]    = 0x4C,
>> +    [SPEL_DOMAIN_USB1]    = 0x50,
>> +    [SPEL_DOMAIN_USB2]    = 0x54,
>> +    [SPEL_DOMAIN_USB3]    = 0x58,
>> +};
> 
> Same comment

ACK

> 
>> +/**
>> + * struct spel_constraint_info - Power limit constraint information
>> + * @limit_offset:    Register offset for power limit value
>> + * @time_window_offset:    Register offset for time window
>> + * @supported_mask:    Bit mask in capability register
> 
> Where is 'supported_mask' initialized?

It is part of constraint_info table and used as bit mask to compare 
againt capability config register value during init for each PL for 
different domains.

> 
>> + * @domain_id:        Domain this constraint applies to
>> + * @pl_id:        Power limit ID (PL1, PL2, etc.)
> 
> [ ... ]
> 
>> +
>> +/**
>> + * struct spel_domain - SPEL power domain
>> + * @power_zone:        Powercap zone
>> + * @lock:        Mutex protecting register access
>> + * @sp:            Parent system
>> + * @status_reg:        Energy counter register
>> + * @pl_name:        Power limit names
>> + * @name:        Domain name
>> + * @id:            Domain type ID
>> + */
>> +struct spel_domain {
> 
> [ ... ]
> 
>> +    struct spel_system *sp;
> 
> [ ... ]
> 
>> +struct spel_system {
>> +    struct spel_domain *domains;
> 
> [ ... ]
> 
>> +};
> 
> There is a cyclic dependency between struct spel_system <-> struct 
> spel_domain. Could it be solved ?

ACK

> 
>> +#define power_zone_to_spel_domain(_zone) \
>> +    container_of(_zone, struct spel_domain, power_zone)
>> +
>> +/* Helper functions */
>> +static bool is_pl_valid(struct spel_domain *sd, int pl)
>> +{
>> +    if (pl < POWER_LIMIT1 || pl >= NR_POWER_LIMITS)
>> +        return false;
> 
> The call to this function is strange. It is like you don't trust your 
> own code.

ACK, I will remove it in v2

> 
>> +    return sd->pl_name[pl] ? true : false;
>> +}
>> +
> 
> [ ... ]
> 
>> +
>> +    switch (pl_op) {
>> +    case PL_LIMIT:
>> +        value &= POWER_LIMIT_MASK;
>> +        if (xlate)
>> +            *data = spel_unit_xlate(sd, POWER_UNIT, value, 0);
>> +        else
>> +            *data = value;
>> +        break;
>> +    case PL_TIME_WINDOW:
>> +        /* Decode time window: bits [22:16] are upper 7 bits, [14:0] 
>> are lower 15 bits */
>> +        value = ((value & TIME_WINDOW_MASK_H) >> 16 << 15) |
>> +            (value & TIME_WINDOW_MASK_L);
> 
> [ ... ]
> 
>> +        reg_val = (reg_val & ~POWER_LIMIT_MASK) | new_val;
>> +
> 
> [ ... ]
> 
>> +        if (new_val == 0)
>> +            reg_val &= ~POWER_LIMIT_ENABLE;
>> +        else
>> +            reg_val |= POWER_LIMIT_ENABLE;
>> +        break;
> 
> [ ... ]
> 
>> +    case PL_TIME_WINDOW:
>> +        /*
>> +         * Encode time window: upper 7 bits to [22:16], lower 15 bits 
>> to [14:0]
>> +         * Time window register is separate from limit register 
>> (different offset),
>> +         * so we write only the time window bits without preserving 
>> any enable bit.
>> +         */
>> +        new_val = spel_unit_xlate(sd, TIME_UNIT, value, 1);
>> +        reg_val = (((new_val >> 15) & 0x7F) << 16) |
>> +              (new_val & 0x7FFF);
> 
> 
> The trend today is to use the FIELD_* macros for bits ops

ACK

> 
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    writel(reg_val, reg_addr);
>> +    return 0;
>> +}
>> +
>> +/* Powercap zone operations */
>> +static int spel_get_energy_counter(struct powercap_zone *power_zone, 
>> u64 *energy_raw)
>> +{
>> +    struct spel_domain *sd = power_zone_to_spel_domain(power_zone);
>> +    u64 value;
>> +
>> +    value = readl(sd->status_reg);
> 
> nit: seems an line in between would help for the readability

ACK

> 
>> +    *energy_raw = spel_unit_xlate(sd, ENERGY_UNIT, value, 0);
>> +
>> +    return 0;
>> +}
>> +
>> +static int spel_get_max_energy_counter(struct powercap_zone *pcd_dev, 
>> u64 *energy)
>> +{
>> +    struct spel_domain *sd = power_zone_to_spel_domain(pcd_dev);
>> +
>> +    *energy = spel_unit_xlate(sd, ENERGY_UNIT, ENERGY_STATUS_MASK, 0);
> 
> nit: missing line

ACK>
>> +    return 0;
>> +}
>> +
>> +static int spel_release_zone(struct powercap_zone *power_zone)
>> +{
>> +    return 0;
>> +}
>> +
>> +static int spel_find_nr_power_limit(struct spel_domain *sd)
>> +{
>> +    int i, nr_pl = 0;
>> +
>> +    for (i = 0; i < NR_POWER_LIMITS; i++) {
>> +        if (is_pl_valid(sd, i))
>> +            nr_pl++;
>> +    }
>> +
>> +    return nr_pl;
>> +}
>> +
>> +static const struct powercap_zone_ops zone_ops = {
>> +    .get_energy_uj = spel_get_energy_counter,
>> +    .get_max_energy_range_uj = spel_get_max_energy_counter,
>> +    .release = spel_release_zone,
>> +};
>> +
>> +/* Constraint operations */
>> +static int spel_constraint_to_pl(struct spel_domain *sd, int cid)
>> +{
>> +    int i, j;
> 
> 'j' name is misleading because it is usually used for nested 'for' blocks

ACK

> 
>> +    for (i = POWER_LIMIT1, j = 0; i < NR_POWER_LIMITS; i++) {
> 
> Do not rely on POWER_LIMIT1 because if someday it is moved in the enum, 
> all the code assuming it is zero will be broken

ACK

> 
>> +        if (is_pl_valid(sd, i) && j++ == cid)
>  > +            return i;> +    }
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +static int spel_set_power_limit(struct powercap_zone *power_zone, int 
>> cid,
>> +                u64 power_limit)
>> +{
>> +    struct spel_domain *sd = power_zone_to_spel_domain(power_zone);
>> +    int id;
>> +
>> +    id = spel_constraint_to_pl(sd, cid);
>> +    if (id < 0)
>> +        return id;
>> +
>> +    return spel_write_pl_data(sd, id, PL_LIMIT, power_limit);
>> +}
>> +
>> +static int spel_get_power_limit(struct powercap_zone *power_zone, int 
>> cid,
>> +                u64 *data)
>> +{
>> +    struct spel_domain *sd = power_zone_to_spel_domain(power_zone);
>> +    u64 val;
>> +    int ret, id;
>> +
>> +    id = spel_constraint_to_pl(sd, cid);
>> +    if (id < 0)
>> +        return id;
>> +
>> +    ret = spel_read_pl_data(sd, id, PL_LIMIT, true, &val);
>> +    if (!ret)
>> +        *data = val;
>> +
>> +    return ret;
>> +}
>> +
>> +static int spel_set_time_window(struct powercap_zone *power_zone, int 
>> cid,
>> +                u64 window)
>> +{
>> +    struct spel_domain *sd = power_zone_to_spel_domain(power_zone);
>> +    int id;
>> +
>> +    id = spel_constraint_to_pl(sd, cid);
>> +    if (id < 0)
>> +        return id;
>> +
>> +    return spel_write_pl_data(sd, id, PL_TIME_WINDOW, window);
>> +}
>> +
>> +static int spel_get_time_window(struct powercap_zone *power_zone, int 
>> cid,
>> +                u64 *data)
>> +{
>> +    struct spel_domain *sd = power_zone_to_spel_domain(power_zone);
>> +    u64 val;
>> +    int ret, id;
>> +
>> +    id = spel_constraint_to_pl(sd, cid);
>> +    if (id < 0)
>> +        return id;
>> +
>> +    ret = spel_read_pl_data(sd, id, PL_TIME_WINDOW, true, &val);
>> +    if (!ret)
>> +        *data = val;
>> +
>> +    return ret;
>> +}
>> +
>> +static const char *spel_get_constraint_name(struct powercap_zone 
>> *power_zone,
>> +                        int cid)
>> +{
>> +    struct spel_domain *sd = power_zone_to_spel_domain(power_zone);
>> +    int id;
>> +
>> +    id = spel_constraint_to_pl(sd, cid);
>> +    if (id >= 0)
>> +        return sd->pl_name[id];
>> +
>> +    return NULL;
>> +}
>> +
>> +static const struct powercap_zone_constraint_ops constraint_ops = {
>> +    .set_power_limit_uw = spel_set_power_limit,
>> +    .get_power_limit_uw = spel_get_power_limit,
>> +    .set_time_window_us = spel_set_time_window,
>> +    .get_time_window_us = spel_get_time_window,
>> +    .get_name = spel_get_constraint_name,
>> +};
>> +
>> +static void spel_init_domains(struct spel_system *sp)
>> +{
>> +    unsigned int i;
>> +
>> +    for (i = 0; i < SPEL_DOMAIN_MAX; i++) {
>> +        struct spel_domain *sd = &sp->domains[i];
>> +
>> +        sd->sp = sp;
>> +        snprintf(sd->name, SPEL_DOMAIN_NAME_LENGTH, "%s",
>> +             spel_domain_names[i]);
>> +        sd->id = i;
>> +        sd->status_reg = sp->node_base + domain_offsets[i];
>> +
>> +        /* PL1 is always supported (required for powercap 
>> registration) */
>> +        sp->limits[i] = BIT(POWER_LIMIT1);
>> +        sd->pl_name[POWER_LIMIT1] = pl_names[POWER_LIMIT1];
>> +    }
>> +}
>> +
>> +static int spel_check_unit(struct spel_system *sp)
>> +{
>> +    u32 value, shift;
>> +
>> +    /* Read power_unit and time_unit from offset 0x0 */
>> +    value = readl(sp->config_base);
>> +
>> +    /*
>> +     * Unit calculation: 1 / (2^shift)
>> +     * Masks limit: TIME_UNIT (4 bits, max 15), POWER_UNIT (3 bits, 
>> max 7).
>> +     */
>> +    shift = (value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
>> +    sp->power_unit = 1000000 / (1 << shift);
>> +
>> +    shift = (value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
>> +    sp->time_unit = 1000000 / (1 << shift);
>> +
>> +    /* Read energy_unit from ENERGY_RPT_UNIT_OFFSET */
>> +    value = readl(sp->config_base + ENERGY_RPT_UNIT_OFFSET);
>> +
>> +    /*
>> +     * Unit calculation: 1 / (2^shift)
>> +     * Masks limit: ENERGY_UNIT (4 bits, max 15).
>> +     */
>> +    shift = (value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
>> +    sp->energy_unit = ENERGY_UNIT_SCALE * 1000000 / (1 << shift);
>> +
>> +    dev_dbg(sp->dev, "Units: energy=%dnJ, time=%dus, power=%duW\n",
>> +        sp->energy_unit, sp->time_unit, sp->power_unit);
>> +
>> +    return 0;
>> +}
>> +
>> +static void spel_detect_powerlimit(struct spel_domain *sd)
>> +{
>> +    struct spel_system *sp = sd->sp;
>> +    u32 capabilities;
>> +    int i, j;
>> +
>> +    capabilities = readl(sp->config_base + LIMITS_CAPABILITY_OFFSET);
>> +
>> +    /* Detect power limits from hardware capabilities */
>> +    for (i = POWER_LIMIT2; i < NR_POWER_LIMITS; i++) {
> 
> For my understanding, why is it starting at POWER_LIMIT2 ?

Since It is failing to register a powercap zone with 0 constraint, I 
need to add alteast one constraint for each domain. PL1 is added by 
default for all domains.

> 
>> +        for (j = 0; j < ARRAY_SIZE(constraints); j++) {
>> +            struct spel_constraint_info *ci = &constraints[j];
>> +
>> +            if (ci->domain_id == sd->id && ci->pl_id == i) {
>> +                if (capabilities & ci->supported_mask) {
>> +                    sp->limits[sd->id] |= BIT(i);
>> +                    sd->pl_name[i] = pl_names[i];
> 
> So, that explains the is_pl_valid()
> 
> Please do not use duplicated array with non-NULL pointer checks
> 
> Or sd->pl_name[] contains all the *valids* power limits, so its size is 
> different than (or equal to) pl_names. Or it is a fixed array with a 
> structure containing a flag telling if it is enabled or not.
> 
> No need to duplicate the array

ACK

> 
>> +                }
>> +                break;
>> +            }
>> +        }
>> +    }
>> +}
>> +
> 
> [ ... ]
> 
>> +static void spel_remove(struct platform_device *pdev)
>> +{
>> +    struct spel_system *sp = platform_get_drvdata(pdev);
>> +    int i;
>> +
>> +    if (!sp)
>> +        return;
> 
> Why test if the value is correct? There is no reason it changed after 
> 'probe' was successful

ACK

Thanks,
Manaf

> 
>> +
>> +    /* Unregister in reverse order: children first, then SOC, then 
>> SYS */
>> +    for (i = SPEL_DOMAIN_MAX - 1; i >= 0; i--)
>> +        powercap_unregister_zone(sp->control_type, &sp- 
>> >domains[i].power_zone);
>> +
>> +    powercap_unregister_control_type(sp->control_type);
>> +}
>> +
>> +static const struct of_device_id spel_of_match[] = {
>> +    { .compatible = "qcom,spel" },
>> +    { }
>> +};
>> +MODULE_DEVICE_TABLE(of, spel_of_match);
>> +
>> +static struct platform_driver spel_driver = {
>> +    .probe = spel_probe,
>> +    .remove = spel_remove,
>> +    .driver = {
>> +        .name = "qcom_spel",
>> +        .of_match_table = spel_of_match,
>> +    },
>> +};
>> +
>> +module_platform_driver(spel_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm SPEL Powercap Driver");
>> +MODULE_LICENSE("GPL");
>>
> 

