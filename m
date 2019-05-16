From: Parth Shah <parth@linux.ibm.com>
Subject: Re: [RFCv2 0/6] TurboSched: A scheduler for sustaining Turbo
 Frequencies for longer durations
Date: Thu, 16 May 2019 21:35:30 +0530
Message-ID: <82883320-fb98-ec7b-ad1a-0c4248a0225b@linux.ibm.com>
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515164854.GZ2589@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515164854.GZ2589@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org



On 5/15/19 10:18 PM, Peter Zijlstra wrote:
> On Wed, May 15, 2019 at 07:23:16PM +0530, Parth Shah wrote:
>> Abstract
>> ========
>>
>> The modern servers allows multiple cores to run at range of
>> frequencies higher than rated range of frequencies. But the power budget
>> of the system inhibits sustaining these higher frequencies for
>> longer durations.
>>
>> However when certain cores are put to idle states, the power can be
>> effectively channelled to other busy cores, allowing them to sustain
>> the higher frequency.
>>
>> One way to achieve this is to pack tasks onto fewer cores keeping others idle,
>> but it may lead to performance penalty for such tasks and sustaining higher
>> frequencies proves to be of no benefit. But if one can identify unimportant low
>> utilization tasks which can be packed on the already active cores then waking up
>> of new cores can be avoided. Such tasks are short and/or bursty "jitter tasks"
>> and waking up new core is expensive for such case.
>>
>> Current CFS algorithm in kernel scheduler is performance oriented and hence
>> tries to assign any idle CPU first for the waking up of new tasks. This policy
>> is perfect for major categories of the workload, but for jitter tasks, one
>> can save energy by packing it onto active cores and allow other cores to run at
>> higher frequencies.
>>
>> These patch-set tunes the task wake up logic in scheduler to pack exclusively
>> classified jitter tasks onto busy cores. The work involves the use of additional
>> attributes inside "cpu" cgroup controller to manually classify tasks as jitter. 
> 
> Why does this make sense? Don't these higher freq bins burn power like
> stupid? That is, it makes sense to use turbo-bins for single threaded
> workloads that are CPU-bound and need performance.
> 
> But why pack a bunch of 'crap' tasks onto a core and give it turbo;
> that's just burning power without getting anything back for it.
> 

Thanks for taking interest in my patch series.
I will try my best to answer your question.

This patch series tries to pack jitter tasks on the busier cores to avoid waking
up any idle core as long as possible. This approach is supposed to give more
performance to the CPU bound tasks by sustaining Turbo for a longer duration.

Current implementation for task wake up is biased towards waking an idle CPU first,
which in turn consumes power as the CPU leaves idle domain.
For the system supporting Turbo frequencies, power budget is fixed and hence to
maintain this budget the system may throttle the frequency.

So the idea is, if we can pack the jitter tasks on already running cores, then we
can avoid waking up new cores and save power thereby sustaining Turbo for longer
duration.
