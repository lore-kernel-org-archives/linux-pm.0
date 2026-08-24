Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18DD3EB0FB
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561776; cv=none; b=kfKvFv0DTu3F3eb7lK3Q3mwIKwyKUgbJZdZMPsSgKhNtYm3z47jtYThAsRed199Li/ZL3LoEhwnttrQLqffIV2BXi3CPBJ6Q78pD5A7d3Y1zHl+mAmPSERHM55L38G0AOWsWt5jeLA1vPb0iQFtBIB6vFjUrzmif7SRpJeLTnmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561776; c=relaxed/simple;
	bh=9QoRTXvi5xZMB0EtZGs0HThpzohwXZKwlo3LdSoKQ3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwtHuNRy5iytJORK1j2OE1iGEl/yQXGWD0GBkS+ww3bZFPnkt32OLPM3YC9/QTA+n+zWdMUjA93aiCqkGUk8ktMrwhIi5+2KYccfsAUFCeEs2tYRVRAVyBTkl1f/EmoynyPDmRcXEpPBb1V6LkGacYCtz2mgEACRV4lpZIKhvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gV4lLQh4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NCVGDkvU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gV4lLQh4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NCVGDkvU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O67c7f1662617
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3cUegRrh4t97vcHkq3HjcZXrnZyd5PTScL+jJc8i9fc=; b=gV4lLQh4ZbrWe6Wo
	Q7IaEn9Zri92+FgN0lSM7Z5fsebe3phgv0oT4aKLCRjnd2qHW2TLPtrWeYWrv6AL
	RtRIEXioGOSD6z+2BSynBvlB+86UTBthgmqsM71MOUjnGmbyMVdlrvkh92KvHwLG
	2B+Vj6XnMSsLLEtM/pPH6V2QaWqm+JXuAW7g6dFEfc5wBLPbsMrz0/RqCzirqGub
	jkfSFU+dr0K98IDxJwVbhzQ1NI9xRrXg/X3VGZWkfTBF6BRj3Ht+DRBNLnwgCFKi
	TybFnK97tjlC6JmrkBQeOOjPzWx0uowtHpxU5KppQf1UgWHT4AzrDoycgz49Dyqd
	Y0IJ/g==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gdsgqn8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:56:13 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-74ab6065f97so73825137.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 01:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787561773; x=1788166573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3cUegRrh4t97vcHkq3HjcZXrnZyd5PTScL+jJc8i9fc=;
        b=NCVGDkvUQ0/KPU/Ot4NC31+wj608NZHXDEJZ2eL9hK5V6VICcsPJRiQXcj5BW0NN/F
         +aYQVGTswvERmKgKsOrr0RwUY3H7C8wtpKBif+EfgdFh7OTT6+6WmK8X1VHFebxfgtX1
         SkKe16yWWeDNGcuwf+BlQGi5YLSLQPvlvF7pkr7Tn/T0+3YTSon9qoJw5CQhSjejUQDF
         Ohcz0hrkDNRtzwJzd4go6icM30e7KGZ3dj6O/N6JyFK8DDGokOvp92zn0IamcNhlFdIp
         VnOynKXp7AmalitIYGNwPb9oD+YImRZ9tC7jP7ZpI7OvbTCNFWY06g0/MDke+EL6I1tl
         YTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787561773; x=1788166573;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3cUegRrh4t97vcHkq3HjcZXrnZyd5PTScL+jJc8i9fc=;
        b=Hx3J05GloIh4OdEcAqT0JKko2SUIkyqXcBnDhYcsRAAAMpFKRtImcHbLlx0wJpV2gJ
         xMxwSKpGpPDeoKBFbInKw8vMEowb3WKLUlyk0w/EPlZDkKcH2U+4hECm+D5KrZi0Sh8i
         1AKoU2RUr18e1zN4yKh1QWyntCppX6X9bIGmOlgWvrRqwHBcGQZw3WX2e3XLbQ4rugcM
         V5HTIbzabCqcUUS1/AeSUZRy4Rc+gmRhQZWHdzJMfE6OCJeoggKcjPqb0XxAzpicp9eY
         Lj5KVV5ToIkWjL/wyD2QazqCJI6cVsFtKto38om9QhG0SJ5hW5WktfLePWa43BgtjZTD
         y4Yw==
