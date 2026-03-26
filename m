Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583153B9D92
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513125; cv=none; b=AVKIoGojhPdEE+T2Mp2LHA5HHbIv6MJ7zV0vvzqhC+9x+aA3ohNSnMl5Q1E0K00d4kQF1sNrMmpzCti0Nw/sOWlPaCgwz5HW9vOM28suquy2TMTP3JY/0IkGIWKWg0F5qUR+hg2hWbeIIClt8DXlh5LEErhsRA7e7ZfVpk5uMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513125; c=relaxed/simple;
	bh=u2Y6KKbgbbKhS8i10gQhgt/wQsfDs6c9xOr5mXVXsMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGqrUrHS9sA2IB1s4RIq1uEN6WAOPOk27fM1hlNoBkeESt0TEdecPJHqx4l6n19ru5hTvXsyiabAYlbs5XnGOygK1PBAgRHIBXjl6fRD2H2rdDF9c51Rro3P6sy7bhw0rlaArEIbYDm3EvJTgL8wTonzbYJu8t1QQdW16nMtClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PsONPIjJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qu3dPAjN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PsONPIjJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qu3dPAjN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q6aIIF052584
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 08:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SxnhaBklzFLc8eoTq471oYVEanoFKpaP1wRuMYtQWrU=; b=PsONPIjJVg0375h+
	slJJhdx2WirToaHrkVwvnIqFOrsips0f3DSFogB3KUat5RCMd8UwAzEE6Jp6c9jA
	xQOKXFNs/VbCC/JqJxSDb9cpH9Ef+08A1pFBv1uXVVp3Al5SalYI2x+C7zoaXDXE
	sikm2S78+VLSyu8gGRbiPnKkNTq1+HdLFgk8FcLNZrge/nfccidrikpcLnZMlC2b
	/AVRU5QGaSFv9NdG/7An/XikKV698Bw+VIGwLhIgIerJnLo1ofXWF0b6LU5GnP+1
	4LMnD0GuDL5GPnXURsA2fzr9bvF5AAHqhGIbmks7UaX5WqOUudWdBKBweLVOXmoI
	yi88FA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4q1t1vwg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 08:18:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aecbb78e44so17416015ad.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 01:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774513121; x=1775117921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxnhaBklzFLc8eoTq471oYVEanoFKpaP1wRuMYtQWrU=;
        b=Qu3dPAjNAmRXNFLvGyGSRToEWvnkVEKXt8oUNTXjXaU7rmJS+muaKyGTlb2YgPJS1a
         8L+kWYi8+ubNZL72tMaFXOloAsadP/+ey3meSCVDQUpp0CTTy8S2yg5C53bmCIwIfJX7
         SREsGOkJ8P96Ttujpf/2eR8pwnKloSrAZwH+61WyHqIPN79g0+2p2Vdarir0luPDMEk0
         9/TiZcUxqwFniLwzZvSe0pA9eGXKluiA8viKph3QNanPQ+B2gEID7/xUnh0XFZGNrSwB
         qKS0A2C2/LAJoBYeGH61qK5nRr3KCWw4cEOaNL98mH+zSu9d4e5kyPpKRG3krBnhw/TV
         JJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774513121; x=1775117921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxnhaBklzFLc8eoTq471oYVEanoFKpaP1wRuMYtQWrU=;
        b=lG1r3CWgNcUwIVvxTBONgjIxTjg76Y1CSMB7VPsEQyHJJKE5s17bN5FOY4Vtag6eXV
         gZlxwQDXx/AILAGocUAPfeBhBjynLO/StCi2BjC6w3jrDYm9ZDvki8VYkNqzM3oXh4R2
         uSrBE5wo/gz6f1Szw1MuPmdr03xGyiC+FS7C78ckVkh0gm2A4IzhCu+A8Qve/Wp9Um30
         Xpis0667Ddj5VXuqjoewkuEIqR8/LCnrgpAuAqsFV3n4JUwwNyl5t3at6OQkAZo7Vqx1
         bmV9GLN33E/yaxni2LzZzBUrcHYvY3HJG6g7IelKWAI80Bj4mm7KhgwNC1cQYI6fbmdF
         3YyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsNLCcBP4JPytoxbAlmiaAJukGaTPSoZyGx4NprmkCzTUZ/OidUPIm4M34gwsV/TNw2rV04CBuQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcSpGP22limSUKGOd4VkaZ7p9LkP8qWPdi0Sg6j5zCYMGXHvV
	4Uq7SLyaOq9qPrWVanBR80z6SGhncNgT6OhOoDoSEuGqSKD1BX0GviQYzQ5ofCO7p4geExPAYeN
	wxFK1HaRoWKzhGuKX6zk63SIHWmDqNP9MI5awpLa7Ewiyts2CXBkGFiNTK10fzg==
