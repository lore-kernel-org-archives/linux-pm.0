Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75835233722
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672011; cv=none; b=gy0NBPh5G8hLUPURZtiMZKkA79nu2ZJzM1UUr2Za7H8iPZCjGlScGM1WyCDVNpUd9H80hNzsVMTFxjHFxroKRUEJrQKyNhrxhNWc/XQtH55jgYrb6gKuByhsc7tHsGGKZ01qlTAPLDs6cMhpfnc4wZp5tYefgEkb1ymIStAzKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672011; c=relaxed/simple;
	bh=kbPd5aEB88RVKC5dTRS0nFWR0+S42v2EQ0FuI8qym78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKnjHItkfUYVSMehtlu+Cfos3z1NO4aNYib/oT3gCETC7adJ9IcBFU9h2Vb73GppWgde0KWKNl9ztW2P9zP9YdbzcMCgzttnsRLTu0vasEdlrO67CcyjtRVbctm6CransJvrO1RUueta94+2MjCwbUWDC3Lz1BXihJMjOx24Y8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dy7lHe70; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SroB+0e9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dy7lHe70";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SroB+0e9"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7U0De4087159
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 08:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mDtlofeD7haSM+lzJFlUgBc/2wfLYIn2wjTkFseiHXg=; b=Dy7lHe70TQudM+wi
	wL0mZ5qrqMwol9lb+JSLRrCKJxrRGAEyHZxX1mPFwjxLU1y9nDbPx3EEyftAlHtq
	kXBFSa+SniulUWEVIssinETeZtjxG6UsK0QwHWmvGuCzOzuyAtrbQUUjpAoiWvWN
	XTv7XNXvWtBTjLXz9NxAWAOn/2WaESwGS3Lg6RCfNi2Db31zhkVH87iQfgzKHHuY
	OkFdID38oPXeuWUqTp2sEW/6wwk1rdUe1MdM8Sj8srtJv91V72Vv9ZMiP5Th2xJj
	rogPFcLO4RsrSbxvt5FXCsIksUzc3ghhiAPhyYItRibKHe9MhT93aCC6pfKuVVpo
	YRDdGA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4t5dk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 08:53:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a1e564fd5so752181385a.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 01:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790672009; x=1791276809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDtlofeD7haSM+lzJFlUgBc/2wfLYIn2wjTkFseiHXg=;
        b=SroB+0e9JM8oaRpopi7k+Tgjm0dWHWO6iqfuy2IEKdEVg81uCSyZBkNl3jDIE91SBm
         ZPqtkZNX9MyGpbmKi3Ovt/sfZsxkjwiRway0vHuwmR45+IOpYmEO/K4EaJbKWAonhytL
         sf9B4sunE6lMXTEW4C7Q5AfPHEV8zAYDoRpj5/iUox1TtJlWEb6kUem+7mFHB5rY/EEG
         k5LINt15kDkkcmWOf7C2xnb8ptapIaRSLxFgR8RaOH1z1Xlk0HZlH1r1+oLR+98aubm1
         YvVpt2U2UewkYxReFFlulQ0INNHhaYEY+fsEThSXAMCMpF+5ru6zm99fK317xQrz7Dai
         rzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790672009; x=1791276809;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mDtlofeD7haSM+lzJFlUgBc/2wfLYIn2wjTkFseiHXg=;
        b=erIbdwjAeI88yQE/msxHPSOHhfm4dhzFSLgPtRiHyoAqOkYc4YeFFqBeeakVgUTlB0
         swswHFFHDFNHrW2NB/fwVKkcH+CP1CeJcrVfS2T23DaP5Md7nMpUunUnsbOCNTlIqBAe
         CTqK2BihEp0EKGhe++vvZ49V86crwTP/sJWrjJcgVumVujUa5GwmSKIo2o6cuwFcgwmu
         BnWqx/i/VEKDIJeKCXSyehA2fnmObe75ab68XTmTZHqPbPVpL+orl0pIBDkEL4Sxh3/L
         6umhIEOFw+PVY1Xoduw8Fq5FQCrCz3S0C0RNqRqZrfvunmlDiHu0zeFWp7SfJ8j2b7qi
         uYgg==
X-Forwarded-Encrypted: i=1; AKwUvBxlWIGMbtON5y5/vsKwO5cJTWeE0YtnKlwjL+tBcXV5axaxgaFMyahjFIUinN4t9ui+5inc57JVaQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lYaxjOa4VKYL5URI/eCNXm/XcQ3LdldOoM5Dvaix7k+FGcOUs9
	iKNFGMaUtP8DALvcw/gbxP/mKrb9m+vMkoQNoZla9zNpxmd8afRtoHXj3vwiE8noydXQBfC8+Rk
	2gdd3mi/0hM1dyD/NNDIytKvoCyZL2bwFP0VWu8PSeLu3DatqXAlX+dk/mWbV7Q==
