Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4992D3AB284
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809521; cv=none; b=JntVOeISmzq3eqHXn6AEjIZxpImGhAsuwCwdu1HJ1DbnopXvf5zwADdP/oo/0joGFM50ibYDXwvwzbpoqqpTSjC8IR7fwVZ0kT6shVVQqcHsPn5iDyrlNbb1nbsxHbVS91Ai3nNILpUHsFSn3X2GTX5AqVSfgCAdo/GFc2KDjvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809521; c=relaxed/simple;
	bh=Z2q0AutS2b33ACOIrUzNkz5NiWSpnSS2tO1ThEACDME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JthMhR0prYh1GGmjKsFhz9SjCp1PkEo5pZdswuyet4Lv3SB82qpfzgHhDSmPbKDBLcv5Wja/aKk4BITuib9xGfEClUQZfIYWPFy36oLoMjabxiCmyd+Wi/NsTPw2ZaXREiF/nSEZ75eDT3DeKYqrlb0f+YMV6PTV4iV0I5nChOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cJJrW1B3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T/J5W/rN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cJJrW1B3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T/J5W/rN"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A6IEVA2866294
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 08:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	teQcy1OrzjiF5Z1tsWO4s9/NnxBJmh3gJnh3t5WKEVU=; b=cJJrW1B3oaOdBFdP
	DzOxdcLnXNJ6BguPgfi4RmHOC27eFnOPSefXt8C6Ix7S/tvM2dy8/juYa7l/kTAJ
	rMwFoMOttLhvapoxeZ1dwZS6VFC4JfCIzwKe2bKBn4jnDADXHpgsGBa2jXfkUTkG
	aDagiCD8zW2r/IzcfY7irdwtR8lzJn0oNdNdvJ+TzQTosAM2rx8qQq1lZgChEj7z
	FKcD/ORoeJXQpxxBarDkv5KJ0S7EVJznPqKVT9+QxNxMmLdOssxHfb/VNeuDMF/K
	JD3Ed090p4orb5z8zOjBf+5+KKW5vFjvlHv6DKzdshZXmZRv/chiDIG89koo1d8X
	D65MGg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decaykhfq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 08:25:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b242cbb97aso15218065ad.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775809518; x=1776414318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=teQcy1OrzjiF5Z1tsWO4s9/NnxBJmh3gJnh3t5WKEVU=;
        b=T/J5W/rNJiFhiY1dJm/X/LXcaYzuDwb4TRygiwZQ3yGutFKhU0/6xJHxlrDHktJQoP
         iSmCLHPZsKJ8EfyUYy6JGm3ilKMCuvGz6RohrYKsC/OcZxF+yN6KSWcrA+ZPKhqWcP9K
         uIPrhjw1cqsnLPGE54ZnIKPg2Zqgdj1OZqjpoA8Egzm8MzDw8gZUr60INeGisgSV1EFj
         PktZhMdYvzARsk0HWuEIQAsOCn0JCeWcwhwVFm/If93/06Uq3jb7c8/ClbWK0HmKH4Rx
         SXj/TFGBKYOIwFz1ZpZhn1xR2iTs6hhjYGnqgqksfGRUow0H1yHCLaqdfGlalzTM0Hlf
         UW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775809518; x=1776414318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teQcy1OrzjiF5Z1tsWO4s9/NnxBJmh3gJnh3t5WKEVU=;
        b=rExsH6iDeOifa79QE7Dso8OzYGmeQPBXqhsYh86fmMwvClgWRdvntzF9M2E7PoIz3K
         cSxplAx1kPFo6kiNWko13tgSRN19c6EUmP1Kxu7OEWdFbqLoz7lVWiNaI0bTni7O472Z
         yQYxKKvBg20KVHFaCxlNwbCT0ZUm3sPduiNatN/Et9f6WzTIbNAQUYe5s15kXhp9t8nb
         4RE5qaq7jDAGUS60Ros5ox7IBczfOaXx6WB8yV9WC3G6pV/rehklke0zp/BmEdwU4jJ+
         wVxXE5D8bw2IK7/2KOiJZoDWldM/rJ/ZjaJoQpdMzhn+ly8pZQk1zwIj052cZpj6RNh3
         vMnA==
