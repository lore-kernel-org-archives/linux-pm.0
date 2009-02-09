From: Uli Luckas <u.luckas@road.de>
Subject: Re:
	=?iso-8859-1?q?non-racy_examples=2C_please_=28was_Re?=
	=?iso-8859-1?q?=3A_=5BPATCH_01/13=5D_PM=3A_Add_wake_lock=09api=2E_?=
	=?iso-8859-1?q?=29?=
Date: Mon, 9 Feb 2009 02:49:58 +0100
Message-ID: <200902090249.59119.u.luckas@road.de>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<d6200be20902051628x50827a27i52c4b69cc64585f7@mail.gmail.com>
	<20090208221747.GM6369@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090208221747.GM6369@elf.ucw.cz>
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
To: linux-pm@lists.linux-foundation.org
Cc: swetland@google.com, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Sunday 08 February 2009, Pavel Machek wrote:
> Hi!
>
> Ok, I think that this wakelock stuff is in "can't be used properly"
> area on Rusty's scale of nasty interfaces.
>
> So... do I understand this correctly that if I want to run "make zImage"
> on Android, I'll need to modify make, gcc, .... to keep system awake?
>
> 	(How to do that? Give all the userland processes access to
> 	/sys/wakelocks ?)
>
> BTW what does android do when battery goes critically low? I believe
> you want to suspend, ignoring wakelocks, at that point.
>
> And now, you have some X-like system.
>
> 	/* We were idle for too long */
> 	blank_screen();
>
> 	unlock_all_wakelocks();		/* We want machine to sleep */
>
> 	wait_for_key();
> 	/* (here) */
> 	lock_wakelocks("processing_key_wakelock");
>
> ...is that approximately correct? There's race there, right? If (here)
> processing takes too long, or whatever, kernel will sleep the machine
> before it even displays "do you want to unlock the screen" dialog,
> right?
>
> Can you solve that in a way that works, always?
> 									Pavel

Pavel, actually Arve's whole wakelock concept is about avoiding races. Please 
go back to where he explains the keyboard example.
The idea is that the keyboard driver grabs a wake lock in it's interrupt and 
releases the lock only, after the resulting key events are read from the 
device's queue. 
This way, userspace can safely select on the key events, then grab it's own 
lock. At that time, the two locks overlap! After that, userspace reads the 
key events. This causes the keyboard driver to relaease it's wake lock. 
Userspace still holds it's wake lock thogh.
You see? The locks together with the key events have been passed to userspace 
safey. Absolutely race free. 

So your example becomes:
	/* We were idle for too long */
 	blank_screen();
	unlock_my_wakelocks();   /* We want machine to sleep if no one
                                                       else holds a wakelock*/
	wait_for_key();                 /* Select on key events */
	/* (here) */
	lock_wakelocks("processing_key_wakelock");
 	read_key_events();

We should take a look at those cases, though, where a timed wacke locks are 
needed. That is definitely unsafe.

Uli
