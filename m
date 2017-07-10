From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 04/10] arm: wire cpufreq input data for
 frequency-invariant accounting up to the arch
Date: Mon, 10 Jul 2017 16:13:50 +0100
Message-ID: <de625d21-6e2c-0a3f-85be-bff70d24ea61@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-5-dietmar.eggemann@arm.com>
 <20170706104258.GC13048@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36830 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753972AbdGJPNy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Jul 2017 11:13:54 -0400
In-Reply-To: <20170706104258.GC13048@vireshk-i7>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>

On 06/07/17 11:42, Viresh Kumar wrote:
> On 06-07-17, 10:49, Dietmar Eggemann wrote:
>> Define arch_set_freq_scale to be the arch_topology "driver" function
>> topology_set_freq_scale() to let FIE work correctly.
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Juri Lelli <juri.lelli@arm.com>
>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> ---
>>  arch/arm/include/asm/topology.h | 5 +++++
>>  arch/arm/kernel/topology.c      | 1 -
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
>> index 370f7a732900..ca05d1b90411 100644
>> --- a/arch/arm/include/asm/topology.h
>> +++ b/arch/arm/include/asm/topology.h
>> @@ -24,6 +24,11 @@ void init_cpu_topology(void);
>>  void store_cpu_topology(unsigned int cpuid);
>>  const struct cpumask *cpu_coregroup_mask(int cpu);
>>  
>> +#include <linux/arch_topology.h>
>> +
>> +/* Subscribe for input data for frequency-invariant load-tracking */
>> +#define arch_set_freq_scale topology_set_freq_scale
>> +
>>  #else
>>  
>>  static inline void init_cpu_topology(void) { }
>> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
>> index bf949a763dbe..2c47a76c67b0 100644
>> --- a/arch/arm/kernel/topology.c
>> +++ b/arch/arm/kernel/topology.c
>> @@ -11,7 +11,6 @@
>>   * for more details.
>>   */
>>  
>> -#include <linux/arch_topology.h>
> 
> Why is this diff part of this patch ?

Since 'arch/$ARCH/include/asm/topology.h' now includes
'include/linux/arch_topology.h' and 'arch/$ARCH/kernel/topology.c'
already includes 'arch/$ARCH/include/asm/topology.h' I thought it's a
good idea to get rid of this include here.
