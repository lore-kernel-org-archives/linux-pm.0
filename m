Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4415D36683D
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774000929; cv=none; b=mqX5p/PWnMNMssrKIFe9xatnzyDrPsIKx/uHVM4iYVGAGMCO19jeSTMzQX1Q6liG5Og4sBmt/15suxMG0HtSz5i23AmTQ62+/5XQwGIC7RCdJGGkr/9pY41bBE9OqeyMbbrahBKLNegwRiLuzQxH7c0BAHRAbwZ+N3UO8ThMUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774000929; c=relaxed/simple;
	bh=L+TFQGorEF8gmVxnSnXa6T6rNtrC/G3rGGfrG4WAx5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZDoocS6BOD07lcc8L/WrXcOEEIcBXV1uN1Nw3JBD61KyYI2GPerrJZheufaWLEHPKlVP9hQA+w5/j8QMIIXmP6pUP2WPcx2Bt1YpiBLA91cHTOxXNOCOiqfWKSUlYtnYHFOEkvqEU9Zs5RKKa35RtUXaeaHlFdO+Y2/xf6WN6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GMlaixtw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dQg9nGSq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GMlaixtw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dQg9nGSq"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K2Y9Xg3558008
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 10:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ND0dBXjqysz5NpSmFZ0lY0fFJs6h5Mzrrxuhwqj/9RY=; b=GMlaixtwPncE6LFd
	a9/Xl6wmwRMqmxU0kCBjqqeoMFjL29vXb/kpp33mISpUW7XQ+mo5Cz8k7oYItMff
	cXJihBeE2D79QJiyJS6v5/ZN3u2ZAPJx+fnZ2b7p/Nv8jrBHlAN/UZ9XCrbSPu9J
	kxKMRDDrpTqD9xrZcU4ZMjNJmSunPsdwFie/eqMVuRicXSjuXDNMLaofWx72+O+6
	nH8YCeS8igT/+4I0e2eL8KhzDGaJhRT+2RLp3tj6tIRzeETwHYB9mZ2KkeX5gual
	9ZXcPVlaGnWmcMqYqd000Djb0MF71kafpOWPKb85PL95e5Le5l8BhcNqmb5D0gHc
	Zv75sg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0r1gst2u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 10:02:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b064884a7cso115663665ad.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774000926; x=1774605726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ND0dBXjqysz5NpSmFZ0lY0fFJs6h5Mzrrxuhwqj/9RY=;
        b=dQg9nGSqVxC3eSGtfUqIzId0LkW+hCPdYwvOt1dZGQGmZeZtm8U06AID0LtNxsGYF8
         Ak66HKiT5hsqAqQNSV7XNAWIJQNyYdFlKHaFIPipzha+2mMC6CHHpA/rihgfvudorcP1
         zhbC8dbE3JpErt+k47nYrkuI0IXTeNtHilAdhRGX6jps8CA9OPaCUTNUokB3iZIh0pTq
         fCWzmp2s2PKumAv9wK4k/gLUwV/XGUMYqxnw7VO1gaEBSZ9JIfJK3a8TYx0fTbTQDBz1
         sQI0nFVD2WkQwmRsWo6y9/R/y8aUzJKzAVvhbQOLj9c25ZFZpSldWlJzYBWCIPI8v7VC
         eOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774000926; x=1774605726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ND0dBXjqysz5NpSmFZ0lY0fFJs6h5Mzrrxuhwqj/9RY=;
        b=l4Nw0hXRMDFX2qOaz7xMC/+7MOu1STzMxSvaX7QbFmimtqgz+Abs15AlWqiGjvKRJW
         Pg5dBusQM+UwnSXBUvVb4h39fkOJm6kotq9Vi7MXGBxMo1W5AVUWACiM4XG0a8RTUQHX
         y/vwCGVRTkWQBXJL0KukxbrnsornM75alTVLhu6Gx1yDdxYBxiLGlpD7BC7KiWoeGaV+
         3wGsMKqfFLeSBS3Y19BnjPzFeG93U1TQI9R3yVWyTNVlk6ogEE9+edVVH2jJAnProiAW
         BdDNANGDdksnHeP9p9iYzZ6rdP1uq+Yz7TkDVdoYumRyj1wlcvn++eB+lmYVd1Qq9m+D
         Mk3w==
