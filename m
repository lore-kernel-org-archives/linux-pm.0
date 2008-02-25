From: Pavel Machek <pavel@ucw.cz>
Subject: using long instead of atomic_t when only set/read is
	required (was	Re: [Bug 10030] Suspend doesn't work when SD
	card is inserted)
Date: Mon, 25 Feb 2008 10:03:16 +0100
Message-ID: <20080225090316.GA420__10769.2702593797$1203947849$gmane$org@elf.ucw.cz>
References: <20080224214253.GE18908@elf.ucw.cz>
	<Pine.LNX.4.44L0.0802242109130.31164-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20080225113631.GA2855@elf.ucw.cz>
Resent-To: drzeus-mmc@drzeus.cx, linux-pm@lists.linux-foundation.org,
        davem@davemloft.net
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0802242109130.31164-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>, davem@davemloft.net
Cc: pm list <linux-pm@lists.linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

Hi!

Alan thinks that `subj` is correct...

> > > > At the very least, you'd need rmb() before reading it and wmb() after
> > > > writing to it, but I'm not sure if that's enough on every obscure
> > > > architecture out there.
> > > 
> > > No, neither one is needed because of the way suspending_task is used.  
> > > 
> > > It's not necessary for a reader R to see the variable's actual value;  
> > > all R needs to know is whether or not suspending_task is equal to R.  
> > > Since the only process which can set suspending_task to R is R itself,
> > > and since R will set suspending_task back to NULL before releasing the
> > > write lock on pm_sleep_rwsem, there's never any ambiguity.
> > 
> > Subtle.
> > 
> > Very subtly wrong ;-).
> > 
> > imagine suspending_task == 0xabcdef01. Now task "R" with current ==
> > 0xabcd0000 reads suspending_task while the other cpu is writing to it,
> > and sees 0xabcd0000 (0xef01 was not yet written) -- and mistakenly
> > believes that  "R" == suspending_task.
> 
> I always thought that reads and writes of pointers are atomic, just 
> like reads and writes of longs.  Is that wrong?

...but I'm not that sure. Can someone clarify?

I guess it only works as long as longs are aligned? Should it be
written down to atomic_ops.txt?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
