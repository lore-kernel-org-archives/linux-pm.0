Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C4A40B0EF;
	Fri, 24 Jul 2026 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784894524; cv=none; b=qz/CmXRyeFlWg5y/YUJTDcMN8mmuqKKli+pIAJNlbzNJ3zkZ6bWvl2/x1g17Na/0gw0RJErQlGBUZuEBcoiOA13UFhUBN3mAJHmGkpbk0SByFag/p7OPMMmTDT9FTmuxOKAVfevb+o3H2RG50K2EN4yl9a978xfjhIkeUxDJlNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784894524; c=relaxed/simple;
	bh=t2Fm4OcZ2NIH+xOpaL0wjVXyHl0Qp/ARR/FcYxwFvrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S16KsjaUC6eF9oW3HK0Ye39OVPge2T6X049XOQY8Ias6WgtLK5WSUIqz7Pi3fPilSfd3pdHuyWCFR+e28P0bNj9SJQNu3SHNFwJpvCvmQ9bkdbMDqfPDxiDoiHgdbrtYWTsF3MSzFeT0wq4Nfx/ZRxw4S6sEcWEGQ/szVxUpQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f5xpij79; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f5xpij79"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C353E1476;
	Fri, 24 Jul 2026 05:01:55 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A56FF3F59E;
	Fri, 24 Jul 2026 05:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784894519; bh=t2Fm4OcZ2NIH+xOpaL0wjVXyHl0Qp/ARR/FcYxwFvrw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f5xpij79JxJpztbGFRwdSOvp1+dta12GYVExyTffv/FIEnIlj/I7uam9oytSozfLd
	 F9RlPnvouBfSPA6C1sOP9SQptVICLbMIDCaPBzkZXNRQ9SJLBl7DAkGgMl8rnJQd/1
	 L8cQYnZ2CjrHEar7UgFdtbeQg25hYbJB0eXrphFo=
Message-ID: <e4b5b99c-bf38-49f5-89bc-e2ee0b58172f@arm.com>
Date: Fri, 24 Jul 2026 13:01:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: Skip writes to unsupported performance
 controls
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Len Brown <lenb@kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>
References: <20260724104042.1481804-1-christian.loehle@arm.com>
 <20260724-astonishing-hysterical-goldfish-87f8df@sudeepholla>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260724-astonishing-hysterical-goldfish-87f8df@sudeepholla>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 11:57, Sudeep Holla wrote:
> On Fri, Jul 24, 2026 at 11:40:42AM +0100, Christian Loehle wrote:
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
> 
> In general, can't be set perf_ctrls->desired_perf if and only if
> CPC_SUPPORTED(desired_reg) ?
> 
> I see cppc_get_perf() does that but I assume you are catering for some
> other access that may happen before ?
> 

cppc-cpufreq sets desired_perf regardless, I guess the check could also move up
there, but down here is fine as well IMO.
