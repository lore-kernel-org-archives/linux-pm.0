Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C1140096B;
	Mon, 27 Jul 2026 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155257; cv=none; b=BPLwnPL6APRxToIlPl8/Rxov4kW2yrK+a99ZTmBS1/GShkip6m4e8oMusCexi6jsdKPffJsC44pCx+GcUgXTCmIEXa+ZRGIzoH+nWUF4xdsXdojAKcat9zPxw1LmS0/Kpi7bU2+7AiIV9gPTQ71/i6WZtKKmsacK8cAXAnRsP20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155257; c=relaxed/simple;
	bh=iLUxx6QCbkzh4XpzyXXu+f/2mqE4e9HxfNn/mbdJZa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLXeTkrsqdvoqWp/qxCIW2bY79tP7+NkIunS0WQnvbsp6o9OE8I5JrGowBl8F+jY+TPnbOqH30oLBzIN/beuObhf8VIpQc4j5HY0f/3IjZbCzZi5+ttPg7PYfJSj6mmPA266zAVaqZc+Jh4TFRBxVuSI/k/t3U5aihBEI3CzJ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RNzhlc2E; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RNzhlc2E"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6438B143D;
	Mon, 27 Jul 2026 05:27:31 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44ECA3F86F;
	Mon, 27 Jul 2026 05:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785155255; bh=iLUxx6QCbkzh4XpzyXXu+f/2mqE4e9HxfNn/mbdJZa4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RNzhlc2Ed2LSzW43JDZ0sUbIGWHAeBg7puQizjtZpvABLIIe72KoaB4H5RrGtBomd
	 obvdggHYVtw7E/SmprVbcdszRokmL2++d72Ws5RPP1NRffdFLeaVkgi33KndxbttjZ
	 58TTI5pGuSkwm7w/qvMrwO0d09y7AaZ8cIxqIdpc=
Message-ID: <9fa94c64-c4ed-45b5-85ab-c6f8f04107e5@arm.com>
Date: Mon, 27 Jul 2026 13:27:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: Skip writes to unsupported performance
 controls
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Pierre Gondois <pierre.gondois@arm.com>,
 Sumit Gupta <sumitg@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>
References: <20260724104042.1481804-1-christian.loehle@arm.com>
 <6174756a-b779-422a-a67d-d677961d99f0@huawei.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <6174756a-b779-422a-a67d-d677961d99f0@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/26 12:14, zhenglifeng (A) wrote:
> On 7/24/2026 6:40 PM, Christian Loehle wrote:
>> MIN_PERF and MAX_PERF are optional CPPC controls. DESIRED_PERF is also
>> optional with CPPC2 when autonomous selection is supported.
>>
>> The cppc-cpufreq target callbacks populate both limits for every request
>> without checking whether the controls are implemented. cppc_set_perf()
>> consequently passes NULL register descriptors to cpc_write(). The writes
>> fail width validation and their return values are ignored, so the failed
>> access paths are repeated on every target request. An autonomous-only
>> platform can take the same path for DESIRED_PERF.
>>
>> Check that each performance control is supported before calling
>> cpc_write().
>>
>> Fixes: ea3db45ae476 ("cpufreq: cppc: Update MIN_PERF/MAX_PERF in target callbacks")
>> Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>> v2: Also added desired_perf check (Sumit)
>>
>>  drivers/acpi/cppc_acpi.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 1d3a94100491..53d09ca98f06 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1963,16 +1963,17 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>  		cpc_desc->write_cmd_status = 0;
>>  	}
>>  
>> -	cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
>> +	if (CPC_SUPPORTED(desired_reg))
>> +		cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
>>  
>>  	/*
>>  	 * Only write if min_perf and max_perf not zero. Some drivers pass zero
>>  	 * value to min and max perf, but they don't mean to set the zero value,
>>  	 * they just don't want to write to those registers.
>>  	 */
>> -	if (perf_ctrls->min_perf)
>> +	if (perf_ctrls->min_perf && CPC_SUPPORTED(min_perf_reg))
>>  		cpc_write(cpu, min_perf_reg, perf_ctrls->min_perf);
>> -	if (perf_ctrls->max_perf)
>> +	if (perf_ctrls->max_perf && CPC_SUPPORTED(max_perf_reg))
>>  		cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
>>  
>>  	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg))
> 
> LGTM.
> 
> Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> 
> Apologize for replying to v1 before seeing v2.
> 

Thanks for taking a look!
You can blame it on me for messing up the title and forgetting to put v2 there :/
