Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6B41E6C9
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693369; cv=none; b=X38QslzgOMt00xq+uCxkn5RRd5jlasP7xyq97Q1ClfKD3A5hH4o9aTFx+9fT2KY5dskSOCr9zMF7lO+aSTYK7Nl1i5OjkJW3oX8KhRAZ3hd9/6lCXHi+qg9fcDCCREXGSMGHMG/c7RJHgs+sKdSan2Zvpn9In3PkVoT/x+YQFmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693369; c=relaxed/simple;
	bh=yQK6BU/jG8kZpwu5by/foagCc8x9efnKwLqHq52D3Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+j9FIO5YKw2PnRxMnqE5YV2ZUyTNeHNrcvEEjy3vGc+kh+rW4QxdjSnmpr6NJzRyri3okmzH5RHXFwr/SUWJs9SgY/ypg+pnN3gxtHz3nVXh9G0oRvFNOHRhry58FzA6xP+TwQauU7eH/JUGoiihEXEBhOmDdzLBBPv/T2u3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EiQnZT4g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D+y6Eu2/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EiQnZT4g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D+y6Eu2/"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E7fTdg678201
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WBklc2G/busGjck73g0DPLTntqH4yid2WXdPSTnv2u0=; b=EiQnZT4gbhHaU+Pj
	kF96ZKDTJmzdLV0vYK4mDYhAiCUq/KsWIwMgBHFiTSDy2UzLQQA2b5OHgCippIZo
	uJYs+Z7DBuUokITFWg9iE45+ysRERVWegCOUoS9kKQdkHzszk3wMd2eZi05WiB6+
	m9ROl4CNEPZKng+17KrJTpQ9/pzwXrKdEiKYh2GAudIxxBl5GWI7QI3XxN4OU+D9
	tCjfqp02HD7neJMTQ8G5zrk60pyHjjoPys2HfwW6GMgYE1NRcQ0qNqCWS8nzacUD
	4anmEftPIjTM95ie1469AyH5FgW7lto/+qYOQd4pwpRyqHHvdjsTvElfxFrEK8Ez
	LarB5w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1v8prm77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:42:39 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb6433e9d4so889009a12.3
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 00:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786693358; x=1787298158; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WBklc2G/busGjck73g0DPLTntqH4yid2WXdPSTnv2u0=;
        b=D+y6Eu2/qDFIqMgjVlNpVmrw/je4jW5z6Am961uQxgSV66G/2sgOWkygPIiy4m39zn
         lYLl08SBYGEv66Ye4A/ESuRjC+r4zIneTDn5+rtcmvCpbtOzMjI5qAaZ4q5vNasIt2yR
         QQs+VxTHU6vypoz/Hs9RzCRquinzsn36FirUdPQzbE9POOAXJumuizGx0HcT9mv4vOVR
         NLMjOUwQ25dOCpTf/SmD/cbbm0P1Bxjb+Bpc0tIVXE3PR8pDYxgW9Te32NcUVlCu0XtW
         R0V/8ATjrdaEi3FTociWiUJsIMfwz32Dnk/qZBRuJvk8kw7c1A0MkEZlQvAW6Pu8Oee0
         x56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693358; x=1787298158;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WBklc2G/busGjck73g0DPLTntqH4yid2WXdPSTnv2u0=;
        b=kgrnrN7+Qbvc7fKi7Ak/SZUj18P8i/SaWrcZkyideAJCv7YJOaAJVkBe4olHnhVivG
         MMVhkNjULqQgX4U4tR/LjWwytTtybZERcgXI6BPZbRJPUt19P4fNWT2BAYo6yvPzuTpC
         UcmqlFrtUxAQCNBeDEioebeu+uyojh2bhjlIXeOpQWMHMIOqFzKzZgoeLlNDjrl9ScWX
         pPWn3oCtz/0CSpGl6dfN66Kux0hnWaS8k50+5If5BumXT7eFTqKRXtM2MDoU9AsEbmiS
         gsWnyKjUA9SPookX3IwrUwhrqlP2+Fk8m/HRWAeJRQgJOuv9M7DpyCJ/apAdJx+7jR1G
         qYCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpoPHOEzxxp+gwTtjfkuQBV527TVDY08KM9lQmHAXo/jUASPuQI9FwEpDyx6k6Ot1l6c6u9o3hhpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSCTOz9vB1iag/oK+fkhv0X81UnU7KSZQzbcDWJYhHQhrcDOrh
	cI9hfptH9jOD33hMdsYUtCijhL0zB7EASOFL8eZa3ZqW/fVdMzxHICBM2qq1M98Av7gjNKJ0oQK
	bdqb/fIQHPBa/OT578cH0aYyXEkCmf5hLRfXSEfotoz38tUPv7PNlOJP6TaFv1Q==
