From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Bug 10030] Suspend doesn't work when SD card is
	inserted
Date: Sun, 24 Feb 2008 22:42:53 +0100
Message-ID: <20080224214253.GE18908__43899.04829809$1203889473$gmane$org@elf.ucw.cz>
References: <20080224201105.GC18908@elf.ucw.cz>
	<Pine.LNX.4.44L0.0802241527420.11316-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0802241527420.11316-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Sun 2008-02-24 15:33:01, Alan Stern wrote:
> On Sun, 24 Feb 2008, Pavel Machek wrote:
> 
> > > > What locking protects this variable? What happens when suspending_task
> > > > exits? (Hmm, that would probably be bug, anyway?)
> > > 
> > > It's protected by whatever existing locking scheme allows only one
> > > task to start a system sleep at a time.  For example, the suspending 
> > > task has to get a write lock on pm_sleep_rwsem.
> > 
> > And readers of suspending_task are protected by?
> 
> I added a comment about that too.
> 
> > At the very least, you'd need rmb() before reading it and wmb() after
> > writing to it, but I'm not sure if that's enough on every obscure
> > architecture out there.
> 
> No, neither one is needed because of the way suspending_task is used.  
> 
> It's not necessary for a reader R to see the variable's actual value;  
> all R needs to know is whether or not suspending_task is equal to R.  
> Since the only process which can set suspending_task to R is R itself,
> and since R will set suspending_task back to NULL before releasing the
> write lock on pm_sleep_rwsem, there's never any ambiguity.

Subtle.

Very subtly wrong ;-).

imagine suspending_task == 0xabcdef01. Now task "R" with current ==
0xabcd0000 reads suspending_task while the other cpu is writing to it,
and sees 0xabcd0000 (0xef01 was not yet written) -- and mistakenly
believes that  "R" == suspending_task.

I agree it is very unlikely, and it will not happen on i386. But what
about just using atomic_t suspending_task, and store current->pid into
it?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
