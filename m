From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 02/10] cpufreq: provide default frequency-invariance
 setter function
Date: Wed, 2 Aug 2017 13:55:02 +0100
Message-ID: <2f8ca8f0-9fff-94e4-2bca-8777d836809a@arm.com>
References: <20170727193312.9849-1-dietmar.eggemann@arm.com>
 <20170727193312.9849-3-dietmar.eggemann@arm.com>
 <20170728073036.GZ352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728073036.GZ352@vireshk-i7>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 28/07/17 08:30, Viresh Kumar wrote:
> On 27-07-17, 20:33, Dietmar Eggemann wrote:
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 9bf97a366029..04e2f7e4964e 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2404,6 +2404,17 @@ int cpufreq_boost_enabled(void)
>>  EXPORT_SYMBOL_GPL(cpufreq_boost_enabled);
>>  
>>  /*********************************************************************
>> + *               FREQUENCY INVARIANT ACCOUNTING SUPPORT              *
>> + *********************************************************************/
> 
> We don't need another of these fancy headers :)
> 
> Just add below routine somewhere at the top, maybe before
> cpufreq_generic_init().

Yes, sure. Will address this in the upcoming v4.

Thanks the review!

-- Dietmar
