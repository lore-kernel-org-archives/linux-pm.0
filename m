Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C669282F0A
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341463; cv=none; b=AnfvKkQDLHebFOJRuG9YI7UhkUMF3dDfqzHI96ccfqWtE/1hmpGNcwAkVgiK133nmHe2YmJY9EVy+glGHVyq5v+v6IZd6oYuSFab/TOqWZybilTLMPOvJFg9kyj/ts2W6iMPov80bXe19tOwmRer1vjI1zog1K9Mlz2Ps0zyWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341463; c=relaxed/simple;
	bh=+U66kiXbQoSgzz8A8b3N5bz9oW3hqUtUZz3l8vU/OZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRe8x/bv82W6Z3/wMJrdNKyKftkTZUE6BNwklXZFWqzHMSLkVlFYZiAEPAAy9briIXaxQIc9FnyfVkrKSvFPYSyo7tND0n7g197itYtHWKcVDYw2QGUMYl8Z4/OuT3X4O8m3TlFknPcJEDNVck2GEJ81FqhypGV+pMAbWfyxyLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y5uZ15dW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eFsb+Xyp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y5uZ15dW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eFsb+Xyp"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829N3mI1080203
	for <linux-pm@vger.kernel.org>; Wed, 2 Sep 2026 09:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kLzQYFaeuVtEE+Dc6N/o8d528C+JcxcVbvwkwNmBaO8=; b=Y5uZ15dWQii8Dy8d
	OYPCtkRngtn4yTCXzoFbdBpOlndX/slsqqKDp8XqGA+axrGcSTG38oGcuVBM4KFR
	dUUteusN7ABVLkkHtW53Xt8P5/91B3UNhkOS0rXFPSOU/7lzn1TrLeWlxlQAZeyu
	rNdIWd9reuEQ9R6yxuj9XHnZsn/6mF0cunUb85GDyUG8YDLf57bnEAuTVjNKcmsu
	0W19P8a3hk8PuiEQrOwjzCJt3PMx0SRO5pUuHGfl3ggiCon2kIugPDNIc6ZpuP0h
	iTGlhHcywxhjbSjcx2Uk70axYdipAGPa393tK3VWP03zsDjMXYZsgnyHlU9WVu+J
	/eHvtA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geb561ecc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 09:30:57 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc42a07d04aso514805a12.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 02:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788341457; x=1788946257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLzQYFaeuVtEE+Dc6N/o8d528C+JcxcVbvwkwNmBaO8=;
        b=eFsb+XypHkUdfSY/zFkK4OroISSJzHNa+jREMnXsZ+9J8corZ4MSr+kg/CgvzxOiMm
         4rrY9oYJzizCzZodPn0cecek5yCd4cVuCD3Wf+ZOfGJLZPxMhLg3qu2s8B5UTxQxVbi5
         zO1wImyPHUsfm+aL46Exqt4rFOQd6BdpfXUwi0GTaqqFz2m4vRTMY1bLSrqB1oGczPY3
         7MfjWB178VmOp6XeeLYEjIUPhvyqdZnipMHg+uhcfNfxvllNifQsOslJPh501QmHB78M
         MUEqPE7AJKZrnZXCqxHgaPflkJrpW5iWnY7jbc2kFyGbIbaj8/rr2mW93SEk+G+3LkfR
         G4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788341457; x=1788946257;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLzQYFaeuVtEE+Dc6N/o8d528C+JcxcVbvwkwNmBaO8=;
        b=R25no6ZPyIiTK0gLrYhFuDIQWqDOigA8Jrl4X88cgZI4537g4413Ej2fQynDsplSxe
         ViAT80fFlk2K0D92Jjo3iKosAxf2acoLgwkumZd30u05JrXzzDXsxxngqL1W7z7tGiyv
         hRh/glXjRKIqhNGFEiaEAyc5o2ifbR5ubx9V/McgEuEGb0DXlUaaQTJ7vyD4Y/Z++NM1
         SaR5b3nNMn5d2rybvCPj2r53SZ86O2O7n9UaLnDLGMDnCWQtwCTxd8/BcAmU0rMDHgwl
         5rgtkonhV27O076B7leODNeshi6KJW6V3dCKoCZBU0Ev203bH8uCfLuxABtmV+HDfvac
         L52A==
X-Forwarded-Encrypted: i=1; AHgh+RpWxCBjT+uB8Pj6Lbd6urO0QJQ3ZlEQC2Ze4klaAqo1ML0KtJyc7BwZ4xajzFcv01lwDzP6Aw5QTQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l8+sHlGbxoQKECqxYpJZW7WqPR1Ttm5Rk6fUM0jOSGlUW1++Wo
	RazBIAV4MgH8ORCxy7kqXlcxOlLjeO4tlMQqBN2UxlCGL5nwihn+2xn85vwaV/rSBugrLlDIj0p
	Y7HLnXtVKgWTir1JiZZ7y8Nt5xIj5XcqoW2wa8vuYiWGqwe93gotq+vkf8ohmqQ==
X-Gm-Gg: AR+sD12oXAgrNsZz+hk3P6HjlgWAeYcz+SrqbkNpmwmyGOzv11y1P+G0vw038KjjJ+g
	dpyH+6e7Pd/2Sui3c6T1VoLqPbTV/4xUQpkQG8paRN/EFmKS6vfrtgTxmX32KtY4b/aUVKJyeE0
	+uTzH+djo3DlpRLFKxBT43A5x7fR2pb4o1CPiUxou1kuhicK8oP4GnKV64w4kMzVvI8dbVMrdkZ
	n/dUwLGh1dfZlDepNrOGxVQyNWY5qJ/zmdNdqyaX/2nrT65vl/288RFnFKmdCRny1+/k/n/K4ze
	zd+roD7lg/SqQPZx5opyTAPFyzqjLaCpMjCOVO+Rnt4spici+Yd4m2gi/8gsf9ntd2/evIbpJtg
	u5YlHPXE0rqfvrfA9j+2mj+JdlJ4=
X-Received: by 2002:a05:6a21:3944:b0:3b4:5ff3:45cb with SMTP id adf61e73a8af0-3d9ad99cf80mr6038817637.8.1788341456382;
        Wed, 02 Sep 2026 02:30:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:3944:b0:3b4:5ff3:45cb with SMTP id adf61e73a8af0-3d9ad99cf80mr6038685637.8.1788341455508;
        Wed, 02 Sep 2026 02:30:55 -0700 (PDT)
Received: from [10.217.217.79] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079f7d77sm5102714eec.12.2026.09.02.02.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 02:30:55 -0700 (PDT)
Message-ID: <1ea96c7d-102a-4261-a70e-ca0813490a02@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 15:00:46 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/12] clk: qcom: Add Global Clock Controller (GCC)
 driver for SM7250
To: Sreeshankar K <sreeshankar0910@gmail.com>, andersson@kernel.org,
        sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, konradybcio@kernel.org,
        tglx@kernel.org, ulfh@kernel.org
