Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33EE39B949
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868771; cv=none; b=ETtkkDGCVNuxBq2tgZfr+P+nAleb0EiTbVXEXy0396BE8uo7kBYGU6CMHHrI8uoXPOY90Fcu/EizfIReDkyJqbKiORt75q8AuTVsPWKWU5YaNkwUkO3P9NyE68k3NRN5bYrkrJLZbhUcrVoTeYUH89lVqXkeDLtCIiT12lNTRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868771; c=relaxed/simple;
	bh=DTE5jQVuYV0r1kGxb4VzemtjCu+7zpF92ilebeYwCOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPSV5zwURzWhM1Q/UwcpXg6L+dE6cVeMziAdASMHMW+iCaPgCK0xlXuOMp/ub3ypJD1kZc4X9pMNcdft0AWoZx3VEGNZALgLYwBmmrKvo9q7+cXSc+zEUuUJqLrJqz9FRg72BpVRm2dvYyuEawfU5tQPv9UkN9ZP2eI2gX8vbpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JkbAohSI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WAEgISPw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JkbAohSI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WAEgISPw"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R2X7Cg322604
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 07:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2piPBjt9DZ9SkS6ZsgqH/ugvBc7q6DFrNcKhvyNtPGc=; b=JkbAohSI3KZ19uXQ
	yECF0fmIK3X6F7EQXdgkRjeH9r0EypyVTrCYqBEey18USGQJa+Ahpwzjv15avaZU
	/UWUVYD7C6hxNhX6lXkvK66aQyQ6JPxfOkxvem1wObN/uivhPj3n17VAocPKlK9a
	zgqYRqRzj002XS2KwxCkLomh93bmuKWQXXYL23Z72rzbDtizb622iaCoEZQMPBMR
	hUA4RqbuqwOI31eJubgfHIh09fQKI4ubD7pMfKZOmh8MTgkKQMuLzx5AbidnzRcb
	+FeLiDJ+/GQo5M4cZtsn3RFRfHMjXtIAz4BjGpQ+Lv0LLS9dMmUzkkmjPljz5PuB
	NkDGEg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edfqk2mvn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 07:59:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba6fe41283so123485915ad.1
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 00:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779868768; x=1780473568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2piPBjt9DZ9SkS6ZsgqH/ugvBc7q6DFrNcKhvyNtPGc=;
        b=WAEgISPwUkEGKXT2d7QH9iqVNJ/q3zPCz5biC6OLucKeI+IzGJD3L6L2kB5HJxPJwH
         EmjN3bSADNqQIkcmG+TeHwAcIrSDQxrMW7B9T4FQqw+eocsBXP+z/d75ZXnY3en+t4zX
         uL5WlgF2SeJsmtHbrUjFWU01hVoSUasxtCcR0BK4AOHF2J9fdSwbWF7Ee6z3CVvnqBo8
         HpchGsRDHhX4MXRRTdznQCobQWmsENzFPIJ7X6lFnQrX/KUuoHBexH3lud/uM/R4zE+E
         kKHVio8x7xpIw2cieO5RlXYN5h1zTjdDDXOLh0BVEkl2484BFpcyYL8daNc/Wt4inOBN
         jPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779868768; x=1780473568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2piPBjt9DZ9SkS6ZsgqH/ugvBc7q6DFrNcKhvyNtPGc=;
        b=U+kJWKLkxbZFEvujxTRlAogR6nfJ7XIHfk62AMH8i2nwZtybU8xIDU9ckiWILZfCAS
         TSnXkW0B7N0B6T5Y9Fsg8JM3CQ8SgiQkamalfnwFlOfuQBR4BLsJC7DySpV+ygqarLaT
         pM8fEvi1h/AR8lI6TlCgi9CFFLgg9M8AQZDeWNv/31w9591A/RYQKw9PexkBU/XFab0D
         FMDuTH2r3QT7eN4lAXQ0tMVwJM1xnhIoMP3QAMM5a3asGS2mwdQxKIyQPJa8TU+Znb+D
         r2gz61ylQDqs3+6aorfZCm/8D5u2ZttB/1wT98bDV+PAHkXIgcmiufEnVAWWJF4PJtOt
         8owg==
X-Forwarded-Encrypted: i=1; AFNElJ8wWxSDXWV0X/Gt8/ICFt362R2YpRU4cq/xZZwH13vHLbe8843D+E8aJ9WC8ZqH8Z7o4ZCBmMvENw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2kBDJd+K7Xgj8mPbo4h+rl+334+Gf04LaEsmYSEYIpobYeeD
	Q0aJ3JNVHCpuMDOy1MV73vG57bgr6Bp6x9hPXVv7XPu5LFAqC8y5758BWQ/m3TJZroq1cDMc6WY
	a3986TUxLpoydd91+DS6a+sQW1kCi0xC843cSqJ7o588IXE78SstVxoPfMHWyYA==
