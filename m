Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD06D3FBB76
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002681; cv=none; b=bklKDeiFqcxXRXXeSMO73KSEKUyShir9Hd26vz5GASPh7USdm8DTriwfmvRuS3gP03x7ByoYHP31wannmH5mAj4oL9yn+x61h6REaQwdoHM962LsITrSb1L/SgTEk7Msd+BjP+Y5lpdwCfsS6cJhyqQKUodbTL2dUJKtkrBwtqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002681; c=relaxed/simple;
	bh=Snhn7dRLdqS8fBHHgHnMySufiY9dAPo2wQhFcMJ8E7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZ0vyHWs153z0TEufTcXQjrD3TXoBk5tOWDBBiHVS3/OhhDFyu2iwh7nBXV6qwI4wsqb2P88aiaASCBX8m6AjMO7iCEA9g9ak1701K1/HGgqXNWaxCITi4YsKfOfUE09ofzFq6dVbiYxt5cMThhHFNSzozmcSa205FuSg8PbtHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Koi4N7dV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N0VTh1oq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Koi4N7dV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N0VTh1oq"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599vDbI1868510
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 10:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f6ILln5Oc0CWwbe2t2UAsyz9mJqiBbsefhKMfnN8zy8=; b=Koi4N7dVFxWniD0C
	y+nFDFeFKdRgtI8TYcWSeSOxgWyBvJJybKtueHZjAeFaqdXxkIB1Ra5OK7dycHVX
	crUdNWPOItJB9i2v9O041mNl38BmagGRoO09Xn8QxLONy74mSe+vqUEo5kZQl6NB
	OSKycl+O04ZgtoR4fKh0waf5jj59OUqTrjAh3+JuMpg/lpJde/+yu9ZQN0YvMgYQ
	HnQ49ozTGWi4T5KcpdhpRAb6HcWCuqkc3QIvExbLZ2IeVURqwfuR6L5Sz4AjxkLb
	50zXKFltP1usSJUx0LxsSBGyGcBNjud6ZBGcSMBbh2a/DnyY5U8UaZw8jNtXTD6r
	21VTPw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wgbjd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 10:57:58 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6c69c788ce7so2248900137.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 03:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781002677; x=1781607477; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f6ILln5Oc0CWwbe2t2UAsyz9mJqiBbsefhKMfnN8zy8=;
        b=N0VTh1oqT0fi3tT42PIiUv060nj0+k57o2BGnFfWAabDy5oOluMzdmuvKTQz6k8zrs
         Ko8Pa3zy8uM1I0naA91Hy3bppBWGjwPCnjJ2gZRq81YiWG50aRDAFZiGJl1HA7jaU2ul
         eSvIiuil8Oa1C3OjEwVF2hdx1cUmQqwBgB7bMXG2J+3/1pFnitb3c1aOon/QpyVIq1BJ
         n9E7VzLQYGnadvsPxFrRQ4GNDOQ5psxWm3avauBXPB4QxR4wz99Jbn+dO34hd8B3SW0W
         UOCmRc8M27IXDX8EfZbLXUq6HYncmYiKmYkpSm8+jb7infAZystrJLeV5jKq/0JeTD7j
         ZRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002677; x=1781607477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6ILln5Oc0CWwbe2t2UAsyz9mJqiBbsefhKMfnN8zy8=;
        b=Tv3R//XRh8vE4iWfrMvlQdFb+SniROlDVe9ek+RP4Z8xzyIRkmTSW3TKUrYUmjPEil
         0VCo+tegYdKqsTOiugiJQK+wwbyvR6K6hkzwUAYyydACuSvnD25LDI6B5N9UQzIDfd3U
         NLIAhRDhDmbUMSdBAVMVotatsJgmeaquCUTeCq6Nd6ZGBS4G1VpP4tcXTtUQrkksny9P
         rwL2nJE2IJd+3IoLtnPfOIoC2bL6ahRG2V5JEwl/LnSEo5JxYZOUQFltx40o4ju6bQM7
         2DmOKibss/Aejwu4wVo9FaL06W4WDygL5hA887dunD5rpXIM9knXCkwL+aQ6MUfCFlIa
         uozQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IucmccBhfmsib8i7r050Dx0EMt94f7q7i2EfyC9k7e9OMNv+y0WkMETclEVKKyw3Bj+PVUnJUKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrZGc3uLtZai8DkH06ZmHW/1/TxHrjAjEOsnIS+PSiVgCIBuww
	ml83ISN1eaEzXK0cmyUAZrS2IisZ2jKYqLVj1hMCZiF+PjqHBce/MuCxm7rcBNvTitfnLrYpe6L
	O8UgPXCPe+CPH5ckigUJ1lpEO/72Si0dgcn8bT+mCZKJX2Xk8rE2fSOqu2Z2XUw==
X-Gm-Gg: Acq92OHWeHICRAqwT2wpqyI0xcd9nGV/zQP847Nt7xIjGpQ7yi4rHKjrTgUeqMqjLRF
	9UKoPsTl4X83QD2yFPOMt59sOhF6gt4i4dlvOm+tOzkI1TaHT1Glsv8FfruiN+EX+YXUKZDtBAM
	XewEdseJaU6QEbMFoKUQQRGcRG5/3FMZ78+hdaXMyuBu8+mbmLg1kTTub7liOCwL96Vbu8t03nN
	WoxM2IfPyUU8MRrdCHU0azO4ivIkjmSu33G0JzalAsm5aWATj1SFU0ONX+p6M0jMxT5M0w8oiQ0
	6jE5R+GadpWQF8CJDbpfoTbI3fb0voEImjCuSXhlpttGrofzdHY3sLnYtL0olqR2BvDd3LXcWH2
	1pSrSr+V9P9kCwJPumK8oUb1RRWft5og9RZUYK8Q2+X2Vl188hULvQ/wSRXlI84OVE5cBXgt2o0
	EIlRdFLAzRNqcpHXDdQIXOffT2ntPOpHaTr0QhePTVHUkt6w==