X-Gm-Gg: AR+sD118Wvedv4bZ4ZS6h8wB7aZrY0iPRv+UEWV0RyriIzyRbm87N14WhwNZSBVeagm
	YhT684lhKoCRGqhbqKgSBCM2FNPjMFNRA/cFBzZWMnfhNgrHsUojWSRywG98qG4TFbMz/LPNamv
	gH/QwXp+mQeO2HEYaDp9vZ4qq9S4EDoHJ/v2WYQB/Od/+p9ZE8owVDW1Mt2TMCRsFKLPzW1LiHD
	S4FPI4Fyln3Y+YGc1m6VlEMVpcHq8llovuNbwPbNve7rDt0xdOrDG1z2IwttNsyQVGOXYwYxUPW
	YWM+TyRDWDwAwAkz8tDmEEdtp/HTh3CT8wY2OGVyxKC7OpexkNvwxgM1l0gUwZqatfNK8s5z5qP
	HUv2mLLMKPt6wLJkiNLkRZ+vLgXSkwfIFmnBc9TiqAQhgmqURjURzYod5h8yVuSxnzwkiKTDhWP
	IGe3fuaYJzQRIAT8+CWeU=
X-Received: by 2002:a05:6a20:3c8f:b0:3c3:b57b:627d with SMTP id adf61e73a8af0-3cc71b83e99mr4271577637.12.1786693358520;
        Fri, 14 Aug 2026 00:42:38 -0700 (PDT)
X-Received: by 2002:a05:6a20:3c8f:b0:3c3:b57b:627d with SMTP id adf61e73a8af0-3cc71b83e99mr4271542637.12.1786693358103;
        Fri, 14 Aug 2026 00:42:38 -0700 (PDT)
Received: from [10.79.117.20] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc095a3f9cfsm136922a12.27.2026.08.14.00.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 00:42:37 -0700 (PDT)
Message-ID: <c1baeaa9-5145-4a3f-bf14-f50ce1e48ae2@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:12:29 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] clk: qcom: Add Global Clock Controller driver for
 Kuno
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-11-5e0ede4a0c72@oss.qualcomm.com>
 <h3mptj7zar6lev6qqsuz6q4gqkywu5djadjglzsjztzqystabz@555y7a4xd6ux>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <h3mptj7zar6lev6qqsuz6q4gqkywu5djadjglzsjztzqystabz@555y7a4xd6ux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K4MS2SWI c=1 sm=1 tr=0 ts=6a7ec6ef cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EkQsDeFWBQwVCp19dG4A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OSBTYWx0ZWRfX9PB/hWCmdch1
 dx/MEPP/+O+H2+zWdFW26ELowTLg/G1E0YxF0nxKUbq7z/vJC1l8R7G6L89K5tjfr8TuF9TZq2z
 FOACyDsRjpBYmlW4sHXY96iWiNGZs8gt7iFFFFog12WRkTATzkQgJJZpKbbgqxvPv1bWiQYDc9A
 zAQy8rSwbsIDgBYlq/fCIWco76RNXt9XKO27U2z62vqAduHnxbMukZNbQvd0UT7qY2D3OXd8EHB
 5OUMLoFHoh2BOUQmwD3ni+27QIPe8smIYPpbYyoGNigiRidRyGKqrQqQia9AIV+eSdzKXwSJ1Wo
 KZP+9JNDU816Q2NBiZeFmeVKEsdK5gNIgb8hTeJHlCJkN3Lhvy14NY8eNcJd5lTlUw/46OBjnsk
 RHumNjBvJWv6RruRNixi9/OKet5g85gbzNglq3iQolMtxKYaZGJa9A4xBBH3AuwNHt77O7IT1bn
 HcvgZNvfXbGOUKhI7BQ==
X-Proofpoint-GUID: XqvlrHZ1XqdQKQEPNM9jgrPc8xUu3j7Z
X-Proofpoint-ORIG-GUID: XqvlrHZ1XqdQKQEPNM9jgrPc8xUu3j7Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OSBTYWx0ZWRfX2GVq0ozNJkl/
 ZX1fEXN/Z2Js/18Ihbxlb/gdyNIEXH6qJe6tFPONoXtD5kZl+7z5oIF61Ws08zn4FzWOb9aHCFz
 n0RJoGFsA9le9VbHAWA1DOYy1v7ReoE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140059


On 8/11/2026 6:36 AM, Dmitry Baryshkov wrote:
> On Sun, Aug 09, 2026 at 12:57:10PM +0530, Hardeep Sharma wrote:
>> Add the global clock controller (GCC) driver for the Qualcomm Kuno SoC,
>> providing the PLLs, root clock generators, gate/branch clocks and resets
>> used by the peripheral devices such as UART, SPI, I2C, USB, SD, PCIe and
>> Ethernet.
>>
>> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
>> ---
>>   drivers/clk/qcom/Kconfig    |   10 +
>>   drivers/clk/qcom/Makefile   |    1 +
>>   drivers/clk/qcom/gcc-kuno.c | 1438 +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1449 insertions(+)
>>
>> +static struct clk_alpha_pll gpll0 = {
>> +	.offset = 0x0,
>> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
>> +	.clkr = {
>> +		.enable_reg = 0x7d000,
>> +		.enable_mask = BIT(0),
>> +		.hw.init = &(const struct clk_init_data){
>> +			.name = "gpll0",
>> +			.parent_data = &(const struct clk_parent_data){
> Whitespace between ) and { (through all the file).
>
>> +				.index = DT_BI_TCXO,
>> +			},
>> +			.num_parents = 1,
>> +			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
>> +		},
>> +	},
>> +};
>> +

Thanks for review.

Done in v2 : 
https://lore.kernel.org/all/20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com/

Best Wishes
Hardeep Sharma

