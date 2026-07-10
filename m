Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3669C18CC13
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667317; cv=none; b=MnnkZFtWkNpT+iNGYC6RnP/Syw4UE36d+KgwzYW1Q6FnOR4VdGRKbyAiZXbzre7fnWB+3EziKGHRUWDUPevUBuV42H2VZvwlnJ9CtyAneUBESMCaAk4l9oJ7nKoxUg8Ax2e8GYz8Pes4gndFWYbMkEA6h/wpGpS7loNixF67+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667317; c=relaxed/simple;
	bh=xp4a4aMg6E+lv0Dg60qUI00g+DbzqxPxFkQDgh0Ntfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2vdGoCwdVTzq5nnXTruVJ8gA3cnoEtyH11m9BsBeNy549uERLoeS7DXWwoXale6GWl/efo0ZS1SzWN+9IluX1K+zlCcIx8DnwC5ilfhX3s+TnWOBm87ws4+it31KNcL8ERB8Lc+Sp9yULhFmSs6gWa9IJLdUruAn3cPEhCqX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ibRX9CAp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JiClzPr3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ibRX9CAp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JiClzPr3"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3nSDN3848786
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 07:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CTo9ErlBaR/hNqzIEgPGk8su1KABztQxV6Y3Dq5N4yE=; b=ibRX9CApqstDvTG/
	OmTTXkPXEyrJA2GJdBHSccgUVltedZJPcRcSNPOuU6S2c72cVOeGrAjujZ0WMOqQ
	LqiwxrqLBi8ODbuGlF4fq7EYtx49gcIedLU4kPRaVE6ifXzDtPOUwhmC1/EchLVw
	EI/H7EZANojl09+zfbz4Weaf5By5Bq558R+H+nhDiaWw7VjKsajEOOUMoANK6Df0
	8dvHdNhE7/p2nUsbRdhkMJXTSR+wTLvjqCv4yGfR4Ib0Fryjs1jrBdGf83MuuTWI
	mm9qk4srvkipLa+tD7PSjwV/b68Z8Kfn9NLAy51e5LycveRWynw3zVfAZVUrUvgV
	r19hGg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesu7v2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 07:08:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bec738909so4622971cf.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 00:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783667313; x=1784272113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CTo9ErlBaR/hNqzIEgPGk8su1KABztQxV6Y3Dq5N4yE=;
        b=JiClzPr39TxdeGrdMgftYFv2SabvqTG5ACcfHwXXxlFK1TTXJDdS8N6yAbZTBAzn4E
         Xl4DktOC+MJldC9Jau/ygCDgHyw38Kr/ZT7NLn27yrMwZDZZ5OBcn4GxXSnqF/g/dgrm
         cxGmwNIz5f8VRTK3sIhUodGAn2d+R3PO7Btep3zbSXOTsURz+8lysk/S1P2Ai+EsH7Hu
         RbhHpdMjjjxxODIgG1THY/IGIjO/NZ7uNEHDFrYqTB6OjChWhcpwhJLszwWxxxi/WAVC
         UDUuHfn0p/qImKtygi6jvX3gtrjWehQNtNrSERLB1/+UzFuyNelUkDd0r5IvI3aR42NS
         1fPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783667313; x=1784272113;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CTo9ErlBaR/hNqzIEgPGk8su1KABztQxV6Y3Dq5N4yE=;
        b=gtE6Pb3Mw5uWhEOdtBUK1XgSYIrb1abygBH2/K4HuVqhbms8TNjDtewE7XbraaQqIF
         HYNr0PT0MDtayiUzNu15QI6N0uJpB8/XMgWMFPw8YeWaKrgTASuCNZirx+t10Sc6vACb
         0ax1/zNiZbSMLHD3syUxE7tIVWcI5mGztfqJ2Fi4J+aP9vCs7vhXlv31HWt2Nou2fJLq
         tvI5cPE+G80mN4j6kWKhbUZ5zu/kI2K7yj81Wq/2G5XRkaeGHwRk8CByjuxi2JlQ8tgp
         fY2mhGC0gky6hNwXiXYMw1PJTLIreRR9xL8wksUh3+xcfoKrtaDVau8hfy39Ua4urbXN
         +Uzg==
X-Forwarded-Encrypted: i=1; AHgh+RojCZB1qTlrMXCtID23CSDFnKZJgWhZF1nNDwwl7/h9gf5FmOfAWGBmHgZH3damOMmtFpuuiNP3BA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+vdumKrUYtB0XCuCEvO7rYAPp8xgoMY2B+TokIriFMBOHu60
	XFzDjBh0In7x5XE5BwQxtRz0RCTgfnrtTGKmD338rUmUZois2JHf7HhOvh82Wt5fz9HUOjhfM2L
	okVCi7jgNkZ8OdpZbSUjl7HG7JC9bGIe1E2FG22NXI5AgQxVngHWkZBk7Y5EXsA==