X-Gm-Message-State: AOJu0Yym8Q6/IXLZZ0FEURlj8PL1m+zRp1CoZldCgGls0wn/nR1CmAnh
	RB8Hrk1jz/mSL9ylY/CHuRcc7uVK5J8Xcu0NEj1AoZ8j1GzkgJYmVnCGRI0hgJz6tioQZpYm/oG
	i3RhPPPu75uAvOiJa0FfUgcjTTPVCZqok/Tqq+rK9OROmJ7rKH1XRbRgoYpSkxQ==
X-Gm-Gg: ATEYQzxugyYCdMPex9DGY/MBbpXPT5BtVe1rk50zqST8o4O66pw+FTC7HiPBDbBSBg0
	CZgxgjuemKLbnqyE9xT3CavDauAPAZX/SudAOLK+QXkmlg/6ReaXvJuT5qARU4cKXzcJRE/MCJ5
	HxZBMyzN9W+krT2IwQSKYlIYAHTuTnOTU1oC5qRIzS4gcMWumWM2ca7+vYZ8rSY2h07/FMevM1N
	LtZ0rh6WFre3rW5d/yPkCdeiFDmGB5W/uRzsAFlumzv4/mDGLbIj3DhJ3gNgzB9jW7lTJwJ+vej
	W9/JVcjUWY+KaUsDInp/sjBG5UXJ17Qf6F5Y4BQYu9sYoQSJcXNezLW3ivPDKaAez7aUxUkTiiv
	Aws/GYNY8XPqnDO2zRIu50v869LW/zJkg8UBfd4xaGgAbAAmSfS4dWle9mXghne7Ph6T3P1PeIr
	XGC+0nsKtRHJ4+rEQeBA==
X-Received: by 2002:a17:902:cccc:b0:2b0:54dc:63e with SMTP id d9443c01a7336-2b08279427bmr19906825ad.33.1774000925808;
        Fri, 20 Mar 2026 03:02:05 -0700 (PDT)
X-Received: by 2002:a17:902:cccc:b0:2b0:54dc:63e with SMTP id d9443c01a7336-2b08279427bmr19906525ad.33.1774000925348;
        Fri, 20 Mar 2026 03:02:05 -0700 (PDT)
Received: from [10.133.33.215] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083527f84sm17441355ad.18.2026.03.20.03.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 03:02:05 -0700 (PDT)
Message-ID: <4c75f644-2c06-48b1-a72b-1b84be7ba4ab@oss.qualcomm.com>
Date: Fri, 20 Mar 2026 18:02:00 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] cpufreq: conservative: Reset requested_freq on limits
 change
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <d846a141a98ac0482f20560fcd7525c0f0ec2f30.1773999467.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <d846a141a98ac0482f20560fcd7525c0f0ec2f30.1773999467.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA3NyBTYWx0ZWRfX+bOjs6Sa3S0k
 otfhujDxQ3zpZa3wl7GpHaJUtJqClO0nQzK9boWrZcoDSCtCWSkmybxxQxGvm83mXIe00/ZgT3d
 sWNGGaeZQIHrDRhfzxmB4cGFGxDg9uVct+k1gGjb8/U7c2Fq9AfE0CbQn7kk5t8jUYfWsVszW0i
 AHt8uBkOzkxZiwlXppWTyY0Vc+FP1Wo3cZVL0l8PRMb1hki7Yuqfil6k+dKOcRe9DJQde/H4B0u
 R6zXOcNU6y74RqmOOLvTFo/8BYJzqHZZ9pYFSxyD1wiLAO9Jze11KiF78/2RwBMvoRLx1THu4UA
 rdzC7LmcP1ekHVCFBPF6hfUZ7XLenzLPFuLUG7G5VUIXR3Q5Riph43ji//NGTzaiAJhgxHKdXm6
 +fZq56BdJbxmZmHe8PIMkIUF1OGusB12mZyFnUZvBT4OvbktKkzfcqsbX2vxadrH/+2P+b/HHeM
 Sj1hvTz45iEugQQkCTg==
