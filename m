From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: schedutil: Rectify comment in sugov_irq_work() function
Date: Thu, 24 Nov 2016 22:05:04 +0100
Message-ID: <CAJZ5v0gF9Ss7mifa8m7jt79C6zM+O-eZWOp7oUXA4MYpDWrH7g@mail.gmail.com>
References: <94dc68617a6c8e42de4f225b1860d9d65d11b4aa.1479975620.git.viresh.kumar@linaro.org>
 <20161124084536.GA17988@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161124084536.GA17988@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 24, 2016 at 9:45 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
>> This patch rectifies a comment present in sugov_irq_work() function to
>> follow proper grammar.
>>
>> Suggested-by: Ingo Molnar <mingo@kernel.org>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  kernel/sched/cpufreq_schedutil.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> index 42a220e78f00..71e1a980d40a 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -315,15 +315,15 @@ static void sugov_irq_work(struct irq_work *irq_work)
>>       sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
>>
>>       /*
>> +      * For Real Time and Deadline tasks, the schedutil governor shoots the
>> +      * frequency to maximum. Special care must be taken to ensure that this
>> +      * kthread doesn't result in the same behavior.
>>        *
>>        * This is (mostly) guaranteed by the work_in_progress flag. The flag is
>> +      * updated only at the end of the sugov_work() function and before that
>> +      * the schedutil governor rejects all other frequency scaling requests.
>>        *
>> +      * There is a very rare case though, where the RT thread yields right
>>        * after the work_in_progress flag is cleared. The effects of that are
>>        * neglected for now.
>>        */
>
> Also:
>
>   s/Real Time task/RT task
>   s/Deadline task/deadline task
>
> With those:
>
>   Acked-by: Ingo Molnar <mingo@kernel.org>
>

Fixed up and applied.

Thanks,
Rafael
