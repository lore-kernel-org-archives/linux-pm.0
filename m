From: Parth Shah <parth@linux.ibm.com>
Subject: Re: [RFCv2 6/6] sched/fair: Bound non idle core search by DIE domain
Date: Thu, 16 May 2019 21:56:08 +0530
Message-ID: <6c7956f0-3ef0-ac6d-d950-b0ed8358b0db@linux.ibm.com>
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-7-parth@linux.ibm.com>
 <20190515164414.GY2589@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515164414.GY2589@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org



On 5/15/19 10:14 PM, Peter Zijlstra wrote:
> On Wed, May 15, 2019 at 07:23:22PM +0530, Parth Shah wrote:
>> This patch specifies the sched domain to search for a non idle core.
>>
>> The select_non_idle_core searches for the non idle cores across whole
>> system. But in the systems with multiple NUMA domains, the Turbo frequency
>> can be sustained within the NUMA domain without being affected from other
>> NUMA.
>>
>> This patch provides an architecture specific implementation for defining
>> the turbo domain to make searching of the core to be bound within the NUMA.
> 
> NAK, this is insane. You don't need arch hooks to find the numa domain.
> 

The aim here is to limit searching for non-idle cores inside a NUMA node
(or DIE sched-domain), because some systems can sustain Turbo frequency by task
packing inside of a NUMA node. Hence turbo domain for them should be DIE.

Since not all systems have DIE domain, adding arch hooks can allow each arch to
override their turbo domain within which to allow task packing.

Thanks
