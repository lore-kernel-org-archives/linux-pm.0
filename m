From: Uli Luckas <u.luckas@road.de>
Subject: Re: non-racy examples,
	please (was Re: [PATCH 01/13] PM: Add wake lock?api.)
Date: Tue, 10 Feb 2009 13:35:11 +0100
Message-ID: <200902101335.12278.u.luckas@road.de>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902090249.59119.u.luckas@road.de>
	<20090210111749.GC4636@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090210111749.GC4636@atrey.karlin.mff.cuni.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Tuesday, 10. February 2009, Pavel Machek wrote:
> > On Sunday 08 February 2009, Pavel Machek wrote:
> > > Hi!
> > >
> > > Ok, I think that this wakelock stuff is in "can't be used properly"
> > > area on Rusty's scale of nasty interfaces.
> > >
> > > So... do I understand this correctly that if I want to run "make
> > > zImage" on Android, I'll need to modify make, gcc, .... to keep system
> > > awake?
> > >
> > > 	(How to do that? Give all the userland processes access to
> > > 	/sys/wakelocks ?)
> > >
> > > BTW what does android do when battery goes critically low? I believe
> > > you want to suspend, ignoring wakelocks, at that point.
> > >
> > > And now, you have some X-like system.
> > >
> > > 	/* We were idle for too long */
> > > 	blank_screen();
> > >
> > > 	unlock_all_wakelocks();		/* We want machine to sleep */
> > >
> > > 	wait_for_key();
> > > 	/* (here) */
> > > 	lock_wakelocks("processing_key_wakelock");
> > >
> > > ...is that approximately correct? There's race there, right? If (here)
> > > processing takes too long, or whatever, kernel will sleep the machine
> > > before it even displays "do you want to unlock the screen" dialog,
> > > right?
> > >
> > > Can you solve that in a way that works, always?
> > > 									Pavel
> >
> > Pavel, actually Arve's whole wakelock concept is about avoiding races.
> > Please go back to where he explains the keyboard example.
> > The idea is that the keyboard driver grabs a wake lock in it's interrupt
> > and releases the lock only, after the resulting key events are read from
> > the device's queue.
> > This way, userspace can safely select on the key events, then grab it's
> > own lock. At that time, the two locks overlap! After that, userspace
> > reads the key events. This causes the keyboard driver to relaease it's
> > wake lock. Userspace still holds it's wake lock thogh.
> > You see? The locks together with the key events have been passed to
> > userspace safey. Absolutely race free.
> >
> > So your example becomes:
> > 	/* We were idle for too long */
> >  	blank_screen();
> > 	unlock_my_wakelocks();   /* We want machine to sleep if no one
> >                                                        else holds a
> > wakelock*/ wait_for_key();                 /* Select on key events */
> > 	/* (here) */
> > 	lock_wakelocks("processing_key_wakelock");
> >  	read_key_events();
> >
> > We should take a look at those cases, though, where a timed wacke locks
> > are needed. That is definitely unsafe.
>
> Well, I failed to see the "as long as there's event waiting on
> select(), it can not sleep". I still wonder how it works down the
> chain...
>
> you expect all applications to use select?
>
> [like... vi?]
>
> Plus I don't like that any application select-ing on input device can
> prevent system from sleeping. That's quite a unexpected sideeffect.
>
It's not about selecting on the input device. The select semantics are not 
changed. It's about not processing input events.
Right, if you open /dev/input/event0 and then don't read it, you can prevent 
the system from suspend. Your application said it wants to process input 
events and so the input driver keeps the system awake until all events are 
passed on.
On my system all event devices belong to root. So this behavior should be 
safe.

regards,
Uli

-- 

------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Head of Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 62 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing director: Hans-Peter Constien