X-Forwarded-Encrypted: i=1; AHgh+Ros3b8vCnll2XcfIStGE+UGJiUDZd8SOu2W/6giExQBfJiNdRd2QYmhm+42EWXZWR3IBqzTNovQmA==@vger.kernel.org
X-Gm-Message-State: AFuF++nvfPO6M8s5u5bl+h+gFDmrtQ6abmUt9xg/7gKk0+K+oWRZdr6D
	N3zUtPawSQhotQCqGCq0sTBUTXI/zTAX4nEBq5ibDftZN15cC69ssnCWqwV1kUPqUcUpmLaLDFh
	SIgvkoyE7zrlwwhKnyESGwBLdtCmHuB6h4wCPPb9vw4Q7pwPd1+OO4BGfUn635tYKd6SlSA==
X-Gm-Gg: AR+sD10QTVOrvKgqafpCwOx1G1A7ih8ocNXfu+mTZMQDN/IKDzaLtK1tqnYmqhSFfPm
	ffpSa8fKDgAnwcieHrOt9UaQT4CMQyWe6mwtIV8lERSTk4z+pi+a1vZ5DueOWjpoT5fGgWrBHZ/
	cZv4u1uYPZVnh0Sff2YmCaOICOBePqitS62FxU/AFFQwR3zp/eiRI49HtuoinYmpRdVXdtu8O6H
	3PX5oG05pmShC6WN9QYUHeo5/7LjIhy5hbnC2nq03rqK3D3ekqRbFp2rnobDI0Il2e/5CBZm69j
	wXbYEO+RqKEFmrY9gy9vsoFrr/c7LpWXwusyc9E04xNvwBgzMuWAMlakh6+rh8P7n/ZBBmtm1Ec
	mXrY00/AVmAQ32oUQgxm49GM0
X-Received: by 2002:a05:6102:6893:b0:6d1:8f7:18a5 with SMTP id ada2fe7eead31-77a6433632emr3278083137.1.1787561772874;
        Mon, 24 Aug 2026 01:56:12 -0700 (PDT)
X-Received: by 2002:a05:6102:6893:b0:6d1:8f7:18a5 with SMTP id ada2fe7eead31-77a6433632emr3278073137.1.1787561772378;
        Mon, 24 Aug 2026 01:56:12 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1ae4efsm6945619a12.21.2026.08.24.01.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 01:56:11 -0700 (PDT)
Message-ID: <57c9495a-45de-43d0-8ab3-4dc8f42712c5@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 10:56:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/13] arm64: dts: qcom: Add SM7250 devicetree file
To: Sreeshankar K <sreeshankar0910@gmail.com>, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, konradybcio@kernel.org, tglx@kernel.org,
        ulfh@kernel.org
Cc: bmasney@redhat.com, radu@rendec.net, abel.vesa@oss.qualcomm.com,
        lpieralisi@kernel.org, quic_tdas@quicinc.com, danila@mainlining.org,
        davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com,
        linux@gurudas.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260821154030.2514-1-sreeshankar0910@gmail.com>
 <20260821154030.2514-14-sreeshankar0910@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260821154030.2514-14-sreeshankar0910@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YA2giWTwIkW57OugyB8HfqxTQm_kHgFS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NyBTYWx0ZWRfX/YC6503QBlVY
 qAFW+xfNeXMXeSU9sMBI0HvB/ge7iLda25QxmIYiM4Pq5YTHxVuYB2+ZAgk45r90zYQzRFH7jh9
 n/qgCMbODchzDRDTWM3F9Lb/RZNQ2dV1exxc3UXkCdrMVU3FCZNuhbrWJ3fBFIfiC0Hp6Xn6uRz
 iX0ylwOo4eZLVeJk5OuqtXVL8hmoOjU09V5lWtiWmzWZ4l8J9+B3RPXhXNaL2a0tbYMjwPkztUL
 bnv3zcm1zYUcbsTrgslU+ZG6ZWySdjstvFIm/GIqFT6TjecrQjH4Wippz5APWyqMnPN6zQBtGw7
 2GtQ0nbPoXb7n+ZzCH7/WYcQyh39/ZFNXZp2rWVQvNNRn/DuIUP0AFdpIrJkj/ZfrRivJ/Ds0mS
 DvBjZ+7lZRS5qFJpFL5ty/AvTKTEo+AABnEglQ8uK3X60GO7U/PbGgeIARJ0igWNFGs713aIY3p
 X0k6If0zyMaprxQrp1A==
