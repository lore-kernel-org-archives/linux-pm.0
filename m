Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7A37AA6D
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356630; cv=none; b=Fd8i+op7vU6KJxdcPFcoqzJ554tTUlDDr/BcSNiMnnd7x+hqUy/WQ/njC8ZCLvWxlFWtdKPUeP2Qkkknm6uPoPr5PbqNU0r2ESKbR6LXBY1MEkqUenJkevGcj81f6/W87+TpcDl0i/DCW2QnWKOJ4cn6R7t180y5Hy1uPRtNkfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356630; c=relaxed/simple;
	bh=3qn5s+dtiX4sfsgJM10WySpwmJvgBdAU8qC72m4EYkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2cy/398wNWdK4aGmQnhEFMBM4JLhFTw05mj4P0yYcbOh7o0UXvW3akIx4/V0Doj7BpET10JeSB4R752YscU1fRwal/XIyzrCLFlGOUL/UNvwsCt8k5uX5Z+oLtOrVQYjtD0a328Kwf6n9TGRhQrYXH1noA2UkWFz8BDp8tFg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HkGoB+/L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZFAeVCJl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HkGoB+/L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZFAeVCJl"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L9A6Iw3452608
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 09:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YHjOKl7tCGgMI267yvUkwNuHMFDd9Df215mjICShWvs=; b=HkGoB+/LhXTFm1th
	UJ7ZAhEZdLQhzQM/sBK1KCihGwEl00WEPBbpUAxZNLknCpvugrv/tEcnusX2zrE2
	GMRhjsEEUYfpM82qgvcmm6IvwhYUXjCj4yb6fU71smD3q2Z0sJWp2uxCWewLLfzs
	JSz0HkRcrHlYr3M18+820ySJ1axXxsic6/HblwRSKi8pOszEAWh/hxR8iRvUGoxd
	/j4keSUb7mXX0kAp+MFHDl5aEu9RWy8oTs8cs/O1ZEGtmxHQLsZc5NOaZktTpxyc
	68736GR2TxsOh56bmgkgTB1xik8XNEBjXwEu14MZKtlVxiia7JPbn/T6bwbVnOKp
	7SHVxQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9y1h86ax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 09:43:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-516cee1f042so29011cf.2
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 02:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779356626; x=1779961426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YHjOKl7tCGgMI267yvUkwNuHMFDd9Df215mjICShWvs=;
        b=ZFAeVCJl7uG3xmxaW6R63BL6104ONZ4h1raBArK/jfssnZoSEuDxU1UF4tP2c2uj0d
         QjYk6RigLXXfS75UIPM/SBtfTzW+9JkiFqIhY45XSYL8UYfPLS/J9Rl6kVAHBta3VSlM
         oaiYhqhgNOEZG3lG85t7YPKj/P4U6f6TeCNqPu58H+uBLySRm5UjLUBnXhBlrwZr0Cz6
         rxBf3JIZueS+0NogvNhUSisKjD6RmFl07lhjAbvS17k6hrytTrU8VOykjrJxebYQp4Xn
         qL5QmieClf52Y/MiMveRbFkPa7KJkJHD+3UNirdYTU8CkoIem/6mWN2HTstZ/mVk2ltH
         P6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779356626; x=1779961426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHjOKl7tCGgMI267yvUkwNuHMFDd9Df215mjICShWvs=;
        b=EqdvT5lroS8NIQL7GCz4ynac20PHk4UHiA5R34RADm7vNxl4ThsPD+TJZuysNnebD1
         m1CLWBbVtAP2afGccpuIgGlmOK3Frf0Kzc12WvJ1ihh9ZVPiaml2A1f5NQiLzS8SGfUb
         mtrSLhrPTZ1uPQq8tlOYNYSXUof6At1JdKstjnrmUqdrLqjgUjRAur3ngGYurmeMQK5F
         E7TaisDoToijHCWywr8GUeTy3PtCYGi80LMO5rKeTHrsy0opxIHmp6kzbwAKAGTMgN5I
         CNm9TvS/wH9Zn9EAmOsD9pAOe3xQl+yH2u1EgtEwCp7ERkpqqZ8A/TyoDonrk12C37os
         vTOg==
X-Forwarded-Encrypted: i=1; AFNElJ/vEi1ybn0SmGjJDVq6uwXuU78KoQj89Tdh8SoQv/wgP6dzql0S/oMr45I82X1MHuZgmHhTOW9AhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxXm/frLcfRzWTwLTXfzkX2GJAKodRtbkEOG4myphtgHBl4zT7
	pJQ6rd28kDdykb77FtsHcwd6r2TreR4KtpM64rhWMVk4pg+6IqEkIuuwpWAHnJFCyG7oskL9eDV
	8NErU+PIiom3n0v2Cw+bkqruChtYkAB2zfNtm6dpv9rC4OtaIkowak21CB9lO5A==
