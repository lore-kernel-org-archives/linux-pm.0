Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821753911AB
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167010; cv=none; b=FnLYsZSB5LW9D+TqQp/NgTqNYXq1TCT+41jFHeXRCreijA5TystWsKazVf4hYtLHNOfxV9V8JHJ88qBjX9IBXzwTLY1fVbaA2JVWqZVdJCWh5lOJr59XwfApOwPLwXoErREWoO7H2elmNwKOWvWUAWovC7IK2vJGR1eXxeHVSKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167010; c=relaxed/simple;
	bh=BrJNowDL1ubUecYSYIeyOW/Legj2+eO/bvW/7AS1fvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=br8G5jIZ37iY/m+WT1EU/he0V2i9RGX26rJQLn4aRJQErucAlDK+w5fYEWRzz8EXrA22utbhU3Ryj051L6ypp3M09Lzem25oO00/YTY7T67jaT0Fdz0rZN+mSv+Lrs2HSCJkrYPABDGyJhg7F/8AG8pdB6UVAtOIGZsIcfHMj9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bNlUg+rJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZRtN2+sU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bNlUg+rJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZRtN2+sU"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlfYI3895656
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	udZKWsoy/KjGJ3Mh1stcIlBeBKiPkG5JHOG+aGyrSMk=; b=bNlUg+rJXEmCb0Q6
	Up9J/AMqPnyjyDhyI//og4/n3ygMUHrWIs/p10m92/FiJRoe3uP8F6cZB+zFLH2j
	2a3J+wCaNoeryoDKyf6QOcipcDB5ohpIwhUCGrtm9mesmo6sobEP0c9xe/TH4637
	wldgdDfEX4gHbp/GTRVK7bMwTtCEgnyCZghQB9RRXJHspf2U4+DYTBNftegbdQ61
	f9vapAZrVHuPYRB2bhs6sPFDKyJkKua5pHHUaVKVe5n3/7NAJ+V2JCqQd2oz90v5
	ua8Yom3zU14oyqTYrkesqbZiF9LLBlE7vMGX9PmsHmUnaOhNXHfyMgNqWDe/KDIA
	fxSMcg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fnsxs3d2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:43:27 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81ed0c52d9cso44774917b3.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785167007; x=1785771807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=udZKWsoy/KjGJ3Mh1stcIlBeBKiPkG5JHOG+aGyrSMk=;
        b=ZRtN2+sUb7takrNTG0L/wIp3ptQSJBkNkgowyaAVMZSVljBkxuEV8hJQx+FE1HDykr
         a/LkRZmVl/k1uvjMx6Al4pC2kPsGvdDjKQHcRfNN17EYD9sM723GUtb2l3deTOz/Ah/a
         xexXPaTfhQzFGfCB1YN4qNMbssu458NV1FdOlSMMMLGdKkCNKzngLKN6/jNd56mpc92+
         IaPD0WMaXnyZ6wr+vugRNdfpL4e7vWn+ZQ4DpzXxnZJBYU6IcK4iIeLK7vQ0UMQzX5/V
         4hCzcliB7oE16ymE1oMkcUS96NZxIOpH6h/wxvfpnLn6JTF16wTZ0+nfbzhKj+9yWGo0
         YdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167007; x=1785771807;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=udZKWsoy/KjGJ3Mh1stcIlBeBKiPkG5JHOG+aGyrSMk=;
        b=Edsp53kTX2XOkbVUuTFe/Ee2foCrk/bc6z1rO18ddn36kcYsOOFatjbf/RNN9aTOIW
         keKKTBPTHezC2ceiUTt5c9RQW6elAYHYeavD3lcWPiksatjAvR5d/3Scvu0RDgVfyCff
         X11yIqtXX8VQnYat8qglRCN7DRPdzruTD6q36mC+4O7QfXfbiezZYTb2L3gOZUJWUwUj
         QxaQOXLf6XmS/aAPkaogg9BXFZOU7/+OgZ/Ju6EuCfYPzFkHJJmbTVAkZGtIO/AE6/tD
         kXShc/GTHqLpe5DYmNDyd+OkqdoBCGdKNt2DrwFrFieXE+UDhmi5q7ki3m1Yeexyi9ab
         7M1g==