X-Gm-Gg: AfdE7cmFV6E6UDX3ri5dcl5Ws+EPsuE9gpChlMveNEXQeeGW/DDf7aZZC0G5vV6TyGa
	g2x53os85Lq95dBLcQapms+yoFN5TdUewL4RQW8Wv6jDkKBdIZ4sRwtO3Z20664HNRTdHSbHMA+
	KN1a+i5iZ3A1APjqiZVa/Ffy71Ihi5HUuu9oTYAqcsfwEofGwZrTtlV5gnWaUpWdVeeTFineD5R
	mHMAh7D7CAzhlrdqJWuu2bzRiXSfhHTA4fce1gh3+nMxuKsXd0aWaMxVOrmEjo51Jn0ajA/qOSH
	JT0x795ZbH7kXxceU9O5UzCh1vKHlXD/EkK8ClCuIASlV+BWrkwepZSOf6Vfas6KkXO28pmR+BX
	6dwsAzBegPny7yqCmhbD4og344Gmi0+Y1abTRbfao3jnuxoMrLSZqWKh1hHNKOluOsolf4kOIag
	==
X-Received: by 2002:ac8:6103:0:b0:51c:7b12:5fde with SMTP id d75a77b69052e-51c8b3fb66bmr109260051cf.74.1783667313190;
        Fri, 10 Jul 2026 00:08:33 -0700 (PDT)
