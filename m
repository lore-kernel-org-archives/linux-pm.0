From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Hibernation: Document
	__save_processor_state() on x86-64
Date: Sun, 30 Dec 2007 20:17:34 +0000
Message-ID: <20071230201734.GA5535__44255.8732619092$1199042512$gmane$org@ucw.cz>
References: <200712281353.37976.rjw@sisk.pl> <20071229234326.GA17807@ucw.cz>
	<200712301430.08274.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200712301430.08274.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun 2007-12-30 14:30:07, Rafael J. Wysocki wrote:
> On Sunday, 30 of December 2007, Pavel Machek wrote:
> > Hi!
> > 
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > Document the fact that __save_processor_state() has to save all CPU
> > > registers referred to by the kernel in case a different kernel is
> > > used to load and restore a hibernation image containing it. 
> > 
> > 
> > > Sigend-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > >  arch/x86/kernel/suspend_64.c |   20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > > 
> > > Index: linux-2.6/arch/x86/kernel/suspend_64.c
> > > ===================================================================
> > > --- linux-2.6.orig/arch/x86/kernel/suspend_64.c
> > > +++ linux-2.6/arch/x86/kernel/suspend_64.c
> > > @@ -19,6 +19,21 @@ extern const void __nosave_begin, __nosa
> > >  
> > >  struct saved_context saved_context;
> > >  
> > > +/**
> > > + *	__save_processor_state - save CPU registers before creating a
> > > + *		hibernation image and before restoring the memory state from it
> > > + *	@ctxt - structure to store the registers contents in
> > > + *
> > > + *	NOTE: If there is a CPU register the modification of which by the
> > > + *	boot kernel (ie. the kernel used for loading the hibernation image)
> > > + *	might affect the operations of the restored target kernel (ie. the one
> > > + *	saved in the hibernation image), then its contents must be saved by this
> > > + *	function.  In other words, if kernel A is hibernated and different
> > > + *	kernel B is used for loading the hibernation image into memory, the
> > > + *	kernel A's __save_processor_state() function must save all registers
> > > + *	needed by kernel A, so that it can operate correctly after the resume
> > > + *	regardless of what kernel B does in the meantime.
> > > + */
> > 
> > Maybe this warning should be appended to struct saved_context
> > definition? Reordering its fields (etc) would be bad news, too,
> 
> Hmm, I think they can be reordered without any problem.  It's always the same
> kernel using them, although at different times.

Aha... ok, then. I misunderstood how it works.

> > and documentation near data structures is easier to find...
> 
> Well, I'll add a coment next to the definition of struct saved_context to
> explain what it's for, but IMO the behavior of __save_processor_state() is what
> _really_ matters (ie. it doesn't matter how and where exactly it saves the
> registers as long as __restore_processor_state() can restore their "old"
> values).

Yep, right.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
