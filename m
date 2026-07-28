Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4D3D6CD8
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226136; cv=none; b=VctKnbhLrjSTttdpO/3YLx7bKrlbxl5gY+1+h6H9sUufPniU4U01aXwc08TW3QDsapOsSQfSQ7U+IxiqMSaVINK53iIsOCWGjJYL1eyvKRYTTLgJAL5p2skg/Meei49acSPK1JntvF4UKsSAIHCG0GnzkXmxVKxA6PYMMq4dSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226136; c=relaxed/simple;
	bh=mPDXysXj5lzIWFwy6wC2FZ/rGmW2AByblfFrnVyPj1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJkPBxKagsBVM6wI33lj5s5OZzlt0MIcG2MFyNktLlhJENt+c8aailMTRmxROGVY67aT9a/1axsR6WU/4GVy8evMIiX1KRfiGA1QUm4WC4EqOShdh5o12g3fX7Uq1t90lAfhyFVVCWXB+n8uhYwHd7sSgIf3VApqNvSiIApK2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oECY8N2U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e6EVttDI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oECY8N2U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e6EVttDI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S82NwK2144983
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 08:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k4JyYcB4rNl1WLdr8qEJ8Cc9TJtQG+TnKG6hDCnD3Po=; b=oECY8N2U1G+KxAvF
	89Mm/FeNM87wXi/JdA1ceMollKJ2MVFvB6ZtKMe3BHkVvOtxGH//KO8Jj/yJngPI
	REv/xoC5Wz3GMGHH7mZZ0cXoKKwz9ASwKdCz+vF/NYDoGWREo5yApcDlI/BNe7zu
	qfONhCIckdfvkr7xjBWtKLnK1+a+uMGyBpkW3EQ7RORkMmTPTbZy6l+WVYQSRUy6
	Koq9flzKVVc81KvQKJTmG4hg5g5A1J8s8QXyK0w5i/3RXjkEwBriH0j1fPh2Z0k5
	N2YGxL8w8Zy3M0foNjcvf/uoJwOoxFKSzHFlZii1b6c+9WlywSiIFg++CuiLdui/
	4c+dow==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19gwbj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 08:08:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c9e97b626so5715831cf.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 01:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785226133; x=1785830933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k4JyYcB4rNl1WLdr8qEJ8Cc9TJtQG+TnKG6hDCnD3Po=;
        b=e6EVttDIYbsD++hqUcDaazn32nGKRctDb5XImyPW0rLlyMw1GVb/rwmQPjl0h0Lf94
         BJZWhfA0k7NVOKFFb22HXYjkDn4Iz9n8fRJDSPofUQReQYlanoZt68t2EfT7e0babCAJ
         ILzFcn5CaopVusV/GqDFoVSYVMsMVDrJcb07/oZMXBrW97LeQ74lnZkNgYj5Z8fsW6a8
         v+2TXD9dhGU3bsycq6hbdrYs25hyP2W2qUs1+APdn35+n5ac3bmnJcPbrt5O3xef/Uyl
         tmQXAsn9eM9tSuxpfzW4z5j1QkwuLLNn5q+df110DySC1he226H5iBbRHrWFZ13A/Y3T
         UJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785226133; x=1785830933;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k4JyYcB4rNl1WLdr8qEJ8Cc9TJtQG+TnKG6hDCnD3Po=;
        b=c109nZC4oDLKtsdYXZnaFin9tHyhAVBsSz9lXDszVkhWrPToyzi3T/m7bg08J+Q8BR
         zQyNAry9dxfeHCeO2KMzZI4NSLV9NOB6E5kZFiLRDjihD8B4iJ1WFeRMRlsB/b+avcvi
         MEONhQ9IONEB0XdeaZu0BgxmnUzINFBJXZ2yewxJiMUrUPr/7LYkuDuPwSirhSNbaDXD
         4O5pFWt6orAXTd7e1pwYC2Od/0MGh//NoLd7U8aFo8RD60TP0AxmLBWYXFaOkoOh+ofv
         oq4iUtj1dmbgNu+n3rwZzKlmx8Qna7dNXzu6xUrJlbBSPf1+YgWvYSv92R3foQbvbKqU
         F7Lw==
X-Forwarded-Encrypted: i=1; AHgh+RpTdu2I9pVXkXNq4mqqXnRRTHk6EvhIP9/KfC6yLe23jWdL8Ng9vC5eNRRFtbU6/wArqlG5T8HcaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydH5GHr6QqsSE6jLTNgFwx1nz8OLIl8k1R2lUjCbCpnaaKb/4H
	/K5lY6/6ob4XLqZKDhJh8MJfYONdDS71sKteShDoUom5TO5qR2YdmbpJmNjxbjB7hCppXEDDThM
	dD+HteC9nspFzwXYzRsDLuvoyiGzLtzux/wqel6aFnMI9OPO0y5dOGdPE3+F5Jw==