Cc: radu@rendec.net, abel.vesa@oss.qualcomm.com, danila@mainlining.org,
        davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com,
        linux@gurudas.dev, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260901092447.3028-1-sreeshankar0910@gmail.com>
 <20260901092447.3028-5-sreeshankar0910@gmail.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20260901092447.3028-5-sreeshankar0910@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA4MiBTYWx0ZWRfX4vh7gCvv1ayC
 wz2yambORvjCbQpxCVGZfuGUwUm4JPyKpe1+atn5ccovvtrYEyrm9vRsfw5qkU+l3TIs+I3rA8k
 cayRjokkUNkyURO0g1W4KFFjSmBvCA4Zc1G7VmpIvei77hUSvHmQVrI+KygsbaxOBTaClqVyzCG
 ztQuOXRZpimzXIgPfd2GyILN98n4fl/wGpHBSSHCa1Wd/wQ/lz9qq2HlB6vcE9t66G1orOnnSUj
 eNBbovHn2XttqXyvflQjG9r3O2ZuA2N5qfKvd6A4R1ME1xHvDAX+fOLQ45+r66Gd4U4yu2uz/on
 9nrbajX8mxKERz24DxDNxphM5vVC8mDb14IpaavtSafIopRh2EXirASgN+2b9y9JKmAIrsP8mQ8
 2YW0B4r1LBBm71xTlxwW201RF0lXE2Z0nNmaOAs1jyR1dPRhJvBPZP12FY98BO3Ub9OW9VLZzjD
 KoHrUDNqKkx2waC83GA==
X-Proofpoint-GUID: HXi_5Gw9pGjZieGqxz88tVQWCjPMQBwr
X-Authority-Analysis: v=2.4 cv=D8N37PRj c=1 sm=1 tr=0 ts=6a97ecd2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=ypSgBc5p4dm3rNKU39cA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: HXi_5Gw9pGjZieGqxz88tVQWCjPMQBwr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA4MiBTYWx0ZWRfX4Lid/8vwrcSx
 tlCaEb1CzwHntdJ4+6EblyVlBny8PIiZqTC+EZ4bkpA7rx/UdSsXXeUGxnFDq1ocXp8UHJiOtRl
 EbjZVyO5vIw4JqwNh1ES7TanBsHg/X0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020082



