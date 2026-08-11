Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CC93FBB7D
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438405; cv=none; b=qlNwLtaNXUJXVVgZyZzWLP8pY/IKOTEsaXGJGACtw3jpt4ulnU8dhyhTHxJP47xfZ5m7fD9XZ2Fi5cJgs0WN08Zed5duslEmhOmIV3GAOss7uFQz6hO8l6WbWs4Wf7fVLoJ8MONB2Igsn6pn22Zj8FDaXgG8SgvaZsBL4gmiOnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438405; c=relaxed/simple;
	bh=AlpHueBt0nZVt2Y7hVkWqy5+bwLUYtg+CHiJAgfM+mI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHt95CNrD3TlbHIrN9ghuMG9peBK+vFBM/9dcbjPBSEjFHnoKB27BIEZDhXPLFCbtx3BaAxFWiS4GT3HkodTrbC5yGpfSZ/b/EM1ncrn6ORf8DQUxp8z/Fe+LOz3Yk4qE8b6GYWxeEVBbLvs4p6Jrvu+CNYjfgKrPJifCZ0HEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F2BVe03n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BY7gJk2h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F2BVe03n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BY7gJk2h"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B6vLAP2706443
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 08:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r8FaFxPD6abqtYobI5S6+75PJDnGpTU9ePdvdvXeAHw=; b=F2BVe03n5ioKA2IH
	+Yf3xy5KymoZ/+9/3BsXGZr+lL1yWAPoEcv2nHxey1DItm5zRs+vCQ6S2yy8sNxq
	5xLS7hoNCU6Pf+r35e6NH+SKGyXI5b1SUSwW70vZ+hcE4pjAklBMveZkqnC1BxAQ
	ZCzYr4u2KlZhlLg6AxpDjbWxqGAPA/5HMHrXzew03TaI9e7Tjj/w7qW8/SqAzk3J
	C4uqOSD9NqF+RTfkRq6iz1lDYBfnoW13/yhk1wOTilrFfAhEF7PkuADk3RKTDRI+
	uj6YeQTlkEF8pcNNET6luloRjZcZzCZot0nYO9pQJU8SLonVdxnkV8/oH6XOHmSH
	5UDFhw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk6399a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 08:53:22 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f0fe57470so768900a91.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786438401; x=1787043201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r8FaFxPD6abqtYobI5S6+75PJDnGpTU9ePdvdvXeAHw=;
        b=BY7gJk2hUMGrvNcmKRz8+5iQMaWRBeOoPjC/BcMnLVRo2zu2jSthNAgTy13gWmBJPy
         jETzsZM+9ALwq+QckooUUPC55E3QsnFPAueGLVsaWp1hOysncY9eiCYKP6GSXOfXU8kP
         Mlo6rJsJrTcnYPmrFUHXtImd88L9dRUnXs2oYEblTVdBb2fGpAYqGjfpgJjw3Q5DNee9
         XVjxQjCC2EjX+vWweTPdgnwVd/F2XBIwQNtQx1dSyOHVfDvWBB27Kp4+Lgnw+WpKnIAM
         WXjAdK1YJV63M3TSEUQBMGNlmzeueotOeIVaKzWZ9zNfKH/yKCBMYMP3At2bT/TcmHON
         Ej5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438401; x=1787043201;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r8FaFxPD6abqtYobI5S6+75PJDnGpTU9ePdvdvXeAHw=;
        b=NTtY7N/SUXbNfVb9XdzQK20/zOn0DlyvJUhtXP0mnU79nAfC9GHkhDuQD3NpjL0kgZ
         JfSlvNus1HYUmTp4UmI4s4g3nSKVRQsLWKds0Ue+p8bCoqmM4IKyhPDDXl0ZD7vKOEDF
         fU8GluE74Dm+YBKA51wuUWlTFhVPeGLY/uST8OQKBWo8kMeegG4MkUtBwFcIK7JGaTri
         e3F/D14QGDiF1Vay2NzAevmuRh/+vxEoRqpipNleJ8sAPgGqkjIt7zqzZQghbuuktcMA
         XKyMJezgXYUOOJ53FWz0aSl8Kabzvj9fgCQng656zuQqnA6FdN++tGkT2NdH5+mKFXu4
         fKWw==
X-Forwarded-Encrypted: i=1; AHgh+RoMwx2izO17bqZsMkeS6LDShN257OQsppyV7XPGyXqtSRykmBO+Q2XGDjKuVwJSxAl0VH5IhguiBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6AjxiSxf2elMTNbptoXg5LwdpdCw+6ZOU3IMXnrVaPnQ8itD6
	Nhz4LTdr93O6h9rB8YpWvCic1EUdnRg7iav8NdvFTufydsqi2TRqvYSO1LZIJ/6PNop3MILSc+5
	CNNRHZ+qWt6T61Nt80VQm+MnivP0zcFvyfxDQQvSM8FFOJf3j2FRzuwoCiTcuig==