X-Gm-Gg: ATEYQzwr6AXBULk/KoAjTpjaSZh1tp6ZSeHmEd2PMaKt6De3khc3/6E/wTuNLd2iMQ1
	uPro5CmldKNlQ1Xlazwg3RWF0Y7Seip6+FTtZl2JSIoy2BlORQsnLEzHCaoLZwNM5ugRJPYrt/7
	4xNmRd1GDYLd2cozI0tJ4f79gRvWVcCrFgZW7EuxeApx/YDhS3qiCMR2CP0KJ53l6Q9omxIeJFy
	vSW/NsVG0afkzaNwRBJpFmyg2+msBHDmrpiQXib+ntOFlYh04CdQXuFrapPokufmLd/eqy7GgJZ
	c8vwSNVHsyVkndmvLmdl73Mk0OUH9VCVmVqlDsRgDZjUZKMN2yhP8u1BVI0HhkFPUDsjEhfICeF
	cd1o1RxyvgXluEiQTShnyRrOkz1nhGK9DA8YDN2S/1JraNLZyTUlnbrjUi2a0wCh9Ypt/DSKcFG
	4aDiWlds9+UF25toxQ
X-Received: by 2002:a17:903:240c:b0:2ae:80bc:9bfb with SMTP id d9443c01a7336-2b0b0b0e2f7mr80094435ad.40.1774513121232;
        Thu, 26 Mar 2026 01:18:41 -0700 (PDT)
X-Received: by 2002:a17:903:240c:b0:2ae:80bc:9bfb with SMTP id d9443c01a7336-2b0b0b0e2f7mr80094085ad.40.1774513120719;
        Thu, 26 Mar 2026 01:18:40 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7b233fsm22925735ad.32.2026.03.26.01.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 01:18:40 -0700 (PDT)
Message-ID: <a382a832-d71b-4227-a469-07c96b70c372@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 16:18:35 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] cpufreq: Add boost_freq_req QoS request
To: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, Huang Rui <ray.huang@amd.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <perry.yuan@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260325165255.386576-1-pierre.gondois@arm.com>
 <20260325165255.386576-3-pierre.gondois@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260325165255.386576-3-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e7cLiKp/ c=1 sm=1 tr=0 ts=69c4ebe2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=7CQSdrXTAAAA:8 a=OTLpJuPVDTOuwz7AMcsA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: yArez5OWBx5jGPCqmrrfqju2K1nPo74b
X-Proofpoint-ORIG-GUID: yArez5OWBx5jGPCqmrrfqju2K1nPo74b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA1OSBTYWx0ZWRfX1L7blCMvuKDh
 EtActu2abyI9vYOxot4rKXqzfiC8xWPzaKIAayg+1HCJ0mAsxDmiDxoT+ZZmJTicKAy6LVB9tyG
 ucEDlED0gmC4hrpRzQDcrIkF5Vs4gjGEanM0M5aIopf/cG4Ufc5+5HQm+B1NTDKhYvH3Q/HeAbD
 efjMCs2lMorAzA/92wyjgDUBucB/Rs8xOcBfKcAKYUEwJNpuSj/BBbMoDwegeHCUUEFVYIpoikJ
 PNcTgaRORnSExAzXBmDn2ib/Q9ZBW9HmYlhpjxknImNDs0bTJmSKSfYVtRvkblWhxnpZDHmbYZL
 GKaHXV1R+b7TgzgosjLELOt2fBsCeY6DwP6oFscUprWxdAO//ec8uhG6x+Q6T9xpYv1mKyAn4rw
 zZaIyfdzGX2ejiyQLGJTjgiIP49Z2o9NPOMzkvq0TUx+QZL+wcY6ZSOiFr34vIAL1QrzNpBcDmK
 i+IcOqBJwj/9PcDX1GA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260059

