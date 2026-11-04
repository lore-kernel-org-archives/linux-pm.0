Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760265;
	b=g0uSs27Qw5szuVC0/d1KdvbfMmGc9dzGGyFWlsF5OZ2Qjv/rS8EcvboYzGVJ7NMlALdk
	 t8GQHgk28mbvVzi1NPRC3xMV0XcAelUX3divXBAzxIbUMGgqjG486fBmWh2Gq7RESzaP5
	 5tli+KRb3eMvxiYoioUG+dv4JyHHOBVfZFy79UqKVa7zOgxwLJHliG6/GMG5w+TEK0kho
	 fn2dG7s4ITgb/iiQMN1YKbM+TuoXxYi+wUOPHoFx7jW8eHmKop+/JXdMhPC/44oTTUShC
	 HHyO/JInF/Oag9YlEPuFTIe0oErdC9LwOsQQeQqi7ohFg2u972wX7YP5mqRZZtvtGqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760265;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8/0VlGRwnkwJXJAiEIiddy8meNnlSku/giZaxn6kwh4=;
	b=2D80l2Djk8xxlrLWfsOKGt9RIYoWxA7rbF9PcTmYRoU0Fw5rFPrErAp0cGpBJF1WoKZh
	 2hsD7WLQ9tPbH+EC5cHfdYBtLJwp1X/VubjfxB4+5EGE49Q4DnEUX2nqHTjzEPVlGGPEL
	 Ku8zJwf1pHAAXCLMrOApeLtmwHLPA+q1VloC+l1GEogAlUYNE3Tnc0ywsGRN7oToMuqTZ
	 I7deiPWEMwdtEUHYvi/0xXah6KTyIMWYosBHuJKKrWb9zxGEcS4KzuEZaxDXbfoFss3hQ
	 FlhcqxjISquF7/Ch8/3hOSeeKsKHs0mVxK4oNYoxWuf4qunv30+o0JIBvrZ7ycPzuoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HZ2nepqE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B7CzXqcm;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64437606A326
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 02:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64437606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HZ2nepqE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B7CzXqcm
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40RL7J222102
	for <linux-pm@vger.kernel.org>; Wed, 4 Nov 2026 02:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8/0VlGRwnkwJXJAiEIiddy8meNnlSku/giZaxn6kwh4=; b=HZ2nepqEyZBwMfzG
	H8UAjaRy3ReTuqhVVeNDZLsK43WnmhrThb+Yb51D++M6pZq7a/shebURdu18z/hj
	d/yTuKBG/l2lhe2JDgt0Ww1eEMgHfYRiZl5X+3xt1z3o+toTdFeBMfRrEKHS1Fx8
	B8THmCysmqS8ix/VqEk3cLT5qQZ8dxss7aa6QvfmlsMbatpEXfu8C6Nbel8T2QDl
	2yuVjjknudERghPWjiVhbl/q+Z1WUZE2zSTYCvPEgosiOtPGfFGibVDdZaouT6G9
	s2DNYYmxHMYJKEVQNpBit06xKgBBQFTPHxiiK8g0TxAu8YbeJmNdVhmBP2R4VgUy
	KEQD2w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqjubjcsq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 02:44:23 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ac77c3ff6aso447910a91.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 18:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793760263; x=1794365063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8/0VlGRwnkwJXJAiEIiddy8meNnlSku/giZaxn6kwh4=;
        b=B7CzXqcmtylPRLtvWD8WliXpUT8W4IVP3EPiqYryOdYBI/3Gb5JqEJ+o7P8Yh5MY6d
         /1RKgls6cnhDYTefcofwPYXw7E+/9qmPEyrp2zNYYJimGDPLWE5jv2LGYOJMTWJNPE32
         wte1y7TjgIlXRapJbEKXDfZASZK7gBbAdGdWgtjJNfR8boezMVwEs8YRNQutCmx5qLU3
         6XTrmFV/ZJco75ky02aR8hTaSWsOoxpFlTWEgwKVo8JfbKw8RiczBLKfHuBT8I/Uvxy8
         Izoq0+ObjqtAIk6qPb+btOmUdc9mQAlGodTP2+L8k/XxkpiqpllXVyBFqdvFjLZs1KkF
         Cmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793760263; x=1794365063;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8/0VlGRwnkwJXJAiEIiddy8meNnlSku/giZaxn6kwh4=;
        b=hNg5niaN/7L34+k4uKIpY0Y0FPsdDNXZSags1n6g+giwW7vgPXzWGq75BBbx4Fof90
         tosnS9W1Mmoj+8o/mHbHCr+q34NgQVT+SlkjmrhmlgyrbP/cxbwiPSTZWzM0sKWZlo0u
         CGoQjdWYaCymbkAb22RpizZRXST5pxt7hZYDSp2MBQymTmh7KCpsou+hoBhsPtNclabk
         nz4mgcBJkHY0chvzmEE4mS6Il48z+O+S1skfW3Qy0rHRO89ydFEIiVUQ+1BcMKmnVn3h
         skheTlzhvS9J9/Hd2y86cA4vGc66AfhIQ1qsmdcj3A5KKQW3U8bhIHUALGPyzzJA2RiT
         9XJA==
X-Forwarded-Encrypted: i=1; AKwUvBzeiGFK8ZukujdG6VWCormQD+jAXFjFK2aVaYp6xNQgVkuB/EgOLaYHHyN3x/ArWQlsINw0DgnrGw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+6iJTvO+w/n/aEIs2blkOEeIGnnK/goaN9UpkSdyXhksPdRwOj
	WTqtV7Xy4FEKJ6Fn65JgDdLNm2BR6azAs2XsuyDVC0RRBma7wgciFeke3MByVTuOJyEuR9cEJp6
	aF4S/+gxHu6JUNl6svmY8i59OnLWKyP/vIh2kPhiFPYRGd7Ezy+J2JAr6XzvaMA==
