From: Pavel Machek <pavel@ucw.cz>
Subject: non-racy examples,
	please (was Re: [PATCH 01/13] PM: Add wake lock	api.)
Date: Sun, 8 Feb 2009 23:17:47 +0100
Message-ID: <20090208221747.GM6369@elf.ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<20090205091132.GG2077@elf.ucw.cz>
	<d6200be20902051628x50827a27i52c4b69cc64585f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902051628x50827a27i52c4b69cc64585f7@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

Ok, I think that this wakelock stuff is in "can't be used properly"
area on Rusty's scale of nasty interfaces.

So... do I understand this correctly that if I want to run "make zImage"
on Android, I'll need to modify make, gcc, .... to keep system awake?

	(How to do that? Give all the userland processes access to
	/sys/wakelocks ?)

BTW what does android do when battery goes critically low? I believe
you want to suspend, ignoring wakelocks, at that point.

And now, you have some X-like system.

	/* We were idle for too long */
	blank_screen();

	unlock_all_wakelocks();		/* We want machine to sleep */

	wait_for_key();
	/* (here) */
	lock_wakelocks("processing_key_wakelock");

...is that approximately correct? There's race there, right? If (here)
processing takes too long, or whatever, kernel will sleep the machine
before it even displays "do you want to unlock the screen" dialog,
right?

Can you solve that in a way that works, always?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
