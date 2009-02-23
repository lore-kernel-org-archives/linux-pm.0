From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Mon, 23 Feb 2009 12:03:07 +0100
Message-ID: <200902231203.09082.rjw__4962.2647617527$1235387187$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <20090223094441.GM9582@elte.hu>
	<m1bpst77te.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1bpst77te.fsf@fess.ebiederm.org>
Content-Disposition: inline
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 23 February 2009, Eric W. Biederman wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> 
> > * Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> >> Ingo Molnar <mingo@elte.hu> writes:
> >> 
> >> > I think this aspect has been well-understood during the 
> >> > discussion of this topic and it's just a slightly misleading 
> >> > changelog.
> >> 
> >> As I was a member of that discussion I did not see that.
> >> 
> >> It took me several passes through the patches to realize the 
> >> goal is to allow drivers to be able to sleep while they are in 
> >> their late pm shutdown routines.
> >> 
> >> Why we want this I don't know.  But it seems simple enough to 
> >> implement, and it makes it harder to get the late pm suspend 
> >> routines wrong, which is always good.
> >
> > That's not the only goal. The other goal is to further shrink a 
> > particular window of suspend fragility: the irqs-disabled stage 
> > of the suspend/resume sequence.
> >
> > Since suspend/resume is a mini-reboot sequence, there's a large 
> > amount of code executed - and the variety of code is large as 
> > well. We had repeat cases of random drivers re-enabling 
> > interrupts and thus breaking other drivers - and these are nasty 
> > to debug.
> >
> > So this patchset disables device IRQs centrally and serializes 
> > with pending work - so there's no races with pending IRQs 
> > anymore.
> >
> > The fact that we keep the timer irq running is two-fold: firstly 
> > the timer code is special and not really part of the regular 
> > suspend/resume sequence.
> >
> > Drivers want to take timestamps, sometimes they even want to do 
> > a small usleep(), etc. Ideally the suspend/resume code is pretty 
> > much _the same_ as a regular bootup (and shutdown) code - so we 
> > want to provide a similar environment to how drivers initialize 
> > and deinitialize, and we want to enable them to share code 
> > between bootup/shutdown and suspend/resume agressively.
> >
> > So the more generic kernel environment we give these fragile 
> > handlers, the better we are off in the end. Since we already had 
> > IRQS_TIMER, that was just the natural thing to do.
> 
> I am all for sharing code, especially if we can factor if
> we can find common factors that do the same thing.
> 
> I don't know how many times I have found drivers doing something
> weird in their shutdown routines that they don't know how
> to get the device out of.  The e1000 driver has shown up several
> times because it likes to suspend the device on shutdown.
> 
> The fact that the methods exposed to drivers were only defined
> to be usable on the s2ram/hibernate path is something I have
> brought up on more than one occasion as a bad choice.
> 
> I'm really not convinced that the rational for separating
> out the shutdown methods from the remove methods has
> been very good.  That of we don't need to clean up the in-kernel
> data structures on reboot so why do something extra that can
> introduce instability.
> 
> So having been watching a smaller form of this drama on the
> reboot path for several years.  Having had a device method
> with fixed semantics, and not the dwm sematics of the historical
> suspend routing.  I expect there is still a ways to go before
> it is simple and easy for drivers to figure out what they need
> to implement out of the confusing variety of possible device
> methods.
> 
> >> > The new suspend code does not rely on truly disabling IRQs 
> >> > on the low level. The purpose is to not get IRQs to drivers 
> >> > - which might crash/hang/race/misbehave.
> >> 
> >> Reasonable.  I expect one of the problems with drivers getting 
> >> it wrong is that the interface is too complex for mortal 
> >> humans to understand.
> >
> > The suspend/resume state machine certainly used to be a piece of 
> > code that makes a seasoned kernel developer weep in fear.
> >
> > That has changed drastically in the past few months. The 
> > suspend+hibernation logic got unified (at least as far as driver 
> > methods go), and all the flow and ordering has been cleaned up 
> > and has been made more robust.
> 
> I will have to look again.  My impression is that overloading
> a single method is part of what got us into this mess in the
> first place.
> 
> No that I don't see things getting better. 
> 
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
> 
> > The combination of these factors really makes up for a perfect 
> > storm in terms of kernel technology: we have this 
> > very-deceivingly-simple-looking but complex-and-rarely-executed 
> > piece of code, which is very hard to debug.
> 
> And much of this as you are finding with this piece of code
> is how the software was designed rather then how the software
> needed to be.
> 
> > Even just one of these factors would be enough to make an 
> > otherwise healthy subsystem fragile - no wonder s2ram has been a 
> > problem ever since it existed in the upstream kernel.
> >
> > So now we need just one thing: patience and more of the same 
> > good stuff that happened lately.
> 
> I think there has been some good progress, and so I am happy
> to be patient.  I will still mention on occasion what it
> seems we are doing wrong.  Unfortunately I don't have time
> to do a lot more than that.
> 
> >> > Still, it might make sense to not just use the ->disable 
> >> > sequence but primarily the ->shutdown irqchip method (when 
> >> > it's available in the irqchip).
> >> 
> >> Disable seems fine to me.  This is interesting in the context 
> >> of all of the irqs that will when masked show up somewhere 
> >> else (think boot interrupts).
> >> 
> >> > While we obviously cannot turn off the PIC that delivers 
> >> > timer IRQs at this stage - there's no theoretical reason why 
> >> > the suspend sequence couldnt power down some secondary PICs 
> >> > as well - in some arch code, or maybe even in the generic 
> >> > driver suspend sequence if the device tree is structured 
> >> > carefully enough so that the PIC gets turned off last.
> >> 
> >> If the point is simply to prevent deliver of irqs to the 
> >> drivers I don't see the point of anything more than what the 
> >> patch does now.
> >
> > ... except for the usecase i described above. Say some PIC sits 
> > on a piece of silicon which gets turned off. I'm not talking 
> > about x86 but some custom device. We really dont want that IRQ 
> > line to send half of an IRQ message (un-ACK-ed) when it gets 
> > turned off. So physically 'suspending' all IRQ lines does make a 
> > certain level of long-term sense.
> 
> Good point.  We will loose both level and edge triggered events
> that occur between suspending the irqs and restoring them but
> that is inevitable.  So we might as well call shutdown and totally
> turn off the irqs if we can.
> 
> I don't know where in the state machine this is getting called but
> I would suggest doing this before we shutdown cpus.

This is the plan.  In fact, I'm going to do this in the next patch after the
$subject one has been tested and found acceptable.

Thanks,
Rafael
