From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug 10030] Suspend doesn't work when SD card is
	inserted
Date: Mon, 25 Feb 2008 12:40:23 +0100
Message-ID: <200802251240.24386.rjw__48686.6002706394$1203939832$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0802242109130.31164-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0802242109130.31164-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Monday, 25 of February 2008, Alan Stern wrote:
> On Sun, 24 Feb 2008, Pavel Machek wrote:
> 
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

That depends on the architecture.  It may be wrong on alpha, IIRC.

> Now if pointers were the same size as long long then I would agree with 
> you.

That certainly is true on x86-64.  On alpha probably too.

> > I agree it is very unlikely, and it will not happen on i386. But what
> > about just using atomic_t suspending_task, and store current->pid into
> > it?
> 
> That would work just as well.  Except that it wouldn't need to be
> atomic_t, because current->pid is always an integer (not guaranteed, I
> suppose, but that's what it is on all current architectures) and
> reads/writes of ints _are_ atomic.

That also depends on the arch, I'm afraid, and in general if we assume
something to be atomic, it's better to make the code reflect that assumption.

Thanks,
Rafael
