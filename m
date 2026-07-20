Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12073CF97F
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535798; cv=none; b=ht6Exs4NKRWw5Ho4YOiMbYyGD/L7ccwztMt854oWNltX8ieBT3+gyK4RFmo2/CgYVIVIQ2M2o25bcCnM9ZVM42BAgmgazflAIT8LM3bFLwlodZfFTqBRC66RvOe73NwsdZCtictoSHd0faCTDe5Zq0APCvbDtjPwAMXRRWCzDAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535798; c=relaxed/simple;
	bh=8xulqPcrGT3G4v6kMgpUnZtZlTdQx0MSEYnJpaZgohU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tf2Mz+40+9VQXBoNAVaqlkewFR+TIkuG2A/1VucxvDDtDIeYAMECu16/pzvyEA6bVYKPtRS/mSy42cWYpNvCNduk2EWMZaXTYNERSmP1Nhxkh8rU9hh4LtuqiMp5BL0HUvZbpidEbrC/1m3U2hbbHpwtpSueeTOH4PTXnshtN9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CkVgk1Ih; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OwG0YPH4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CkVgk1Ih";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OwG0YPH4"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6Rnxu1263187
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YdHOvi6op9PZsp0dCdMAIUCpZ6ygglE1WyUlQZxnVkw=; b=CkVgk1Ih0dV7+IyQ
	Es3Q06Bw345082P7HpCeFPGlxI6iZQDQQyVeO2wnFJ6nEWLotxuEAEs1C0mpygnJ
	WDSE+pcDLL2q99BpBfrvlPnVUoHF5kWXq1Jd+qpwnNy2V2zMhQHJDLPh+MaYNT1L
	cMtFPa1NZD/3n+P/mlyacQ94Cx7QYgDtd/SGZIaVSPg7hiQ3v0VQG0ZQ9e4bsnMQ
	Hvz5h0eKO6KYdrEmsIOtkFVmeOgw6HD6FoIwruXrj250UKIjPvJqL53tJydBXNzh
	LwPyWkT1+gGJTvsvhgIs5zb0vI87yXpy4L3W3n8VeZWo1wPFRcvselcERU+0tt0F
	/9NbPQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2nhn5by-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:23:16 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-847a00bcbd0so12594278b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 01:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784535796; x=1785140596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YdHOvi6op9PZsp0dCdMAIUCpZ6ygglE1WyUlQZxnVkw=;
        b=OwG0YPH4axrikoGCYUy54ywy07TCi4MVuhSZAD8rOgGiiAptZhWMG5cHKT+q2/aOMz
         zUG1QSuGZTTbB0wIze5xEmBgxA48tW9wwEYvQaNJ4XBUrV6X2Kh4nzKDlGhX1qRnk0Pm
         jaUX4k0rf+a1tqn/IELvlVFcdA6fgl1pnVoKqCRTkvGRLq43R0nPrL7WWAtYZrSFvPdg
         4kpZvFyBIGYpQu1JhKZWsGCit1O7Hc4uJdv/5rDYoPrpgmTq5BsPpg386qH5+a8Hs7nc
         5n0JIRzdfXF3EavDeb0xDK4+lTsPeGltOWg/ga3pZGVCKcf6vwCDFLBptEN7I7J1bzz/
         C+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784535796; x=1785140596;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YdHOvi6op9PZsp0dCdMAIUCpZ6ygglE1WyUlQZxnVkw=;
        b=RVUSwkkb7YPmGUMHUutDowgtCho8pX54qsd0Tjc/4raCwJTpGzcFkGDIKsMuSYeEcA
         d0jIiAe+0lvBQj6fl0kJ5wqY3mAB3zE4rvjZXGEvwM6rwmj1F7Dy81eEUr3C0x014EoR
         5s7P2dQXTG5OgOAhj9fHDG+BN6I1Hr0n2m0USDSIEBLCQJlkEb62y4d/sfzXlMm36HRt
         t99y4XsbgTX2FkDfOHTznjOI/U0x8oG+dByUeTrodXZsP82JC2U0XfMu+qeezaaGHROF
         bEu75xbY9y8srVD1C95ZIwKFXtCG3wqL5vNJVxfUPoour5ipHHhse+cXumsTcn65XxGC
         a4Tw==
X-Forwarded-Encrypted: i=1; AHgh+Rr27aWhnuEBeBarREhVUWFmZaz9Uuy1aAZg6tqMKj28qxhZMaZimDxvr7gWMCuIHIPUkPH+t3Wx+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9eQb0wgRsK9neMMdhM9PNAXJT1DftrAU00RCKdIA9x2xFixtR
	9/QwdeLoxEpkW9+AcDn8ZE9drKjDIEaT1sX6UmN+l3s4kcjikH1e/hss+j3mtMeqaZBNfaWJy9O
	Al0R9CyGwlmKAGLAyuvyaMoR0nhXejCBQ1o9mntYs63vijBkBri88J/4sDL7ATm+JqO8Z2g==