X-Gm-Gg: AYBFou2zHdk3RC4RAlhoAEqxMYxIgnWMjO6cPwIVy19DosrHG55ax45WT3jvhRqOYli
	ci1SwkfyF4aU52rco+IQrmyy2qdmjG0bKbQyy3twfsUEcvMTpRBtjGIuW7y8raq4iHj3bu0BttY
	USOOoGZlczQZoaFgzpOsmxfWF0z3hGrXkcJrhoBEBGnwx1kM3Pe893vHv9QXjM1ilWISFlEmJIr
	MhdT3kwgzRdSq8ohSsEviwuRV6nRJ8ERF+I1+eMLIQ+dehXYgrIp4HJjwP+p7hTdd5RNwMDIc7z
	nNWXigTDG19rGxtyMi4gV0ZQDr88N4HCrmACcq34uCMqCQwQ4uIaRnN4QycupPF48MlzCnqZglL
	E34/kM/Fc1Odkmc1QyHr8BTUFBgDhChSNWjJ+7OwuLJAiFel8so0EkI12+DT0bQ==
X-Received: by 2002:a05:620a:2b97:b0:939:1222:b9f1 with SMTP id af79cd13be357-93c439cff38mr2562088785a.0.1790672008620;
        Tue, 29 Sep 2026 01:53:28 -0700 (PDT)
X-Received: by 2002:a05:620a:2b97:b0:939:1222:b9f1 with SMTP id af79cd13be357-93c439cff38mr2562085485a.0.1790672008082;
        Tue, 29 Sep 2026 01:53:28 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a012387337sm18281345e9.8.2026.09.29.01.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 01:53:27 -0700 (PDT)
Message-ID: <5c0317c1-f4df-4b2a-ab03-2a7b7132b1c6@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 10:53:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] thermal/drivers/airoha: Serialise access to the
 shared ADC
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260915191131.25214-1-sochnev.v.74@gmail.com>
 <20260915191131.25214-3-sochnev.v.74@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260915191131.25214-3-sochnev.v.74@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzNSBTYWx0ZWRfX94aaUeT2lu9G
 qtKj6e/DBAeZoSnQR4xkfJKW1dgtWpPa0J/L1yFkWA666GpNZGYTsOGIJlqOlTI3KTEEt5jFpcB
 QDaGWZBU09nkM3uKBjltZ//gAKfFmfg=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abb7c89 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=4F_TT5Ia9pFYpsbeirgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzNSBTYWx0ZWRfX1DolGMtTOhrG
 inkd3DcmHLahVNMgFNYNCh/O26oNQNU8nqPv2Ms3V4Qiq3lP1wTdCqRTD7t1oyb7gRewFw8mF7y
 dlQpMn13hUw7WKCuLT+1O47FRSS43reqKBrFnLPAlJPnP/X2A+i+r8Uao/+wcifG+S9NFu7F6/q
 sOd0Q0dDTjEtrGbFtYfRpypQCBDL/5JG99UlsTvLT0ZkVhAAnpGSmIBS61qbuFTX59aB7wElNn1
 TJgjlIaAmMf7fccJcBgDQVYPHkRDMjZ19aMoF0p6+L8jgNfonbShT9T3Qs6h8orEFiF+1WDdLf3
 vw2Bukl4+b1O11QPcJlCr0Kpa6BQ1gbVZCBkOZML/IEWKAtr9QZg+hl+ylgGY+vSlyM9W18GKNc
 04qaFdCvWoo5s1Ng4hcNHeq65UMkg+pbJV4C21VtUw3I6eKcGqHNdmb3DZifjdRBHNrQLOcoewy
 Y43YtGqL40J/r/LUKXg==
X-Proofpoint-GUID: ufVSGwU2wp56rTpFxqbcTwGs9Vpivw9R
X-Proofpoint-ORIG-GUID: ufVSGwU2wp56rTpFxqbcTwGs9Vpivw9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290035

On 9/15/26 21:11, Vitaliy Sochnev wrote:
> A read selects the sensor and walks three diodes with a 10 ms settle on
> each. Nothing serialises this, so concurrent reads interleave and
> convert samples taken at another mux position.
> 
> Mux writes are dropped silently unless PLLRG_PROTECT is lifted, and its
> save and restore do not nest. The cached TADC value also skips a write
> after another reader has moved the mux.
> 
> With the AN7583 sensors read as parallel zones during CPU frequency
> changes, a zone crossed its critical trip on a chip at 55 C and the
> board shut down.
> 
> Serialise the sequence, drop the cache, check the selection after
> writing and after sampling, and return -EAGAIN if it does not hold.
> 
> Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
> ---

Should this have a Fixes: tag?


