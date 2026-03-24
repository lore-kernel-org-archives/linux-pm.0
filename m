Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304501459FA
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 03:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774324500; cv=none; b=GCFljHo/2gN6EyVEcJDiDna4CT62Pw8mNI7MItV4y223h5DNQ2TO1Q3MZq7s57M6eP/alS/9NBwaUWu4ujNHEcxuMZPDiJJpkL9LF5MtiaX1KkbRS6K3E6/KZUaeulP3kxGtnnhBQgzpSUo3rZY3Y1pVqyYlsuCkYgOT83I9eKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774324500; c=relaxed/simple;
	bh=nch6HwVJmtoyUlnwSKH0WOT9HnBY73sA0m0Yloh7jzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FekP/W7Eovy1V88CicF8+91Yu/nzwOtbIhVU+B1aswAGbnT/XrG3Ip9I4ei7JH8i9NeVTmRwMBuGAWpyER6vjb79n2RguQMWlxNBe937SswYdbZ6/qmctjQ+PFQTy4IhYHnEhynpwM3yV9APxxA/1wCvcWzFoeyyqZYDzgwibdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=drovxgbN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LgzUlXPq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="drovxgbN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LgzUlXPq"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O3nsYe2971865
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 03:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nP71PADgJHyGzIhlDIRjWc3hGCi19X2SvL2Sofx1lxM=; b=drovxgbNzLfGLMsl
	RWLKiw2FH88Iph2rmib6T0/iWHFLr1lFHxArykLlEtNdYmyn9ct+9kP7ZzXgMaTy
	tSxNm1iHcFG/iIXn+9izipxOUVsc4sTXqXS4FJ/8DV6Nl9tvcGv+ac/2Rnk4JNcG
	CUnl3qFnWdEI+PC0lOh6bHXtVTL58vzRLbHAcQ7+0KbExPmGFhrQ5QF1RtWa4+1Q
	5D26cM9bXKJOlSTBMpI3MX5P1Y+pkL5Q7Ie+BGcw1jdYBnNh6/vdvW2q4p2EowE0
	t/fTCS5CSh6SDZjlNCQ69FClIPRFQroR4uyX/cWEduw5MUbXA6Uo2G7EY2CvTcC/
	/hepHQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jc3xdc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 03:54:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b04db6c138so67351395ad.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 20:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774324498; x=1774929298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nP71PADgJHyGzIhlDIRjWc3hGCi19X2SvL2Sofx1lxM=;
        b=LgzUlXPqHmwm+QvG1YeYqi/9B7sQxB7BxkGfpZBADZBiqNvTMigdkddoYbEk1ezMfe
         FTdByWyJipMNXDBo8SsOt9vmiuVpZk3oREgrJbFsAF//xAK0UywAq+I8VdUwiYM8hRWa
         KPC9K6XEr7ekgki4FavtN4QRsQAdJuHaDFvcCtWLWx9oIQq0sleBoYXg7Gu0VlvKC+0i
         7DkaJi2B7YkTSPyTuW0ZQ48LSzZrEGiMNXv5ZCMhHU1GsBPsLMWr5CPz2q7c5AsKTJDA
         utAlTvZdnupMWX3w+MX2iIKKkuBitlMklfCJqHR8Nm8GKWo2M3f/ObktTU7Y26qo5GNx
         S8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774324498; x=1774929298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nP71PADgJHyGzIhlDIRjWc3hGCi19X2SvL2Sofx1lxM=;
        b=hFnUqFL/A6tzS7ZKzkrqnKHQdQSSGHPO/EK/DgckpLNHcVj7CXLjFExDKZtXgyDds8
         8YOVAojhaajUZ95wzaYpHuy187i6+r2iOPfCvLrGOzdRyIWUnn+qS14JZe0PIXme9ZwW
         E7Jvz1mSh6gtNXkurUsFBJPpmMee4lIct5y/kZjD0vEZSxzbIGlqBhrW6yBV61L/ZaX1
         cjd3dQcyfEr3ATyiAMXDTUxHv/3HCXfzwm3Aml5MDQuUU16v+NWm3fEQCnL1JHFyqkoa
         CKWYUns3IWMuDmh+S5gdJ5BWQxnp5aZex0NHvZWvr4cNbubMCrQzmHMa8KasFX6ARgrm
         yaWw==
