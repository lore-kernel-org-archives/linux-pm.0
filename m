Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9DE3242BA
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786418866; cv=none; b=Pfn2xx8qjlNHpjZ66jnYtsKpGGHIHLHQoLSAKLUlI5CBMOX1O719sE0N9ysGOiK29mrVywWD+F74bvxqKBXR9flDBiEfwOpVi0UUbpVzx4rkE98gnFk/2XgZJaxuE6rNyseUPdYMDyvja1QbfGzydt2F16H4MU0bcxSNWgelK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786418866; c=relaxed/simple;
	bh=sSxhR3y2knoHzKuNfvEVgs0w6SRJwZzns1Ihmf/T2QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fH/f6G2zkSVl142MNzhUPcDiPqW4DlR9LLR1+W/+tQ7eYEui47eGYCR19LWufqUcaIx8XP/bOAUgN9vLoYs+5lTQ5rW/5P/eZSWT9ozzYswBI4XF7aKrPB1qh02gKQpf/9g9/vLkIltF6XcXhIGZGR9kvJQe3BoMYEmsF15cgLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=brU2uPP3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JPGbO1Ti; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="brU2uPP3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JPGbO1Ti"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AMqHCK2253696
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DJRhorLfLEqwz2jpltyXTbdis2z/2pLgjJJZqss1KS8=; b=brU2uPP3u19wx+rt
	YdEMZEis4tqR5T4yvPzzk5uK0U4/674ovJ1lG+NTABOgVk/LxjVaxYP76LClVLAg
	M4Ht5zkH8AFwDu63Z4GB207s2OLJfFdVFh3yaVh6RlENsXMoHg7pM8RAPzxv5Spr
	m3WDS32IdvU0CJmf0vn1O7c9mMbmt7qpEWlIz+pH9EQs8NqPRDGKYMulMgoHSG6G
	V2fY1Om9cJAZyAFPfHFPFwvRID9zCTVrtCHrb/1+MAeldwZ7w/edqerlArDHYFMq
	gM+XsvRXl4Dj8UzGKCizhG33vs2fBygzcX8+uH7vLggl9fB5JWNM3io6NL0+J6oN
	APAZLQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk7a6p3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:27:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso634065a91.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 20:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786418862; x=1787023662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DJRhorLfLEqwz2jpltyXTbdis2z/2pLgjJJZqss1KS8=;
        b=JPGbO1TiW+faN+tJeDBr2D47OOUM9Gr39LMyHq+TeY9/fYngqZs+9xrWMQmwHiMZfE
         sSe/uoFvSaFnmmCEKhF+Gz3dYJlKwz78jaNyMukFV7TIHISMfq+NpFxj0ytvjv0pKPIQ
         FbqLqKMJgSAUFio4H5XeZafDfWKqMfB8qtmZsqz/MjXIlhUsdJY5NCh+gyomeGX6/lKA
         HlgnFZm/8154DT4/KaN7vHWOrcJkStDZ8CTXhevK9XFB1j4xljQr/WJFRfLgrQAcj66b
         +4nddOVxPFV5ryTu+Zhp7qs6RMAYjePTBMgEBl5rLUXbM8tGByWkk1iKxG/S6ekPs55u
         b/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786418862; x=1787023662;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJRhorLfLEqwz2jpltyXTbdis2z/2pLgjJJZqss1KS8=;
        b=pvvXHNawyQT2V8Wmk/JGYfORkc7xH3Q7jKF2HmbOu6KVIeCapaPWt7KbQysyW8Qi27
         s5Y1NDO6CarmQQRGqjmALkvwa5e6jZAMoQSpdzPjxJgeWG7sUivPpxb2Z/1r4Mzu5/a6
         241CqRHD4MR4aeZ6Y2MpzbOp+rBX8ssPkUAYq8/jv5jIFnIahdW64bRic3Sd0g6nb8Ry
         3X8jItxu8HoBdEa0EiFvEi4f6t2dFXQnRIv6+lGl4GwbqqB4zeyG3wcN4tR0WokJXiZ6
         DP6flYwmN0XszOwWuTAEaGyvx3U3Nkjcyb4BW3tLVhfvV7jB6juRNj7V/h+O7qkofq6G
         mrEQ==
