Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE02EC0A7
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307163; cv=none; b=rHdUYqk5gan3Va3XaI6yms1kFTXXyvY6dLJxvgQgeMg5Yf4+lIuyDU0gdiUchCDKygNtQkNawAR+rJ1mgbc+mOrj/znamc/agiuUDTCE74PD/j28wGfdRCKUtuHvapD/EsFERdrbJWc4ty+fqCBs5DSrE3WudeNCeXlc9QIcj18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307163; c=relaxed/simple;
	bh=DiH5UzajGrApAb2LRnf0TdnfZVH7UpcgdFCXsVnPHRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6rfBdqN3cOyAyanS/5g2/JEokeyYoE39dD/8EHiWrMG1OnWy9vfautrpQNcFnSsvAu20ZYs/3yZiVNFcuBDuQNK/fG5V48vJSa5kyQeoK0GZEhFRdimFvm/WUYev5S7j1lqgCY/ah4wKq+Q9YbN8mlp99u/8ajtVmdbKnrY8UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bSG92Jtl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N4IcPHLT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bSG92Jtl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N4IcPHLT"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9Li2S1983083
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 10:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yksbzOTQ/eC3Z53PGx/czvNi
	B3RKb7i+djGFkbXFPg8=; b=bSG92Jtlp7Ugc8PCGs0gGExQ/jRBfx5rwvFGhF27
	parmlyomdS3YJi4wYjWDyFQCqFQcitoZonE00epurXO7dO5cGPcoXbn46bwLMgOG
	5ng423QDx20E40ASknUKiB+LlqnOzbNLvzi9wPATp0CDv5oXwKdjf3Vh9x8owwem
	AtZwFItFFXBZwPVvjZqiuGOU5SofsIWUgX12Blw5dXeUFgw4jQgDvVl+53yPPQ8P
	NdVKwCL9qqHMkfA4KvOOOsFQCuYT1ATuPvWWTQA1s6/Z29fMgoPxnbZxQLpitSOe
	MAWl4Nj6EJkS3L6IinTGHjpsBmiTAkKFZPpiTCzpbLkIsA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6cdsht5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 10:12:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52b4f6ac06aso13399151cf.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787307146; x=1787911946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yksbzOTQ/eC3Z53PGx/czvNiB3RKb7i+djGFkbXFPg8=;
        b=N4IcPHLTGDmqhTL9BU2ef4tMhGGjpT+Z8o0bJjUMKJ0Y6QJJmFyu+d+vShn3O00Suu
         vwLmkoQjLl7hhkR2BVh9QLqK46HL5hAOZ6waXaOR4BvzAG0E6HilX09+rd+x3DOc6nji
         T3BozsVmXeWfrOr/J6JboxrDKAWyCxGdtcBgtiH9ubxF7awtVAcxBw2OW+0tZVkn+46j
         TkRJ55/Zp3sCV8WvtgPuSqnElC16sDJzHrBJ6qwmPdJzpZb9QpWK306pSJpTM1Q0ruwJ
         DjBkuA7/7bwdSWQgGNC3cRX+l8jS4lZZm8F+m1yze7xwgLyt7kelSwIh3/PvIgKzm+vQ
         lGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787307146; x=1787911946;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yksbzOTQ/eC3Z53PGx/czvNiB3RKb7i+djGFkbXFPg8=;
        b=j7z9S9rdMrxudJ0Ao735JuDU5jG2qNXUAFYhasKCoAQ5XwrVxC/gYADxlLxqrcwEak
         Cs6IHaS5dXMC1gtdI5RBFPdHe5HusxHBVVxdYni/6k+O/uHkMBeE5trUjxAosrd3UGau
         0MHn7uY2UZ4lVYLO2YiwVK7eOFti11ls5QopEon0N0/sMXJOeyzYCyZ6fC9voi6Xztyq
         QAg/IhvLYpsaGb6Ykw+OkZt2XpnGIq4+ijn2nMmut6Z2qGSDPMHuc/ZFg740pQadWee7
         bwVT3CL6HtIAgeME+1tT/0HsZXy3oX7ULUnfCob0/5aLGqIgev5X1KRBymaujG7S15Sr
         098w==
X-Forwarded-Encrypted: i=1; AHgh+RpTecL6+v3M3VcpVMsUvvwROiEvzdmM/oklH0YRDmsd+XWMJxB0YXDvLpemotI28hz/NZ56V1YgVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YypJoPMziC3TGGvDH8PEo218sSnXP/b5DtPgPiTgm1hfV7TJfvl
	QgVW9hlSnUoOlaP+BghMTd+K85Rh0bl4DChB+bGks5TXFmAmFSf+yBt/9aBt24pOSskAC8pHrFw
	2pXVlBzllg6txoV7yHYTLJ6ymCq19LyXTYsc+lvEPdrc7bjbnV66PdGVI+nbk7g==
X-Gm-Gg: AR+sD12nFJ+x/taj+0b0Uch76qgKKC47sMyJPD/8/GwRDzo/jSP9jrP9Hk97gLVhc8Y
	p2sEXCnxBf9c1drIRuwHn/zgsh+UENq3Eopy5QQalEjHiwnVTv/U8rfIP7SrwAc2hB5QxfvWt6N
	effqxqOuUuGubfiShKQm4+GYupx9Qn63vz9epiFylxzEQeJBG1diIGr4pakaFkHWnnFjiyFmUmJ
	61NdqsDqLBKPaUUuUOa5Iux5K6AAJN3U1XcGQ1LRuZrkX8Wg6mgoqmcY8BIflnNp6mftxB1KnM6
	L+q6VJ/xtJL0/osZ9veBDNPY36zc7CYG+XUrCIipDd4Xq3Dhb7IriKvS8Vb/eK+cnumOvfyKXLN
	RCTfckSmaUQx8sXU=