X-Gm-Message-State: AOJu0YwoRlRbzcWf4PapiLVexzjEWKQUQ61D/2YKcprqCw1uj8lsW6h3
	3cjrXWqc+0gwWIzhbemZMct6zhE0qxUSKEkakQV3dPhAXPRMyHjKeJiymBPVfjOcJrUBmbYKxmB
	CaQ12iOsql9bHFKUVuv9yiQz3ycWkl68rFYK0JgWZJGB4omxNJ4RmOqM54+PzFg==
X-Gm-Gg: AeBDieuEOoiXvoGClthV0GKydB0s5YYfGPxejRhi+ubMXh1XLRf7GF0hUpZX8H0PL2r
	ao6CBOa/k4gy4A21WhTfMws8mUrk5rnPIZq7jcYqS/W97bq1/Z698p0g7pN0nRYz8PH5KW+yU2E
	t/e2Gpx0bCCQCXJ5Pf5hkhTZz4KVQhJ+NVIqVtt/0TcrCim5OrR0hrm8qGjjqZOGyk0k5ymMWMc
	oIBrS6k4HDVtYIPyLeUxYd8zbQZ6pdIi4KqBgV9fBA9MfkVohWdg/zMpGKwehXq8RzAOEOHpPGS
	b8xAsoMFs13A9DsozPcHpJHsrXNvN+P3zqg7GAt3LVGC8WbsGovVuuHZTzosz43GglgpOwjVWRp
	aL4KlGUBUzDgxFFP9zeoJ3K9kxcFtsfDC4AbiAINp4NgiWnxpTwdxV++tJaQbrgGQFFAsTffjzY
	SgFB60W0vFYA==
X-Received: by 2002:a17:902:f9cb:b0:2ae:6457:3099 with SMTP id d9443c01a7336-2b2d5a307f5mr17590195ad.26.1775809517497;
        Fri, 10 Apr 2026 01:25:17 -0700 (PDT)
X-Received: by 2002:a17:902:f9cb:b0:2ae:6457:3099 with SMTP id d9443c01a7336-2b2d5a307f5mr17589935ad.26.1775809516948;
        Fri, 10 Apr 2026 01:25:16 -0700 (PDT)
Received: from [10.133.33.62] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dd83d5sm20216725ad.25.2026.04.10.01.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 01:25:16 -0700 (PDT)
Message-ID: <38088fd6-1db6-4591-b489-33b52f727549@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 16:25:08 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] thermal: spacemit: k1: Add thermal sensor support
To: Shuwei Wu <shuwei.wu@mailbox.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
        linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>,
        Troy Mitchell <troy.mitchell@linux.spacemit.com>, Yao Zi <me@ziyao.cc>,
        Vincent Legoll <legoll@online.fr>, Gong Shuai <gsh517025@gmail.com>
References: <20260410-k1-thermal-v1-0-12c87dd063c3@mailbox.org>
 <20260410-k1-thermal-v1-2-12c87dd063c3@mailbox.org>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20260410-k1-thermal-v1-2-12c87dd063c3@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=69d8b3ee cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=b3CbU_ItAAAA:8 a=pGLkceISAAAA:8 a=lv0vYI88AAAA:8 a=ZcGH_eeS6DTE5rAZkC4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=Rv2g8BkzVjQTVhhssdqe:22 a=9qqun4PRrEabIEPCFt1_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA3NiBTYWx0ZWRfX6oOqy0fyTlpB
 posplh3jrmGNMiG90XMNlRm7sWo0JTvVbkvxP3vn6T/D/enuJXZaCcDVXpJ9oWlH0lpo7EPo39P
 rIUAqkGlavXNyDSk9kkcHXDhAeMhefjnWpdwdSQcniitIuRiZCbCVh57FAHIAte0jc0t4XywSMR
 tODyflnVdcDE/54vpaF2iuXIZx2gpVLI0z66I1uj5StCayiPBctqa24zZQ/xZTol+iaEz+blLKI
 JtkQ2/cXkgWZfW/d0yd2/zeVi862j0w/Y90AkDDMFr+Jfr36l5WccYEimW0SGzm8MG7+8d+QMx3
 zEADxjGc1TnxKTy8H4EZCHCyeb6+lz1W/xh34Iksj7InG4pQexMpYRLwFPnGA03xXEYwPIWO3ve
 fMcnDkmbnpnWDEMS7yJrAJnD5QHLwymAX42SHELbAiAICtKSdP5SSBwQzKXLq3cJsFtuge1b6QX
 oe2xdGFnyLLcNfC6nUg==
