Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663942DBF75
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786410428; cv=none; b=P5M+oJJHcSGktPJVlgSivw8ddK38OSVZaS4PnQu6dbquxZ0oIbmbE7a1Cgwoc4TASPcKU+gjeAiE30rvDHJwA3pXBc1VEKml68rQKFR1BiE3GhsrViWfBaQUHGJt2TFpHHl0atDNENPzzNOsvdj2SltH7pJ6Ld5yeWhVCiyQSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786410428; c=relaxed/simple;
	bh=0a7KrwckELD0BSsVz1sZpospsBXzH5+wJ3BdAHmVwqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzfETRN3Ucsubw2vT5gKGN7VLBJqYMGM6IX0pDPz8cSyqxt4p/tqqtEkQEqvOfaqCKH1NoN2S9+/BNHE82/pbkqU+/z/AZjA+ePdw2QYdJjuPj2nQLiMlmDyIligFCosiNOf18f8FTZvt4BA9sM3XumHPzNYli5+3w9eiCOunfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jxza7oXM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BTTuZcHR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jxza7oXM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BTTuZcHR"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AMpswq2705347
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 01:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LKWM64w9B/428ZZASotTcAv1
	uE/KA59H6TXr868LmeA=; b=Jxza7oXMVn41cVQ2wPrP6IG7+Jprdl5vaVU5gRkS
	oAuW0QFGmJ/vSh0jMw9FVQtlciDTIzMa0oILUlC7rcG0AjDtynG8RF0bbfnUq6Tu
	7bQ1Rg2NrAxsVomj1YkifV8eGFk9OWoHtm3r7oBmcr1mSsSuOeJvzGLdUbGqwyfC
	45F0FL7tSET3vpxmGwrKEhfCN7E9S687OS9cvMsafC4bF0ydMpasYX+vX02geDn6
	N91xnz7b6R+3X+hl262fLHmb8D36bgNFixHCmFePrhbE7u5nqdCGhiq55e8xLla+
	LX+DV4CUkFPuE+oaFhNIPjH9OPmra0SQKd7Iif4q7P1NZg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk61qpd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 01:07:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bff5c7035so50631771cf.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 18:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786410426; x=1787015226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LKWM64w9B/428ZZASotTcAv1uE/KA59H6TXr868LmeA=;
        b=BTTuZcHRdPXmKfLxEzf4nZ2RE57A6dYpnGtWfk9d09MMKtKuIZITtiATjyfhXaXwTa
         d2yjCxeCUOZnpMo30tpaYXKfvg03C1haY05ivKzMT3UHR6/eG/Ii1cQl3AwmD9IRUVv8
         pLiBEgNAITM5tTnvXs84GUYHGY/QHIMjl4VeihxHUlRIc5YLEKPoQfHLaMNsQh/lrNEu
         nnoAN0hW5Z0kc3TGzizYGEq++q/v0tCbfnmlUChH40UISGIrQDP0nscy+FiQs8iPvVXc
         utLjbH51L4r7/ori+/s3r2oERztW+qAd146FiGYT0WOlnFawkYAIS9+oSrrRedhjvUBe
         RcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786410426; x=1787015226;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LKWM64w9B/428ZZASotTcAv1uE/KA59H6TXr868LmeA=;
        b=NmMO6sejbqEzdzyCV4f8qEPFG2ShmlgPIGPCOPieJkGzcij4Dy0wqzB3j0ZQ2csJmK
         qAzhaKYVEbJ2G2pDId4EdTjEV6VajtyoYSWwBtH/68YS6Q7JDSB8y7Bwq/HRyneZFkfQ
         O46IXkpu66TalLZ+dBBF5o/mVxNBnvKpo+G1HEySHudoihk5EAIL6418Oiiy1b4C68cS
         cUblbmHeYF+df7icbVj2Kzzq4BKi6j9TMoOxvzaRHwFN2ovn3NOLIGAeuZczmAjm5Xay
         nRDNHJJbH1+8auU8ES39ZazrL5EYYpxKyhQZRQZt9MFzqpHrVOAFYB531NhsMBcP/dCG
         Gu1A==
X-Forwarded-Encrypted: i=1; AHgh+RquvFES9urDKQO75wmKRwu3jKqXCHb2ywcd4qzCGYo4F2fvBWQFD8B+qjANIxCDm9/4fuAvzrp+4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT1EvpSV6KoT7M5IIV/cy7DaTPHFz0xHCe5Y7NF/5eKn97+d0X
	L/XxruT6d2YUkm1QvYpi0Flqps3K4ubi9Xh/OtPHDt8B69BeJ4U5cITEIztJHP70ycpYw9rcdd+
	2nC4kuHZK2O9xLxesilT6ieHgZB4aMfrGiXxF1r3bs+TpzoH7UZZmLahfnuqoKQ==