X-Gm-Gg: AYBFou3Bf9h5OQO0xyC/2+Nb1qLCmKRHEHlzCKqoiQ6q0gkaOlB6OcSfT8wnHQBqx1c
	LK5Gf17t+QLShH58eehaSaeMMj93Kb7JPdEkKs+qidaq2TFI3rYeHf4xMoVfQNmUf86rZnOLgIC
	oRc2rNiLUYrDU/FQPNmsnFS4JyajVy04gyfwR6ySOL1CGncbpCdaylOAt3ZP4n5Gf40LcMOmukW
	7VRXJxKBZjY3hJ3Y/MLaxUR0fYYBsgY6MaQECW3krSFDSyzmjfStK9J9PIROiZc3bKCJ5+h34TX
	JLjPikwiyzzbmgWLqntiOHYkvP3hYUnPrGLjRHzUXODGbYmC4HvG/xYYzWcmm3Hhvdr54IAn1c5
	oMGHITEf6AMWYK9BMlPkIe4eSa/mTXgI6eSRd0o1elzxKFX1zQ17QwxOnS2LFivQefVH5Dl30dt
	zBiQYPYNxwOBYHTN6To0oO2gutH1pvt8MeUjsBfmzDjw==
X-Received: by 2002:a17:90b:3844:b0:3ab:36c4:b502 with SMTP id 98e67ed59e1d1-3ae89814e4fmr12122114a91.30.1793760262980;
        Tue, 03 Nov 2026 18:44:22 -0800 (PST)
X-Received: by 2002:a17:90b:3844:b0:3ab:36c4:b502 with SMTP id 98e67ed59e1d1-3ae89814e4fmr12122087a91.30.1793760262359;
        Tue, 03 Nov 2026 18:44:22 -0800 (PST)
Received: from [10.133.33.74] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed08fe463fsm1179335ad.24.2026.11.03.18.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 18:44:21 -0800 (PST)
Message-ID: <ec9e63d8-f04c-4a59-a70b-0ea87a501920@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 10:44:17 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] cpufreq: Fix synchronization with system
 suspend/resume
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Doug Smythies <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mario Limonciello <superm1@kernel.org>, zhongqiu.han@oss.qualcomm.com
References: <6065833.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <6065833.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAxMCBTYWx0ZWRfX51aAYDnr7TmM
 WGpNe9ib19CWKjR0nPvuQQcKCFnVDB+pS37yjdHvs8L1Konyh+gREBeRHJbxyIbhzASmIsiQMRs
 +LZhYvXLvLE37WLJDqF2i3+UdhUiuiU=
X-Authority-Analysis: v=2.4 cv=JeUpPkKV c=1 sm=1 tr=0 ts=6aea9c08 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=96_gvHe8Ml0037tMNxUA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: a8uvXDw4THq4qcFdcEOMvL4tLjeIKClV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAxMCBTYWx0ZWRfX/PU60YKt89U0
 7b7VrlykYfDP6WLngA+klkErQq+xPTY34mFb8GOxgZzYF7CugOz64BArZ+MM3BXliqEC0fFm86T
 yTig9xEMC+iA4qW/8tDMWL/xmNmG486NtiRoRUFrF9u0Ba+Z1ONexW7TuIgZrVb8MXK4HppM4Wx
 5voxGZXJxaxbr2E6dC/Ut1jCQ11lVFTNgVh6li/PThdA2knxzHqQixqTsJGIZ0PGGeBviWteoBS
 9gBcp+8m0TGiZBG9BEutfimV2FSiwJb9FIgotnaqLlO80skfafoBcz4fswh5Zc9eNmOTzH93OIk
 OQMowS6Oje6FGzcBr2fEsutTb5EOb4y7HKQFgBTK7dP+24APw5Pds5OOOtZznqvDfJ23ZVTB5ok
 VwiioqS8iu5jzkgUwTiM+XJQwEXgCP1TJqFtpkCd17Z6P7R3xZYXgOWCDfvAvpyHb7UbDDMqAEa
 TbXFeuI59vGw8b6p8qQ==
X-Proofpoint-ORIG-GUID: a8uvXDw4THq4qcFdcEOMvL4tLjeIKClV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040010

On 11/4/2026 3:42 AM, Rafael J. Wysocki wrote:
> Hi,
> 
> This is an update of
> 
> https://lore.kernel.org/linux-pm/5162355.31r3eYUQgx@rafael.j.wysocki/
> 
> that modifies the first two patches in the series (to address Sashiko
> findings) and drops the last one.
> 
> This series fixes issues related to the synchronization between cpufreq
> and the intel_pstate driver with system suspend/resume mentioned here:
> 
> https://lore.kernel.org/linux-pm/CAJZ5v0hT6aoX4tuJM+rO_5iequFc_7rEXCoaFnHoJBaH3JP4KA@mail.gmail.com/
> 
> The first patch actually prevents governor operations from being
> carried out on suspended cpufreq policies.
> 
> The second one forces the driver .target() callback to be invoked on
> the first frequency update after cpufreq policy resume.
> 
> The third one causes intel_pstate to invalidate the cached last
> P-state value during suspend.
> 
> Thanks!
> 
> 

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> 
> 


-- 
Thx and BRs,
Zhongqiu Han