X-Forwarded-Encrypted: i=1; AJvYcCUHZauARV2fy9ZrxCkSdNLZQtPhyv9AjHjm68bNet+EA/kv5F0Rj6gndzuFZ3KPKwuBhia6BwDW4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0GEln1ptz/3HBQm50WBxifIJpY0pNiawu77GNWNFCwkZxXgj9
	Ng935K/S9sSZSNniq22hpAyemB4b1/sD92Hau6mTlFhy8/u4tF0GeFlfggKUVhlzj+pJi2amxdg
	femCNswl7bmI76wgXYRYk/HpnpxUj4rnnPQWI5+Tj9S2jPdh+FT2auUE8vGgiTg==
X-Gm-Gg: ATEYQzy+ebou3OLX/dr4ECU59spoIf4fDvRoSwrijKjMXINDf6uqwanyXOzHga30TyR
	BBZdmDKGhi8uHFHlI29bwElMuzIHLM8bOm3vr1+5EqTgVSU9x4B33EMqaWvKsF6LBsYV1r4ymWC
	ydo6FoybKeiQ8jxBdEqaV/MQ3hMFpW/4YQD4RAR2x9ReS/HrpsaG8iyZhnZWBxL1sRdatQ9soVJ
	vybxS/kBlu65r/54Irfe3mroP/0QTmzp6UnL0YIxW1rt9XwkGwk0GMLjgL0DAyaIuLFBmVYn8hS
	ir+AkrRyfv+JfzZx07s69e6pWfxV9E1IPhKKqeg075qdoC9f66BmCnBykd6l8w8KCy40uuQyENo
	9zvygxmF819BS/N2EGbVjJht88UMTEjaeic/3x6GeO5GdYLdKUimBKZ0nbCwv1l1pRyszSeT1ZP
	fzjATRTvTgYws0hfPtLA==
X-Received: by 2002:a17:903:40cf:b0:2ae:5345:89ee with SMTP id d9443c01a7336-2b082710b53mr131050585ad.1.1774324497619;
        Mon, 23 Mar 2026 20:54:57 -0700 (PDT)
X-Received: by 2002:a17:903:40cf:b0:2ae:5345:89ee with SMTP id d9443c01a7336-2b082710b53mr131050385ad.1.1774324497154;
        Mon, 23 Mar 2026 20:54:57 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08352a17asm124482105ad.24.2026.03.23.20.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 20:54:56 -0700 (PDT)
Message-ID: <3722f045-666b-4802-952c-359be6221809@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 11:54:53 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Cache the max frequency in cpudata
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
        zhongqiu.han@oss.qualcomm.com
References: <20260323043253.722730-1-superm1@kernel.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260323043253.722730-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fKc0HJae c=1 sm=1 tr=0 ts=69c20b12 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=3jVmB1qmJSOyyuLW4wIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: d0mm2aCOXEA1JTsnim-0XT7f8Daj-YAN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAzMCBTYWx0ZWRfX+Qhf79KfwqVE
 DBhlZPVjAgw04FvvdMjbyhAZ5wIlW4Czg9SHBGpd9YCKj/2wtXL0tMDcUey+VErph6QcEzro47R
 Dkck0efErPcjP7viiJslbatTqvib8nAfbw1y7fDrrahk1Q3JcSvKFvKn2bF8VBWnLt/p0+pC457
 Mpw5gzB725zYiTVbz0SDlVifwhL4zOY/xBITtFOYVVupF0nF/1msplpiYQ64oihNKz/62pCT+cL
 0n3EvhdZGFMMJ2fui4JFCF0HRrHH8eySDa5/CHQU1W0jgmHStphRU3u6KzAG5VOzd/YSmS0hXTt
 RhewuGhXwXNFOLBETOlgzookgg60uduZMMSL5IMrq9YwDH6xKkcCepGtCh8Yh/RST9xU/zzHTi0
 BgBjzHYb9j7vOpnHlzBNl9HUW5WSfUzYayDsngzzRs0NHES6qtOQO8dShwINvDeKqqG+AZw5lXZ
 PB6MrazF7a30AQ4KA4A==
