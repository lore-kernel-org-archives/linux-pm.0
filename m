From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/suspend: fix false positive KASAN warning on
 suspend/resume
Date: Thu, 1 Dec 2016 11:34:38 -0600
Message-ID: <20161201173438.bfe5eq23i6ezfxsq@treble>
References: <20161129181300.GA29095@sbauer-Z170X-UD5>
 <20161130183507.syv3cdpp3hzxi77k@treble>
 <20161130190217.GA2756@sbauer-Z170X-UD5>
 <20161130231011.ofmbmevn3hqasetz@treble>
 <8f4c4a62-d912-0cd9-3462-8df20a868834@virtuozzo.com>
 <20161201145821.imkcgizo4thmiei2@treble>
 <20161201164551.52xlcftamleam6vq@treble>
 <CACT4Y+YXxcFAvBGsStZv8LC_30JvaC==UHznJre1z3UmsoqGsQ@mail.gmail.com>
 <20161201171306.swnvi4f2ezavloxd@treble>
 <CACT4Y+anS0XniR7ZxoEQ1nnAKPsGNvgc5L72uiSThOi3F742gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751301AbcLARel (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Dec 2016 12:34:41 -0500
Content-Disposition: inline
In-Reply-To: <CACT4Y+anS0XniR7ZxoEQ1nnAKPsGNvgc5L72uiSThOi3F742gA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Scott Bauer <scott.bauer@intel.com>, "x86@kernel.org" <x86@kernel.org>, Alexander Potapenko <glider@google.com>, kasan-dev <kasan-dev@googlegroups.com>

On Thu, Dec 01, 2016 at 06:27:31PM +0100, Dmitry Vyukov wrote:
> On Thu, Dec 1, 2016 at 6:13 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Thu, Dec 01, 2016 at 05:51:52PM +0100, Dmitry Vyukov wrote:
> >> On Thu, Dec 1, 2016 at 5:45 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >> > On Thu, Dec 01, 2016 at 08:58:21AM -0600, Josh Poimboeuf wrote:
> >> >> On Thu, Dec 01, 2016 at 12:05:34PM +0300, Andrey Ryabinin wrote:
> >> >> >
> >> >> >
> >> >> > On 12/01/2016 02:10 AM, Josh Poimboeuf wrote:
> >> >> > > Resuming from a suspend operation is showing a KASAN false positive
> >> >> > > warning:
> >> >> > >
> >> >> >
> >> >> > > KASAN instrumentation poisons the stack when entering a function and
> >> >> > > unpoisons it when exiting the function.  However, in the suspend path,
> >> >> > > some functions never return, so their stack never gets unpoisoned,
> >> >> > > resulting in stale KASAN shadow data which can cause false positive
> >> >> > > warnings like the one above.
> >> >> > >
> >> >> > > Reported-by: Scott Bauer <scott.bauer@intel.com>
> >> >> > > Tested-by: Scott Bauer <scott.bauer@intel.com>
> >> >> > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> >> >> > > ---
> >> >> > >  arch/x86/kernel/acpi/sleep.c | 3 +++
> >> >> > >  include/linux/kasan.h        | 7 +++++++
> >> >> > >  2 files changed, 10 insertions(+)
> >> >> > >
> >> >> > > diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> >> >> > > index 4858733..62bd046 100644
> >> >> > > --- a/arch/x86/kernel/acpi/sleep.c
> >> >> > > +++ b/arch/x86/kernel/acpi/sleep.c
> >> >> > > @@ -115,6 +115,9 @@ int x86_acpi_suspend_lowlevel(void)
> >> >> > >   pause_graph_tracing();
> >> >> > >   do_suspend_lowlevel();
> >> >> > >   unpause_graph_tracing();
> >> >> > > +
> >> >> > > + kasan_unpoison_stack_below_sp();
> >> >> > > +
> >> >> >
> >> >> > I think this might be too late. We may hit stale poison in the first C function called
> >> >> > after resume (restore_processor_state()). Thus the shadow must be unpoisoned prior such call,
> >> >> > i.e. somewhere in do_suspend_lowlevel() after .Lresume_point.
> >> >>
> >> >> Yeah, I think you're right.  Will spin a v2.
> >> >
> >> > So I tried calling kasan_unpoison_task_stack_below() from
> >> > do_suspend_lowlevel(), but it hung on the resume.  Presumably because
> >> > restore_processor_state() does some important setup which would be
> >> > needed before calling into kasan_unpoison_task_stack_below().  For
> >> > example, setting up the gs register.  So it's a bit of a catch-22.
> >> >
> >> > It could probably be fixed properly by rewriting do_suspend_lowlevel()
> >> > to call restore_processor_state() with the temporary stack before
> >> > switching to the original stack and doing the unpoison.
> >> >
> >> > (And there are some other issues with do_suspend_lowlevel() and I'd love
> >> > to try taking a scalpel to it.  But I have too many knives in the air
> >> > already to want to try to attempt that right now...)
> >> >
> >> > Unless somebody else wants to take a stab at it, my original patch is
> >> > probably good enough for now, since restore_processor_state() doesn't
> >> > seem to be triggering any KASAN warnings.
> >>
> >> restore_processor_state/__restore_processor_state does not seem to
> >> have any local variables, so KASAN does not do any stack checks there.
> >
> > Actually, looking at the object code, it uses a lot of stack space and
> > has several calls to __asan_report_load*() functions.  Probably due to
> > inlining of other functions which have stack variables.
> 
> That can be loads of heap variables (or other non-stack data). KASAN
> will emit these checks for lots of loads, but they don't necessary go
> to stack.

I also see the stack poisoning instructions:

 54f:   49 c1 ee 03             shr    $0x3,%r14
 553:   4c 01 f0                add    %r14,%rax
 556:   c7 00 f1 f1 f1 f1       movl   $0xf1f1f1f1,(%rax)
 55c:   c7 40 04 00 00 f4 f4    movl   $0xf4f40000,0x4(%rax)
 563:   c7 40 08 f3 f3 f3 f3    movl   $0xf3f3f3f3,0x8(%rax)

> >> We could disable KASAN instrumentation of the file, or of particular
> >> functions.
> >
> > I don't think that would be sufficient unless it were disabled for
> > __restore_processor_state() and all the functions it calls (and the
> > functions they call, etc), which wouldn't necessarily be
> > straightforward.
> >
> >> Or we could call kasan_unpoison_shadow() on the stack range
> >> before switching to it.
> >
> > I tried that already, but it hung because restore_processor_state()
> > hadn't been called yet (the catch-22 I mentioned aboved).
> 
> Ah, I see, we just can't execute normal C code at that point...

Right.

-- 
Josh
