From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH v2 1/6] sched/fair: Create util_fits_capacity()
Date: Thu, 12 Apr 2018 10:20:05 +0200
Message-ID: <0184b049-9333-2b6b-09a0-bdb71f491e25@arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-2-dietmar.eggemann@arm.com>
 <20180412070230.GV7671@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180412070230.GV7671@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 04/12/2018 09:02 AM, Viresh Kumar wrote:
> On 06-04-18, 16:36, Dietmar Eggemann wrote:
>> The functionality that a given utilization fits into a given capacity
>> is factored out into a separate function.
>>
>> Currently it is only used in wake_cap() but will be re-used to figure
>> out if a cpu or a scheduler group is over-utilized.
>>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> ---
>>   kernel/sched/fair.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 0951d1c58d2f..0a76ad2ef022 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6574,6 +6574,11 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
>>   	return min_t(unsigned long, util, capacity_orig_of(cpu));
>>   }
>>   
>> +static inline int util_fits_capacity(unsigned long util, unsigned long capacity)
>> +{
>> +	return capacity * 1024 > util * capacity_margin;
> 
> This changes the behavior slightly compared to existing code. If that
> wasn't intentional, perhaps you should use >= here.

You're right here ... Already on our v3 list. Thanks!

The 'misfit' patch-set comes with a similar function 
task_fits_capacity() so we have to align on this one with this patch-set 
as well.

[...]
