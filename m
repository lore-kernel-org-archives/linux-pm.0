From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/suspend: fix false positive KASAN warning on
 suspend/resume
Date: Thu, 1 Dec 2016 10:45:51 -0600
Message-ID: <20161201164551.52xlcftamleam6vq@treble>
References: <20161129181300.GA29095@sbauer-Z170X-UD5>
 <20161130183507.syv3cdpp3hzxi77k@treble>
 <20161130190217.GA2756@sbauer-Z170X-UD5>
 <20161130231011.ofmbmevn3hqasetz@treble>
 <8f4c4a62-d912-0cd9-3462-8df20a868834@virtuozzo.com>
 <20161201145821.imkcgizo4thmiei2@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161201145821.imkcgizo4thmiei2@treble>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org, luto@amacapital.net, Scott Bauer <scott.bauer@intel.com>, x86@kernel.org, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 01, 2016 at 08:58:21AM -0600, Josh Poimboeuf wrote:
> On Thu, Dec 01, 2016 at 12:05:34PM +0300, Andrey Ryabinin wrote:
> > 
> > 
> > On 12/01/2016 02:10 AM, Josh Poimboeuf wrote:
> > > Resuming from a suspend operation is showing a KASAN false positive
> > > warning:
> > > 
> > 
> > > KASAN instrumentation poisons the stack when entering a function and
> > > unpoisons it when exiting the function.  However, in the suspend path,
> > > some functions never return, so their stack never gets unpoisoned,
> > > resulting in stale KASAN shadow data which can cause false positive
> > > warnings like the one above.
> > > 
> > > Reported-by: Scott Bauer <scott.bauer@intel.com>
> > > Tested-by: Scott Bauer <scott.bauer@intel.com>
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > ---
> > >  arch/x86/kernel/acpi/sleep.c | 3 +++
> > >  include/linux/kasan.h        | 7 +++++++
> > >  2 files changed, 10 insertions(+)
> > > 
> > > diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> > > index 4858733..62bd046 100644
> > > --- a/arch/x86/kernel/acpi/sleep.c
> > > +++ b/arch/x86/kernel/acpi/sleep.c
> > > @@ -115,6 +115,9 @@ int x86_acpi_suspend_lowlevel(void)
> > >  	pause_graph_tracing();
> > >  	do_suspend_lowlevel();
> > >  	unpause_graph_tracing();
> > > +
> > > +	kasan_unpoison_stack_below_sp();
> > > +
> > 
> > I think this might be too late. We may hit stale poison in the first C function called
> > after resume (restore_processor_state()). Thus the shadow must be unpoisoned prior such call,
> > i.e. somewhere in do_suspend_lowlevel() after .Lresume_point.
> 
> Yeah, I think you're right.  Will spin a v2.

So I tried calling kasan_unpoison_task_stack_below() from
do_suspend_lowlevel(), but it hung on the resume.  Presumably because
restore_processor_state() does some important setup which would be
needed before calling into kasan_unpoison_task_stack_below().  For
example, setting up the gs register.  So it's a bit of a catch-22.

It could probably be fixed properly by rewriting do_suspend_lowlevel()
to call restore_processor_state() with the temporary stack before
switching to the original stack and doing the unpoison.

(And there are some other issues with do_suspend_lowlevel() and I'd love
to try taking a scalpel to it.  But I have too many knives in the air
already to want to try to attempt that right now...)

Unless somebody else wants to take a stab at it, my original patch is
probably good enough for now, since restore_processor_state() doesn't
seem to be triggering any KASAN warnings.

-- 
Josh
