From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/3] powernv/cpuidle: Fastsleep workaround and fixes
Date: Thu, 02 Oct 2014 22:10:47 +0530
Message-ID: <542D800F.60200@linux.vnet.ibm.com>
References: <1412149560-2953-1-git-send-email-shreyas@linux.vnet.ibm.com> <2978842.I7Hdqv7lNe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:39267 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbaJBQk4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 12:40:56 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shreyas@linux.vnet.ibm.com>;
	Fri, 3 Oct 2014 02:40:54 +1000
In-Reply-To: <2978842.I7Hdqv7lNe@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Srivatsa S. Bhat" <srivatsa@mit.edu>, "Preeti U. Murthy" <preeti@linux.vnet.ibm.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>



On Thursday 02 October 2014 02:16 AM, Rafael J. Wysocki wrote:
> On Wednesday, October 01, 2014 01:15:57 PM Shreyas B. Prabhu wrote:
>> Fast sleep is an idle state, where the core and the L1 and L2
>> caches are brought down to a threshold voltage. This also means that
>> the communication between L2 and L3 caches have to be fenced. However
>> the current P8 chips have a bug wherein this fencing between L2 and
>> L3 caches get delayed by a cpu cycle. This can delay L3 response to
>> the other cpus if they request for data during this time. Thus they
>> would fetch the same data from the memory which could lead to data
>> corruption if L3 cache is not flushed. 
>>
>> This series overcomes above problem in kernel.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: Srivatsa S. Bhat <srivatsa@mit.edu>
>> Cc: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
>> Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
>>
>> v2:
>> Rebased on 3.17-rc7
>> Split from 'powerpc/powernv: Support for fastsleep and winkle'
>>
>> v1:
>> https://lkml.org/lkml/2014/8/25/446
>>
>> Preeti U Murthy (1):
>>   powerpc/powernv/cpuidle: Add workaround to enable fastsleep
>>
>> Shreyas B. Prabhu (1):
>>   powerpc/kvm/book3s_hv: Enable CPUs to run guest after waking up from
>>     fast-sleep
>>
>> Srivatsa S. Bhat (1):
>>   powerpc/powernv: Enable Offline CPUs to enter deep idle states
>>
>>  arch/powerpc/include/asm/machdep.h             |   3 +
>>  arch/powerpc/include/asm/opal.h                |   7 ++
>>  arch/powerpc/include/asm/processor.h           |   4 +-
>>  arch/powerpc/kernel/exceptions-64s.S           |  35 ++++----
>>  arch/powerpc/kernel/idle.c                     |  19 ++++
>>  arch/powerpc/kernel/idle_power7.S              |   2 +-
>>  arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
>>  arch/powerpc/platforms/powernv/powernv.h       |   7 ++
>>  arch/powerpc/platforms/powernv/setup.c         | 118 +++++++++++++++++++++++++
>>  arch/powerpc/platforms/powernv/smp.c           |  11 ++-
>>  drivers/cpuidle/cpuidle-powernv.c              |  13 ++-
>>  11 files changed, 194 insertions(+), 26 deletions(-)
> 
> [2/3] seems to be missig from the series.
> 
> Also, since that mostly modifies arch/powerpc, I think it should go through
> that tree.  I'm fine with the cpuidle-powernv changes in [1/3] and [3/3].
> 
Hi Rafael, 

Thanks for looking into this. The second patch is an independent fix in the 
powerpc exception handler. To be safe I am ccing you and linux-pm list on that
patch now. 


Thanks, 
Shreyas

