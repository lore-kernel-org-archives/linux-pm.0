From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][PATCH v5 6/7] cpuidle: menu: Refine idle state selection
 for running tick
Date: Mon, 19 Mar 2018 10:49:08 +0100
Message-ID: <CAJZ5v0jz63BwRR6Hybz1rwXs1HS2WdzqSRDW_bOkd5_3DotLdg@mail.gmail.com>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <4980385.RayypyZ8dA@aspire.rjw.lan>
 <20180319094549.GG4043@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319094549.GG4043@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 19, 2018 at 10:45 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Mar 15, 2018 at 11:16:41PM +0100, Rafael J. Wysocki wrote:
>
>> --- linux-pm.orig/kernel/time/tick-sched.c
>> +++ linux-pm/kernel/time/tick-sched.c
>> @@ -1031,10 +1031,11 @@ void tick_nohz_irq_exit(void)
>>
>>  /**
>>   * tick_nohz_get_sleep_length - return the expected length of the current sleep
>> + * @cur_ret: pointer for returning the current time to the next event
>
> Both name and description are confusing, what it actually appears to
> return is the duration until the next event. Which would suggest a name
> like: delta_next or something along those lines.
>
> But 'cur' short for current, is very misleading.

OK, I'll change that.

Thanks!