X-Received: by 2002:a05:622a:5591:b0:516:ed02:c85d with SMTP id d75a77b69052e-52df5637a7dmr48417501cf.3.1787307146412;
        Fri, 21 Aug 2026 03:12:26 -0700 (PDT)
X-Received: by 2002:a05:622a:5591:b0:516:ed02:c85d with SMTP id d75a77b69052e-52df5637a7dmr48416921cf.3.1787307145847;
        Fri, 21 Aug 2026 03:12:25 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2459223b9esm407623366b.62.2026.08.21.03.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:12:24 -0700 (PDT)
Date: Fri, 21 Aug 2026 13:12:22 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, konradybcio@kernel.org,
        tglx@kernel.org, ulfh@kernel.org, bmasney@redhat.com, radu@rendec.net,
        lpieralisi@kernel.org, quic_tdas@quicinc.com, danila@mainlining.org,
        davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com,
        linux@gurudas.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 04/13] clk: qcom: Add Global Clock Controller (GCC)
 driver for SM7250
Message-ID: <345sjivput4nhwbid5ic5ar6fj3prkzmbozhjkvhob4kk2keio@jzs737d26og2>
References: <20260821081125.4522-1-sreeshankar0910@gmail.com>
 <20260821081125.4522-5-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821081125.4522-5-sreeshankar0910@gmail.com>
X-Proofpoint-ORIG-GUID: oGiiTHjZqvOIkvEmORKreYY5V5-rVUVM
X-Proofpoint-GUID: oGiiTHjZqvOIkvEmORKreYY5V5-rVUVM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3NiBTYWx0ZWRfX6PYMTY+ZUX8w
 Gp6jYSAEIrSblNwe/i+hJVsr39dCEgyVHXri00gw2FNfDIRyF0FFyBJ1sski64OYpy+hC5ORn90
 P7P5vq3igW24HBdEFmExbELe+1XJSKw=
X-Authority-Analysis: v=2.4 cv=RN2D2Yi+ c=1 sm=1 tr=0 ts=6a88248b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=LIp7Q8giVWzGnOrG83AA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3NiBTYWx0ZWRfXyS59CR52hK4z
 BnJ1FmkgTQvbiI97+2lOy/8dZrOs7v/aZWfauMEjcUvwfP/NSRsqe8lAedrdLvv9Vh4fmO0nrkL
 vbGh5hXeHAiv77JF2xmOIHqpexDeYhmmPk/VKwsarNz1N4Cgqnu3VdtqdW7hiES0FvnLY159aT6
 dm64j4mwSA/CwIGnjpLfttyWZaFCk6Z1Ig4pnKO9OX+SX2kCXdHt5CvCHLmRBN46FK/n0EUWNtR
 DjWRZ33Zty4QCkkY2A+M3tj8EzHEM5yMwXhEuL8Zxsd6XAaCnIVEGgy0n7788jI3cDpQNVXow+S
 1QYyL/e2857NUXV1pU9VoDHgTdGF2Dz6Q37Rtg8kmIWe7Scs71WJZpihs2C88MoJuEiVsCvpDNM
 kQME+IavAluFXsl7dlcLdTfRKNSy0QA57S1wdCGce3u0354gZAF3YM2GR/ykJQSgZEQZ69v41dc
 huOYCBvG3GjbFOtuLCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210076

On 26-08-21 08:11:16, Sreeshankar K wrote:
> Add support for the global clock controller found on SM7250
> based devices. This should allow most non-multimedia device
> drivers to probe and control their clocks.
> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> ---
>  drivers/clk/qcom/Kconfig      |    9 +
>  drivers/clk/qcom/Makefile     |    1 +
>  drivers/clk/qcom/gcc-sm7250.c | 2269 +++++++++++++++++++++++++++++++++
>  3 files changed, 2279 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-sm7250.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 7d84c2f1d..532d8f002 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -1416,6 +1416,15 @@ config SM_GCC_7150
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
> index 58f9a5eb6..18414089c 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -174,6 +174,7 @@ obj-$(CONFIG_SM_GCC_6125) += gcc-sm6125.o
>  obj-$(CONFIG_SM_GCC_6350) += gcc-sm6350.o
>  obj-$(CONFIG_SM_GCC_6375) += gcc-sm6375.o
>  obj-$(CONFIG_SM_GCC_7150) += gcc-sm7150.o
> +obj-$(CONFIG_SM_GCC_7250) += gcc-sm7250.o
>  obj-$(CONFIG_SM_GCC_8150) += gcc-sm8150.o
>  obj-$(CONFIG_SM_GCC_8250) += gcc-sm8250.o
>  obj-$(CONFIG_SM_GCC_8350) += gcc-sm8350.o
> diff --git a/drivers/clk/qcom/gcc-sm7250.c b/drivers/clk/qcom/gcc-sm7250.c
> new file mode 100644
> index 000000000..b98806fab
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-sm7250.c
> @@ -0,0 +1,2269 @@
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
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpll0",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "bi_tcxo",

We use index here. Look at gcc-sm7150.c.

Same for the rest below.

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
> +	.clkr.hw.init = &(struct clk_init_data){

const. Like above. And everywhere else.
