From: Pavel Machek <pavel@ucw.cz>
Subject: Re: non-racy examples,
	please (was Re: [PATCH 01/13] PM: Add wake	lock api.)
Date: Mon, 9 Feb 2009 00:14:13 +0100
Message-ID: <20090208231413.GV6369@elf.ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<20090205091132.GG2077@elf.ucw.cz>
	<d6200be20902051628x50827a27i52c4b69cc64585f7@mail.gmail.com>
	<20090208221747.GM6369@elf.ucw.cz>
	<d6200be20902081440y6c25a01cw1aae1c47b04bfd03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902081440y6c25a01cw1aae1c47b04bfd03@mail.gmail.com>
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

On Sun 2009-02-08 14:40:29, Arve Hj?nnev?g wrote:
> On Sun, Feb 8, 2009 at 2:17 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> > Ok, I think that this wakelock stuff is in "can't be used properly"
> > area on Rusty's scale of nasty interfaces.
> >
> > So... do I understand this correctly that if I want to run "make zImage"
> > on Android, I'll need to modify make, gcc, .... to keep system awake?
> 
> Or you could grab a wake lock before starting the job. e.g.
> "runwithwakelock make".

Uhuh.

> What prevents the system from suspending while you run make in your
> existing system?

My existing system does not autosleep.

My experimental sleepy linux will autosleep if it knows there are no
runnable userspace jobs, and if nearest timer to fire is far enough in
future.

> >        (How to do that? Give all the userland processes access to
> >        /sys/wakelocks ?)
> 
> That depends, do you want users to be able to keep the system on?

Yes. But I also want to kill -9 to work, and want my system to sleep
after I kill -9ed all the offending processes.

...which would suggest that wakelock should be a filedescriptor. hmm.

> > BTW what does android do when battery goes critically low? I believe
> > you want to suspend, ignoring wakelocks, at that point.
> 
> I don't know for sure, but I believe it does a full shutdown.

Ok, but suspend would be more elgant (faster, does not loose user
context). Take it as an example where mixing auto-sleep and forced
sleep makes sense.

> > And now, you have some X-like system.
> >
> >        /* We were idle for too long */
> >        blank_screen();
> >
> >        unlock_all_wakelocks();         /* We want machine to sleep */
> >
> >        wait_for_key();
> >        /* (here) */
> >        lock_wakelocks("processing_key_wakelock");
> >
> > ...is that approximately correct? There's race there, right? If (here)
> > processing takes too long, or whatever, kernel will sleep the machine
> > before it even displays "do you want to unlock the screen" dialog,
> > right?
> >
> > Can you solve that in a way that works, always?
...
> There is no race in your
> example as long as your wait_for_key function just does a select or
> poll call and does not read the key events. The wakelock on the event
> queue prevents sleep.

Ugh; okay, interesting. So if rogue userspace program wants to keep
system awake forever, all it needs to do is take filedescriptor from
some input device, select() on it and not read events?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
