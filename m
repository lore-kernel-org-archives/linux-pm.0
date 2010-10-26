From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 13:48:48 +0200
Message-ID: <201010261348.49240.trenn__25728.1038830572$1288093866$gmane$org@suse.de>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<AANLkTiknZ5t24j44hhDrbocJSJv1d=9LtvcSrd2QPcq2@mail.gmail.com>
	<20101026112129.GB27258@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101026112129.GB27258@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-trace-users@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tuesday 26 October 2010 13:21:29 Ingo Molnar wrote:
> 
> * Jean Pihet <jean.pihet@newoldbits.com> wrote:
..
> > >> +#ifndef _TRACE_POWER_ENUM_
> > >> +#define _TRACE_POWER_ENUM_
> > >> +enum {
> > >> +     POWER_NONE = 0,
> > >> +     POWER_CSTATE = 1,
> > >> +     POWER_PSTATE = 2,
> > >> +};
> > >> +#endif
> > >
> > > Since we are cleaning up all these events, those enum definitions dont really look
> > > logical. For example, what is 'POWER_NONE'? Can a CPU have 'no power'?
> >
> > The enum belongs to the deprecated API so I would rather not touch it.
> > Keeping the deprecated code isolated will make it easier to remove
> > later.
> 
> So what will replace it? We still have a state field.
Nothing, this is part of the cleanup.
As you state above: POWER_NONE does not make sense at all.
The whole thing (type= attribute that vanishes now) is
passed to userspace, but never gets used there because the
same info is in the event name:
cpu_frequency <-> frequency_switch      <-> PSTATE
cpu_idle      <-> power_start/power_end <-> CSTATE 

I expect that there was an initial power_start/end which
was also used for frequency switching.
Then it got realized that _start/_end does not work out and
frequency_switch got introduced.
To stay compatible the whole power_start/end was not renamed
to cpu_idle and the type= field was kept.

This is a guess without even looking at the git history.
Therefore my partly harsh comments about the sanity of the
current power tracing events.

> Passing in platform specific codes is a step backwards.
> 
> > >> +TRACE_EVENT(machine_suspend,
> > >> +
> > >> +     TP_PROTO(unsigned int state),
> > >> +
> > >> +     TP_ARGS(state),
> > >> +
> > >> +     TP_STRUCT__entry(
> > >> +             __field(        u32,            state           )
> > >> +     ),
> > >
> > > Hm, this event is not used anywhere in the submitted patches. Where is the patch
> > > that adds usage, and what are the possible values for 'state'?
> >
> > This will come as a separate patch, which fits all platforms. Cf.
> > http://marc.info/?l=linux-omap&m=128620575300682&w=2.
> > The state field is of type suspend_state_t, cf. include/linux/suspend.h
> 
> Ok, that's at least generic. Needs the review of Rafael, to determine
> whether this state value is all we want to know when we enter suspend.
He already gave an acked-by on this generic one here:
Re: [PATCH 3/4] perf: add calls to suspend trace point
Oh now, that was on the X86 specific part which depends on this one.
One should expect that he's fine with the generic part as well then,
but I agree that he should definitely have a look at this and sign it off.

So as they got signed-off already, I'll send the X86 suspend events
on top, once I find these in a tree...

    Thomas