X-Authority-Analysis: v=2.4 cv=Fqo1OWrq c=1 sm=1 tr=0 ts=6a8c072d cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=7WNnuz4HuO7MmHYjhCwA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: YA2giWTwIkW57OugyB8HfqxTQm_kHgFS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NyBTYWx0ZWRfX2PXdghBJSGl/
 t4O4UxYeEAIRRIdjGwBNp3fB0ZZVwi39dIUW+iUT/oaGYreE8WFqScERsp6wv2wnEhWIItPLcjU
 +fAiBSrUYjC1q4XSbGbamNTD2f8RD8M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240077

On 8/21/26 5:40 PM, Sreeshankar K wrote:
> Add base devicetree file for SM7250 SoC.
> This file adds the basic nodes like cpu, psci and other required
> configuration for booting up to the serial console.
> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> ---

[...]


> +		cluster_pd: power-domain-cpu-cluster0 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&cluster_sleep_pc
> +					      &cluster_sleep_cx
> +					      &cluster_sleep_aoss>;

nit:

<&foo>,
<&bar>,
...

(compiles to the same bytecode)

[...]

> +	soc: soc@0 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0 0 0 0 0x10 0>;
> +		dma-ranges = <0 0 0 0 0x10 0>;
> +		compatible = "simple-bus";

compatible should come first

> +
> +		gcc: clock-controller@100000 {
> +			compatible = "qcom,sm7250-gcc";
> +			reg = <0x0 0x00100000 0x0 0x1f0000>;
> +			clock-names = "bi_tcxo",
> +				      "bi_tcxo_ao",
> +				      "sleep_clk";
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK_A>,
> +				 <&sleep_clk>;
> +			power-domains = <&rpmhpd RPMHPD_CX>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
> +		qupv3_id_1: geniqup@9c0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x0 0x009c0000 0x0 0x6000>;
> +			clock-names = "m-ahb", "s-ahb";
> +			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			status = "disabled";

I think this wrapper can be enabled globally


> +
> +			uart2: serial@988000 {
> +				compatible = "qcom,geni-debug-uart";
> +				reg = <0 0x00988000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
> +				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		intc: interrupt-controller@17a00000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
> +			      <0x0 0x17a60000 0x0 0x100000>;    /* GICR * 8 */
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			interrupts = <GIC_PPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pdc: interrupt-controller@b220000 {
> +			compatible = "qcom,sm7250-pdc", "qcom,pdc";
> +			reg = <0 0xb220000 0 0x30000>, <0 0x17c000f0 0 0x60>;
> +			qcom,pdc-ranges = <0 480 42>, <42 612 28>,
> +					  <70 63 1>, <71 640 15>, <86 522 52>;

1 a line, please

> +			#interrupt-cells = <2>;
> +			interrupt-parent = <&intc>;
> +			interrupt-controller;
> +		};
> +
> +		spmi_bus: spmi@c440000 {
> +			compatible = "qcom,spmi-pmic-arb";
> +			reg = <0x0 0x0c440000 0x0 0x0001100>,
> +			      <0x0 0x0c600000 0x0 0x2000000>,
> +			      <0x0 0x0e600000 0x0 0x0100000>,
> +			      <0x0 0x0e700000 0x0 0x00a0000>,
> +			      <0x0 0x0c40a000 0x0 0x0026000>;
> +			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";

and here

[...]

> +		apps_rsc: rsc@18200000 {
> +			compatible = "qcom,rpmh-rsc";
> +			reg = <0x0 0x18200000 0x0 0x10000>,
> +			      <0x0 0x18210000 0x0 0x10000>,
> +			      <0x0 0x18220000 0x0 0x10000>;
> +			reg-names = "drv-0", "drv-1", "drv-2";

and here

[...]


> +		cpufreq_hw: cpufreq@18323000 {
> +			compatible = "qcom,sm7250-cpufreq-hw", "qcom,cpufreq-hw";
> +			reg = <0 0x18323000 0 0x1000>,
> +			      <0 0x18325800 0 0x1000>,
> +			      <0 0x18327800 0 0x1000>;
> +			reg-names = "freq-domain0", "freq-domain1",
> +				    "freq-domain2";

and here

> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> +			clock-names = "xo", "alternate";
> +			#freq-domain-cells = <1>;
> +			#clock-cells = <1>;
> +		};
> +
> +		tcsr_mutex: hwlock@1f40000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x0 0x01f40000 0x0 0x40000>;
> +			#hwlock-cells = <1>;
> +		};
> +
> +		timer@17c20000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			compatible = "arm,armv7-timer-mem";

Compatible should come as the first property

> +			reg = <0x0 0x17c20000 0x0 0x1000>;
> +			clock-frequency = <19200000>;

This line should not be necessary

Konrad
