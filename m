From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 03/10] drivers base/arch_topology: frequency-invariant
 load-tracking support
Date: Fri, 7 Jul 2017 17:51:28 +0100
Message-ID: <2e775230-be37-d840-1938-7217f718d224@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-4-dietmar.eggemann@arm.com>
 <20170706104515.GD13048@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751916AbdGGQvc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jul 2017 12:51:32 -0400
In-Reply-To: <20170706104515.GD13048@vireshk-i7>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>

On 06/07/17 11:45, Viresh Kumar wrote:
> On 06-07-17, 10:49, Dietmar Eggemann wrote:

[...]

>> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
>> index 9af3c174c03a..168104d2d2cf 100644
>> --- a/include/linux/arch_topology.h
>> +++ b/include/linux/arch_topology.h
>> @@ -4,6 +4,8 @@
>>  #ifndef _LINUX_ARCH_TOPOLOGY_H_
>>  #define _LINUX_ARCH_TOPOLOGY_H_
>>  
>> +#include <linux/cpumask.h>
>> +
> 
> You don't need a full include here, instead following will work pretty well.
> 
> struct cpumask;

True. Forward declaration is sufficient here. Will change it.

[...]

> Apart from that:
> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!
