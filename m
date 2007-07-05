From: Pavel Machek <pavel@ucw.cz>
Subject: removing refrigerator does not help with s2ram vs. fuse deadlocks
	(was Re: Re: [PATCH] Remove process freezer from
	suspend to RAM pathway)
Date: Thu, 5 Jul 2007 11:15:26 +0200
Message-ID: <20070705091526.GA3084__18541.2777275362$1183627246$gmane$org@elf.ucw.cz>
References: <18059.6726.218205.104212@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44L0.0707041104140.25704-100000@netrider.rowland.org>
	<18060.15591.556676.28935@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <18060.15591.556676.28935@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kernel development list <linux-kernel@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > The fact remains that lots of drivers would still need to be changed.  
> > In the read and write methods someone would have to add code amounting
> > to this:
> > 
> > 	if (suspend_is_under_way()) {
> > 		mutex_unlock(...);
> > 		block_until_resume();
> > 		goto restart;
> > 	}
> > 
> > Freezing userspace is a small amount of code by comparison.
> 
> Normally devices have some sort of queue of pending operations.  So
> all that is required on suspend is to stop processing the queue and
> wait for any currently-underway operations to complete.  The blocking
> then happens naturally using the normal I/O wait mechanisms.

So... instead of one big freezer (we know it is problematic), you have
100 small freezers, problematic in same way :-(.

Let's take current FUSE problems, and see if they have problem on PPC,
ok?

Let's say FUSE thread touches one of those "blocking" devices. It is
now in D state, somewhere in kernel.... exactly same way refrigerator
works.

Now, if kernel needs FUSE services for some reason (that's the problem
we hit in s2ram case, right?), we have a deadlock.

So main problem still seems to be "kernel should not depend on
userland services during suspend", refrigerator or not.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
