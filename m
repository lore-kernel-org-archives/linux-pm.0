From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during	suspend-resume
Date: Mon, 23 Feb 2009 12:04:33 +0100
Message-ID: <20090223110433.GA17312__21028.8405222402$1235387258$gmane$org@elte.hu>
References: <200902221837.49396.rjw@sisk.pl>
	<alpine.LFD.2.00.0902220946070.3111@localhost.localdomain>
	<200902222342.08285.rjw@sisk.pl> <200902230048.33635.rjw@sisk.pl>
	<m1ab8ddfbr.fsf@fess.ebiederm.org> <20090223084400.GB9582@elte.hu>
	<m17i3ha4nk.fsf@fess.ebiederm.org> <20090223094441.GM9582@elte.hu>
	<m1bpst77te.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <m1bpst77te.fsf@fess.ebiederm.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> > What makes s2ram fragile is not human failure but the 
> > combination of a handful of physical property:
> >
> > 1) Psychology: shutting the lid or pushing the suspend button is 
> >    a deceivingly 'simple' action to the user. But under the 
> >    hood, a ton of stuff happens: we deinitialize a lot of 
> >    things, we go through _all hardware state_, and we do so in a 
> >    serial fashion. If just one piece fails to do the right 
> >    thing, the box might not resume. Still, the user expects this 
> >    'simple' thing to just work, all the time. No excuses 
> >    accepted.
> >
> > 2) Length of code: To get a successful s2ram sequence the kernel
> >    runs through tens of thousands of lines of code. Code which
> >    never gets executed on a normal box - only if we s2ram. If 
> >    just one step fails, we get a hung box.
> >
> > 3) Debuggability: a lot of s2ram code runs with the console off, 
> >    making any bugs hard to debug. Furthermore we have no 
> >    meaningful persistent storage either for kernel bug messages. 
> >    The RTC trick of PM_DEBUG works but is a very narrow channel 
> >    of information and it takes a lot of time to debug a bug via 
> >    that method.
> 
> Yep that is an issue.

I'd also like to add #4:

     4) One more thing that makes s2ram special is that when the 
        resume path finds hardware often in an even more 
        deinitialized form than during normal bootup. During
        normal bootup the BIOS/firmware has at least done some
        minimal bootstrap (to get the kernel loaded), which
        makes life easier for the kernel.

        At s2ram stage we've got a completely pure hardware
        init state, with very minimal firmware activation. So 
        many of the init and deinit problems and bugs we only 
        hit in the s2ram path - which dynamics is again not 
        helpful.

> > The combination of these factors really makes up for a 
> > perfect storm in terms of kernel technology: we have this 
> > very-deceivingly-simple-looking but 
> > complex-and-rarely-executed piece of code, which is very 
> > hard to debug.
> 
> And much of this as you are finding with this piece of code is 
> how the software was designed rather then how the software 
> needed to be.

Well most of the 4 problems above are externalities and cannot 
go away just by fixing the kernel.

 #1 will always be with us.
 #3 needs the hardware to change. It's happening, but slowly.
 #4 will be with us as long as there's non-Linux BIOSes

#2 is the only thing where we can make a realistic difference,
but there's just so much we can do there.

And that still leaves the other three items: each of which is 
powerful enough of a force to give a bad name to any normal 
subsystem.

	Ingo