X-Forwarded-Encrypted: i=1; AHgh+Rp7mHZSLSP+GWhvuuylfGhXd8siQ2c1RoXj284Q2mkHiJNCmFbYpbvKs6EMPGah5+P9hG8Pz5AjJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxANu6tcvy5PBmQYiiUnM4d+W27Oj44pV/8DMFoRP8Q7GL7t+d/
	3kCqUiXkeulhBJCNZA4eKH0iEAvlam4t93/ejLMghGZTspPPtp1/7Y2nNgviasdJlXvFhJMCZ6F
	DA0zOXCpBFBRHD8zyjbPMXPW1xy9Dv9MAO7Y1H5QMSlPnbMg6BCBwz/6WplMxnA==
X-Gm-Gg: AR+sD107OM8azsCO6+j2f8q4knyNPZa2XqZziZd1B8I3oG25+eai/89PdQ8ylemOV43
	2GSyxMramoSsN8a0wqgyawFzY1Mxi7gtqmT1zFY0WgcJsbyS40Awv9iWOVLnMm2dw9ibFiM25tD
	dN1kSYS8wrl8TcGgm5/VHkeo9Mb6nRL3liytkofgAeMJsaURHStgwSorUfz9UFXKqBgHFHj+AIN
	iQssf+JGTetzw908YPgR9w3zEWD9UBrxsQXfPuwjgRKPYsZlAaxjK42Nb3wMV3xFfpIh7I3ZK7j
	Eo2MbxafSH88Zyl2BuZIl4ZsB4lh+PkVCRBO3hSW5CXhR+axHG28+8RGwSlYpXZC/0JCyCmA+AE
	chZcI5lN6kPp5XH559IRylXJO+850tGE6WTwy9p2k9zZX76fWnkytLu5sPA7vo4dC
X-Received: by 2002:a05:690c:6287:b0:81d:26f9:bc85 with SMTP id 00721157ae682-81f69dea8b2mr31502737b3.45.1785167006782;
        Mon, 27 Jul 2026 08:43:26 -0700 (PDT)
X-Received: by 2002:a05:690c:6287:b0:81d:26f9:bc85 with SMTP id 00721157ae682-81f69dea8b2mr31502477b3.45.1785167006227;
        Mon, 27 Jul 2026 08:43:26 -0700 (PDT)