X-Proofpoint-GUID: EVubm5Tuxhn6FU7Y-nJR6cOwS2l5hmQ6
X-Proofpoint-ORIG-GUID: EVubm5Tuxhn6FU7Y-nJR6cOwS2l5hmQ6
X-Authority-Analysis: v=2.4 cv=Y/D1cxeN c=1 sm=1 tr=0 ts=69bd1b1e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=tFKV1D7yu5sg3FCBrf4A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200077

On 3/20/2026 5:38 PM, Viresh Kumar wrote:
> A recently reported issue highlighted that the cached requested_freq
> is not guaranteed to stay in sync with policy->cur. If the platform
> changes the actual CPU frequency after the governor sets one (e.g.
> due to platform-specific frequency scaling) and a re-sync occurs
> later, policy->cur may diverge from requested_freq.
> 
> This can lead to incorrect behavior in the conservative governor.
> For example, the governor may assume the CPU is already running at
> the maximum frequency and skip further increases even though there
> is still headroom.
> 
> Avoid this by resetting the cached requested_freq to policy->cur on
> detecting a change in policy limits.
> 

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>



> Reported-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Tested-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Link: https://lore.kernel.org/all/20260210115458.3493646-1-zhenglifeng1@huawei.com/
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> [v2]
> - Completely different design to solve the problem.
> 
>   drivers/cpufreq/cpufreq_conservative.c | 12 ++++++++++++
>   drivers/cpufreq/cpufreq_governor.c     |  3 +++
>   drivers/cpufreq/cpufreq_governor.h     |  1 +
>   3 files changed, 16 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index e0e847764511..df01d33993d8 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -313,6 +313,17 @@ static void cs_start(struct cpufreq_policy *policy)
>   	dbs_info->requested_freq = policy->cur;
>   }
>   
> +static void cs_limits(struct cpufreq_policy *policy)
> +{
> +	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
> +
> +	/*
> +	 * The limits have changed, so may have the current frequency. Reset
> +	 * requested_freq to avoid any unintended outcomes due to the mismatch.
> +	 */
> +	dbs_info->requested_freq = policy->cur;
> +}
> +
>   static struct dbs_governor cs_governor = {
>   	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
>   	.kobj_type = { .default_groups = cs_groups },
> @@ -322,6 +333,7 @@ static struct dbs_governor cs_governor = {
>   	.init = cs_init,
>   	.exit = cs_exit,
>   	.start = cs_start,
> +	.limits = cs_limits,
>   };
>   
>   #define CPU_FREQ_GOV_CONSERVATIVE	(cs_governor.gov)
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 36eb7aee4bcd..acf101878733 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -563,6 +563,7 @@ EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_stop);
>   
>   void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
>   {
> +	struct dbs_governor *gov = dbs_governor_of(policy);
>   	struct policy_dbs_info *policy_dbs;
>   
>   	/* Protect gov->gdbs_data against cpufreq_dbs_governor_exit() */
> @@ -574,6 +575,8 @@ void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
>   	mutex_lock(&policy_dbs->update_mutex);
>   	cpufreq_policy_apply_limits(policy);
>   	gov_update_sample_delay(policy_dbs, 0);
> +	if (gov->limits)
> +		gov->limits(policy);
>   	mutex_unlock(&policy_dbs->update_mutex);
>   
>   out:
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index 168c23fd7fca..1462d59277bd 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -138,6 +138,7 @@ struct dbs_governor {
>   	int (*init)(struct dbs_data *dbs_data);
>   	void (*exit)(struct dbs_data *dbs_data);
>   	void (*start)(struct cpufreq_policy *policy);
> +	void (*limits)(struct cpufreq_policy *policy);
>   };
>   
>   static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy)


-- 
Thx and BRs,
Zhongqiu Han
