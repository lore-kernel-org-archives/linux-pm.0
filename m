From: Parth Shah <parth@linux.ibm.com>
Subject: Re: [RFCv2 2/6] sched: Introduce switch to enable TurboSched mode
Date: Thu, 16 May 2019 21:45:42 +0530
Message-ID: <fd7bd5e7-8d89-2c0b-1f3d-d229b7af5757@linux.ibm.com>
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-3-parth@linux.ibm.com>
 <20190515163032.GU2589@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515163032.GU2589@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org



On 5/15/19 10:00 PM, Peter Zijlstra wrote:
> On Wed, May 15, 2019 at 07:23:18PM +0530, Parth Shah wrote:
>> +void turbo_sched_get(void)
>> +{
>> +	spin_lock(&turbo_sched_lock);
>> +	if (!turbo_sched_count++)
>> +		static_branch_enable(&__turbo_sched_enabled);
>> +	spin_unlock(&turbo_sched_lock);
>> +}
> 
> Muwhahaha, you didn't test this code, did you?
> 

yeah, I didn't see task-sleep problem coming in.
I will change to mutex.

Thanks for pointing out.