X-Received: by 2002:ac8:6103:0:b0:51c:7b12:5fde with SMTP id d75a77b69052e-51c8b3fb66bmr109259721cf.74.1783667312518;
        Fri, 10 Jul 2026 00:08:32 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8e86:6bca:4a7e:8b62? ([2a05:6e02:1041:c10:8e86:6bca:4a7e:8b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3dcdsm113162415e9.3.2026.07.10.00.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 00:08:31 -0700 (PDT)
Message-ID: <bbe3e9a1-86df-4c36-be68-ed480de10c1d@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 09:08:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] thermal: qcom: add support for PMIC5 Gen3 ADC
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
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
 <20260705-gen3_adc_tm-v3-3-ac62f387dbce@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260705-gen3_adc_tm-v3-3-ac62f387dbce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VF83uv7zV2RZOu9MAk9NXA8CiNdGihR-
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a509a71 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=7NxYetYoRXDlURz2KLYA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2NyBTYWx0ZWRfX180v34xvw4aJ
 w29L91T6wqMGnNzB/apYlG5kG3r2k7NZ26c5rE+SMPas9yqFJJq8McOsN02L/Ri6JdEwb40BV3i
 Uku4vn+oq7tyQ4BR/TGsuE57oA9LJ0k=
X-Proofpoint-ORIG-GUID: VF83uv7zV2RZOu9MAk9NXA8CiNdGihR-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2NyBTYWx0ZWRfX2+ZRB4Jt9RTk
 8ryLlKgtuib/6WzLdZFvUvJ5Liiwh1uzIV/VlButSOqdPtMYm0HfpAVvPjKUdvOOeTWA+Ti9uvZ
 YezIUGE3qhZgYigzg15YRryiAvqMEQ1ZOZt2TSWwfPhD1xVefDX3wCnaH/AZO9LAiaCQTeCyZpz
 MpVrCHAdhTmEFvK9eHw6FQ2W+a4wCKIgeSkorAnzy6mZtr+X2eJ+E9WKhVo0K7i33zZ/4RM4orQ
 +nEA8MWU/InZOZXGkJpWXq3x2z5UcjXTy0PC22QTH4hwJHTCaawlZ0zb7W5H0cKviwE9F1RCaMm
 c8o9LOnT/4UDvyidesL3+CNP7+lfQV4apr/5f+0vm2//q1Q3qeok732x95RkAcqH6Ui5z1WnDdd
 eLVVybSwNtNzZBVMq04WWAhNy+TI3atKBTRPakfMQuOVjoyvyEM4ah4CTVfetfqxm+qO9s1cCTU
 pGeu5HNYfXFZY4VsymA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100067


Hi Jishnu,

On 7/5/26 18:53, Jishnu Prakash wrote:
> Add support for ADC_TM part of PMIC5 Gen3.
> 
> This is an auxiliary driver under the Gen3 ADC driver, which implements the
> threshold setting and interrupt generating functionalities of QCOM ADC_TM
> drivers, used to support thermal trip points.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

Overall the driver LGTM but as you are sending a new version to take 
into account Andy's and Jonathan's comments, please take the opportunity 
to document a bit more the code and the changelog regarding the hardware 
(eg. register layout)

Thanks

   -- Daniel

> ---
>   drivers/thermal/qcom/Kconfig                  |   9 +
>   drivers/thermal/qcom/Makefile                 |   1 +
>   drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 425 ++++++++++++++++++++++++++
>   3 files changed, 435 insertions(+)
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
> index 000000000000..5a82c4d8a37e
> --- /dev/null
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> @@ -0,0 +1,425 @@
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
> + * @common_props: structure with common  ADC channel properties.
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
> +DEFINE_GUARD(adc5_gen3, struct adc_tm5_gen3_chip *, adc5_gen3_mutex_lock(_T->dev),
> +	     adc5_gen3_mutex_unlock(_T->dev))
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
> +static int adc5_gen3_tm_status_check(struct adc_tm5_gen3_chip *adc_tm5,
> +				     int sdam_index, u8 tm_status[at_least 2])
> +{
> +	int ret;
> +
> +	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS,
> +			     tm_status, 2);
> +	if (ret)
> +		return ret;
> +
> +	return adc5_gen3_status_clear(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS_CLR,
> +				     tm_status, 2);
> +}
> +
> +static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
> +	u8 tm_status[2] = { };
> +	int sdam_index;
> +
> +	sdam_index = get_sdam_from_irq(adc_tm5, irq);
> +	if (sdam_index < 0)
> +		return IRQ_NONE;
> +
> +	scoped_guard(adc5_gen3, adc_tm5) {
> +		int ret = adc5_gen3_tm_status_check(adc_tm5, sdam_index,
> +						    tm_status);
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
> +	/* High temperature corresponds to low voltage threshold */
> +	prop->low_thr_en = (high_temp != INT_MAX);
> +	if (prop->low_thr_en) {
> +		adc_code = qcom_adc_tm5_gen2_temp_res_scale(high_temp);
> +		put_unaligned_le16(adc_code, &buf[8]);
> +	}
> +
> +	/* Low temperature corresponds to high voltage threshold */
> +	prop->high_thr_en = (low_temp != -INT_MAX);
> +	if (prop->high_thr_en) {
> +		adc_code = qcom_adc_tm5_gen2_temp_res_scale(low_temp);
> +		put_unaligned_le16(adc_code, &buf[10]);
> +	}
> +
> +	buf[7] = 0;
> +	if (prop->high_thr_en)
> +		buf[7] |= ADC5_GEN3_HIGH_THR_INT_EN;
> +	if (prop->low_thr_en)
> +		buf[7] |= ADC5_GEN3_LOW_THR_INT_EN;
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
> +				dev_info(adc_tm5->dev,
> +					 "thermal sensor on channel %d is not used\n",
> +					 channel);
> +				continue;
> +			}
> +			return dev_err_probe(adc_tm5->dev, PTR_ERR(tzd),
> +					     "Error registering TZ zone:%ld for channel:%d\n",
> +					     PTR_ERR(tzd), channel);
> +		}
> +		adc_tm5->chan_props[i].tzd = tzd;
> +		ret = devm_thermal_add_hwmon_sysfs(adc_tm5->dev, tzd);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +static void adc5_gen3_disable(void *data)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = data;
> +
> +	guard(adc5_gen3)(adc_tm5);
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
> +	u32 irq_flags;
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
> +		adc_tm5->chan_props[i].common_props = aux_dev_wrapper->tm_props[i];
> +		adc_tm5->chan_props[i].timer = MEAS_INT_1S;
> +		adc_tm5->chan_props[i].sdam_index = (i + 1) / 8;
> +		adc_tm5->chan_props[i].tm_chan_index = (i + 1) % 8;
> +		adc_tm5->chan_props[i].chip = adc_tm5;
> +	}
> +
> +	/* This is to disable all ADC_TM channels in case of probe failure. */
> +	ret = devm_add_action(dev, adc5_gen3_disable, adc_tm5);
> +	if (ret)
> +		return ret;
> +
> +	ret = adc_tm5_register_tzd(adc_tm5);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * First SDAM's interrupt is shared between main ADC driver
> +	 * and auxiliary TM driver, so its flags must include
> +	 * IRQF_SHARED. This is not needed for other SDAMs as they
> +	 * will be used only for TM functionality.
> +	 */
> +	irq_flags = IRQF_ONESHOT | IRQF_SHARED;
> +	for (int i = 0; i < adc_tm5->dev_data->num_sdams; i++) {
> +		ret = devm_request_threaded_irq(dev,
> +						adc_tm5->dev_data->base[i].irq,
> +						adctm5_gen3_isr, adctm5_gen3_isr_thread,
> +						irq_flags, adc_tm5->dev_data->base[i].irq_name,
> +						adc_tm5);
> +		if (ret < 0)
> +			return ret;
> +		irq_flags = IRQF_ONESHOT;
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

