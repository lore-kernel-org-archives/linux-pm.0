Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B7478F4A;
	Mon,  1 Jun 2026 02:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780281117; cv=none; b=lPYa8hMHUYdKL6MDWc0pGHfPId+ErTO3JY+nA8nJXJAK3TapYU3VcehfP9G4AfF76lHtAs7dfkrION4oqHh+HWutDViyx27sfZhHbtlhzetNi+GxoIBYEODdEKFkBiQ+5WmXS8kNITlZmUfV4OD1hPmNx/us8wsMZoWe4vhUEsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780281117; c=relaxed/simple;
	bh=mMceGhfGGhIyUIAPtc4wT2ZortdfXYgsMpxqn8eoBA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lbw3dvzIGpBTWGDNrv05hfHSKwIEdZvsM+ZFQ9OiVcuX4lVJDM8vxB5dCXa9JnLLwIBxTn2YezjvJeb3rRGmq35Wk07QZL96j/vFgDInNMQSkPSuIhm7m9Oy78b6e9WpPMUbG9v0ykzt1k4PQ7SFvcxnu0rqmUcbQpJY1eH+lN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 098874ec5d6211f1aa26b74ffac11d73-20260601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e8df8b6f-1adc-4009-a840-06959c90a7ca,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:4f66cb218efca946c6ff02be308f0345,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 098874ec5d6211f1aa26b74ffac11d73-20260601
Received: from [10.42.13.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoxueqin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1043785512; Mon, 01 Jun 2026 10:31:47 +0800
Message-ID: <5e91635e-8aa5-4113-bce9-b7a82320e09c@kylinos.cn>
Date: Mon, 1 Jun 2026 10:31:46 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: Add helper to get effective guaranteed
 performance
Content-Language: en-US
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
 saket.dumbre@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20260529081801.29346-1-luoxueqin@kylinos.cn>
 <60119eb883057391dc6def200be119e56a6e4fb5.camel@linux.intel.com>
From: luoxueqin <luoxueqin@kylinos.cn>
In-Reply-To: <60119eb883057391dc6def200be119e56a6e4fb5.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/5/29 23:33, srinivas pandruvada 写道:
> On Fri, 2026-05-29 at 16:18 +0800, Xueqin Luo wrote:
>> According to the ACPI CPPC specification, if the Guaranteed
>> Performance register is not implemented, OSPM assumes the
>> guaranteed performance is equal to nominal performance.
>>
>> Add cppc_get_effective_guaranteed_perf() helper to provide a
>> spec-compliant effective guaranteed performance value while
>> preserving the raw values returned by cppc_get_perf_caps().
>>
> Hi Luo,
>
> Are you trying to fix any issue where you have issue with
> "base_frequency" display? intel_pstate will revert to native MSR, which
> is always present when we are using CPPC.
>
> I worry about some bad nominal perf in some platforms as we will be
> dependent on OEM BIOS.
>
> Thanks,
> Srinivas
>
Thanks Srinivas.

The intent is not to fix any issue in intel_pstate. It already
implements the fallback correctly today.

My goal was to provide a common helper encapsulating the ACPI
CPPC semantics, with intel_pstate serving as the first user.
That said, I agree the benefit may not justify a new exported
helper at this point.
>> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
>> ---
>>   drivers/acpi/cppc_acpi.c       | 26 ++++++++++++++++++++++++++
>>   drivers/cpufreq/intel_pstate.c | 10 ++++------
>>   include/acpi/cppc_acpi.h       |  5 +++++
>>   3 files changed, 35 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index f370be8715ae..6dc11030707a 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1328,6 +1328,32 @@ int cppc_get_highest_perf(int cpunum, u64
>> *highest_perf)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>>   
>> +/**
>> + * cppc_get_effective_guaranteed_perf - get effective guaranteed
>> performance
>> + * @cpunum: CPU number
>> + * @guaranteed_perf: Effective guaranteed performance value
>> + *
>> + * The ACPI CPPC specification states that if the Guaranteed
>> + * Performance register is not implemented, OSPM assumes the
>> + * guaranteed performance is equal to nominal performance.
>> + *
>> + * Return: 0 on success, negative errno on failure.
>> + */
>> +int cppc_get_effective_guaranteed_perf(int cpunum, u64
>> *guaranteed_perf)
>> +{
>> +	struct cppc_perf_caps perf_caps;
>> +	int ret;
>> +
>> +	ret = cppc_get_perf_caps(cpunum, &perf_caps);
>> +	if (ret)
>> +		return ret;
>> +	*guaranteed_perf = perf_caps.guaranteed_perf ?:
>> +			   perf_caps.nominal_perf;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_effective_guaranteed_perf);
>> +
>>   /**
>>    * cppc_get_epp_perf - Get the epp register value.
>>    * @cpunum: CPU from which to get epp preference value.
>> diff --git a/drivers/cpufreq/intel_pstate.c
>> b/drivers/cpufreq/intel_pstate.c
>> index 8dc22a65e025..8934e48f71a2 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -404,17 +404,15 @@ static void intel_pstate_set_itmt_prio(int cpu)
>>   
>>   static int intel_pstate_get_cppc_guaranteed(int cpu)
>>   {
>> -	struct cppc_perf_caps cppc_perf;
>> +	u64 guaranteed_perf;
>>   	int ret;
>>   
>> -	ret = cppc_get_perf_caps(cpu, &cppc_perf);
>> +	ret = cppc_get_effective_guaranteed_perf(cpu,
>> &guaranteed_perf);
>> +
>>   	if (ret)
>>   		return ret;
>>   
>> -	if (cppc_perf.guaranteed_perf)
>> -		return cppc_perf.guaranteed_perf;
>> -
>> -	return cppc_perf.nominal_perf;
>> +	return guaranteed_perf;
>>   }
>>   
>>   static int intel_pstate_cppc_get_scaling(int cpu)
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index d1f02ceec4f9..c02f3bc1fc1a 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -155,6 +155,7 @@ struct cppc_cpudata {
>>   extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>>   extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
>>   extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
>> +extern int cppc_get_effective_guaranteed_perf(int cpunum, u64
>> *guaranteed_perf);
>>   extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs
>> *perf_fb_ctrs);
>>   extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls
>> *perf_ctrls);
>>   extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls
>> *perf_ctrls);
>> @@ -198,6 +199,10 @@ static inline int cppc_get_highest_perf(int
>> cpunum, u64 *highest_perf)
>>   {
>>   	return -EOPNOTSUPP;
>>   }
>> +static inline int cppc_get_effective_guaranteed_perf(int cpunum, u64
>> *guaranteed_perf)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>>   static inline int cppc_get_perf_ctrs(int cpu, struct
>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>   {
>>   	return -EOPNOTSUPP;
