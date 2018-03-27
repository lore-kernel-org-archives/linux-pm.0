From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
Date: Tue, 27 Mar 2018 23:06:07 +0200
Message-ID: <CAJZ5v0j_Rp5tzs2hbhX+1rSBYU3JLxiV-DCN+8rOr=SkFgTKAw@mail.gmail.com>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan> <1521736343.6308.25.camel@surriel.com>
 <4731938.EeADOapqQb@aspire.rjw.lan> <1522173560.6308.66.camel@surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522173560.6308.66.camel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rik van Riel <riel@surriel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 27, 2018 at 7:59 PM, Rik van Riel <riel@surriel.com> wrote:
> On Thu, 2018-03-22 at 18:09 +0100, Rafael J. Wysocki wrote:
>
>> Does it improve if you do something like the below on top of it?
>
> First off, apologies for doing my testing wrong.
> There was an error, which was cleverly hidden by
> scripts, and things were not running the way they
> should.

No worries.

I'm glad that what you really see appears to match my understanding of
things. :-)

> After running the tests right, I have seen some
> results. My own test patch of disabling polling,
> and always dropping into at least C1, resulted in
> a CPU use increase of 0.4%.
>
> Your patch below, with a single cpu_relax(), and
> the local variable to not read the TSC too often,
> seems to give the best performance here, with a
> 0.2% reduction in CPU use.

Cool.

> Again, apologies for messing up the testing.
>
> I will kick off proper tests for that other patch
> series right now.

Thanks!

>> > Let me go test the nohz idle series by itself,
>> > without this patch.
>>
>> OK
>>
>> ---
>>  drivers/cpuidle/poll_state.c |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> Index: linux-pm/drivers/cpuidle/poll_state.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpuidle/poll_state.c
>> +++ linux-pm/drivers/cpuidle/poll_state.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/sched/idle.h>
>>
>>  #define POLL_IDLE_TIME_LIMIT (TICK_NSEC / 16)
>> +#define POLL_IDLE_COUNT              1000
>>
>>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>>                              struct cpuidle_driver *drv, int
>> index)
>> @@ -18,9 +19,14 @@ static int __cpuidle poll_idle(struct cp
>>
>>       local_irq_enable();
>>       if (!current_set_polling_and_test()) {
>> +             unsigned int loop_count = 0;
>> +
>>               while (!need_resched()) {
>>                       cpu_relax();
>> +                     if (loop_count++ < POLL_IDLE_COUNT)
>> +                             continue;
>>
>> +                     loop_count = 0;
>>                       if (local_clock() - time_start >
>> POLL_IDLE_TIME_LIMIT)
>>                               break;
>>               }
>>
>>
> --
> All Rights Reversed.