X-Forwarded-Encrypted: i=1; AHgh+RorOeL6NF09yxviy91/rwV5MOFXlxSctkJ6J4dSMmQszNMi8mtFDzXTuf5DJyTIy+PEOPUaSUoYeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx//nBNSfnyf+yXp20G7XlshVCRn75zOAijuGFkArBBC9yQmPQM
	CgvzoEr6NfpK0CH9uUJWZF9yVwyFLbdrfOk4fd8HaFTJZCNBW+QOzOHFrVeZWbVqow2zJUGf8lz
	EpzZPFzsHel0P9+72xpvDSdPllW/C4zaL8DQT0b8Eir+0Zlo0RL6DaXfBX4Dl5Q==
X-Gm-Gg: AR+sD110QHsS7HTeuPxohufoAhxnak7x/pQmOswaKMWZ/k055Q7g81BwE9A8GNXn3W7
	HZe/4NegsSd/UxunvduQb1ZIqjH8B34t7fAxxA2bE9k8HKM6FLRkANLQVQ1OfevVKbue5CS3zyB
	901K8pMwLSZwkTjQJjf/q0Gm0GwGVqnPqAp1B3OC7CKV11wJZ/Dd+sQhiQMHcdi4VHKvVr2rZ5u
	rc9pFk/LertiwNfuQTFI1EE4VQFfRjxkjWm+bNFSLwb2gMYtQEL+hP3pT8r9SH0EDlOmnMfKGUS
	F2Xr8HV08QNU/R6YYcab6cD9hYVkYv31pkRJHCFYrk4aLX9eGiida8z14lvjYkFU6Tb5WJ6qaOP
	PfAPWI9uwhn8RK0+BEDKaDUmLhzs=
X-Received: by 2002:a17:90b:184c:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-392ec654644mr267707a91.15.1786418862334;
        Mon, 10 Aug 2026 20:27:42 -0700 (PDT)
X-Received: by 2002:a17:90b:184c:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-392ec654644mr267664a91.15.1786418861886;
        Mon, 10 Aug 2026 20:27:41 -0700 (PDT)
Received: from [10.239.132.75] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d537fb9bsm1697177a91.15.2026.08.10.20.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 20:27:41 -0700 (PDT)
Message-ID: <a8d4461c-8bf8-440c-bc67-1a6a718fa9af@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 11:27:36 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: interconnect: qcom-bwmon: Add Maili
 cpu-bwmon compatible
To: Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260602-bwmon-v2-1-d4a851c45f37@oss.qualcomm.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <20260602-bwmon-v2-1-d4a851c45f37@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yus/gYYX c=1 sm=1 tr=0 ts=6a7a96ae cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=x1iS9OEPbFcJzOgkp3wA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: d1EGvbl2mWHe5UvHVTeMY2rytlkPNaqD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAyNiBTYWx0ZWRfX7Hg7cf2G2qwc
 Gtv9tRUhxTuy1zodMLODGJidSCEQGCa01qDNMoD8QTVvY40KkHGYkGuk8cIMk+a8nyxgpXG0VBj
 Hpt1ZFVbZIaogXX5DGrxknhJAUUVVvRDJhRpBezoVECBddq+nUCwHp29M4adI7rULWPDj9zDtwJ
 2TMGJ9XbwW//By3oSusyEW2bnyZI/Z0ycENXocn33Yb+uI6IQRMkmpkxPF1Gvg/ZBBfxUYuhTL/
 s7/ads3SfMTL06NqFQqQte/yDxYJJDzKXSzzxE3oy8nmnWLdQoXlKi6d6m61XBaeRcLqh2dAT8E
 FMSPnf5MeU4IOLY3rOfTTSH9NvINZoUhdPm42fhqa8mocQgiA5GHndN+X8CoBpE3cKLNNA8OMWe
 HvECXYsrkgAUDlzKmXWu1mdN4/zwyNtkfVF93hAlzObxR3LnGtwcSpvFmfHlN7x62QWkr2j97Q3
 hEsKy1EgBsl6g8W7S/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAyNiBTYWx0ZWRfX+VhQ/GTDiLtk
 zFUhnLeg2+3o0YYHPV+qkhsVmKFa3uqT9MrotUZvyBwPsCz5TNY/oeqXv8FU1muK2TJyFj/wzpz
 /dpIGPXDIl7p5JFzRKiqtOy/v0MepUM=
X-Proofpoint-GUID: d1EGvbl2mWHe5UvHVTeMY2rytlkPNaqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110026



On 6/2/2026 2:54 PM, Yijie Yang wrote:
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
> 
> 

This change applies cleanly on linux-next.

Reviewed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>

Thanks,
Jingyi
