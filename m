From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH 1/7] time: tick-sched: Reorganize idle tick
 management code
Date: Mon, 5 Mar 2018 12:26:50 +0100
Message-ID: <CAJZ5v0hMgdvoZdBwyCXSf--Cy1-20qXDscNKGmfsyeVi8HVevw@mail.gmail.com>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan> <46071692.o1R0bjyNQV@aspire.rjw.lan>
 <20180305104446.GN25201@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305104446.GN25201@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 5, 2018 at 11:44 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sun, Mar 04, 2018 at 11:24:00PM +0100, Rafael J. Wysocki wrote:
>> +/**
>> + * tick_nohz_idle_prepare - prepare for entering idle on the current CPU.
>> + *
>> + * Called when we start the idle loop.
>> + */
>> +void tick_nohz_idle_prepare(void)
>> +{
>> +     __tick_nohz_idle_prepare();
>> +
>> +     local_irq_enable();
>> +}
>
> I really dislike the asymmetry in IRQ state you introduced here.
> __tick_nohz_idle_prepare() disables IRQs. Must we do that?

Not really, but at the cost of a tiny bit of duplicated code.
