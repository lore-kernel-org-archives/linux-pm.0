From: Joe Perches <joe@perches.com>
Subject: Re: Subject: [PATCH] [PATCH] time: tick-sched: use bool for
 tick_stopped
Date: Tue, 10 Apr 2018 08:14:54 -0700
Message-ID: <bece0d90535709ef39006adb5f481993d6063929.camel@perches.com>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
         <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
         <20180410123305.GF4082@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180410123305.GF4082@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: yuankuiz@codeaurora.org, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, aulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, apw@canonical.com
List-Id: linux-pm@vger.kernel.org

On Tue, 2018-04-10 at 14:33 +0200, Peter Zijlstra wrote:
> On Tue, Apr 10, 2018 at 10:00:01AM +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 10, 2018 at 9:33 AM,  <yuankuiz@codeaurora.org> wrote:
> > > +++ b/kernel/time/tick-sched.h
> > > @@ -48,8 +48,8 @@ struct tick_sched {
> > >         unsigned long                   check_clocks;
> > >         enum tick_nohz_mode             nohz_mode;
> > > 
> > > +       bool                            tick_stopped    : 1;
> > >         unsigned int                    inidle          : 1;
> > > -       unsigned int                    tick_stopped    : 1;
> > >         unsigned int                    idle_active     : 1;
> > >         unsigned int                    do_timer_last   : 1;
> > >         unsigned int                    got_idle_tick   : 1;
> > 
> > I don't think this is a good idea at all.
> > 
> > Please see https://lkml.org/lkml/2017/11/21/384 for example.
> 
> Joe, apw, could we get Checkpatch to whinge about _Bool in composite
> types? That should immediately also disqualify using it as the base type
> of bitfields.

Whinging about bool <foo> : <x> seems entirely sensible
and straightforward to do.

I'm not so sure about bool in structs as a patch context
could be adding a bool to local stack definitions and
there's no real ability to determine if the bool is in a
struct or on the stack.

Also, I think there's nothing really wrong with using
bool in structs.  Steven Rostedt's rationale in
https://lkml.org/lkml/2017/11/21/207 isn't really right
as sizeof(int) is 4 not 1 and sizeof(bool) is 1 on arches
without alignment issues.  I believe when using gcc,
sizeof(bool) is always 1 and there may be alignment padding
added on some arches.  Dunno.

But I think the battle is already lost anyway.

git grep -P  '(?<!static|extern)\s+bool\s+\w+\s*;' include | wc -l
1543
