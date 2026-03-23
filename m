Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06481390210
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262476; cv=none; b=JUW6i6WZGK5mmqDxAgREWg0FgqFC/Ax4t79gshhwLh35AbRQlZN+ec1FVnqVC2Qhua83ZkWJemIBEWgnn0TIrhFQpT9nobbUrZp7F+cHOC/N+dKwpm8N4IT2W21RN447I9DlDd69Gg455eng6Gg/0KztNJs+RS75rYxreCIw7eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262476; c=relaxed/simple;
	bh=7oMdsqXRGNvaicdqOHAsaU4zBGqBAOxTdGO3h9kw9xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+bNXxCKmQZgYJZtpSeTbLeGhJ79dUWUMt4HYkqWDasXTaZDFcQa7HNSOReTnrolTCLmDCibN68dXtf+i+yMA7nwsPTtr0TtoNlRtdyvaJ725t/0xqnP1ANEm50pM5f1qDc8GMErwPkuWcj3D5VOGDG0D2OScWtWwnodmhsQr0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nOxh1LSJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jhh5+AXP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nOxh1LSJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jhh5+AXP"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N9uGXQ745170
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q8LBTPEg6h1Y7za/pguHJmr2p6xBplPTOo6n03VNRxw=; b=nOxh1LSJ7nWE1wpR
	enNoFVHVoobdSDgDMt2Kb+JRKU91/XKmOiq7aqpx4aYklieqZ2InjPy6rPTE7uWE
	5Rsatz9wmJpjLKY7RuPODp0UO3mgV09Otmo2rpgDpYbbfQ3ql/mjDupjbjrQat6Q
	yM2FaFGxfBM16BmF8921O/rUAzwlqmLPJyLog0XtsIrDxb21Z9d/aROJEP5jgSFs
	GDko+xp1LXz4mWNeRuchVY/f9x3goL7NoiNhTGD9bVX2aOkeeginI//5X4kV+VE+
	gi4W0vyfskPCahoPDIb5wgFxaQQHNsPQdhdYa6wqijC8D+ZeqGKD+kz4KqrSs93n
	jjLNLA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jb5n2vv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:41:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b2955cc1eso25532681cf.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774262473; x=1774867273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q8LBTPEg6h1Y7za/pguHJmr2p6xBplPTOo6n03VNRxw=;
        b=Jhh5+AXPKfPcKp/WvVPHeX8FsRt55COVTCagbCAuJxi4+y9udeof6VMpZjQBSHcMTk
         ZBEJrr8Cl6Y/UFfFm3vWjxd+BzJFGF4mWM2XXAJImcrAnVALy7DKd9cSI7Uzqv9Rc3eV
         7HqQxtgOSAQAw6TnOQnzfUbdYiqk3YR3COC1QUddCKz3OuP/m9sbzn6EPW8AB96GLajO
         s7ylnLzu4VsL7SFf0nyinYgMKH3yA876GkTzg7v35DS/9FdLMUvw8x3okc1YCjYj2obQ
         RHeGgu/CLibmSZv3iz5V7zyEp2oemDlHNg5P//wIB4XbTQea6Lr+PT8uKshGmlgeKFdW
         1KDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774262473; x=1774867273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8LBTPEg6h1Y7za/pguHJmr2p6xBplPTOo6n03VNRxw=;
        b=iRvdd7V78SIz9CuIn1u2nVVEtgPczch6rDmald8gIjZ2qXqvruNAPTRP5464FcRD8C
         MUG9dmecCqdapgmT2fCNygP0TQPb9/2XJyZod8G+IN1H0hOILkMQbpwIqCUVrjVmgzx7
         p3FSktUvNRHF4iGhSXeTPGXPFRzVcjLj+RD+wf4oEFxM5Pr6Dz7su4qOUR1xuA4PxaCy
         tXbYoT/qZBHP8KjCcv+km488OLx4m3sBpi7BsAvScFahm3ACkfYIFY+2r23hP2aUrgc/
         lG4bMMQbiPCnWX8jsSXkvSjcw18pmGHEC8IiFx5WrMwqbdGrsJVNxKA2tuCV7tt44GVn
         RPJA==
X-Forwarded-Encrypted: i=1; AJvYcCXHXjOaBwmH6PKClg6ZOJrclV/2aWuERkn4OHPwbT2dITken4kJOVBwjuPyMAuZ++zVtIHDM0nhsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHNMZQ/HWYRNyZUSPQpM79EkVVMNPnSh3Kk3TyFNuyAFm78F+P
	yIyeCfRB9Wt9XggDkAretLlx3/rgEP5y1/zbLA8T/BXxcmhd3FMFh1ahBL5IgecBc9KyJi3NPg9
	qDUeH8B76je6v3p3iEGDiOR00Xn8FpUe+ckqLNPFnPDL3uyn+HAiGyzJemRrldw==