X-Gm-Gg: AR+sD10Pvdh2lHNaPM0y+tWWx0vENeyh5WujICG18fqQN8l3Zc5k7Us1qeA72xqaLi4
	nvdNmcbnNWdOaxBGtlQnxH05CMLqLu4I2cZRrkbx1qfPRQGIl2c2G1iUuzjl3agMs8Gpm9Inxy5
	PVV9/71Il7Zs2vfZYO4PsupK4iB9CjbpSeDNYTyWbPc6jQnS7M77wuKmFheA1yQPT8qT4TyhRvO
	XDMBUHx5juRH/3UdMtRAA7IjiCmXrGWCuNL53S8mEnbX8uFjRTzwZ2v9EfAQI6Dur0oe3YTToze
	M7Zjtx9uhcI3zk3jAhcQxMrTOW0p1KxD7yZLqoT7QoK+knvtXtBvzI8MXIyXqbjbpZ1gRv0dgPB
	1wN3640LVmAqxSAVk719C5O6L
X-Received: by 2002:a05:622a:a98e:20b0:51c:1c73:51a6 with SMTP id d75a77b69052e-529d6fe33e2mr6436221cf.5.1785226133621;
        Tue, 28 Jul 2026 01:08:53 -0700 (PDT)
X-Received: by 2002:a05:622a:a98e:20b0:51c:1c73:51a6 with SMTP id d75a77b69052e-529d6fe33e2mr6436041cf.5.1785226133066;
        Tue, 28 Jul 2026 01:08:53 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32af244asm720034066b.27.2026.07.28.01.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 01:08:52 -0700 (PDT)
Message-ID: <b417ff8c-7829-4db5-b3de-9ee946c493f5@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:08:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
 <20260728-eliza_evk-v4-3-decc7fe5246e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260728-eliza_evk-v4-3-decc7fe5246e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a686396 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=obKXXINtG9EwW41erPwA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfXzU8oGkBeF/Hp
 NCGHkeD8hYrN4C2rSolmV0wNHraNZw/p5B3glz63CO6UrIK0YpDL6ZK/E4WRZ4iRkcfEbI8ChYl
 wyb6nOq/dwy4761tmc0Wjj6emH+u/XVPYsxFFrIrFqTuzl0NHaJg0VjgCsUJFIIE3dzVnOoF44C
 8UGYynX8ZeTyOFtvyuBWDM9qkcRPpXq9jFLjH47kL4PADknkHjG/zGwWu1X+/E2fX7YqkdpGmS+
 Mn3fb/D6oguViLQwGIKDyF0wDICZCdS16nSvV6Deacfq8gM4hb4XU9/2Ou/2nOs2Rx4bjv2HLsr
 /9gFY3WuVt+825lhPrBECufi09kIOg4gZWaT4utQ9m4VRljMQppPRiUWLyrrIC1V/+CaWM0GdFo
 7G24NS+QJxkqueyQZV7RgZU9qbW/fkFVDLlnOLN+awtq+amiN+wISHcSrslS1S47t9fRoknqFjF
 62CRy9Ga5bz5JOD0u9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX2CjsYKoL1xoh
 Jy0RfzufcuddRzyiwpajxeU6xKYlGHEM/gxevvG6xu1t4W+5KcnqmDhdkjafHxSw90Rg9bx74kd
 83WoQhLpd64UVU8kxqlYzrNSuiyfGxE=
X-Proofpoint-GUID: awfnwM_hlKwK3ZVC82gc1MY7HweZx6m8
X-Proofpoint-ORIG-GUID: awfnwM_hlKwK3ZVC82gc1MY7HweZx6m8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280069

On 7/28/26 9:06 AM, Krishna Chaitanya Chundru wrote:
> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
> 
> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
> 
> Override the base iommu-map with the expanded set covering all the
> switch's downstream ports (0x1400-0x1408 SID range).
> 
> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
> from the PCIe controller.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

[...]

> +			reg = <0x21800 0x0 0x0 0x0 0x0>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			ranges;
> +			bus-range = <0x5 0xff>;
> +
> +			pci@0,0 {

FWIW these subnodes should be pcie@ too

Konrad

> +				reg = <0x50000 0x0 0x0 0x0 0x0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				device_type = "pci";
> +				ranges;
> +			};
> +
> +			pci@0,1 {
> +				reg = <0x50100 0x0 0x0 0x0 0x0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				device_type = "pci";
> +				ranges;
> +			};
> +		};
> +	};
> +};
> +
>  &uart13 {
>  	compatible = "qcom,geni-debug-uart";
>  
> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
> index c99bcccae00c..2ecfeddea496 100644
> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
> @@ -2104,6 +2104,7 @@ opp-16000000-3 {
>  			};
>  
>  			pcie1_port0: pcie@0 {
> +				compatible = "pciclass,0604";
>  				device_type = "pci";
>  				reg = <0x0 0x0 0x0 0x0 0x0>;
>  				bus-range = <0x01 0xff>;
> 