X-Gm-Gg: AR+sD13rwbD+x2GK6JJ2kcrloFaZrsUYEdZ9sPgBq1ISpGqjWFiKwAT6cM4E4lnM+my
	UYtD1yW/hpiApDRFWrS3n/ma4fpFrWcq6wFAaRfawXoIHff5TqPaIb9weNrYFmaqxhYsmE7d188
	KIjdFYL+dsjYhT7sEHkKoa6NF8Nmn0iqZYymKvwniGX/1MHBiUQOOCQpE9lCSsZMDiqKqMbm7WO
	DKPHmGUAFdRcWxkiTFtUO+IyasPSMOxjRcWnazYYfsA81rsmKP0TC/nTU8im0V0MjiZrkPFmJT4
	OVULhtLXJSccz8ZuD46gzgPMW9xZz0NBnsVpnxXKb5w5qyMa06KYxDUMMaoC3xemn94upKzuzqX
	6XhLYh4uT3Ti9iTSueO7AnOEn
X-Received: by 2002:a17:90b:4c84:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-392ed50d590mr575264a91.1.1786438401282;
        Tue, 11 Aug 2026 01:53:21 -0700 (PDT)
X-Received: by 2002:a17:90b:4c84:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-392ed50d590mr575236a91.1.1786438400824;
        Tue, 11 Aug 2026 01:53:20 -0700 (PDT)
Received: from [10.64.68.239] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392e5650731sm560412a91.1.2026.08.11.01.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 01:53:20 -0700 (PDT)
Message-ID: <366132c2-273f-4b8e-948d-4956e5241881@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 16:53:14 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] dt-bindings: interconnect: qcom-bwmon: Add
 Maili cpu-bwmon compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260811-bwmon-v2-1-80f7f150ab9e@oss.qualcomm.com>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <20260811-bwmon-v2-1-80f7f150ab9e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Nb3WEWD4 c=1 sm=1 tr=0 ts=6a7ae302 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=x1iS9OEPbFcJzOgkp3wA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 1FBnvSr9zn0GDtgN1nYciSMkvObEEyN9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MyBTYWx0ZWRfXxAafiZhBK5Kt
 c4/mDtUIiY/GXKCNTndn4it9OL383MCDJbVaqF6RMAlr5hZAqE/TN6HBgvuo+b4AZOhjFQ51Yj/
 idrTBvbtMsjma1kQa15lbDYbcg+DNQ0=
X-Proofpoint-GUID: 1FBnvSr9zn0GDtgN1nYciSMkvObEEyN9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MyBTYWx0ZWRfX2dGbbB4HAjgn
 UBwLgF40W2GEjvc1DIf5QOKE436SxdPsAwdH/SS4k3sVv/EPOYEa/OVDe/20O3kUM4gbuuQtcAJ
 AkO8/kIlLQ23lQjzgFJGJ/CU9iku62XhRtmhOpv+U6x2SAi9ALQQhZw1pVBBdCzWEgaZTUmq5JM
 4fGU9NhLEK5W+FRFAMEhqTI8SDIl2pGJ38cCgKap4eNFMqqlbctBJi8FnfPNjykOuSSdnG9xiSw
 1av9sG5Z6sFppONLyaBBCRmPfhq0fC80pf/EuiC0HDX7g770iOeMNDbD2JzwmDrqk3m5TW+ByqO
 hpHJpY4xj9128drwm8/C1HtrrBfdBFcsMhmMk6xZLH/r1WQ1Q/yPbJERRqAFFvEXGxXU94QeaJu
 Bqi/rn1GDKFXaaQpYaFTdnmhEdOoJFRqu9nY5zVBMjosSx30c62FSkM3KG6mUbXeZf/2om7muxo
 aYpse2Rud5nLjkSsYyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110073



On 8/11/2026 4:46 PM, Yijie Yang wrote:
> Add the Qualcomm Maili SoC compatible string for the CPU bandwidth
> monitor (BWMONv4). This falls back to the sdm845-bwmon compatible,
> consistent with the existing pattern used by other recent SoCs such as
> sm8750 and kaanapali.
> 
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
> Changes in v2:
> - Drop Assisted-by tag; no functional change.
> - Link to v1: https://patch.msgid.link/20260525-bwmon-v1-1-b8f6e189c3e3@oss.qualcomm.com
> ---
>   Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> index 82b1d94d3010..7989db1aa774 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> @@ -28,6 +28,7 @@ properties:
>                 - qcom,glymur-cpu-bwmon
>                 - qcom,hawi-cpu-bwmon
>                 - qcom,kaanapali-cpu-bwmon
> +              - qcom,maili-cpu-bwmon
>                 - qcom,qcm2290-cpu-bwmon
>                 - qcom,qcs615-cpu-bwmon
>                 - qcom,qcs8300-cpu-bwmon
> 
> ---
> base-commit: 550604d6c9b9efc8d068aff94dc301694a7afdee
> change-id: 20260512-bwmon-ecb43fda63c9
> 
> Best regards,
> --
> Yijie Yang <yijie.yang@oss.qualcomm.com>

Sorry for missing the previous Reviewed-by and Acked-by tags. I'll send 
a v3 update to include them.

-- 
Best Regards,
Yijie