X-Gm-Gg: Acq92OG+VoUuAOyzzZex3bmIcqq84/WPB/nuV9i1bohtDcCmO0LakbOssa5OLWJwVyK
	7BGpVDuF0NxGDWKiiR+65jzUspKN2R1COtO63/p2CxGQB6/Szl/HRZm+69a6Z1rgN9QsUeEcuxc
	2Y8BOwW/d6ixuo61stzTBLBXOhOvjtXEGhNvAkoD4l0Mek5+G6NPzNM2u/jRndqQUTZKVLDcCmn
	ZyJCaxgXH4jXXm/wLOq82j7MnT0Tw6rxiI35u+7z77sB42axFI54RVx6GLqCHpsiZRNtgYLfhqF
	V6AOpmvtv3TFkE7hiEb+Jfzde+iwUeRyuP9mZq6S4FablfVgefFb1UuFqtaeOBiPFPdp/hZM3RC
	kmpK12HsLwOqxSJQFqRveKVvu2bOr0VTw7jWhTkAwRU1PU1PCVjy5CyspbaEPz/5S8ddgq6/e8L
	wyZm0=
X-Received: by 2002:ac8:5ccd:0:b0:50b:3489:5495 with SMTP id d75a77b69052e-516c56d0badmr18732321cf.8.1779356625852;
        Thu, 21 May 2026 02:43:45 -0700 (PDT)
X-Received: by 2002:ac8:5ccd:0:b0:50b:3489:5495 with SMTP id d75a77b69052e-516c56d0badmr18732051cf.8.1779356625303;
        Thu, 21 May 2026 02:43:45 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc87e79e04sm23605166b.21.2026.05.21.02.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 02:43:44 -0700 (PDT)
Message-ID: <7ddd43eb-855f-435f-8f8c-5d1bf10bc31b@oss.qualcomm.com>
Date: Thu, 21 May 2026 11:43:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] interconnect: qcom: Make important drivers default
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260515-interconnect-qcom-clean-arm64-v2-0-adeebc73596d@oss.qualcomm.com>
 <20260515-interconnect-qcom-clean-arm64-v2-3-adeebc73596d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260515-interconnect-qcom-clean-arm64-v2-3-adeebc73596d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MpqqCAmO0H0iyMqDWwxvhrIK7kQ9WDfu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA5NiBTYWx0ZWRfX4WxbRlNZNuYS
 JrjyORom/jcxRs/R6DOPnVDJhtGx+aQKTQJZ2adz+20o/yJQBePBBizb+IlVOx1mfyDInGaYTM3
 nPlS00rG73CLRO8MVzNfsfpS1zW6+HCk8fsGW03MyAlWHk/SEttiKCZkKiYaKDC2MQuZSnMoI7n
 elFx6//BR+lKKUWqs2ajpDSDTQydtYMDLgPH/gf7UpAgAU5Rc5z1gUYVlTu8ARi7NAzZdRz9JpP
 lHOVI2FvNz1Qe+lneRTjWb7EGCTP/LQ8mZqaqJTim9GxtI+vbUjB0iTkEXxLQtjZN7NXrSUIUTk
 iLvisNozU2dyhjiJxJZ23mHGRAmVnTCVmLWgrsKM9yE31k2pSv0PmU1u5Y9gmEpBY5CxouQp7oV
 OzAO54qIFFkAhxAT9T6xnQzSOAN2MUJTq3mGN5nvszVi7BGpy8+ChC5ECYt+YvBzvhErALIm9A4
 bWZCqlhWwIzyH9ZU9YQ==
X-Authority-Analysis: v=2.4 cv=YfyNIQRf c=1 sm=1 tr=0 ts=6a0ed3d2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=N0nv3qFBaOOCOp0HD7oA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: MpqqCAmO0H0iyMqDWwxvhrIK7kQ9WDfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210096

On 5/15/26 2:11 PM, Krzysztof Kozlowski wrote:
> The interconnect drivers for Qualcomm SoC Network-on-Chip are covering a
> basic or fundamental SoC feature: bandwidth management between internal
> SoC blocks.  SoC can boot without these, but power management or
> performance will be affected.  These drivers do not represent any sort
> of buses visible to the board designers/configurators, thus they should
> be always enabled, regardless how SoC is used in the final board.
> 
> Kernel configuration should not ask users choice of drivers when that
> choice is obvious and known to the developers that answer should be
> 'yes' or 'module'.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