On 3/26/2026 12:52 AM, Pierre Gondois wrote:
> The Power Management Quality of Service (PM QoS) allows to
> aggregate constraints from multiple entities. It is currently
> used to manage the min/max frequency of a given policy.
> 
> Frequency constraints can come for instance from:
> - Thermal framework: acpi_thermal_cpufreq_init()
> - Firmware: _PPC objects: acpi_processor_ppc_init()
> - User: by setting policyX/scaling_[min|max]_freq
> The minimum of the max frequency constraints is used to compute
> the resulting maximum allowed frequency.
> 
> When enabling boost frequencies, the same frequency request object
> (policy->max_freq_req) as to handle requests from users is used.
> As a result, when setting:
> - scaling_max_freq
> - boost
> The last sysfs file used overwrites the request from the other
> sysfs file.
> 
> To avoid this, create a per-policy boost_freq_req to save the boost
> constraints instead of overwriting the last scaling_max_freq
> constraint.
> 
> policy_set_boost() calls the cpufreq set_boost callback.
> Update the newly added boost_freq_req request from there:
> - whenever boost is toggled
> - to cover all possible paths
> 
> In the existing .set_boost() callbacks:
> - Don't update policy->max as this is done through the qos notifier
>    cpufreq_notifier_max() which calls cpufreq_set_policy().
> - Remove freq_qos_update_request() calls as the qos request is now
>    done in policy_set_boost() and updates the new boost_freq_req
> 
> $ ## Init state
> scaling_max_freq:1000000
> cpuinfo_max_freq:1000000
> 
> $ echo 700000 > scaling_max_freq
> scaling_max_freq:700000
> cpuinfo_max_freq:1000000
> 
> $ echo 1 > ../boost
> scaling_max_freq:1200000
> cpuinfo_max_freq:1200000
> 
> $ echo 800000 > scaling_max_freq
> scaling_max_freq:800000
> cpuinfo_max_freq:1200000
> 
> $ ## Final step:
> $ ## Without the patches:
> $ echo 0 > ../boost
> scaling_max_freq:1000000
> cpuinfo_max_freq:1000000
> 
> $ ## With the patches:
> $ echo 0 > ../boost
> scaling_max_freq:800000
> cpuinfo_max_freq:1000000
> 
> Note:
> cpufreq_frequency_table_cpuinfo() updates policy->min
> and max from:
> A.
> cpufreq_boost_set_sw()
> \-cpufreq_frequency_table_cpuinfo()
> B.
> cpufreq_policy_online()
> \-cpufreq_table_validate_and_sort()
>    \-cpufreq_frequency_table_cpuinfo()
> Keep these updates as some drivers expect policy->min and
> max to be set through B.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>   drivers/cpufreq/amd-pstate.c   |  2 --
>   drivers/cpufreq/cppc_cpufreq.c | 10 ++-----
>   drivers/cpufreq/cpufreq.c      | 51 ++++++++++++++++++++++++++--------
>   include/linux/cpufreq.h        |  1 +
>   4 files changed, 43 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5aa9fcd80cf51..d0675d6a19fe1 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -769,8 +769,6 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>   	else if (policy->cpuinfo.max_freq > nominal_freq)
>   		policy->cpuinfo.max_freq = nominal_freq;
>   
> -	policy->max = policy->cpuinfo.max_freq;
> -
>   	if (cppc_state == AMD_PSTATE_PASSIVE) {
>   		ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
>   		if (ret < 0)
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 011f35cb47b94..f4f574fbe547b 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -807,17 +807,11 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>   {
>   	struct cppc_cpudata *cpu_data = policy->driver_data;
>   	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> -	int ret;
>   
>   	if (state)
> -		policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
> +		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
>   	else
> -		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
> -	policy->cpuinfo.max_freq = policy->max;
> -
> -	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> -	if (ret < 0)
> -		return ret;
> +		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
>   
>   	return 0;
>   }
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 5757f12633d16..947ed87cf8d76 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -609,10 +609,19 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
>   	policy->boost_enabled = enable;
>   
>   	ret = cpufreq_driver->set_boost(policy, enable);
> -	if (ret)
> +	if (ret) {
>   		policy->boost_enabled = !policy->boost_enabled;
> +		return ret;
> +	}
>   
> -	return ret;
> +	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);