X-Gm-Gg: AfdE7cm5aThWRfQ1FTTySyatItO/y4hHMtKZgW/5euZvBAyItT7gJgTfoxDXbSXsJYS
	45nKLflFLPaLE9GGwg9yC8rjDUrTVxpeQlLptMPXYySQmW5skqfF/nqxDNBC/pMvfWlF1NFBNbJ
	ku7dQL6yHIGGjM4bj//jq1AzIhuQiMXFCAb6km2YPrxftCm61+nc4fP8SWoT8M92kfEgzZ5iKR6
	On9zXoZz1Ol0s1+AxZgQ20zNRgmQ2Yha2MgKCMuNt5RhlrdrSRgJ7KOw1HzPju+wna1NtL5pB+4
	4S1m8pF2gMQOEQ29qyOKL00qGzBYR1tseIPq+ZHgmED6LJG5ZyqLXfR8/VYSYqzws+DaOK226SL
	7EJpT2u8AEnIztCNztI833W+r9IAokYRh5BQAFPfdAxEuhNCciKl4r+dlGtiVXgR8ojvXDoO0
X-Received: by 2002:a05:6a00:391f:b0:847:83bd:6676 with SMTP id d2e1a72fcca58-84c2927e709mr13775016b3a.17.1784535796232;
        Mon, 20 Jul 2026 01:23:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:391f:b0:847:83bd:6676 with SMTP id d2e1a72fcca58-84c2927e709mr13774994b3a.17.1784535795785;
        Mon, 20 Jul 2026 01:23:15 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af9f00bsm5233431b3a.56.2026.07.20.01.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 01:23:15 -0700 (PDT)
Message-ID: <cefa6f15-c20d-42f0-a39e-6582a841b595@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:23:02 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: apple-soc: Calculate frequency as a 64-bit
 value
To: Sasha Finkelstein <k@chaosmail.tech>, Sven Peter <sven@kernel.org>,
        Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260720-cpufreq-64-v2-1-72bd9b4e5ca0@chaosmail.tech>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260720-cpufreq-64-v2-1-72bd9b4e5ca0@chaosmail.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a5ddaf4 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=iQvuD4D9eR7FdX2dW0kA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: IJvMtMdFXMmDvsEiOxat6i0twmNOxbVz
X-Proofpoint-ORIG-GUID: IJvMtMdFXMmDvsEiOxat6i0twmNOxbVz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MiBTYWx0ZWRfXyUKVJ2auA5+v
 OpBsw/BxFRTyezmFLUh8RIdueDH5ViBhpvmTympj1vk6uXwHTCknnoWvTVEPlByGJVAQg+gBsWN
 gf8xqfZY4j07cI76Tlppg92HfX/GYG1vgek3kJXgsoLFRA+Ju5hkpqBRhTk8g5B/prhKhTIaHHR
 tk08b52lw/ElN2+g3QBm785alUojDqDaazzBOQ0sgjtcy47wDE4+CxAFqS4tk6XqqnV0DObN4s6
 bC9JtQmtMefU+CZJS2blHTRxgfNE8eUpT8I0l7Z0yk5jNeMYl/9Iqbeq7q6DDkWYg8LyZieVBXE
 GA3rrYoWgExWcliUNhhi1znQiJA87V9aRPj2UGSDdUUM7JNijFJwDpTbB7tf7VhFJjuYu36GUT3
 LGmvk0OZnuaTWfp2ZJMqSj/Cdi1ESgXTZZKl1inVRluNEA6plTAQx/RCtHInWBpeDU3dndlLhMN
 ENTqdqlgTwvLQS0i2EA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MiBTYWx0ZWRfX858S05V355S5
 Zyhi9CcSNPVYGbn2zsnhbEUzYasUxEGNYpSBe9m+iq+JbQDFuFvAEHGJs3tWwgB9HArsF4JYflp
 zkMsD43Nej9w+kUzx6sdIgT93esvPT4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200092

On 7/20/2026 3:25 PM, Sasha Finkelstein wrote:
> The current frequency calculation is done in 32 bit, causing problems
> if run on a future SoC that can boost higher than 4.2GHz. Ideally, we
> should use a true u64 instead of unsigned long and "knowning" that this
> only runs on 64 bit machines, but the core code uses ulong everywhere,
> so this should be good enough.
> 
> Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
> ---
> Changes in v2:
> - Minor style fixes
> - Link to v1: https://patch.msgid.link/20260703-cpufreq-64-v1-1-c406c705319a@chaosmail.tech

Looks good to me.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
> index 638e5bf72185..5ad274a1e6ae 100644
> --- a/drivers/cpufreq/apple-soc-cpufreq.c
> +++ b/drivers/cpufreq/apple-soc-cpufreq.c
> @@ -288,7 +288,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
>   
>   	/* Get OPP levels (p-state indexes) and stash them in driver_data */
>   	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
> -		unsigned long rate = freq_table[i].frequency * 1000 + 999;
> +		unsigned long rate = freq_table[i].frequency * 1000UL + 999;
>   		struct dev_pm_opp *opp = dev_pm_opp_find_freq_floor(cpu_dev, &rate);
>   
>   		if (IS_ERR(opp)) {
> 
> ---
> base-commit: 4a50a141f05a8d1737661b19ee22ff8455b94409
> change-id: 20260703-cpufreq-64-2a23d7261e09
> 
> Best regards,
> --
> Sasha Finkelstein <k@chaosmail.tech>
> 
> 


-- 
Thx and BRs,
Zhongqiu Han