Received: from ?IPV6:2a01:cde0:108:24ed:6c20:c6e6:2fc0:aab7? ([2a01:cde0:108:24ed:6c20:c6e6:2fc0:aab7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f6592ecd4sm33445157b3.47.2026.07.27.08.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 08:43:25 -0700 (PDT)
Message-ID: <a68078d9-9b80-48af-808c-af24d97268c0@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 17:43:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260722-gen3_adc_tm-v4-0-011981f756c8@oss.qualcomm.com>
 <20260722-gen3_adc_tm-v4-3-011981f756c8@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260722-gen3_adc_tm-v4-3-011981f756c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0NyBTYWx0ZWRfX1+bRPC3m7Mby
 mqCgaLgOwWfkpMvoddk/TL2CTItDsZegMWM6k6jwl4BsG+/udo9bNHDDEWOQSJVsAhXUoHK+RF4
 /m2SuMQo2Oh8CsH6hDP8swT76BYqsYgfIARQX93L5nmSdL/qrO8laytGFhpLSUeQDstUgqS0jdQ
 Qtzgy1XbTAhZrxAxMWEwG0f7NmSFRrLBDPka7+/EwpBzlf9JwZ4de6KUZHcox93lzkRFtBWa0GH
 peNXJAiyoubo7hKQns/D3ynOlvOvRqjQlt0dUJxZqHBZHJIwlbbdU7dL3sqIoo+KciUnN2Tw2GV
 rTgTmUOOj7FmBQDcLn7I5vC0nwdfhrrQuUC3wZfxiE/rBtmnksr2gMl9Xndsf2BuC8KLBeCxlq1
 LfG0dcYMp31wAwk88isfg7+NDcP9vIFzS/k63S48rC/JGNLA/80Tgj4TT2Bwlodl9hgO+fqez43
 vIi5F32qFbgHG+kCaNw==
X-Authority-Analysis: v=2.4 cv=EYr4hvmC c=1 sm=1 tr=0 ts=6a677c9f cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=k6uiJ9FFFaPGw3kp3twA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-ORIG-GUID: tx1IKR09Tbazd4obAQQHeANHuSN6vuPH
X-Proofpoint-GUID: tx1IKR09Tbazd4obAQQHeANHuSN6vuPH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0NyBTYWx0ZWRfX72ObDRqfoTAq
 Wz1OREiOEq9OckSXT1QznAdf0irz4RS2fzYLs56wj/FnEjr3/fvMXKkRaYTsE48aQj1zgUBtMww
 IuEAY6fseSR0tRayUG0qVPSEp/3RusA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270147


Hi,

Andy ? Are fine with these changes ?



On 7/22/26 13:26, Jishnu Prakash wrote:
> Add support for ADC_TM part of PMIC5 Gen3 in an auxiliary driver
> under the Gen3 ADC driver. Its functionality is similar to that of
> PMIC5 Gen2 ADC_TM, which implements the threshold setting and
> interrupt generating functions, used to support thermal trip points.
> 
> In Gen3 ADC, the register interface is implemented on one or more SDAM
> (Shared Direct Access Memory) peripherals instead of dedicated ADC
> peripherals. Each ADC SDAM has eight channels which can be configured
> for either immediate reads (main ADC driver's functionality) or ADC_TM
> reads. By convention, the first channel of the first ADC SDAM is reserved
> for all immediate reads and remaining channels across all SDAMs are used
> for ADC_TM functionality.
> 
> On the first SDAM, the interrupt line and configuration registers are
> shared between the main ADC and auxiliary ADC_TM drivers. Access to the
> registers is protected through a mutex shared between the drivers. The
> ADC_TM driver accesses this mutex and some other functions shared from
> the main driver (like adc5_gen3_get_scaled_reading() for immediate channel
> reads in the .get_temp() callback) through APIs exported into a shared
> namespace.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
>   drivers/thermal/qcom/Kconfig                  |   9 +
>   drivers/thermal/qcom/Makefile                 |   1 +
>   drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 434 ++++++++++++++++++++++++++
>   3 files changed, 444 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index a6bb01082ec6..1acb11e4ac80 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -21,6 +21,15 @@ config QCOM_SPMI_ADC_TM5
>   	  Thermal client sets threshold temperature for both warm and cool and
>   	  gets updated when a threshold is reached.
>   
> +config QCOM_SPMI_ADC_TM5_GEN3
> +	tristate "Qualcomm SPMI PMIC Thermal Monitor ADC5 Gen3"
> +	depends on QCOM_SPMI_ADC5_GEN3
> +	help
> +	  This enables the auxiliary thermal driver for the ADC5 Gen3 thermal
> +	  monitoring device. It shows up as a thermal zone with multiple trip points.
> +	  Thermal client sets threshold temperature for both warm and cool and
> +	  gets updated when a threshold is reached.
> +
>   config QCOM_SPMI_TEMP_ALARM
>   	tristate "Qualcomm SPMI PMIC Temperature Alarm"
>   	depends on OF && SPMI && IIO
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index 0fa2512042e7..828d9e7bc797 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -4,5 +4,6 @@ obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
>   qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
>   				   tsens-8960.o
>   obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
> +obj-$(CONFIG_QCOM_SPMI_ADC_TM5_GEN3)	+= qcom-spmi-adc-tm5-gen3.o
>   obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
>   obj-$(CONFIG_QCOM_LMH)		+= lmh.o
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> new file mode 100644
> index 000000000000..9cf552d36868
> --- /dev/null
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> @@ -0,0 +1,434 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/container_of.h>
> +#include <linux/device/devres.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/thermal.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +
> +#include "../thermal_hwmon.h"
> +
> +#define ADC_TM5_GEN3_CONFIG_REGS 12
> +
> +struct device;
> +struct adc_tm5_gen3_chip;
> +
> +/**
> + * struct adc_tm5_gen3_channel_props - ADC_TM channel structure
> + * @common_props: structure with common ADC channel properties.
> + * @chip: ADC TM device.
> + * @tzd: pointer to thermal device corresponding to TM channel.
> + * @sdam_index: SDAM on which this TM channel lies.
> + * @timer: time period of recurring TM measurement.
> + * @tm_chan_index: TM channel number used.
> + * @high_thr_en: TM high threshold crossing detection enabled.
> + * @low_thr_en: TM low threshold crossing detection enabled.
> + */
> +struct adc_tm5_gen3_channel_props {
> +	struct adc5_channel_common_prop common_props;
> +	struct adc_tm5_gen3_chip *chip;
> +	struct thermal_zone_device *tzd;
> +	unsigned int sdam_index;
> +	unsigned int timer;
> +	unsigned int tm_chan_index;
> +	bool high_thr_en;
> +	bool low_thr_en;
> +};
> +
> +/**
> + * struct adc_tm5_gen3_chip - ADC Thermal Monitoring device structure
> + * @dev_data: Top-level ADC device data.
> + * @chan_props: Array of ADC_TM channel structures.
> + * @dev: SPMI ADC5 Gen3 device.
> + * @nchannels: number of TM channels allocated
> + */
> +struct adc_tm5_gen3_chip {
> +	struct adc5_device_data *dev_data;
> +	struct adc_tm5_gen3_channel_props *chan_props;
> +	struct device *dev;
> +	unsigned int nchannels;
> +};
> +
> +DEFINE_GUARD(adc5_gen3, struct adc_tm5_gen3_chip *,
> +	     adc5_gen3_mutex_lock(_T->dev), adc5_gen3_mutex_unlock(_T->dev))
> +
> +static int get_sdam_from_irq(struct adc_tm5_gen3_chip *adc_tm5, int irq)
> +{
> +	for (int i = 0; i < adc_tm5->dev_data->num_sdams; i++) {
> +		if (adc_tm5->dev_data->base[i].irq == irq)
> +			return i;
> +	}
> +	return -ENOENT;
> +}
> +
> +static irqreturn_t adctm5_gen3_isr(int irq, void *dev_id)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
> +	int ret, sdam_num;
> +	u8 tm_status[2];
> +	u8 status, val;
> +
> +	sdam_num = get_sdam_from_irq(adc_tm5, irq);
> +	if (sdam_num < 0)
> +		return IRQ_NONE;
> +
> +	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_STATUS1,
> +			     &status, sizeof(status));
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
> +		val = ADC5_GEN3_CONV_ERR_CLR_REQ;
> +		adc5_gen3_status_clear(adc_tm5->dev_data, sdam_num,
> +				       ADC5_GEN3_CONV_ERR_CLR, &val, 1);
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_TM_HIGH_STS,
> +			     tm_status, sizeof(tm_status));
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	if (tm_status[0] || tm_status[1])
> +		return IRQ_WAKE_THREAD;
> +
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
> +	u8 tm_status[2];
> +	int sdam_index;
> +
> +	sdam_index = get_sdam_from_irq(adc_tm5, irq);
> +	if (sdam_index < 0)
> +		return IRQ_NONE;
> +
> +	scoped_guard(adc5_gen3, adc_tm5) {
> +		int ret;
> +
> +		ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS,
> +				     tm_status, sizeof(tm_status));
> +		if (ret)
> +			return IRQ_NONE;
> +
> +		ret = adc5_gen3_status_clear(adc_tm5->dev_data, sdam_index,
> +					     ADC5_GEN3_TM_HIGH_STS_CLR, tm_status,
> +					     sizeof(tm_status));
> +		if (ret)
> +			return IRQ_NONE;
> +	}
> +
> +	for (int i = 0; i < adc_tm5->nchannels; i++) {
> +		struct adc_tm5_gen3_channel_props *chan_prop = &adc_tm5->chan_props[i];
> +		int offset = chan_prop->tm_chan_index;
> +		bool upper_set, lower_set;
> +
> +		if (chan_prop->sdam_index != sdam_index)
> +			continue;
> +
> +		upper_set = ((tm_status[0] & BIT(offset)) && chan_prop->high_thr_en);
> +		lower_set = ((tm_status[1] & BIT(offset)) && chan_prop->low_thr_en);
> +
> +		if (!(upper_set || lower_set))
> +			continue;
> +
> +		thermal_zone_device_update(chan_prop->tzd, THERMAL_TRIP_VIOLATED);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int adc_tm5_gen3_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	struct adc_tm5_gen3_channel_props *prop = thermal_zone_device_priv(tz);
> +	struct adc_tm5_gen3_chip *adc_tm5;
> +
> +	if (!prop || !prop->chip)
> +		return -EINVAL;
> +
> +	adc_tm5 = prop->chip;
> +
> +	return adc5_gen3_get_scaled_reading(adc_tm5->dev, &prop->common_props, temp);
> +}
> +
> +static int adc_tm5_gen3_disable_channel(struct adc_tm5_gen3_channel_props *prop)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = prop->chip;
> +	int ret;
> +	u8 val;
> +
> +	prop->high_thr_en = false;
> +	prop->low_thr_en = false;
> +
> +	ret = adc5_gen3_poll_wait_hs(adc_tm5->dev_data, prop->sdam_index);
> +	if (ret)
> +		return ret;
> +
> +	val = BIT(prop->tm_chan_index);
> +	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
> +			      ADC5_GEN3_TM_HIGH_STS_CLR, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
> +			      ADC5_GEN3_TM_LOW_STS_CLR, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	val = MEAS_INT_DISABLE;
> +	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
> +			      ADC5_GEN3_TIMER_SEL, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	/* To indicate there is an actual conversion request */
> +	val = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
> +	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
> +			      ADC5_GEN3_PERPH_CH, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	val = ADC5_GEN3_CONV_REQ_REQ;
> +	return adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
> +			       ADC5_GEN3_CONV_REQ, &val, sizeof(val));
> +}
> +
> +static int adc_tm5_gen3_configure(struct adc_tm5_gen3_channel_props *prop,
> +				  int low_temp, int high_temp)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = prop->chip;
> +	u8 buf[ADC_TM5_GEN3_CONFIG_REGS];
> +	u8 conv_req;
> +	u16 adc_code;
> +	int ret;
> +
> +	ret = adc5_gen3_poll_wait_hs(adc_tm5->dev_data, prop->sdam_index);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adc5_gen3_read(adc_tm5->dev_data, prop->sdam_index,
> +			     ADC5_GEN3_SID, buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Write SID */
> +	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->common_props.sid);
> +
> +	/* Select TM channel and indicate there is an actual conversion request */
> +	buf[1] = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
> +
> +	buf[2] = prop->timer;
> +
> +	/* Digital param selection */
> +	adc5_gen3_update_dig_param(&prop->common_props, &buf[3]);
> +
> +	/* Update fast average sample value */
> +	buf[4] = FIELD_PREP(ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK,
> +			    prop->common_props.avg_samples) | ADC5_GEN3_FAST_AVG_CTL_EN;
> +
> +	/* Select ADC channel */
> +	buf[5] = prop->common_props.channel;
> +
> +	/* Select HW settle delay for channel */
> +	buf[6] = FIELD_PREP(ADC5_GEN3_HW_SETTLE_DELAY_MASK,
> +			    prop->common_props.hw_settle_time_us);
> +
> +	buf[7] = 0;
> +
> +	/* High temperature corresponds to low voltage threshold */
> +	prop->low_thr_en = (high_temp != INT_MAX);
> +	if (prop->low_thr_en) {
> +		adc_code = qcom_adc_tm5_gen2_temp_res_scale(high_temp);
> +		put_unaligned_le16(adc_code, &buf[8]);
> +		buf[7] |= ADC5_GEN3_LOW_THR_INT_EN;
> +	}
> +
> +	/* Low temperature corresponds to high voltage threshold */
> +	prop->high_thr_en = (low_temp != -INT_MAX);
> +	if (prop->high_thr_en) {
> +		adc_code = qcom_adc_tm5_gen2_temp_res_scale(low_temp);
> +		put_unaligned_le16(adc_code, &buf[10]);
> +		buf[7] |= ADC5_GEN3_HIGH_THR_INT_EN;
> +	}
> +
> +	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index, ADC5_GEN3_SID,
> +			      buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +
> +	conv_req = ADC5_GEN3_CONV_REQ_REQ;
> +	return adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
> +			       ADC5_GEN3_CONV_REQ, &conv_req, sizeof(conv_req));
> +}
> +
> +static int adc_tm5_gen3_set_trip_temp(struct thermal_zone_device *tz,
> +				      int low_temp, int high_temp)
> +{
> +	struct adc_tm5_gen3_channel_props *prop = thermal_zone_device_priv(tz);
> +	struct adc_tm5_gen3_chip *adc_tm5;
> +
> +	if (!prop || !prop->chip)
> +		return -EINVAL;
> +
> +	adc_tm5 = prop->chip;
> +
> +	dev_dbg(adc_tm5->dev, "channel:%s, low_temp(mdegC):%d, high_temp(mdegC):%d\n",
> +		prop->common_props.label, low_temp, high_temp);
> +
> +	guard(adc5_gen3)(adc_tm5);
> +
> +	return adc_tm5_gen3_configure(prop, low_temp, high_temp);
> +}
> +
> +static const struct thermal_zone_device_ops adc_tm_ops = {
> +	.get_temp = adc_tm5_gen3_get_temp,
> +	.set_trips = adc_tm5_gen3_set_trip_temp,
> +};
> +
> +static int adc_tm5_register_tzd(struct adc_tm5_gen3_chip *adc_tm5)
> +{
> +	struct thermal_zone_device *tzd;
> +	unsigned int channel;
> +	int ret;
> +
> +	for (int i = 0; i < adc_tm5->nchannels; i++) {
> +		channel = ADC5_GEN3_V_CHAN(adc_tm5->chan_props[i].common_props);
> +		tzd = devm_thermal_of_zone_register(adc_tm5->dev, channel,
> +						    &adc_tm5->chan_props[i],
> +						    &adc_tm_ops);
> +		if (IS_ERR(tzd)) {
> +			if (PTR_ERR(tzd) == -ENODEV) {
> +				dev_dbg(adc_tm5->dev,
> +					"thermal sensor on channel %d is not used\n",
> +					channel);
> +				continue;
> +			}
> +			return PTR_ERR(tzd);
> +		}
> +		adc_tm5->chan_props[i].tzd = tzd;
> +		ret = devm_thermal_add_hwmon_sysfs(adc_tm5->dev, tzd);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void adc5_gen3_disable(void *data)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = data;
> +
> +	guard(adc5_gen3)(adc_tm5);
> +
> +	/* Disable all available TM channels */
> +	for (int i = 0; i < adc_tm5->nchannels; i++)
> +		adc_tm5_gen3_disable_channel(&adc_tm5->chan_props[i]);
> +}
> +
> +static int adc_tm5_probe(struct auxiliary_device *aux_dev,
> +			 const struct auxiliary_device_id *id)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5;
> +	struct tm5_aux_dev_wrapper *aux_dev_wrapper;
> +	struct device *dev = &aux_dev->dev;
> +	int ret;
> +
> +	adc_tm5 = devm_kzalloc(dev, sizeof(*adc_tm5), GFP_KERNEL);
> +	if (!adc_tm5)
> +		return -ENOMEM;
> +
> +	aux_dev_wrapper = container_of(aux_dev, struct tm5_aux_dev_wrapper, aux_dev);
> +
> +	adc_tm5->dev = dev;
> +	adc_tm5->dev_data = aux_dev_wrapper->dev_data;
> +	adc_tm5->nchannels = aux_dev_wrapper->n_tm_channels;
> +	adc_tm5->chan_props = devm_kcalloc(dev, aux_dev_wrapper->n_tm_channels,
> +					   sizeof(*adc_tm5->chan_props), GFP_KERNEL);
> +	if (!adc_tm5->chan_props)
> +		return -ENOMEM;
> +
> +	for (int i = 0; i < adc_tm5->nchannels; i++) {
> +		/*
> +		 * Since the first channel of the first SDAM is reserved for
> +		 * immediate ADC conversions, TM channel count must start from
> +		 * the channel just after it. The variable tm_count is used to
> +		 * calculate SDAM and TM channel index on that SDAM correctly
> +		 * for each TM channel.
> +		 */
> +		int tm_count = i + 1;
> +
> +		adc_tm5->chan_props[i].common_props = aux_dev_wrapper->tm_props[i];
> +		adc_tm5->chan_props[i].timer = MEAS_INT_1S;
> +		adc_tm5->chan_props[i].sdam_index = tm_count / 8;
> +		adc_tm5->chan_props[i].tm_chan_index = tm_count % 8;
> +		adc_tm5->chan_props[i].chip = adc_tm5;
> +	}
> +
> +	/*
> +	 * ADC_TM channels are enabled in the loop in adc_tm5_register_tzd() as
> +	 * part of the set_trips calls during thermal zone registration. This
> +	 * action is to disable them all in case of probe failure.
> +	 */
> +	ret = devm_add_action(dev, adc5_gen3_disable, adc_tm5);
> +	if (ret)
> +		return ret;
> +
> +	ret = adc_tm5_register_tzd(adc_tm5);
> +	if (ret)
> +		return ret;
> +
> +	for (int i = 0; i < adc_tm5->dev_data->num_sdams; i++) {
> +		u32 irq_flags = IRQF_ONESHOT;
> +
> +		/*
> +		 * First SDAM's interrupt is shared between main ADC driver and
> +		 * auxiliary TM driver, so its flags must include IRQF_SHARED.
> +		 * This is not needed for other SDAMs as they will be used only
> +		 * for TM functionality.
> +		 */
> +		if (i == 0)
> +			irq_flags |= IRQF_SHARED;
> +
> +		ret = devm_request_threaded_irq(dev,
> +						adc_tm5->dev_data->base[i].irq,
> +						adctm5_gen3_isr,
> +						adctm5_gen3_isr_thread,
> +						irq_flags,
> +						adc_tm5->dev_data->base[i].irq_name,
> +						adc_tm5);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct auxiliary_device_id adctm5_auxiliary_id_table[] = {
> +	{ .name = "qcom_spmi_adc5_gen3.adc5_tm_gen3" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, adctm5_auxiliary_id_table);
> +
> +static struct auxiliary_driver adctm5gen3_auxiliary_driver = {
> +	.id_table = adctm5_auxiliary_id_table,
> +	.probe = adc_tm5_probe,
> +};
> +module_auxiliary_driver(adctm5gen3_auxiliary_driver);
> +
> +MODULE_DESCRIPTION("SPMI PMIC Thermal Monitor ADC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("QCOM_SPMI_ADC5_GEN3");
> 