X-Gm-Gg: AR+sD11hVMbjflePLpCEAy7ecleesBb6kT6eh63oWebCTWWshjvyEuHaHtEzbtWRhtG
	5pjRwEik6cXuVm7o9B9AZwreqSYxHctrC2eJ+iZXhY7VmDGXQjjjVIj5DLXL7n+c1qIdQNQ5zzf
	U1M9UC3Xm6ON1dPzKaykks6xPYCSWHdi1G1JEY7kZZA/LR2+s5g0j/YA4caFvD6kn0QqkHfcxt4
	TfezsoLlnuM9nS166KDRJxuwz3gZ7FqkBJiGdlXtcZRe9y1HxylWSy9xV0aBNywKnS8QQCg8ME4
	fVVuET8YNyZ0NNscBI3kBfmghKOkZOX3RRuTHPewA5pFNtX0mAhtYoYeBCaDCSAI1cYX5L+Jiir
	j9T4i7U/ahnnRstKBR6Y+ZI4uraJe+PrERIMWzT526YZ4LPWvxQW42MscdSdVi2SIsNFHo2RDzj
	kU0n1QZKNlJE6aAw==
X-Received: by 2002:ac8:5c84:0:b0:51a:8bc9:2915 with SMTP id d75a77b69052e-52d4bb52da7mr76245201cf.8.1786410425712;
        Mon, 10 Aug 2026 18:07:05 -0700 (PDT)
X-Received: by 2002:ac8:5c84:0:b0:51a:8bc9:2915 with SMTP id d75a77b69052e-52d4bb52da7mr76244441cf.8.1786410425284;
        Mon, 10 Aug 2026 18:07:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39fdda80e00sm26841741fa.9.2026.08.10.18.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 18:07:02 -0700 (PDT)
Date: Tue, 11 Aug 2026 04:06:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 11/15] clk: qcom: Add Global Clock Controller driver for
 Kuno
Message-ID: <h3mptj7zar6lev6qqsuz6q4gqkywu5djadjglzsjztzqystabz@555y7a4xd6ux>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-11-5e0ede4a0c72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809-kuno-soc-support-v1-11-5e0ede4a0c72@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Nb3WEWD4 c=1 sm=1 tr=0 ts=6a7a75ba cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=AtW9uK5K-k73WlJJaeAA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 6zR9DEsRGkCD1wXKHRPTSQSOvai4BqTQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAwNyBTYWx0ZWRfX+phpXNYL3MIv
 85BWtCZ9/ZsX+VVKvZDoLF3aTekuapAAIESnYXMhFGc8WLLXgXRAc2R5DIVKd6GugoY8o/Z+FKV
 PqPldI9+NM6twKTgtmdup7zp79PsG8E=
X-Proofpoint-GUID: 6zR9DEsRGkCD1wXKHRPTSQSOvai4BqTQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAwNyBTYWx0ZWRfX70uPhazaoRmR
 ic4aQ2noqNUJ3TjG+iWbo3IIX+WAn+2PQTho9VsZbijeeZ0uewAs4UlyO/Ldrh+CTkoa2tv+/kM
 zInclqC5Y8QnhS4nNG83dzjz85HyQK8j+WDTaNVSR749HDGrqBS2oCidOQ9nHbBN+XTdFlp8dsD
 HHBCXrIbUXFiESaKF5mgIODQgu7zb+xizyK2yNPyaxMohUe7UUPRjeLzMXa6tITuns1T2DZMYXi
 lAiTsDeB82Bsj+jz9+HeICcC4jE5NhXng1TJW0Mpp8mpF1O0ymdRwKng/I12KwpLefUvi1frOA+
 CpQ5gvBwTMqISsF33NcFtM5omPFLUw+v8p9lm46XAddalg+3nKN7T08wvP0SaaSnRf5sPKHfGlx
 UWRVpptN1IMPZYzY3yWTs4oCv0fRKKGXk2StlXao+C8UYIxDUTzw1+tvOqlClFqQsehAs0EBAYF
 J2wogLTRmVeQxgV0pgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110007

On Sun, Aug 09, 2026 at 12:57:10PM +0530, Hardeep Sharma wrote:
> Add the global clock controller (GCC) driver for the Qualcomm Kuno SoC,
> providing the PLLs, root clock generators, gate/branch clocks and resets
> used by the peripheral devices such as UART, SPI, I2C, USB, SD, PCIe and
> Ethernet.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig    |   10 +
>  drivers/clk/qcom/Makefile   |    1 +
>  drivers/clk/qcom/gcc-kuno.c | 1438 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1449 insertions(+)
> 
> +static struct clk_alpha_pll gpll0 = {
> +	.offset = 0x0,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
> +	.clkr = {
> +		.enable_reg = 0x7d000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "gpll0",
> +			.parent_data = &(const struct clk_parent_data){

Whitespace between ) and { (through all the file).

> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
> +		},
> +	},
> +};
> +
-- 
With best wishes
Dmitry