X-Received: by 2002:a05:6102:fa0:b0:611:e0c2:1604 with SMTP id ada2fe7eead31-719367de123mr712098137.19.1781002676995;
        Tue, 09 Jun 2026 03:57:56 -0700 (PDT)
X-Received: by 2002:a05:6102:fa0:b0:611:e0c2:1604 with SMTP id ada2fe7eead31-719367de123mr712082137.19.1781002676561;
        Tue, 09 Jun 2026 03:57:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97a74asm4447482e87.53.2026.06.09.03.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:57:55 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:57:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: Re: [PATCH v3 4/8] arm64: dts: qcom: kodiak: Enable CDSP & Modem
 cooling
Message-ID: <pf6rymdtbfcqqzt6vnn6gc3uuod4vlfpw42dxxag33aom7lltu@6ymibirvwfnc>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-4-291a2ff4c634@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609-qmi-tmd-v3-4-291a2ff4c634@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEwMiBTYWx0ZWRfX/y3ElfgoIg33
 NXg4ycUynp6DR5MUVKkaZN7fJvyA/vBvCY01upznX8uT1LxUjifCf3YtvpO2JxQ0VVsitz3Jdty
 zUUIoPz9uaA2uRuAelRpeP/grOlUZVfIe1etmsrm6lsMX4Mgg8MZErTFW2UZUwJr5bbQC3xdTyT
 2OZcgKuL+87VBAAct8zkyoVXpCsB95y3Bg7VyP27DPYV0PAnFp34ug2/1HFXGykyAiAjD0p+muK
 YoqEwxqMCKKrbQZSL7gQwkGPX6q92A/U+2Kvc+jdSsQdE1SYtyliPHM5H6SWmiqSOJCQVPL2bKq
 SAXTP9dPWXSbLLrX1mStuDxLJXdvZZjJUzLs4yrT7mqX1GGaEzI5RkfepBByIhwJ6w949zSJ7Fd
 AQUx8OsG2m+vgsr85WcO5JEWbqKDAbetWtzTfNi1YdQXsxZuGeLolKR1s90YZdKfoLoqiSh6RiO
 rUKszOMGN1IOf3sLR4g==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a27f1b6 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=LIoh_saxUwtCYziVtm8A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: NegnCZBa5cplGvOxXbHT9UJiGxsoSgYU
X-Proofpoint-ORIG-GUID: NegnCZBa5cplGvOxXbHT9UJiGxsoSgYU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090102

On Tue, Jun 09, 2026 at 03:52:59PM +0530, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP/Modem does not throttle its speed automatically
> when it reaches high temperatures in kodiak.
> 
> Set up CDSP cooling by throttling the cdsp when it reaches 100°C and
> for modem when it reaches to 95°C.
> 
> Remove inherited mdmss cooling-map nodes for Non Modem kodiak variant.

Why? If it is a GNSS-only MPSS, does it not provide any thermal
mitigation mechanisms? Does ADSP provide those? WPSS?

> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi               | 127 ++++++++++++++++++++-
>  .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     |  17 +++

So, you removed those for Radxa Q6A, but not forRB3 Gen2. Why?

>  .../dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts  |  17 +++
>  .../boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts |  17 +++
>  .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  18 +++
>  .../boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi   |  16 +++
>  6 files changed, 208 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> index fa540d8c2615..d345add2d8c8 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -3427,6 +3427,9 @@ remoteproc_mpss: remoteproc@4080000 {
>  			qcom,smem-states = <&modem_smp2p_out 0>;
>  			qcom,smem-state-names = "stop";
>  
> +			#cooling-cells = <3>;
> +			tmd-names = "pa", "modem";
> +
>  			status = "disabled";
>  
>  			glink-edge {
> @@ -4787,6 +4790,9 @@ remoteproc_cdsp: remoteproc@a300000 {
>  			qcom,smem-states = <&cdsp_smp2p_out 0>;
>  			qcom,smem-state-names = "stop";
>  
> +			#cooling-cells = <2>;
> +			tmd-names = "cdsp_sw";

I'm going to review only this DT, the comments apply to the rest of
them.

So, we have two cases, CDSP and MPSS. Why does CDSP have only 2 cells?
Just because tmd-names has only one name? What if we add another
mitigation (which can be added in the firmware), do we suddenly have to
change number of cells and all the cooling devices to reflect it?

Finally. If I understand correctly, these mitigtion mechanisms are
provided by the firmware. Firmware differs between the boards. Vendors
(in theory) can change them. Why do we list these names here, in the SoC
DT?

> +
>  			status = "disabled";
>  
>  			glink-edge {
> +			cooling-maps {
> +				map0 {
> +					trip = <&mdmss0_alert1>;
> +					cooling-device = <&remoteproc_mpss 0 0 2>;

What does this mean? I assume that the first cell is one of the
mechanisms. What is the difference between them? Do we really need to
list them one by one here?

What do other cells mean? Why are they 0 and 2 rather than
THERMAL_NO_LIMIT? How does one come with those values? This should all
be documented and explained somewhere.

> +				};
> +
> +				map1 {
> +					trip = <&mdmss0_alert1>;
> +					cooling-device = <&remoteproc_mpss 1 0 2>;
> +				};
> +			};
>  		};
>  

-- 
With best wishes
Dmitry