X-Gm-Gg: Acq92OFlj95udt9cLVD2Bkr37rK0OAsxAkH+5W0aCboYDEoJDe8eruVWDyv6QTPGTUq
	ghgbKJ/rwEuOf4NCLsGl7JPDmAOzNxITzqEUWHzxyZi9S7Ngk4IHU3E15Wi+SV2VfrMfCAEz5bZ
	fuf6JAEARILCQcQjxoskAdtJdWqZ9TpK+GwRQc8JR1LHjxYVayCfoKrepGI0ZJ9Nc5Az7GMoBH3
	GCyhDqX7XiVjXjhdE+2RfOvoYeNVcDToHjmqINp4QIlCg5Uoed05wKO6bNACX6uK+2jAjpI4FUv
	byVR8p8j9tUD/9u1O83AfexNRY+zfjV22gxw5jWQbxJxx+43nG1naq99CyEK7PRtnWAA3uuP4Vl
	L5xCtVlCWzMaH6Q3SWgJOaTfX1qMr+lvrUeRs9GbqwvhfgmBIeYLO1DuKfC+EsM5iJqifQZiV9P
	YgT2oWsgPxCFfSz8rsjA==
X-Received: by 2002:a17:903:3b83:b0:2b2:ec31:25b0 with SMTP id d9443c01a7336-2beb0616d02mr240590765ad.29.1779868768041;
        Wed, 27 May 2026 00:59:28 -0700 (PDT)
X-Received: by 2002:a17:903:3b83:b0:2b2:ec31:25b0 with SMTP id d9443c01a7336-2beb0616d02mr240590525ad.29.1779868767543;
        Wed, 27 May 2026 00:59:27 -0700 (PDT)
Received: from [10.133.33.240] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b387dsm149557025ad.50.2026.05.27.00.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 00:59:26 -0700 (PDT)
Message-ID: <c1214419-1f29-490e-a553-8662b08de2c1@oss.qualcomm.com>
Date: Wed, 27 May 2026 15:59:20 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cpufreq: ti: Add EPROBE_DEFER for K3 SoCs
To: Akashdeep Kaur <a-kaur@ti.com>, praneeth@ti.com, nm@ti.com,
        vigneshr@ti.com, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vishalm@ti.com, sebin.francis@ti.com, k-willis@ti.com,
        zhongqiu.han@oss.qualcomm.com
References: <20260527062534.1808422-1-a-kaur@ti.com>
 <20260527062534.1808422-2-a-kaur@ti.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260527062534.1808422-2-a-kaur@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fqPsol4f c=1 sm=1 tr=0 ts=6a16a460 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=sozttTNsAAAA:8 a=MtSs_4BOwNy--CBe7RAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: cVUvSGNVaIRnaT363GHs6dH1AYVDsMOq
X-Proofpoint-GUID: cVUvSGNVaIRnaT363GHs6dH1AYVDsMOq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA3NSBTYWx0ZWRfXzauYvLn5LvvG
 NnCnN9SqMEj+MxFJsnCeBvEqpdWtJRLchQmyMro4u1eOHy0KVsatzwLHNzyfIH/rre7XMibjkuI
 gkoDPJ68fVS1sKqe7OI7yDtYyi11UHluuMwuK705ldjJO3dc8ajPBicNI5smG64uhP346V46673
 ViyyS2sGJnuch4wCvQiz8Kj2tQK1INVSXvixlQzyE63uas+PPpEQGKHxafv+Opiyzr6c4x+Vnv4
 mmlir/gJmtunAlQTuNt/6gYjIIqd0WczX3rJkMXwNl2HQg3oryphS3ZSUnMQN/+9Cz1igOhgfk5
 iKitBzatjtXEYlK+bbUgE/iT0yGERJHAdGRTak+KTVA4L0o9VLV1tb1k9aBCU+GYCR13pMPGWuh
 fFh6nEBY09kA1MWfHIJ0FLdi14AhheQ/7cVlkI/W4bpdUOsy2DKI0ap1swv98Ng64P3Xmih6Hjr
 7s1CftXmOVuZBtJK32Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270075

On 5/27/2026 2:25 PM, Akashdeep Kaur wrote:
> On K3 SoCs, ti-cpufreq relies on k3-socinfo to register the SoC
> device before soc_device_match() can return valid revision
> information. If ti-cpufreq probes before k3-socinfo,
> soc_device_match() returns NULL, leading to incorrect CPU frequency
> scaling behavior.
> Defer probe when k3-socinfo hasn't registered the SoC device yet.
> 
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> ---
>   drivers/cpufreq/ti-cpufreq.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index a01abc1622eb..72832898f3f5 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -429,6 +429,7 @@ static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
>   static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
>   			      u32 *revision_value)
>   {
> +	const struct of_device_id *match;
>   	struct device *dev = opp_data->cpu_dev;
>   	u32 revision;
>   	int ret;
> @@ -441,6 +442,15 @@ static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
>   		 */
>   		*revision_value = 0x1;
>   		goto done;
> +	} else {
> +		/* Check if we're on a K3 SoC that needs k3-socinfo */
> +		match = dev_get_platdata(dev);


Hi Akashdeep,

Just to double-check: here 'dev' is 'opp_data->cpu_dev'
(get_cpu_device(0)), not 'pdev->dev', right?

In that case, would the 'struct of_device_id' match data actually be
associated with the ti-cpufreq platform device rather than the CPU
device?

Do you think it would be reasonable to add a boolean
`needs_k3_socinfo` flag to `struct ti_cpufreq_soc_data` (similar to the
existing multi_regulator pattern), and check
`opp_data->soc_data->needs_k3_socinfo` instead?



> +		if (match && !strncmp(match->compatible, "ti,am62", 7)) {
> +			/* SoC info not ready yet, defer */
> +			dev_dbg(opp_data->cpu_dev,
> +				"Failed to get SoC info, deferring probe\n");
> +			return -EPROBE_DEFER;
> +		}
>   	}
>   
>   	ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,


-- 
Thx and BRs,
Zhongqiu Han