X-Proofpoint-GUID: nI0oJtOEvFS0I436ntXthTxqcdLP7jo3
X-Proofpoint-ORIG-GUID: nI0oJtOEvFS0I436ntXthTxqcdLP7jo3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100076



On 4/10/2026 11:31 AM, Shuwei Wu wrote:
> The thermal sensor on K1 supports monitoring five temperature zones.
> The driver registers these sensors with the thermal framework
> and supports standard operations:
> - Reading temperature (millidegree Celsius)
> - Setting high/low thresholds for interrupts
> 
> Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
> Reviewed-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Reviewed-by: Yao Zi <me@ziyao.cc>
> Tested-by: Vincent Legoll <legoll@online.fr> # OrangePi-RV2
> Tested-by: Gong Shuai <gsh517025@gmail.com>
> 
> ---
> Changes in v4:
> - Add 'depends on THERMAL_OF' in drivers/thermal/spacemit/Kconfig
> 
> Changes in v3:
> - Align multi-line assignments as suggested by reviewer
> - Remove unnecessary variable definitions
> 
> Changes in v2:
> - Rename k1_thermal.c to k1_tsensor.c for better hardware alignment
> - Move driver to drivers/thermal/spacemit/
> - Add Kconfig/Makefile for spacemit and update top-level build files
> - Refactor names, style, code alignment, and comments
> - Simplify probe and error handling
> ---
>   drivers/thermal/Kconfig               |   2 +
>   drivers/thermal/Makefile              |   1 +
>   drivers/thermal/spacemit/Kconfig      |  19 +++
>   drivers/thermal/spacemit/Makefile     |   3 +
>   drivers/thermal/spacemit/k1_tsensor.c | 281 ++++++++++++++++++++++++++++++++++
>   5 files changed, 306 insertions(+)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index b10080d61860..1c4a5cd5a23e 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -472,6 +472,8 @@ endmenu
>   
>   source "drivers/thermal/renesas/Kconfig"
>   
> +source "drivers/thermal/spacemit/Kconfig"
> +
>   source "drivers/thermal/tegra/Kconfig"
>   
>   config GENERIC_ADC_THERMAL
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index bb21e7ea7fc6..3b249195c088 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -65,6 +65,7 @@ obj-y				+= mediatek/
>   obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
>   obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>   obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
> +obj-y				+= spacemit/
>   obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>   obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
>   obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
> diff --git a/drivers/thermal/spacemit/Kconfig b/drivers/thermal/spacemit/Kconfig
> new file mode 100644
> index 000000000000..de7b5ece5af2
> --- /dev/null
> +++ b/drivers/thermal/spacemit/Kconfig
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menu "SpacemiT thermal drivers"
> +depends on ARCH_SPACEMIT || COMPILE_TEST
> +
> +config SPACEMIT_K1_TSENSOR
> +	tristate "SpacemiT K1 thermal sensor driver"
> +	depends on THERMAL_OF
> +	help
> +	  This driver provides support for the thermal sensor
> +	  integrated in the SpacemiT K1 SoC.
> +
> +	  The thermal sensor monitors temperatures for five thermal zones:
> +	  soc, package, gpu, cluster0, and cluster1. It supports reporting
> +	  temperature values and handling high/low threshold interrupts.
> +
> +	  Say Y here if you want to enable thermal monitoring on SpacemiT K1.
> +	  If compiled as a module, it will be called k1_tsensor.
> +
> +endmenu
> diff --git a/drivers/thermal/spacemit/Makefile b/drivers/thermal/spacemit/Makefile
> new file mode 100644
> index 000000000000..82b30741e4ec
> --- /dev/null
> +++ b/drivers/thermal/spacemit/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_SPACEMIT_K1_TSENSOR)	+= k1_tsensor.o
> diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spacemit/k1_tsensor.c
> new file mode 100644
> index 000000000000..b742739e9019
> --- /dev/null
> +++ b/drivers/thermal/spacemit/k1_tsensor.c
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Thermal sensor driver for SpacemiT K1 SoC
> + *
> + * Copyright (C) 2026 Shuwei Wu <shuwei.wu@mailbox.org>
> + */
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +
> +#include "../thermal_hwmon.h"
> +
> +#define K1_TSENSOR_PCTRL_REG		0x00
> +#define K1_TSENSOR_PCTRL_ENABLE		BIT(0)
> +#define K1_TSENSOR_PCTRL_TEMP_MODE	BIT(3)
> +#define K1_TSENSOR_PCTRL_RAW_SEL	BIT(7)
> +
> +#define K1_TSENSOR_PCTRL_CTUNE		GENMASK(11, 8)
> +#define K1_TSENSOR_PCTRL_SW_CTRL	GENMASK(21, 18)
> +#define K1_TSENSOR_PCTRL_HW_AUTO_MODE	BIT(23)
> +
> +#define K1_TSENSOR_EN_REG		0x08
> +#define K1_TSENSOR_EN_ALL		GENMASK(MAX_SENSOR_NUMBER - 1, 0)
> +
> +#define K1_TSENSOR_TIME_REG		0x0C
> +#define K1_TSENSOR_TIME_WAIT_REF_CNT	GENMASK(3, 0)
> +#define K1_TSENSOR_TIME_ADC_CNT_RST	GENMASK(7, 4)
> +#define K1_TSENSOR_TIME_FILTER_PERIOD	GENMASK(21, 20)
> +#define K1_TSENSOR_TIME_MASK		GENMASK(23, 0)
> +
> +#define K1_TSENSOR_INT_CLR_REG		0x10
> +#define K1_TSENSOR_INT_EN_REG		0x14
> +#define K1_TSENSOR_INT_STA_REG		0x18
> +
> +#define K1_TSENSOR_INT_EN_MASK		BIT(0)
> +#define K1_TSENSOR_INT_MASK(x)		(GENMASK(2, 1) << ((x) * 2))
> +
> +#define K1_TSENSOR_DATA_BASE_REG	0x20
> +#define K1_TSENSOR_DATA_REG(x)		(K1_TSENSOR_DATA_BASE_REG + ((x) / 2) * 4)
> +#define K1_TSENSOR_DATA_LOW_MASK	GENMASK(15, 0)
> +#define K1_TSENSOR_DATA_HIGH_MASK	GENMASK(31, 16)
> +
> +#define K1_TSENSOR_THRSH_BASE_REG	0x40
> +#define K1_TSENSOR_THRSH_REG(x)		(K1_TSENSOR_THRSH_BASE_REG + ((x) * 4))
> +#define K1_TSENSOR_THRSH_LOW_MASK	GENMASK(15, 0)
> +#define K1_TSENSOR_THRSH_HIGH_MASK	GENMASK(31, 16)
> +
> +#define MAX_SENSOR_NUMBER		5
> +
> +/* Hardware offset value required for temperature calculation */
> +#define TEMPERATURE_OFFSET		278
> +
> +struct k1_tsensor_channel {
> +	struct k1_tsensor *ts;
> +	struct thermal_zone_device *tzd;
> +	int id;
> +};
> +
> +struct k1_tsensor {
> +	void __iomem *base;
> +	struct k1_tsensor_channel ch[MAX_SENSOR_NUMBER];
> +};
> +
> +static void k1_tsensor_init(struct k1_tsensor *ts)
> +{
> +	u32 val;
> +
> +	/* Disable all the interrupts */
> +	writel(0xffffffff, ts->base + K1_TSENSOR_INT_EN_REG);
> +
> +	/* Configure ADC sampling time and filter period */
> +	val = readl(ts->base + K1_TSENSOR_TIME_REG);
> +	val &= ~K1_TSENSOR_TIME_MASK;
> +	val |= K1_TSENSOR_TIME_FILTER_PERIOD |
> +	       K1_TSENSOR_TIME_ADC_CNT_RST |
> +	       K1_TSENSOR_TIME_WAIT_REF_CNT;
> +	writel(val, ts->base + K1_TSENSOR_TIME_REG);
> +
> +	/*
> +	 * Enable all sensors' auto mode, enable dither control,
> +	 * consecutive mode, and power up sensor.
> +	 */
> +	val = readl(ts->base + K1_TSENSOR_PCTRL_REG);
> +	val &= ~K1_TSENSOR_PCTRL_SW_CTRL;
> +	val &= ~K1_TSENSOR_PCTRL_CTUNE;
> +	val |= K1_TSENSOR_PCTRL_RAW_SEL |
> +	       K1_TSENSOR_PCTRL_TEMP_MODE |
> +	       K1_TSENSOR_PCTRL_HW_AUTO_MODE |
> +	       K1_TSENSOR_PCTRL_ENABLE;
> +	writel(val, ts->base + K1_TSENSOR_PCTRL_REG);
> +
> +	/* Enable thermal interrupt */
> +	val = readl(ts->base + K1_TSENSOR_INT_EN_REG);
> +	val |= K1_TSENSOR_INT_EN_MASK;
> +	writel(val, ts->base + K1_TSENSOR_INT_EN_REG);
> +
> +	/* Enable each sensor */
> +	val = readl(ts->base + K1_TSENSOR_EN_REG);
> +	val |= K1_TSENSOR_EN_ALL;
> +	writel(val, ts->base + K1_TSENSOR_EN_REG);
> +}
> +
> +static void k1_tsensor_enable_irq(struct k1_tsensor_channel *ch)
> +{
> +	struct k1_tsensor *ts = ch->ts;
> +	u32 val;
> +
> +	val = readl(ts->base + K1_TSENSOR_INT_CLR_REG);
> +	val |= K1_TSENSOR_INT_MASK(ch->id);
> +	writel(val, ts->base + K1_TSENSOR_INT_CLR_REG);
> +
> +	val = readl(ts->base + K1_TSENSOR_INT_EN_REG);
> +	val &= ~K1_TSENSOR_INT_MASK(ch->id);
> +	writel(val, ts->base + K1_TSENSOR_INT_EN_REG);
> +}
> +
> +/*
> + * The conversion formula used is:
> + * T(m°C) = (((raw_value & mask) >> shift) - TEMPERATURE_OFFSET) * 1000
> + */
> +static int k1_tsensor_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	struct k1_tsensor_channel *ch = thermal_zone_device_priv(tz);
> +	struct k1_tsensor *ts = ch->ts;
> +	u32 val;
> +
> +	val = readl(ts->base + K1_TSENSOR_DATA_REG(ch->id));
> +	if (ch->id % 2)
> +		*temp = FIELD_GET(K1_TSENSOR_DATA_HIGH_MASK, val);
> +	else
> +		*temp = FIELD_GET(K1_TSENSOR_DATA_LOW_MASK, val);
> +
> +	*temp -= TEMPERATURE_OFFSET;
> +	*temp *= 1000;
> +
> +	return 0;
> +}
> +
> +/*
> + * For each sensor, the hardware threshold register is 32 bits:
> + * - Lower 16 bits [15:0] configure the low threshold temperature.
> + * - Upper 16 bits [31:16] configure the high threshold temperature.
> + */
> +static int k1_tsensor_set_trips(struct thermal_zone_device *tz, int low, int high)
> +{
> +	struct k1_tsensor_channel *ch = thermal_zone_device_priv(tz);
> +	struct k1_tsensor *ts = ch->ts;
> +	u32 val;
> +
> +	if (low >= high)
> +		return -EINVAL;
> +
> +	if (low < 0)
> +		low = 0;
> +
> +	high = high / 1000 + TEMPERATURE_OFFSET;

Consider passes high = INT_MAX here:

high = INT/1000 + TEMPERATURE_OFFSET == 2147761;

> +	low = low / 1000 + TEMPERATURE_OFFSET;
> +
> +	val = readl(ts->base + K1_TSENSOR_THRSH_REG(ch->id));
> +	val &= ~K1_TSENSOR_THRSH_HIGH_MASK;
> +	val |= FIELD_PREP(K1_TSENSOR_THRSH_HIGH_MASK, high);

K1_TSENSOR_THRSH_HIGH_MASK is a 16-bit MASK:
FIELD_PREP(K1_TSENSOR_THRSH_HIGH_MASK, 2147761); <- overflow happened

the maximum value here will be changed to 50609 from 65536.

We should add a check here and limit the 'high' value here to avoid 
overflow:

if (high > (int)((0xFFFF - TEMPERATURE_OFFSET) * 1000))
	high = (0Xffff - TEMPERATURE_OFFSET) * 1000;

high = high / 1000 + TEMPERATURE_OFFSET;

...
	
> +
> +	val &= ~K1_TSENSOR_THRSH_LOW_MASK;
> +	val |= FIELD_PREP(K1_TSENSOR_THRSH_LOW_MASK, low);
> +	writel(val, ts->base + K1_TSENSOR_THRSH_REG(ch->id));
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_device_ops k1_tsensor_ops = {
> +	.get_temp = k1_tsensor_get_temp,
> +	.set_trips = k1_tsensor_set_trips,
> +};
> +
> +static irqreturn_t k1_tsensor_irq_thread(int irq, void *data)
> +{
> +	struct k1_tsensor *ts = (struct k1_tsensor *)data;
> +	int mask, status, i;
> +
> +	status = readl(ts->base + K1_TSENSOR_INT_STA_REG);
> +
> +	for (i = 0; i < MAX_SENSOR_NUMBER; i++) {
> +		if (status & K1_TSENSOR_INT_MASK(i)) {
> +			mask = readl(ts->base + K1_TSENSOR_INT_CLR_REG);
> +			mask |= K1_TSENSOR_INT_MASK(i);
> +			writel(mask, ts->base + K1_TSENSOR_INT_CLR_REG);
> +			thermal_zone_device_update(ts->ch[i].tzd, THERMAL_EVENT_UNSPECIFIED);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int k1_tsensor_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct k1_tsensor *ts;
> +	struct reset_control *reset;
> +	struct clk *clk;
> +	int i, irq, ret;
> +
> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	ts->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ts->base))
> +		return dev_err_probe(dev, PTR_ERR(ts->base), "Failed to get reg\n");
> +
> +	reset = devm_reset_control_get_exclusive_deasserted(dev, NULL);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(dev, PTR_ERR(reset), "Failed to get/deassert reset control\n");
> +
> +	clk = devm_clk_get_enabled(dev, "core");
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get core clock\n");
> +
> +	clk = devm_clk_get_enabled(dev, "bus");
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get bus clock\n");
> +
> +	k1_tsensor_init(ts);
> +
> +	for (i = 0; i < MAX_SENSOR_NUMBER; ++i) {
> +		ts->ch[i].id = i;
> +		ts->ch[i].ts = ts;
> +		ts->ch[i].tzd = devm_thermal_of_zone_register(dev, i, ts->ch + i, &k1_tsensor_ops);
> +		if (IS_ERR(ts->ch[i].tzd))
> +			return PTR_ERR(ts->ch[i].tzd);
> +
> +		/* Attach sysfs hwmon attributes for userspace monitoring */
> +		ret = devm_thermal_add_hwmon_sysfs(dev, ts->ch[i].tzd);
> +		if (ret)
> +			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
> +
> +		k1_tsensor_enable_irq(ts->ch + i);

should call after the devm_request_threaded_irq succeeds;

Thanks,
Jie

> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL,
> +					k1_tsensor_irq_thread,
> +					IRQF_ONESHOT, "k1_tsensor", ts);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, ts);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id k1_tsensor_dt_ids[] = {
> +	{ .compatible = "spacemit,k1-tsensor" },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, k1_tsensor_dt_ids);
> +
> +static struct platform_driver k1_tsensor_driver = {
> +	.driver = {
> +		.name		= "k1_tsensor",
> +		.of_match_table = k1_tsensor_dt_ids,
> +	},
> +	.probe	= k1_tsensor_probe,
> +};
> +module_platform_driver(k1_tsensor_driver);
> +
> +MODULE_DESCRIPTION("SpacemiT K1 Thermal Sensor Driver");
> +MODULE_AUTHOR("Shuwei Wu <shuwei.wu@mailbox.org>");
> +MODULE_LICENSE("GPL");
> 

