Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868350;
	b=xphpJ//0PdHRaAJUZzmBh1C4Wz/RyuHLd/+EpZfMAhBc0Y6ba0MlgyUo+57GxY5GyVA+
	 MIBH8BwDXJvmnQnS/XpD3CjFhTSWrNpplcNZHHf+nZjQlRGs30mauCpP4tObmOuxAhqPu
	 TLlzgh1OkIRUwO1pkKLx35txZalbpxx4joGQGb0HDkauxFWDFNUi9QKq4Mh+bn8sj4kCH
	 E75oDbs2yUXLBoclDFxvO+qGdhPdJQzdLWrR1U4eD1bqDh7YJi13K0nYE18wRfd+hDBkh
	 p1OE4cO26S5rjflDHVQg9dpSPDcW63p//XT7q+DWPPIPZ39Zpc7Ul8ceQiFfbDCcbaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868350;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FoR45qrqaj+lPz6WlzCAFCZClLnjC68M6qIS0mQfoxA=;
	b=V+mxVaP7NeXFtBrGYoGTnfnwwKJIYgVRFXXXONhjRJ8QLTq/BvZk8nxxNpp/Gg7248tz
	 dDGf+sIhdNbaMwcKJFyQZlfJbGNN+L2Y1i6yzPYcdGiDDksjuYfxKZQjr9UOkj0DsM8cI
	 EPDYlJBLtf7GFLO5WwPM74l1MSWre8+yhqDm/1/jgHi0Mu4h3IhXhethFmrRbUFhwXopD
	 MqrYupHRyIAe8rtfzWmuRZNBQt11xfgFKpCQPdW9wUS54bwy6UfSqMi034zbfyPoKKdR2
	 Wyki6BR7BCm6ikT496rSCtN/jQzmlAw6rr6NKMfaG0Oa9t6q48r5fQ9lvvV/iZpSlAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cVoAAeo0;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A44B606A328;
	Thu,  5 Nov 2026 08:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A44B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cVoAAeo0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FBDE15A1;
	Thu,  5 Nov 2026 00:45:45 -0800 (PST)
Received: from [10.0.130.179] (e127648.arm.com [10.0.130.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BAA53F673;
	Thu,  5 Nov 2026 00:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793868348; bh=INwrRA7UlAKXSVavSkzgi19E7CGzsxQNnMkdjRAuHQQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cVoAAeo08hijHlL5qONupSMoKy0Q4ZlWoqQouZllN+sn83jSp8DWM2+H2HOp7Yyz4
	 o/JXkdaF+O8U+sVY47sN+kklnUmXSqYlcOpnhqFyKIaeZPUMC98w4qlPMsb3LyWQ66
	 f6bFseBhkMZ+iFb/XWvp6o3ySL/7163DVt3KJrBs=
Message-ID: <d4a8d9fb-5ccf-4313-b69e-22b330aa145a@arm.com>
Date: Thu, 5 Nov 2026 08:45:44 +0000
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
Subject: Re: [PATCH] cpufreq: Preserve global boost state on failed updates
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 sumit.gupta@nvidia.com, zhanjie9@hisilicon.com, superm1@kernel.org,
 zhangpengjie2@huawei.com
References: <20261104161657.546370-1-christian.loehle@arm.com>
 <2291138c-0e2b-4625-b982-8d72a43c23be@oss.qualcomm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2291138c-0e2b-4625-b982-8d72a43c23be@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/5/26 08:41, Zhongqiu Han wrote:
> On 11/5/2026 12:16 AM, Christian Loehle wrote:
>> cpufreq_boost_trigger_state() restores the opposite of the requested
>> state when updating policy boost state fails. For example, a failed
>> write of 0 when global boost is already disabled enables the global
>> flag without enabling any policies.
>>
>> Save the original global boost state using a mutex and restore it on
>> failure.
>>
>> Fixes: 121baab7b88e ("cpufreq: Force sync policy boost with global boost on sysfs update")
>> Fixes: 6f19efc0a1ca ("cpufreq: Add boost frequency support in core")
> 
> It seems the only appropriate Fixes tag here is 121baab7b88e ("cpufreq:
> Force sync policy boost with global boost on sysfs update"). Commit
> 6f19efc0a1ca ("cpufreq: Add boost frequency support in core") did not
> have this issue, since it returned early when the state was unchanged:
> 
>     if (cpufreq_driver->boost_enabled == state)
>         return 0;

Yes, that wouldn't flip it, although still race between sysfs writers.

> 
> so restoring "!state" on failure was equivalent to restoring the old
> value. 121baab7b88e removed that check, which is what introduced the
> bug.
> 
> Also, is the new mutex meant to address a separate race between
> concurrent sysfs writers? If so, it would be good to mention that in the
> commit message or using separate patch?

Yes indeed, otherwise we could fold it into cpufreq_driver_lock.
I can split the two including the Fixes tag

> 
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>> On a platform without boost_supported the unfixed behaviour is:
>> # cat /sys/devices/system/cpu/cpufreq/boost
>> 0
>> # echo 1 > /sys/devices/system/cpu/cpufreq/boost
>> echo: write error: invalid argument
>> # cat /sys/devices/system/cpu/cpufreq/boost
>> 0
>> # echo 0 > /sys/devices/system/cpu/cpufreq/boost
>> echo: write error: invalid argument
>> # cat /sys/devices/system/cpu/cpufreq/boost
>> 1
>>
>>   drivers/cpufreq/cpufreq.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 54dde8419bdc..d95c849f79c5 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2810,18 +2810,24 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
>>   }
>>   EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
>>   +static DEFINE_MUTEX(cpufreq_boost_mutex);
>> +
>>   static int cpufreq_boost_trigger_state(int state)
>>   {
>>       struct cpufreq_policy *policy;
>>       unsigned long flags;
>> +    bool boost_enabled;
>>       int ret = -EOPNOTSUPP;
>>   +    guard(mutex)(&cpufreq_boost_mutex);
>> +
>>       /*
>>        * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
>>        * make sure all policies are in sync with global boost flag.
>>        */
>>         write_lock_irqsave(&cpufreq_driver_lock, flags);
>> +    boost_enabled = cpufreq_driver->boost_enabled;
>>       cpufreq_driver->boost_enabled = state;
>>       write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>>   @@ -2841,7 +2847,7 @@ static int cpufreq_boost_trigger_state(int state)
>>           return 0;
>>         write_lock_irqsave(&cpufreq_driver_lock, flags);
>> -    cpufreq_driver->boost_enabled = !state;
>> +    cpufreq_driver->boost_enabled = boost_enabled;
>>       write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>>         pr_err("%s: Cannot %s BOOST\n",
> 
> 