X-Gm-Gg: ATEYQzy7678yL4f17vZ8bsnaw/K7v+Ek2Eq3Jy7OcPLPsJBzferAIAPMVDYVyyjgDQO
	tctfZldxDo4OOorFkXSqB0j+lYXTXOl1esFjXQP+WBbeH+7jV0rlF/QKue2RFLoMX8BBnqdh7Cf
	+A9PRoDc0eQcpR9wVCEECGyjQUBLrvLFgdloBpaw/k1pCXltEGWVwo590PeWCMlIXCYzBv5xc/G
	2tIDieyNDVOo4FRvf80VEHdyYYcXvGsoAfT2j22TSws3EWkXpRWZpu6oBDr/RzfYyGWGCg3diCq
	W/cospm4bC63yHaIXVME8ssp8EXoKwffZpxYH2UKB0+jUlkeXVwo34SWD4SGf1orcPpwQIYJfqr
	HAl0wcydWP9MBkvuzZC27Ne+blORVRnPmyaNyKjAKS/+eOQNmCME4QYrKOempku4l0JvhQEpIBC
	VguNs=
X-Received: by 2002:a05:622a:4cd:b0:509:47e2:9df3 with SMTP id d75a77b69052e-50b37425671mr126608541cf.1.1774262473376;
        Mon, 23 Mar 2026 03:41:13 -0700 (PDT)
X-Received: by 2002:a05:622a:4cd:b0:509:47e2:9df3 with SMTP id d75a77b69052e-50b37425671mr126608331cf.1.1774262472926;
        Mon, 23 Mar 2026 03:41:12 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-668cf7e30f7sm3571255a12.8.2026.03.23.03.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 03:41:11 -0700 (PDT)
Message-ID: <e01920a9-6e0e-4101-b329-baa706717cc6@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 11:41:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] ARM: dts: qcom: msm8974: Drop RPM bus clocks
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss
 <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
 <20260323-msm8974-icc-v1-9-7892b8d5f2ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260323-msm8974-icc-v1-9-7892b8d5f2ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aJv9aL9m c=1 sm=1 tr=0 ts=69c118ca cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=wPxavPm_kgLNTp2k2vYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: s25r-TmX2RVTGPu5fyRDlroYEC5JVXBf
X-Proofpoint-ORIG-GUID: s25r-TmX2RVTGPu5fyRDlroYEC5JVXBf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MiBTYWx0ZWRfX9fdkwpJDGOoG
 xz6oMMGY4nvFxIUQYbeai19zGQht+Vxh7CuVUqLKb0oUnKaZhRyykbYQEVfdH0xXLnWQPKhMbVe
 urdZVxTPnS+iYeCEnwbYPR9fD0V3St6GZsMM4XWOqctla2eR9acBtCRsNxnz+QXOgiOvFgMihtQ
 EtmXBL8MNobzeOvlyNTaDLDbnQ/Q2tgnwc2bZRGWIAW8QjCXChvDMyC+8Ozn0LOcX7zsaUobz9X
 cLnxrtrAkJ5iY5/DRFKETrDQLk7QfKbwrZl7YNdvbolnICkDm/6L5AaxCYlMhDkSzZIQjBjLVmX
 T0fa1ozqS7WgMM5ZJ3jZrdIGQHgmt5lVLqhKL7AwxEDOcleyjwI6RLUpWr7OLimCFdGEzHfc12u
 yxfVRXz+1GYLetAGww2RVJO3ULr/rJFeb+8CJrk+xKDFUuuBwW3YTN1rkCIJvbZXHL7fhrxO8we
 J7dhCOXgzq4l/+aE9Fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230082

On 3/23/26 2:17 AM, Dmitry Baryshkov wrote:
> Some nodes are abusingly referencing some of the internal bus clocks,
> that were recently removed in Linux (because the original implementation
> did not make much sense), managing them as if they were the only devices
> on an NoC bus.
> 
> These clocks are now handled from within the icc framework and are
> no longer registered from within the CCF. Remove them.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

>  		mmssnoc: interconnect@fc478000 {
>  			reg = <0xfc478000 0x4000>;
>  			compatible = "qcom,msm8974-mmssnoc";
>  			#interconnect-cells = <1>;
> -			clock-names = "bus", "bus_a";
> -			clocks = <&mmcc MMSS_S0_AXI_CLK>,
> -				 <&mmcc MMSS_S0_AXI_CLK>;
> +			clock-names = "bus";
> +			clocks = <&mmcc MMSS_S0_AXI_CLK>;

x
x-names

please

>  		};
>  
>  		cnoc: interconnect@fc480000 {
>  			reg = <0xfc480000 0x4000>;
>  			compatible = "qcom,msm8974-cnoc";
>  			#interconnect-cells = <1>;
> -			clock-names = "bus", "bus_a";
> -			clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
> -				 <&rpmcc RPM_SMD_CNOC_A_CLK>;
>  		};
>  
>  		tsens: thermal-sensor@fc4a9000 {
> @@ -2223,6 +2207,7 @@ sram@fdd00000 {
>  			      <0xfec00000 0x180000>;
>  			reg-names = "ctrl", "mem";
>  			ranges = <0 0xfec00000 0x180000>;
> +			// core clock is unused, kept for ABI compliance

Do we still enforce C-style comments?

Also "unused" is not really right.. After the 'revolution', SMD_RPM_CC
no longer ""provides"" that clock in reality, since it was never a "clock"
but rather an interconnect resource

Konrad

>  			clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>,
>  				 <&mmcc OCMEMCX_OCMEMNOC_CLK>;
>  			clock-names = "core", "iface";
> 