On 9/1/2026 2:54 PM, Sreeshankar K wrote:
> Add support for the global clock controller found on SM7250
> based devices.
> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> ---
>  drivers/clk/qcom/Kconfig      |    9 +
>  drivers/clk/qcom/Makefile     |    1 +
>  drivers/clk/qcom/gcc-sm7250.c | 2275 +++++++++++++++++++++++++++++++++
>  3 files changed, 2285 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-sm7250.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index d1fc9bf87..b1710aabe 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -1650,6 +1650,15 @@ config SM_GCC_7150
>  	  Say Y if you want to use peripheral devices such as UART,
>  	  SPI, I2C, USB, SD/UFS, PCIe etc.
>  
> +config SM_GCC_7250
> +	tristate "SM7250 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
> +	select QCOM_GDSC
> +	help
> +	  Support for the global clock controller on SM7250 devices.
> +	  Say Y if you want to use peripheral devices such as UART,
> +	  SPI, I2C, USB, SD/UFS etc.
> +
>  config SM_GCC_MILOS
>  	tristate "Milos Global Clock Controller"
>  	depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index daf25d583..bde1de0cd 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -183,6 +183,7 @@ obj-$(CONFIG_SM_GCC_6125) += gcc-sm6125.o
>  obj-$(CONFIG_SM_GCC_6350) += gcc-sm6350.o
>  obj-$(CONFIG_SM_GCC_6375) += gcc-sm6375.o
>  obj-$(CONFIG_SM_GCC_7150) += gcc-sm7150.o
> +obj-$(CONFIG_SM_GCC_7250) += gcc-sm7250.o
>  obj-$(CONFIG_SM_GCC_8150) += gcc-sm8150.o
>  obj-$(CONFIG_SM_GCC_8250) += gcc-sm8250.o
>  obj-$(CONFIG_SM_GCC_8350) += gcc-sm8350.o
> diff --git a/drivers/clk/qcom/gcc-sm7250.c b/drivers/clk/qcom/gcc-sm7250.c
> new file mode 100644
> index 000000000..37a429e31
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-sm7250.c
> @@ -0,0 +1,2275 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2026, Sreeshankar K <sreeshankar0910@gmail.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,sm7250-gcc.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "common.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +enum {
> +	DT_BI_TCXO,
> +	DT_BI_TCXO_AO,
> +	DT_SLEEP_CLK,
> +};
> +
> +enum {
> +	P_BI_TCXO,
> +	P_GPLL0_OUT_EVEN,
> +	P_GPLL0_OUT_MAIN,
> +	P_GPLL6_OUT_MAIN,
> +	P_GPLL9_OUT_MAIN,
> +	P_SLEEP_CLK,
> +};
> +
> +static struct clk_alpha_pll gpll0 = {
> +	.offset = 0x0,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr = {
> +		.enable_reg = 0x52010,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gpll0",
> +			.parent_data = &(const struct clk_parent_data){
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_fixed_lucid_ops,
> +		},
> +	},
> +};
> +
> +static const struct clk_div_table post_div_table_gpll0_out_even[] = {
> +	{ 0x1, 2 },
> +	{ }
> +};
> +
> +static struct clk_alpha_pll_postdiv gpll0_out_even = {
> +	.offset = 0x0,
> +	.post_div_shift = 8,
> +	.post_div_table = post_div_table_gpll0_out_even,
> +	.num_post_div = ARRAY_SIZE(post_div_table_gpll0_out_even),
> +	.width = 4,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gpll0_out_even",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&gpll0.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_alpha_pll_postdiv_lucid_ops,
> +	},
> +};
> +
> +static struct clk_alpha_pll gpll6 = {
> +	.offset = 0x13000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr = {
> +		.enable_reg = 0x52010,
> +		.enable_mask = BIT(6),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gpll6",
> +			.parent_data = &(const struct clk_parent_data){
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_fixed_lucid_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_alpha_pll gpll9 = {
> +	.offset = 0x1c000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr = {
> +		.enable_reg = 0x52010,
> +		.enable_mask = BIT(9),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gpll9",
> +			.parent_data = &(const struct clk_parent_data){
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_fixed_lucid_ops,
> +		},
> +	},
> +};
> +
> +static const struct parent_map gcc_parent_map_0[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPLL0_OUT_MAIN, 1 },
> +	{ P_GPLL0_OUT_EVEN, 6 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_0[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &gpll0.clkr.hw },
> +	{ .hw = &gpll0_out_even.clkr.hw },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_0_ao[] = {
> +	{ .index = DT_BI_TCXO_AO },
> +	{ .hw = &gpll0.clkr.hw },
> +	{ .hw = &gpll0_out_even.clkr.hw },

please remove gpll0 instances as we do not support any other frequencies
for cpu_ahb_clock.

> +};
> +
> +static const struct parent_map gcc_parent_map_1[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPLL0_OUT_MAIN, 1 },
> +	{ P_SLEEP_CLK, 5 },
> +	{ P_GPLL0_OUT_EVEN, 6 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_1[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &gpll0.clkr.hw },
> +	{ .index = DT_SLEEP_CLK },
> +	{ .hw = &gpll0_out_even.clkr.hw },
> +};
> +
> +static const struct parent_map gcc_parent_map_2[] = {
> +	{ P_BI_TCXO, 0 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_2[] = {
> +	{ .index = DT_BI_TCXO },
> +};
> +
> +static const struct parent_map gcc_parent_map_3[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPLL0_OUT_MAIN, 1 },
> +	{ P_GPLL6_OUT_MAIN, 2 },
> +	{ P_GPLL0_OUT_EVEN, 6 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_3[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &gpll0.clkr.hw },
> +	{ .hw = &gpll6.clkr.hw },
> +	{ .hw = &gpll0_out_even.clkr.hw },
> +};
> +
> +static const struct parent_map gcc_parent_map_4[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPLL0_OUT_MAIN, 1 },
> +	{ P_GPLL9_OUT_MAIN, 2 },
> +	{ P_GPLL0_OUT_EVEN, 6 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_4[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &gpll0.clkr.hw },
> +	{ .hw = &gpll9.clkr.hw },
> +	{ .hw = &gpll0_out_even.clkr.hw },
> +};
> +
> +static const struct parent_map gcc_parent_map_5[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_SLEEP_CLK, 5 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_5[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_SLEEP_CLK },
> +};
> +
> +static const struct freq_tbl ftbl_gcc_cpuss_ahb_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),

use DT_BI_TCXO_AO

> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_cpuss_ahb_clk_src = {
> +	.cmd_rcgr = 0x48010,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_cpuss_ahb_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_cpuss_ahb_clk_src",
> +		.parent_data = gcc_parent_data_0_ao,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0_ao),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_gp1_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(25000000, P_GPLL0_OUT_EVEN, 12, 0, 0),
> +	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
> +	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
> +	F(200000000, P_GPLL0_OUT_MAIN, 3, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_gp1_clk_src = {
> +	.cmd_rcgr = 0x64004,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_1,
> +	.freq_tbl = ftbl_gcc_gp1_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_gp1_clk_src",
> +		.parent_data = gcc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_gp2_clk_src = {
> +	.cmd_rcgr = 0x65004,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_1,
> +	.freq_tbl = ftbl_gcc_gp1_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_gp2_clk_src",
> +		.parent_data = gcc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_gp3_clk_src = {
> +	.cmd_rcgr = 0x66004,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_1,
> +	.freq_tbl = ftbl_gcc_gp1_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_gp3_clk_src",
> +		.parent_data = gcc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
> +	F(9600000, P_BI_TCXO, 2, 0, 0),
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(60000000, P_GPLL0_OUT_MAIN, 10, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_pdm2_clk_src = {
> +	.cmd_rcgr = 0x33010,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_pdm2_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_pdm2_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
> +	F(7372800, P_GPLL0_OUT_EVEN, 1, 384, 15625),
> +	F(14745600, P_GPLL0_OUT_EVEN, 1, 768, 15625),
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(29491200, P_GPLL0_OUT_EVEN, 1, 1536, 15625),
> +	F(32000000, P_GPLL0_OUT_EVEN, 1, 8, 75),
> +	F(48000000, P_GPLL0_OUT_EVEN, 1, 4, 25),
> +	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
> +	F(64000000, P_GPLL0_OUT_EVEN, 1, 16, 75),
> +	F(75000000, P_GPLL0_OUT_EVEN, 4, 0, 0),
> +	F(80000000, P_GPLL0_OUT_EVEN, 1, 4, 15),
> +	F(96000000, P_GPLL0_OUT_EVEN, 1, 8, 25),
> +	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
> +	F(102400000, P_GPLL0_OUT_EVEN, 1, 128, 375),
> +	F(112000000, P_GPLL0_OUT_EVEN, 1, 28, 75),
> +	F(117964800, P_GPLL0_OUT_EVEN, 1, 6144, 15625),
> +	F(120000000, P_GPLL0_OUT_EVEN, 2.5, 0, 0),
> +	F(128000000, P_GPLL0_OUT_MAIN, 1, 16, 75),
> +	{ }
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
> +	.name = "gcc_qupv3_wrap0_s0_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
> +	.cmd_rcgr = 0x17010,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap0_s0_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
> +	.name = "gcc_qupv3_wrap0_s1_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
> +	.cmd_rcgr = 0x17140,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap0_s1_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
> +	.name = "gcc_qupv3_wrap0_s2_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
> +	.cmd_rcgr = 0x17270,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap0_s2_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
> +	.name = "gcc_qupv3_wrap0_s3_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
> +	.cmd_rcgr = 0x173a0,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap0_s3_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
> +	.name = "gcc_qupv3_wrap0_s4_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
> +	.cmd_rcgr = 0x174d0,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap0_s4_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap0_s5_clk_src_init = {
> +	.name = "gcc_qupv3_wrap0_s5_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
> +	.cmd_rcgr = 0x17600,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap0_s5_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap1_s0_clk_src_init = {
> +	.name = "gcc_qupv3_wrap1_s0_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
> +	.cmd_rcgr = 0x18010,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap1_s0_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap1_s1_clk_src_init = {
> +	.name = "gcc_qupv3_wrap1_s1_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
> +	.cmd_rcgr = 0x18140,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap1_s1_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap1_s2_clk_src_init = {
> +	.name = "gcc_qupv3_wrap1_s2_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
> +	.cmd_rcgr = 0x18270,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap1_s2_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap1_s3_clk_src_init = {
> +	.name = "gcc_qupv3_wrap1_s3_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
> +	.cmd_rcgr = 0x183a0,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap1_s3_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap1_s4_clk_src_init = {
> +	.name = "gcc_qupv3_wrap1_s4_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
> +	.cmd_rcgr = 0x184d0,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap1_s4_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap1_s5_clk_src_init = {
> +	.name = "gcc_qupv3_wrap1_s5_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
> +	.cmd_rcgr = 0x18600,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap1_s5_clk_src_init,
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
> +	F(144000, P_BI_TCXO, 16, 3, 25),
> +	F(400000, P_BI_TCXO, 12, 1, 4),
> +	F(20000000, P_GPLL0_OUT_EVEN, 5, 1, 3),
> +	F(25000000, P_GPLL0_OUT_EVEN, 6, 1, 2),
> +	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
> +	F(100000000, P_GPLL0_OUT_EVEN, 3, 0, 0),
> +	F(192000000, P_GPLL6_OUT_MAIN, 2, 0, 0),
> +	F(384000000, P_GPLL6_OUT_MAIN, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_sdcc1_apps_clk_src = {
> +	.cmd_rcgr = 0x26024,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_3,
> +	.freq_tbl = ftbl_gcc_sdcc1_apps_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_sdcc1_apps_clk_src",
> +		.parent_data = gcc_parent_data_3,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
> +		.flags = CLK_OPS_PARENT_ENABLE,
> +		.ops = &clk_rcg2_floor_ops,
> +	},
> +};
> +
> +
> +static const struct freq_tbl ftbl_gcc_sdcc1_ice_core_clk_src[] = {
> +	F(100000000, P_GPLL0_OUT_EVEN, 3, 0, 0),
> +	F(150000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
> +	F(300000000, P_GPLL0_OUT_MAIN, 2, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src = {
> +	.cmd_rcgr = 0x2600c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_sdcc1_ice_core_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_sdcc1_ice_core_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_OPS_PARENT_ENABLE,

Why did you add this?

> +		.ops = &clk_rcg2_floor_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
> +	F(400000, P_BI_TCXO, 12, 1, 4),
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(25000000, P_GPLL0_OUT_EVEN, 6, 1, 2),
> +	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
> +	F(100000000, P_GPLL0_OUT_EVEN, 3, 0, 0),
> +	F(202000000, P_GPLL9_OUT_MAIN, 4, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
> +	.cmd_rcgr = 0x1400c,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_4,
> +	.freq_tbl = ftbl_gcc_sdcc2_apps_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_sdcc2_apps_clk_src",
> +		.parent_data = gcc_parent_data_4,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
> +		.flags = CLK_OPS_PARENT_ENABLE,

same here?

> +		.ops = &clk_rcg2_floor_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc4_apps_clk_src[] = {
> +	F(400000, P_BI_TCXO, 12, 1, 4),
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(25000000, P_GPLL0_OUT_EVEN, 6, 1, 2),
> +	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
> +	F(100000000, P_GPLL0_OUT_EVEN, 3, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
> +	.cmd_rcgr = 0x1600c,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_sdcc4_apps_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_sdcc4_apps_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.ops = &clk_rcg2_floor_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
> +	F(25000000, P_GPLL0_OUT_EVEN, 12, 0, 0),
> +	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
> +	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
> +	F(200000000, P_GPLL0_OUT_MAIN, 3, 0, 0),
> +	F(240000000, P_GPLL0_OUT_MAIN, 2.5, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
> +	.cmd_rcgr = 0x77024,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_ufs_phy_axi_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_ufs_phy_axi_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.ops = &clk_rcg2_ops,

Please use clk_rcg2_shared_ops...

> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_ufs_phy_ice_core_clk_src[] = {
> +	F(37500000, P_GPLL0_OUT_EVEN, 8, 0, 0),
> +	F(75000000, P_GPLL0_OUT_EVEN, 4, 0, 0),
> +	F(150000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
> +	F(300000000, P_GPLL0_OUT_MAIN, 2, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
> +	.cmd_rcgr = 0x7706c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_ufs_phy_ice_core_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_ufs_phy_ice_core_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.ops = &clk_rcg2_ops,

clk_rcg2_shared_ops

> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_ufs_phy_phy_aux_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_ufs_phy_phy_aux_clk_src = {
> +	.cmd_rcgr = 0x770a0,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_2,
> +	.freq_tbl = ftbl_gcc_ufs_phy_phy_aux_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_ufs_phy_phy_aux_clk_src",
> +		.parent_data = gcc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
> +		.ops = &clk_rcg2_ops,

clk_rcg2_shared_ops

> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
> +	F(37500000, P_GPLL0_OUT_EVEN, 8, 0, 0),
> +	F(75000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
> +	F(150000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
> +	.cmd_rcgr = 0x77084,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_ufs_phy_unipro_core_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_ufs_phy_unipro_core_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
> +	F(66666667, P_GPLL0_OUT_EVEN, 4.5, 0, 0),
> +	F(133333333, P_GPLL0_OUT_MAIN, 4.5, 0, 0),
> +	F(200000000, P_GPLL0_OUT_MAIN, 3, 0, 0),
> +	F(240000000, P_GPLL0_OUT_MAIN, 2.5, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
> +	.cmd_rcgr = 0xf020,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_usb30_prim_master_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_usb30_prim_master_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.ops = &clk_rcg2_ops,

clk_rcg2_shared_ops

> +	},
> +};
> +
> +static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
> +	.cmd_rcgr = 0xf038,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_ufs_phy_phy_aux_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_usb30_prim_mock_utmi_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.ops = &clk_rcg2_ops,

clk_rcg2_shared_ops

> +	},
> +};
> +
> +static struct clk_rcg2 gcc_usb3_prim_phy_aux_clk_src = {
> +	.cmd_rcgr = 0xf064,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_5,
> +	.freq_tbl = ftbl_gcc_ufs_phy_phy_aux_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data){
> +		.name = "gcc_usb3_prim_phy_aux_clk_src",
> +		.parent_data = gcc_parent_data_5,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
> +		.ops = &clk_rcg2_ops,

clk_rcg2_shared_ops

> +	},
> +};
> +
> +static struct clk_branch gcc_aggre_ufs_phy_axi_clk = {
> +	.halt_reg = 0x770cc,
> +	.halt_check = BRANCH_HALT_VOTED,

Reason to use HALT_VOTED?

> +	.hwcg_reg = 0x770cc,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x770cc,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_aggre_ufs_phy_axi_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_ufs_phy_axi_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_aggre_usb3_prim_axi_clk = {
> +	.halt_reg = 0xf080,
> +	.halt_check = BRANCH_HALT_VOTED,

Any reason to use HALT_VOTED?

> +	.clkr = {
> +		.enable_reg = 0xf080,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_aggre_usb3_prim_axi_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_usb30_prim_master_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_boot_rom_ahb_clk = {
> +	.halt_reg = 0x38004,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.hwcg_reg = 0x38004,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x52000,
> +		.enable_mask = BIT(10),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_boot_rom_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camera_hf_axi_clk = {
> +	.halt_reg = 0xb028,
> +	.halt_check = BRANCH_HALT_VOTED,

If you use HALT_VOTED, it is a problem as this clock should be actually
enabled for the further camera to be operational.

> +	.clkr = {
> +		.enable_reg = 0xb028,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_camera_hf_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camera_sf_axi_clk = {
> +	.halt_reg = 0xb02c,
> +	.halt_check = BRANCH_HALT_VOTED,

Same here. The camera SW driver needs to vote on BW and then this clock
needs to be turned ON.

> +	.clkr = {
> +		.enable_reg = 0xb02c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_camera_sf_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_cfg_noc_usb3_prim_axi_clk = {
> +	.halt_reg = 0xf07c,
> +	.halt_check = BRANCH_HALT_VOTED,

Please do not use VOTED.

> +	.clkr = {
> +		.enable_reg = 0xf07c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_cfg_noc_usb3_prim_axi_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_usb30_prim_master_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_cpuss_gnoc_clk = {
> +	.halt_reg = 0x48064,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52000,
> +		.enable_mask = BIT(29),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_cpuss_gnoc_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_cpuss_rbcpr_clk = {
> +	.halt_reg = 0x48004,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x48004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_cpuss_rbcpr_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_ddrss_gpu_axi_clk = {
> +	.halt_reg = 0x71154,
> +	.halt_check = BRANCH_HALT_VOTED,

BRANCH_VOTED (we do not check the HALT bit any time).

> +	.clkr = {
> +		.enable_reg = 0x71154,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_ddrss_gpu_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_disp_gpll0_clk_src = {
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x52000,
> +		.enable_mask = BIT(20),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_disp_gpll0_clk_src",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gpll0.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_disp_hf_axi_clk = {
> +	.halt_reg = 0xb030,
> +	.halt_check = BRANCH_HALT_VOTED,

BRANCH_HALT

> +	.clkr = {
> +		.enable_reg = 0xb030,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_disp_hf_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_disp_sf_axi_clk = {
> +	.halt_reg = 0xb034,
> +	.halt_check = BRANCH_HALT_VOTED,

BRANCH_HALT

> +	.clkr = {
> +		.enable_reg = 0xb034,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_disp_sf_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_gp1_clk = {
> +	.halt_reg = 0x64000,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x64000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_gp1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_gp1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_gp2_clk = {
> +	.halt_reg = 0x65000,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x65000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_gp2_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_gp2_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_gp3_clk = {
> +	.halt_reg = 0x66000,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x66000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_gp3_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_gp3_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_gpu_gpll0_clk_src = {
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x52000,
> +		.enable_mask = BIT(15),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_gpu_gpll0_clk_src",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gpll0.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_gpu_gpll0_div_clk_src = {
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x52000,
> +		.enable_mask = BIT(16),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_gpu_gpll0_div_clk_src",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gpll0_out_even.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_gpu_iref_clk = {
> +	.halt_reg = 0x8c014,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8c014,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_gpu_iref_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_gpu_memnoc_gfx_clk = {
> +	.halt_reg = 0x7100c,
> +	.halt_check = BRANCH_HALT_VOTED,

BRANCH_VOTED

> +	.clkr = {
> +		.enable_reg = 0x7100c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_gpu_memnoc_gfx_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_gpu_snoc_dvm_gfx_clk = {
> +	.halt_reg = 0x71018,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x71018,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_gpu_snoc_dvm_gfx_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_npu_axi_clk = {
> +	.halt_reg = 0x4d008,
> +	.halt_check = BRANCH_HALT_VOTED,

Can you help me understand why we moved all the halt_checks from what is
there in the downstream driver?

> +	.clkr = {
> +		.enable_reg = 0x4d008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_npu_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_npu_bwmon2_axi_clk = {
> +	.halt_reg = 0x7000c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x7000c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_npu_bwmon2_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_npu_bwmon_axi_clk = {
> +	.halt_reg = 0x70008,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x70008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_npu_bwmon_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_npu_dma_clk = {
> +	.halt_reg = 0x4d00c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x4d00c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_npu_dma_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_npu_gpll0_clk_src = {
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x52000,
> +		.enable_mask = BIT(18),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_npu_gpll0_clk_src",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gpll0.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_npu_gpll0_div_clk_src = {
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x52000,
> +		.enable_mask = BIT(19),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_npu_gpll0_div_clk_src",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gpll0_out_even.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_pdm2_clk = {
> +	.halt_reg = 0x3300c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x3300c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_pdm2_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_pdm2_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_pdm_ahb_clk = {
> +	.halt_reg = 0x33004,
> +	.halt_check = BRANCH_HALT,
> +	.hwcg_reg = 0x33004,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x33004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_pdm_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_pdm_xo4_clk = {
> +	.halt_reg = 0x33008,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x33008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_pdm_xo4_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_prng_ahb_clk = {
> +	.halt_reg = 0x34004,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52000,
> +		.enable_mask = BIT(13),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_prng_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qmip_camera_nrt_ahb_clk = {
> +	.halt_reg = 0xb018,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.hwcg_reg = 0xb018,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0xb018,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qmip_camera_nrt_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qmip_camera_rt_ahb_clk = {
> +	.halt_reg = 0xb01c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.hwcg_reg = 0xb01c,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0xb01c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qmip_camera_rt_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qmip_disp_ahb_clk = {
> +	.halt_reg = 0xb020,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.hwcg_reg = 0xb020,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0xb020,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qmip_disp_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qmip_rt_disp_ahb_clk = {
> +	.halt_reg = 0xb07c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.hwcg_reg = 0xb07c,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0xb07c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qmip_rt_disp_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qmip_video_cvp_ahb_clk = {
> +	.halt_reg = 0xb010,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.hwcg_reg = 0xb010,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0xb010,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qmip_video_cvp_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qmip_video_vcodec_ahb_clk = {
> +	.halt_reg = 0xb014,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.hwcg_reg = 0xb014,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0xb014,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qmip_video_vcodec_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap0_core_2x_clk = {
> +	.halt_reg = 0x23008,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(9),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap0_core_2x_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap0_core_clk = {
> +	.halt_reg = 0x23000,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(8),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap0_core_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap0_s0_clk = {
> +	.halt_reg = 0x1700c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(10),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap0_s0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_qupv3_wrap0_s0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap0_s1_clk = {
> +	.halt_reg = 0x1713c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(11),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap0_s1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_qupv3_wrap0_s1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap0_s2_clk = {
> +	.halt_reg = 0x1726c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(12),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap0_s2_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_qupv3_wrap0_s2_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap0_s3_clk = {
> +	.halt_reg = 0x1739c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(13),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap0_s3_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_qupv3_wrap0_s3_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap0_s4_clk = {
> +	.halt_reg = 0x174cc,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(14),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap0_s4_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_qupv3_wrap0_s4_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap0_s5_clk = {
> +	.halt_reg = 0x175fc,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(15),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap0_s5_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_qupv3_wrap0_s5_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap1_core_2x_clk = {
> +	.halt_reg = 0x23140,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(18),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap1_core_2x_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap1_core_clk = {
> +	.halt_reg = 0x23138,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(19),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap1_core_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap1_s0_clk = {
> +	.halt_reg = 0x1800c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(22),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap1_s0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_qupv3_wrap1_s0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap1_s1_clk = {
> +	.halt_reg = 0x1813c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(23),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap1_s1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_qupv3_wrap1_s1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap1_s2_clk = {
> +	.halt_reg = 0x1826c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(24),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap1_s2_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_qupv3_wrap1_s2_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap1_s3_clk = {
> +	.halt_reg = 0x1839c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(25),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap1_s3_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_qupv3_wrap1_s3_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap1_s4_clk = {
> +	.halt_reg = 0x184cc,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(26),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap1_s4_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_qupv3_wrap1_s4_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap1_s5_clk = {
> +	.halt_reg = 0x185fc,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(27),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap1_s5_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_qupv3_wrap1_s5_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap_0_m_ahb_clk = {
> +	.halt_reg = 0x17004,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(6),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap_0_m_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap_0_s_ahb_clk = {
> +	.halt_reg = 0x17008,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.hwcg_reg = 0x17008,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(7),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap_0_s_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap_1_m_ahb_clk = {
> +	.halt_reg = 0x18004,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(20),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap_1_m_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qupv3_wrap_1_s_ahb_clk = {
> +	.halt_reg = 0x18008,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.hwcg_reg = 0x18008,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x52008,
> +		.enable_mask = BIT(21),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_qupv3_wrap_1_s_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_sdcc1_ahb_clk = {
> +	.halt_reg = 0x26004,
> +	.halt_check = BRANCH_HALT,
> +	.hwcg_reg = 0x26004,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x26004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_sdcc1_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_sdcc1_apps_clk = {
> +	.halt_reg = 0x26008,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x26008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_sdcc1_apps_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_sdcc1_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_sdcc1_ice_core_clk = {
> +	.halt_reg = 0x2603c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2603c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_sdcc1_ice_core_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_sdcc1_ice_core_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_sdcc2_ahb_clk = {
> +	.halt_reg = 0x14008,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x14008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_sdcc2_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_sdcc2_apps_clk = {
> +	.halt_reg = 0x14004,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x14004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_sdcc2_apps_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_sdcc2_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_sdcc4_ahb_clk = {
> +	.halt_reg = 0x16008,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x16008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_sdcc4_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_sdcc4_apps_clk = {
> +	.halt_reg = 0x16004,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x16004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_sdcc4_apps_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_sdcc4_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_ufs_1x_clkref_clk = {
> +	.halt_reg = 0x8c000,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8c000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_ufs_1x_clkref_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_ufs_phy_ahb_clk = {
> +	.halt_reg = 0x77018,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.hwcg_reg = 0x77018,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x77018,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_ufs_phy_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_ufs_phy_axi_clk = {
> +	.halt_reg = 0x77010,
> +	.halt_check = BRANCH_HALT,
> +	.hwcg_reg = 0x77010,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x77010,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_ufs_phy_axi_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_ufs_phy_axi_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_ufs_phy_ice_core_clk = {
> +	.halt_reg = 0x77064,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.hwcg_reg = 0x77064,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x77064,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_ufs_phy_ice_core_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_ufs_phy_ice_core_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_ufs_phy_phy_aux_clk = {
> +	.halt_reg = 0x7709c,
> +	.halt_check = BRANCH_HALT,
> +	.hwcg_reg = 0x7709c,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x7709c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_ufs_phy_phy_aux_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_ufs_phy_phy_aux_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_ufs_phy_rx_symbol_0_clk = {
> +	.halt_reg = 0x77020,
> +	.halt_check = BRANCH_HALT_SKIP,
> +	.clkr = {
> +		.enable_reg = 0x77020,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_ufs_phy_rx_symbol_0_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_ufs_phy_rx_symbol_1_clk = {
> +	.halt_reg = 0x770b8,
> +	.halt_check = BRANCH_HALT_SKIP,
> +	.clkr = {
> +		.enable_reg = 0x770b8,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_ufs_phy_rx_symbol_1_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_ufs_phy_tx_symbol_0_clk = {
> +	.halt_reg = 0x7701c,
> +	.halt_check = BRANCH_HALT_SKIP,
> +	.clkr = {
> +		.enable_reg = 0x7701c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_ufs_phy_tx_symbol_0_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_ufs_phy_unipro_core_clk = {
> +	.halt_reg = 0x7705c,
> +	.halt_check = BRANCH_HALT,
> +	.hwcg_reg = 0x7705c,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x7705c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_ufs_phy_unipro_core_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_ufs_phy_unipro_core_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_usb30_prim_master_clk = {
> +	.halt_reg = 0xf010,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0xf010,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_usb30_prim_master_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_usb30_prim_master_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_usb30_prim_mock_utmi_clk = {
> +	.halt_reg = 0xf01c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0xf01c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_usb30_prim_mock_utmi_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&gcc_usb30_prim_mock_utmi_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_usb30_prim_sleep_clk = {
> +	.halt_reg = 0xf018,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0xf018,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_usb30_prim_sleep_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_usb3_prim_clkref_clk = {
> +	.halt_reg = 0x8c010,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8c010,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_usb3_prim_clkref_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_usb3_prim_phy_aux_clk = {
> +	.halt_reg = 0xf054,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0xf054,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_usb3_prim_phy_aux_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_usb3_prim_phy_aux_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_usb3_prim_phy_com_aux_clk = {
> +	.halt_reg = 0xf058,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0xf058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_usb3_prim_phy_com_aux_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_usb3_prim_phy_aux_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
> +	.halt_reg = 0xf05c,
> +	.halt_check = BRANCH_HALT_SKIP,
> +	.clkr = {
> +		.enable_reg = 0xf05c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_usb3_prim_phy_pipe_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_video_axi_clk = {
> +	.halt_reg = 0xb080,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0xb080,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gcc_video_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct gdsc ufs_phy_gdsc = {
> +	.gdscr = 0x77004,
> +	.pd = {
> +		.name = "ufs_phy_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
> +static struct gdsc usb30_prim_gdsc = {
> +	.gdscr = 0xf004,
> +	.pd = {
> +		.name = "usb30_prim_gdsc",
> +	},
> +	.pwrsts = PWRSTS_RET_ON,
> +};
> +
> +static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc = {
> +	.gdscr = 0x7d050,
> +	.pd = {
> +		.name = "hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = VOTABLE,
> +};
> +
> +static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc = {
> +	.gdscr = 0x7d058,
> +	.pd = {
> +		.name = "hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = VOTABLE,
> +};
> +
> +static struct gdsc hlos1_vote_mmnoc_mmu_tbu_sf0_gdsc = {
> +	.gdscr = 0x7d054,
> +	.pd = {
> +		.name = "hlos1_vote_mmnoc_mmu_tbu_sf0_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = VOTABLE,
> +};
> +
> +static struct clk_regmap *gcc_sm7250_clocks[] = {
> +	[GCC_AGGRE_UFS_PHY_AXI_CLK] = &gcc_aggre_ufs_phy_axi_clk.clkr,
> +	[GCC_AGGRE_USB3_PRIM_AXI_CLK] = &gcc_aggre_usb3_prim_axi_clk.clkr,
> +	[GCC_BOOT_ROM_AHB_CLK] = &gcc_boot_rom_ahb_clk.clkr,
> +	[GCC_CAMERA_HF_AXI_CLK] = &gcc_camera_hf_axi_clk.clkr,
> +	[GCC_CAMERA_SF_AXI_CLK] = &gcc_camera_sf_axi_clk.clkr,
> +	[GCC_CFG_NOC_USB3_PRIM_AXI_CLK] = &gcc_cfg_noc_usb3_prim_axi_clk.clkr,
> +	[GCC_CPUSS_AHB_CLK_SRC] = &gcc_cpuss_ahb_clk_src.clkr,
> +	[GCC_CPUSS_GNOC_CLK] = &gcc_cpuss_gnoc_clk.clkr,
> +	[GCC_CPUSS_RBCPR_CLK] = &gcc_cpuss_rbcpr_clk.clkr,
> +	[GCC_DDRSS_GPU_AXI_CLK] = &gcc_ddrss_gpu_axi_clk.clkr,
> +	[GCC_DISP_GPLL0_CLK_SRC] = &gcc_disp_gpll0_clk_src.clkr,
> +	[GCC_DISP_HF_AXI_CLK] = &gcc_disp_hf_axi_clk.clkr,
> +	[GCC_DISP_SF_AXI_CLK] = &gcc_disp_sf_axi_clk.clkr,
> +	[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
> +	[GCC_GP1_CLK_SRC] = &gcc_gp1_clk_src.clkr,
> +	[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
> +	[GCC_GP2_CLK_SRC] = &gcc_gp2_clk_src.clkr,
> +	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
> +	[GCC_GP3_CLK_SRC] = &gcc_gp3_clk_src.clkr,
> +	[GCC_GPU_GPLL0_CLK_SRC] = &gcc_gpu_gpll0_clk_src.clkr,
> +	[GCC_GPU_GPLL0_DIV_CLK_SRC] = &gcc_gpu_gpll0_div_clk_src.clkr,
> +	[GCC_GPU_IREF_CLK] = &gcc_gpu_iref_clk.clkr,
> +	[GCC_GPU_MEMNOC_GFX_CLK] = &gcc_gpu_memnoc_gfx_clk.clkr,
> +	[GCC_GPU_SNOC_DVM_GFX_CLK] = &gcc_gpu_snoc_dvm_gfx_clk.clkr,
> +	[GCC_NPU_AXI_CLK] = &gcc_npu_axi_clk.clkr,
> +	[GCC_NPU_BWMON2_AXI_CLK] = &gcc_npu_bwmon2_axi_clk.clkr,
> +	[GCC_NPU_BWMON_AXI_CLK] = &gcc_npu_bwmon_axi_clk.clkr,
> +	[GCC_NPU_DMA_CLK] = &gcc_npu_dma_clk.clkr,
> +	[GCC_NPU_GPLL0_CLK_SRC] = &gcc_npu_gpll0_clk_src.clkr,
> +	[GCC_NPU_GPLL0_DIV_CLK_SRC] = &gcc_npu_gpll0_div_clk_src.clkr,
> +	[GCC_PDM2_CLK] = &gcc_pdm2_clk.clkr,
> +	[GCC_PDM2_CLK_SRC] = &gcc_pdm2_clk_src.clkr,
> +	[GCC_PDM_AHB_CLK] = &gcc_pdm_ahb_clk.clkr,
> +	[GCC_PDM_XO4_CLK] = &gcc_pdm_xo4_clk.clkr,
> +	[GCC_PRNG_AHB_CLK] = &gcc_prng_ahb_clk.clkr,
> +	[GCC_QMIP_CAMERA_NRT_AHB_CLK] = &gcc_qmip_camera_nrt_ahb_clk.clkr,
> +	[GCC_QMIP_CAMERA_RT_AHB_CLK] = &gcc_qmip_camera_rt_ahb_clk.clkr,
> +	[GCC_QMIP_DISP_AHB_CLK] = &gcc_qmip_disp_ahb_clk.clkr,
> +	[GCC_QMIP_RT_DISP_AHB_CLK] = &gcc_qmip_rt_disp_ahb_clk.clkr,
> +	[GCC_QMIP_VIDEO_CVP_AHB_CLK] = &gcc_qmip_video_cvp_ahb_clk.clkr,
> +	[GCC_QMIP_VIDEO_VCODEC_AHB_CLK] = &gcc_qmip_video_vcodec_ahb_clk.clkr,
> +	[GCC_QUPV3_WRAP0_CORE_2X_CLK] = &gcc_qupv3_wrap0_core_2x_clk.clkr,
> +	[GCC_QUPV3_WRAP0_CORE_CLK] = &gcc_qupv3_wrap0_core_clk.clkr,
> +	[GCC_QUPV3_WRAP0_S0_CLK] = &gcc_qupv3_wrap0_s0_clk.clkr,
> +	[GCC_QUPV3_WRAP0_S0_CLK_SRC] = &gcc_qupv3_wrap0_s0_clk_src.clkr,
> +	[GCC_QUPV3_WRAP0_S1_CLK] = &gcc_qupv3_wrap0_s1_clk.clkr,
> +	[GCC_QUPV3_WRAP0_S1_CLK_SRC] = &gcc_qupv3_wrap0_s1_clk_src.clkr,
> +	[GCC_QUPV3_WRAP0_S2_CLK] = &gcc_qupv3_wrap0_s2_clk.clkr,
> +	[GCC_QUPV3_WRAP0_S2_CLK_SRC] = &gcc_qupv3_wrap0_s2_clk_src.clkr,
> +	[GCC_QUPV3_WRAP0_S3_CLK] = &gcc_qupv3_wrap0_s3_clk.clkr,
> +	[GCC_QUPV3_WRAP0_S3_CLK_SRC] = &gcc_qupv3_wrap0_s3_clk_src.clkr,
> +	[GCC_QUPV3_WRAP0_S4_CLK] = &gcc_qupv3_wrap0_s4_clk.clkr,
> +	[GCC_QUPV3_WRAP0_S4_CLK_SRC] = &gcc_qupv3_wrap0_s4_clk_src.clkr,
> +	[GCC_QUPV3_WRAP0_S5_CLK] = &gcc_qupv3_wrap0_s5_clk.clkr,
> +	[GCC_QUPV3_WRAP0_S5_CLK_SRC] = &gcc_qupv3_wrap0_s5_clk_src.clkr,
> +	[GCC_QUPV3_WRAP1_CORE_2X_CLK] = &gcc_qupv3_wrap1_core_2x_clk.clkr,
> +	[GCC_QUPV3_WRAP1_CORE_CLK] = &gcc_qupv3_wrap1_core_clk.clkr,
> +	[GCC_QUPV3_WRAP1_S0_CLK] = &gcc_qupv3_wrap1_s0_clk.clkr,
> +	[GCC_QUPV3_WRAP1_S0_CLK_SRC] = &gcc_qupv3_wrap1_s0_clk_src.clkr,
> +	[GCC_QUPV3_WRAP1_S1_CLK] = &gcc_qupv3_wrap1_s1_clk.clkr,
> +	[GCC_QUPV3_WRAP1_S1_CLK_SRC] = &gcc_qupv3_wrap1_s1_clk_src.clkr,
> +	[GCC_QUPV3_WRAP1_S2_CLK] = &gcc_qupv3_wrap1_s2_clk.clkr,
> +	[GCC_QUPV3_WRAP1_S2_CLK_SRC] = &gcc_qupv3_wrap1_s2_clk_src.clkr,
> +	[GCC_QUPV3_WRAP1_S3_CLK] = &gcc_qupv3_wrap1_s3_clk.clkr,
> +	[GCC_QUPV3_WRAP1_S3_CLK_SRC] = &gcc_qupv3_wrap1_s3_clk_src.clkr,
> +	[GCC_QUPV3_WRAP1_S4_CLK] = &gcc_qupv3_wrap1_s4_clk.clkr,
> +	[GCC_QUPV3_WRAP1_S4_CLK_SRC] = &gcc_qupv3_wrap1_s4_clk_src.clkr,
> +	[GCC_QUPV3_WRAP1_S5_CLK] = &gcc_qupv3_wrap1_s5_clk.clkr,
> +	[GCC_QUPV3_WRAP1_S5_CLK_SRC] = &gcc_qupv3_wrap1_s5_clk_src.clkr,
> +	[GCC_QUPV3_WRAP_0_M_AHB_CLK] = &gcc_qupv3_wrap_0_m_ahb_clk.clkr,
> +	[GCC_QUPV3_WRAP_0_S_AHB_CLK] = &gcc_qupv3_wrap_0_s_ahb_clk.clkr,
> +	[GCC_QUPV3_WRAP_1_M_AHB_CLK] = &gcc_qupv3_wrap_1_m_ahb_clk.clkr,
> +	[GCC_QUPV3_WRAP_1_S_AHB_CLK] = &gcc_qupv3_wrap_1_s_ahb_clk.clkr,
> +	[GCC_SDCC1_AHB_CLK] = &gcc_sdcc1_ahb_clk.clkr,
> +	[GCC_SDCC1_APPS_CLK] = &gcc_sdcc1_apps_clk.clkr,
> +	[GCC_SDCC1_APPS_CLK_SRC] = &gcc_sdcc1_apps_clk_src.clkr,
> +	[GCC_SDCC1_ICE_CORE_CLK] = &gcc_sdcc1_ice_core_clk.clkr,
> +	[GCC_SDCC1_ICE_CORE_CLK_SRC] = &gcc_sdcc1_ice_core_clk_src.clkr,
> +	[GCC_SDCC2_AHB_CLK] = &gcc_sdcc2_ahb_clk.clkr,
> +	[GCC_SDCC2_APPS_CLK] = &gcc_sdcc2_apps_clk.clkr,
> +	[GCC_SDCC2_APPS_CLK_SRC] = &gcc_sdcc2_apps_clk_src.clkr,
> +	[GCC_SDCC4_AHB_CLK] = &gcc_sdcc4_ahb_clk.clkr,
> +	[GCC_SDCC4_APPS_CLK] = &gcc_sdcc4_apps_clk.clkr,
> +	[GCC_SDCC4_APPS_CLK_SRC] = &gcc_sdcc4_apps_clk_src.clkr,
> +	[GCC_UFS_1X_CLKREF_CLK] = &gcc_ufs_1x_clkref_clk.clkr,
> +	[GCC_UFS_PHY_AHB_CLK] = &gcc_ufs_phy_ahb_clk.clkr,
> +	[GCC_UFS_PHY_AXI_CLK] = &gcc_ufs_phy_axi_clk.clkr,
> +	[GCC_UFS_PHY_AXI_CLK_SRC] = &gcc_ufs_phy_axi_clk_src.clkr,
> +	[GCC_UFS_PHY_ICE_CORE_CLK] = &gcc_ufs_phy_ice_core_clk.clkr,
> +	[GCC_UFS_PHY_ICE_CORE_CLK_SRC] = &gcc_ufs_phy_ice_core_clk_src.clkr,
> +	[GCC_UFS_PHY_PHY_AUX_CLK] = &gcc_ufs_phy_phy_aux_clk.clkr,
> +	[GCC_UFS_PHY_PHY_AUX_CLK_SRC] = &gcc_ufs_phy_phy_aux_clk_src.clkr,
> +	[GCC_UFS_PHY_RX_SYMBOL_0_CLK] = &gcc_ufs_phy_rx_symbol_0_clk.clkr,
> +	[GCC_UFS_PHY_RX_SYMBOL_1_CLK] = &gcc_ufs_phy_rx_symbol_1_clk.clkr,
> +	[GCC_UFS_PHY_TX_SYMBOL_0_CLK] = &gcc_ufs_phy_tx_symbol_0_clk.clkr,
> +	[GCC_UFS_PHY_UNIPRO_CORE_CLK] = &gcc_ufs_phy_unipro_core_clk.clkr,
> +	[GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC] =
> +		&gcc_ufs_phy_unipro_core_clk_src.clkr,
> +	[GCC_USB30_PRIM_MASTER_CLK] = &gcc_usb30_prim_master_clk.clkr,
> +	[GCC_USB30_PRIM_MASTER_CLK_SRC] = &gcc_usb30_prim_master_clk_src.clkr,
> +	[GCC_USB30_PRIM_MOCK_UTMI_CLK] = &gcc_usb30_prim_mock_utmi_clk.clkr,
> +	[GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC] =
> +		&gcc_usb30_prim_mock_utmi_clk_src.clkr,
> +	[GCC_USB30_PRIM_SLEEP_CLK] = &gcc_usb30_prim_sleep_clk.clkr,
> +	[GCC_USB3_PRIM_CLKREF_CLK] = &gcc_usb3_prim_clkref_clk.clkr,
> +	[GCC_USB3_PRIM_PHY_AUX_CLK] = &gcc_usb3_prim_phy_aux_clk.clkr,
> +	[GCC_USB3_PRIM_PHY_AUX_CLK_SRC] = &gcc_usb3_prim_phy_aux_clk_src.clkr,
> +	[GCC_USB3_PRIM_PHY_COM_AUX_CLK] = &gcc_usb3_prim_phy_com_aux_clk.clkr,
> +	[GCC_USB3_PRIM_PHY_PIPE_CLK] = &gcc_usb3_prim_phy_pipe_clk.clkr,
> +	[GCC_VIDEO_AXI_CLK] = &gcc_video_axi_clk.clkr,
> +	[GPLL0] = &gpll0.clkr,
> +	[GPLL0_OUT_EVEN] = &gpll0_out_even.clkr,
> +	[GPLL6] = &gpll6.clkr,
> +	[GPLL9] = &gpll9.clkr,
> +};
> +
> +static struct gdsc *gcc_sm7250_gdscs[] = {
> +	[UFS_PHY_GDSC] = &ufs_phy_gdsc,
> +	[USB30_PRIM_GDSC] = &usb30_prim_gdsc,
> +	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] =
> +					&hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc,
> +	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] =
> +					&hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc,
> +	[HLOS1_VOTE_MMNOC_MMU_TBU_SF0_GDSC] =
> +					&hlos1_vote_mmnoc_mmu_tbu_sf0_gdsc,
> +};
> +
> +static const struct qcom_reset_map gcc_sm7250_resets[] = {
> +	[GCC_DPM_BCR] = { 0x46000 },
> +	[GCC_GPU_BCR] = { 0x71000 },
> +	[GCC_MMSS_BCR] = { 0xb000 },
> +	[GCC_NPU_BWMON_BCR] = { 0x70000 },
> +	[GCC_NPU_BCR] = { 0x4d000 },
> +	[GCC_PDM_BCR] = { 0x33000 },
> +	[GCC_PRNG_BCR] = { 0x34000 },
> +	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x17000 },
> +	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x18000 },
> +	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
> +	[GCC_SDCC1_BCR] = { 0x26000 },
> +	[GCC_SDCC2_BCR] = { 0x14000 },
> +	[GCC_SDCC4_BCR] = { 0x16000 },
> +	[GCC_UFS_PHY_BCR] = { 0x77000 },
> +	[GCC_USB30_PRIM_BCR] = { 0xf000 },
> +	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
> +	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
> +	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
> +	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
> +};
> +
> +static const u32 gcc_sm7250_critical_cbcrs[] = {
> +	0x0b004, /* GCC_VIDEO_AHB_CLK */
> +	0x0b008, /* GCC_CAMERA_AHB_CLK */
> +	0x0b00c, /* GCC_DISP_AHB_CLK */
> +	0x0b038, /* GCC_VIDEO_XO_CLK */
> +	0x0b03c, /* GCC_CAMERA_XO_CLK */
> +	0x0b040, /* GCC_DISP_XO_CLK */
> +	0x4d004, /* GCC_NPU_CFG_AHB_CLK */
> +	0x52000, /* GCC_SYS_NOC_CPUSS_AHB_CLK */
> +	0x70004, /* GCC_NPU_BWMON_CFG_AHB_CLK */
> +	0x71004, /* GCC_GPU_CFG_AHB_CLK */
> +};
> +
> +static const struct clk_rcg_dfs_data gcc_sm7250_dfs_clocks[] = {
> +	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s0_clk_src),
> +	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s1_clk_src),
> +	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s2_clk_src),
> +	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s3_clk_src),
> +	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s4_clk_src),
> +	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s5_clk_src),
> +	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s0_clk_src),
> +	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s1_clk_src),
> +	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s2_clk_src),
> +	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s3_clk_src),
> +	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s4_clk_src),
> +	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s5_clk_src),
> +};
> +
> +static const struct regmap_config gcc_sm7250_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x9c100,
> +	.fast_io = true,
> +};
> +
> +static void gcc_sm7250_clk_regs_configure(struct device *dev, struct regmap *regmap)
> +{
> +	/*
> +	 * Disable the GPLL0 active input to NPU and GPU
> +	 * via MISC registers.
> +	 */
> +	regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
> +	regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
> +
> +	/*
> +	 * Critical clocks that has same register with
> +	 * different mask
> +	 */
> +	regmap_update_bits(regmap, 0x52000, BIT(21), BIT(21)); /* GCC_CPUSS_AHB_CLK */
> +}
> +
> +static const struct qcom_cc_driver_data gcc_sm7250_driver_data = {
> +	.clk_cbcrs = gcc_sm7250_critical_cbcrs,
> +	.num_clk_cbcrs = ARRAY_SIZE(gcc_sm7250_critical_cbcrs),
> +	.dfs_rcgs = gcc_sm7250_dfs_clocks,
> +	.num_dfs_rcgs = ARRAY_SIZE(gcc_sm7250_dfs_clocks),
> +	.clk_regs_configure = gcc_sm7250_clk_regs_configure,
> +};
> +
> +static const struct qcom_cc_desc gcc_sm7250_desc = {
> +	.config = &gcc_sm7250_regmap_config,
> +	.clks = gcc_sm7250_clocks,
> +	.num_clks = ARRAY_SIZE(gcc_sm7250_clocks),
> +	.resets = gcc_sm7250_resets,
> +	.num_resets = ARRAY_SIZE(gcc_sm7250_resets),
> +	.gdscs = gcc_sm7250_gdscs,
> +	.num_gdscs = ARRAY_SIZE(gcc_sm7250_gdscs),
> +	.use_rpm = true,
> +	.driver_data = &gcc_sm7250_driver_data,
> +};
> +
> +static const struct of_device_id gcc_sm7250_match_table[] = {
> +	{ .compatible = "qcom,sm7250-gcc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gcc_sm7250_match_table);
> +
> +static int gcc_sm7250_probe(struct platform_device *pdev)
> +{
> +	return qcom_cc_probe(pdev, &gcc_sm7250_desc);
> +}
> +
> +static struct platform_driver gcc_sm7250_driver = {
> +	.probe = gcc_sm7250_probe,
> +	.driver = {
> +		.name = "gcc-sm7250",
> +		.of_match_table = gcc_sm7250_match_table,
> +	},
> +};
> +
> +static int __init gcc_sm7250_init(void)
> +{
> +	return platform_driver_register(&gcc_sm7250_driver);
> +}
> +subsys_initcall(gcc_sm7250_init);
> +
> +static void __exit gcc_sm7250_exit(void)
> +{
> +	platform_driver_unregister(&gcc_sm7250_driver);
> +}
> +module_exit(gcc_sm7250_exit);
> +
> +MODULE_DESCRIPTION("QTI GCC SM7250 Driver");
> +MODULE_LICENSE("GPL");

-- 
Thanks,
Taniya Das