X-Proofpoint-ORIG-GUID: d0mm2aCOXEA1JTsnim-0XT7f8Daj-YAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240030

On 3/23/2026 12:32 PM, Mario Limonciello (AMD) wrote:
> The value of maximum frequency is fixed and never changes. Doing
> calculations every time based off of perf is unnecessary.
> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v2:
>   * Remove unused variable
> ---
>   drivers/cpufreq/amd-pstate.c | 27 +++++++++------------------
>   drivers/cpufreq/amd-pstate.h |  1 +
>   2 files changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5aa9fcd80cf51..9f80f8b23a43f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -757,15 +757,13 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> -	union perf_cached perf = READ_ONCE(cpudata->perf);
> -	u32 nominal_freq, max_freq;
> +	u32 nominal_freq;
>   	int ret = 0;
>   
>   	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> -	max_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf);
>   
>   	if (on)
> -		policy->cpuinfo.max_freq = max_freq;
> +		policy->cpuinfo.max_freq = cpudata->max_freq;
>   	else if (policy->cpuinfo.max_freq > nominal_freq)
>   		policy->cpuinfo.max_freq = nominal_freq;
>   
> @@ -952,13 +950,15 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   
>   	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
>   
> +	/* max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf */
>   	max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
> +	WRITE_ONCE(cpudata->max_freq, max_freq);
> +
>   	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
>   	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
>   
>   	/**
>   	 * Below values need to be initialized correctly, otherwise driver will fail to load
> -	 * max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf
>   	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
>   	 * Check _CPC in ACPI table objects if any values are incorrect
>   	 */
> @@ -1021,9 +1021,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
>   							      cpudata->nominal_freq,
>   							      perf.lowest_perf);
> -	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
> -							      cpudata->nominal_freq,
> -							      perf.highest_perf);
> +	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
>   
>   	ret = amd_pstate_cppc_enable(policy);
>   	if (ret)
> @@ -1090,14 +1088,9 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>   static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>   					char *buf)
>   {
> -	struct amd_cpudata *cpudata;
> -	union perf_cached perf;
> -
> -	cpudata = policy->driver_data;
> -	perf = READ_ONCE(cpudata->perf);
> +	struct amd_cpudata *cpudata = policy->driver_data;
>   
> -	return sysfs_emit(buf, "%u\n",
> -			  perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf));
> +	return sysfs_emit(buf, "%u\n", cpudata->max_freq);
>   }
>   
>   static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
> @@ -1503,9 +1496,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
>   							      cpudata->nominal_freq,
>   							      perf.lowest_perf);
> -	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
> -							      cpudata->nominal_freq,
> -							      perf.highest_perf);
> +	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
>   	policy->driver_data = cpudata;
>   
>   	ret = amd_pstate_cppc_enable(policy);
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index cb45fdca27a6c..485ee023d79c5 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -94,6 +94,7 @@ struct amd_cpudata {
>   	u32	min_limit_freq;
>   	u32	max_limit_freq;
>   	u32	nominal_freq;
> +	u32	max_freq;

Hi Mario,

A minor finding: the new u32 max_freq field is missing a kdoc entry in
struct amd_cpudata.


>   	u32	lowest_nonlinear_freq;
>   
>   	struct amd_aperf_mperf cur;


-- 
Thx and BRs,
Zhongqiu Han
