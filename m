From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 01/10] drivers base/arch_topology: free cpumask
 cpus_to_visit
Date: Fri, 7 Jul 2017 16:50:43 +0100
Message-ID: <0133bcf5-0037-7b31-94d9-98fa241355a1@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-2-dietmar.eggemann@arm.com>
 <20170706102249.GA13048@vireshk-i7>
 <20170706105921.hbio5jrwsb4xlxeu@e106622-lin>
 <20170706111506.GB1523@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbdGGPuq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jul 2017 11:50:46 -0400
In-Reply-To: <20170706111506.GB1523@vireshk-i7>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>

On 06/07/17 12:15, Viresh Kumar wrote:
> On 06-07-17, 11:59, Juri Lelli wrote:
>> On 06/07/17 15:52, Viresh Kumar wrote:

[...]

>>
>> If that's the case I'm wondering however if we need explicit
>> synchronization though. Otherwise both threads can read the mask as
>> full, clear only their bits and not schedule the workfn?
> 
> Maybe not as the policies are created one by one only, not concurrently.
> 
>> But, can the policies be concurrently initialized? Or is the
>> initialization process serialized or the different domains?
> 
> There can be complex cases here. For example consider this.
> 
> Only the little CPUs are brought online at boot. Their policy is set and they
> are cleared from the cpus_to_visit mask. Now we try to bring any big CPU online
> and at the same time try changing min/max from sysfs for the LITTLE CPU policy.
> 
> The notifier may get called concurrently here I believe and cause the problem I
> mentioned earlier.
> 

I chatted with Juri and your proposed fix to do the unregister before
the free makes sense to us. Thanks for spotting this! I will change in
the next version.
