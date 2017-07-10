From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 10/10] drivers base/arch_topology: inline cpu- and
 frequency-invariant accounting
Date: Mon, 10 Jul 2017 16:17:51 +0100
Message-ID: <80be7145-99c3-b13b-ae2e-0ce6e4623da0@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-11-dietmar.eggemann@arm.com>
 <20170706105753.GA1523@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170706105753.GA1523@vireshk-i7>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 06/07/17 11:57, Viresh Kumar wrote:
> Sure this patch looks pretty useful, but ...
> 
> On 06-07-17, 10:49, Dietmar Eggemann wrote:
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index 63fb3f945d21..b4481cff14bf 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -22,12 +22,7 @@
>>  #include <linux/string.h>
>>  #include <linux/sched/topology.h>
>>  
>> -static DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
>> -
>> -unsigned long topology_get_freq_scale(struct sched_domain *sd, int cpu)
>> -{
>> -	return per_cpu(freq_scale, cpu);
>> -}
>> +DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
> 
> ... you just undo what you did earlier in this series, and that is somewhat
> discouraged.
> 
> What about making this as the first patch of the series and move only the below
> part to the header. And then you can add the above part to the right place in
> the first attempt itself?
> 
> But maybe this is all okay :)

I just wanted to show people what we gain in completely inlining FIE and
CIE on ARM64 in the scheduler hot-path. But yes, with the next version I
want to fold this inlining into the actual FIE/CIE patch.
