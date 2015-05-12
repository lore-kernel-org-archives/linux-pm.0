From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpufreq: arm_big_little: remove compile-time dependency
 on BL_SWITCHER
Date: Tue, 12 May 2015 09:03:19 +0100
Message-ID: <5551B3C7.80004@arm.com>
References: <1431343473-9915-1-git-send-email-sudeep.holla@arm.com> <20150512072754.GF32300@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150512072754.GF32300@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Medhurst <tixy@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org



On 12/05/15 08:27, Viresh Kumar wrote:
> On 11-05-15, 12:24, Sudeep Holla wrote:
>> With the addition of switcher code, there's compile-time dependency on
>> BL_SWITCHER to get arm_big_little driver compiling on ARM64. Since ARM64
>
> The Kconfig dependency isn't on the switcher but big.LITTLE, which
> isn't defined for arm64. So, we need a bit of clarity here.
>

Right, we update accordingly.

>> @@ -562,8 +580,7 @@ int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)
>>
>>   	arm_bL_ops = ops;
>>
>> -	ret = bL_switcher_get_enabled();
>> -	set_switching_enabled(ret);
>> +	set_switching_enabled(bL_switcher_get_enabled());
>
> This change wasn't required.
>
Right, I thought ret is not used anywhere else and might produce 
warnings, which is wrong. I will revert it back.

Regards,
Sudeep
