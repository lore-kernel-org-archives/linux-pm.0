From: Pavel Machek <pavel@ucw.cz>
Subject: Re: non-racy examples,
	please (was Re: [PATCH 01/13] PM: Add wake lock?api.)
Date: Tue, 10 Feb 2009 12:17:49 +0100
Message-ID: <20090210111749.GC4636@atrey.karlin.mff.cuni.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<d6200be20902051628x50827a27i52c4b69cc64585f7@mail.gmail.com>
	<20090208221747.GM6369@elf.ucw.cz>
	<200902090249.59119.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902090249.59119.u.luckas@road.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Uli Luckas <u.luckas@road.de>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

> On Sunday 08 February 2009, Pavel Machek wrote:
> > Hi!
> >
> > Ok, I think that this wakelock stuff is in "can't be used properly"
> > area on Rusty's scale of nasty interfaces.
> >
> > So... do I understand this correctly that if I want to run "make zImage"
> > on Android, I'll need to modify make, gcc, .... to keep system awake?
> >
> > 	(How to do that? Give all the userland processes access to
> > 	/sys/wakelocks ?)
> >
> > BTW what does android do when battery goes critically low? I believe
> > you want to suspend, ignoring wakelocks, at that point.
> >
> > And now, you have some X-like system.
> >
> > 	/* We were idle for too long */
> > 	blank_screen();
> >
> > 	unlock_all_wakelocks();		/* We want machine to sleep */
> >
> > 	wait_for_key();
> > 	/* (here) */
> > 	lock_wakelocks("processing_key_wakelock");
> >
> > ...is that approximately correct? There's race there, right? If (here)
> > processing takes too long, or whatever, kernel will sleep the machine
> > before it even displays "do you want to unlock the screen" dialog,
> > right?
> >
> > Can you solve that in a way that works, always?
> > 									Pavel
> 
> Pavel, actually Arve's whole wakelock concept is about avoiding races. Please 
> go back to where he explains the keyboard example.
> The idea is that the keyboard driver grabs a wake lock in it's interrupt and 
> releases the lock only, after the resulting key events are read from the 
> device's queue. 
> This way, userspace can safely select on the key events, then grab it's own 
> lock. At that time, the two locks overlap! After that, userspace reads the 
> key events. This causes the keyboard driver to relaease it's wake lock. 
> Userspace still holds it's wake lock thogh.
> You see? The locks together with the key events have been passed to userspace 
> safey. Absolutely race free. 
> 
> So your example becomes:
> 	/* We were idle for too long */
>  	blank_screen();
> 	unlock_my_wakelocks();   /* We want machine to sleep if no one
>                                                        else holds a wakelock*/
> 	wait_for_key();                 /* Select on key events */
> 	/* (here) */
> 	lock_wakelocks("processing_key_wakelock");
>  	read_key_events();
> 
> We should take a look at those cases, though, where a timed wacke locks are 
> needed. That is definitely unsafe.

Well, I failed to see the "as long as there's event waiting on
select(), it can not sleep". I still wonder how it works down the
chain...

you expect all applications to use select?

[like... vi?]

Plus I don't like that any application select-ing on input device can
prevent system from sleeping. That's quite a unexpected sideeffect.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
