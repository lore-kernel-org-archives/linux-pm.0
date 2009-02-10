From: Pavel Machek <pavel@ucw.cz>
Subject: Re: non-racy examples,
	please (was Re: [PATCH 01/13] PM: Add wake lock api.)
Date: Tue, 10 Feb 2009 12:15:30 +0100
Message-ID: <20090210111530.GB4636@atrey.karlin.mff.cuni.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<20090205091132.GG2077@elf.ucw.cz>
	<d6200be20902051628x50827a27i52c4b69cc64585f7@mail.gmail.com>
	<20090208221747.GM6369@elf.ucw.cz>
	<d6200be20902081440y6c25a01cw1aae1c47b04bfd03@mail.gmail.com>
	<20090208231413.GV6369@elf.ucw.cz>
	<d6200be20902081535u689bfd58xe5aef77c5a4e6bd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902081535u689bfd58xe5aef77c5a4e6bd8@mail.gmail.com>
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

> On Sun, Feb 8, 2009 at 3:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >> What prevents the system from suspending while you run make in your
> >> existing system?
> >
> > My existing system does not autosleep.
> 
> Does it not support any kind of autosleep, or did you not enable it.
> If you enable autosleep after some number of minutes of inactivity,
> does the the running make job keep the system on? The systems I have
> seen (not Linux) will go to sleep while make is still running.

My system does not support autosleep. The systems that do it from
timer, unconditionally do it like after 30 minutes by default; while
android wants to suspend after some seconds.

> > My experimental sleepy linux will autosleep if it knows there are no
> > runnable userspace jobs, and if nearest timer to fire is far enough in
> > future.
> 
> We do this from idle. The nearest timer is never more than one second
> in the future.

Well, so you fix the timers... that is good for everyone. I got to 5
second with some effort, and could extend it some more.

> >> > BTW what does android do when battery goes critically low? I believe
> >> > you want to suspend, ignoring wakelocks, at that point.
> >>
> >> I don't know for sure, but I believe it does a full shutdown.
> >
> > Ok, but suspend would be more elgant (faster, does not loose user
> > context). Take it as an example where mixing auto-sleep and forced
> > sleep makes sense.
> 
> I think a high priority sleep (like someone suggested) make more sense
> than a forced sleep for this situation. The wakelock code could deal
> with this as another wakelock type, and ignore normal wakelocks when a
> high priority sleep is requested. We cannot necessarily ignore all
> wakelocks since some may be used to manage the battery and charger.

Now.. that's a differnce from PC. But...if you shutdown -h now, what
happens to battery and charger?

> > Ugh; okay, interesting. So if rogue userspace program wants to keep
> > system awake forever, all it needs to do is take filedescriptor from
> > some input device, select() on it and not read events?
> 
> Yes, but input devices should not be accessible to any process.

Normally, untrusted processes are welcome to use ttyX directly... I
know about X today...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