Hello Pierre,

Would it be reasonable to add a NULL check for policy->boost_freq_req in
policy_set_boost() before calling freq_qos_update_request(), even though
callers already check policy->boost_supported? Thanks


> +	if (ret < 0) {
> +		policy->boost_enabled = !policy->boost_enabled;
> +		cpufreq_driver->set_boost(policy, policy->boost_enabled);
> +		return ret;
> +	}
> +
> +	return 0;
>   }
>   
>   static ssize_t store_local_boost(struct cpufreq_policy *policy,
> @@ -1377,6 +1386,8 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>   	}
>   
>   	freq_qos_remove_request(policy->min_freq_req);
> +	if (policy->boost_freq_req)
> +		freq_qos_remove_request(policy->boost_freq_req);
>   	kfree(policy->min_freq_req);
>   
>   	cpufreq_policy_put_kobj(policy);
> @@ -1445,18 +1456,42 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>   	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>   
>   	if (new_policy) {
> +		unsigned int req_nr;
> +
>   		for_each_cpu(j, policy->related_cpus) {
>   			per_cpu(cpufreq_cpu_data, j) = policy;
>   			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>   		}
>   
> -		policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
> +		req_nr = policy->boost_supported ? 3 : 2;
> +		policy->min_freq_req = kzalloc(req_nr * sizeof(*policy->min_freq_req),
>   					       GFP_KERNEL);
>   		if (!policy->min_freq_req) {
>   			ret = -ENOMEM;
>   			goto out_destroy_policy;
>   		}
>   
> +		if (policy->boost_supported) {
> +			policy->boost_freq_req = policy->min_freq_req + 2;
> +
> +			/*
> +			 * If boost is supported,
> +			 * init the constraint with cpuinfo.max_freq.
> +			 */
> +			ret = freq_qos_add_request(&policy->constraints,
> +						   policy->boost_freq_req,
> +						   FREQ_QOS_MAX,
> +						   policy->cpuinfo.max_freq);
> +			if (ret < 0) {
> +				/*
> +				 * So we don't call freq_qos_remove_request() for an
> +				 * uninitialized request.
> +				 */
> +				policy->boost_freq_req = NULL;
> +				goto out_destroy_policy;
> +			}
> +		}
> +
>   		ret = freq_qos_add_request(&policy->constraints,
>   					   policy->min_freq_req, FREQ_QOS_MIN,
>   					   FREQ_QOS_MIN_DEFAULT_VALUE);
> @@ -2788,16 +2823,10 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
>   		return -ENXIO;
>   
>   	ret = cpufreq_frequency_table_cpuinfo(policy);
> -	if (ret) {
> +	if (ret)
>   		pr_err("%s: Policy frequency update failed\n", __func__);
> -		return ret;
> -	}
> -
> -	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> -	if (ret < 0)
> -		return ret;
>   
> -	return 0;
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
>   
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index cc894fc389710..89157e367eefa 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -81,6 +81,7 @@ struct cpufreq_policy {
>   	struct freq_constraints	constraints;
>   	struct freq_qos_request	*min_freq_req;
>   	struct freq_qos_request	*max_freq_req;
> +	struct freq_qos_request *boost_freq_req;
>   
>   	struct cpufreq_frequency_table	*freq_table;
>   	enum cpufreq_table_sorting freq_table_sorted;


-- 
Thx and BRs,
Zhongqiu Han
