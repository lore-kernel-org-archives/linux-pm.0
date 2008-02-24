From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Bug 10030] Suspend doesn't work when SD card is
	inserted
Date: Sun, 24 Feb 2008 15:33:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802241527420.11316-100000__12217.16840887$1203885311$gmane$org@netrider.rowland.org>
References: <20080224201105.GC18908@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080224201105.GC18908@elf.ucw.cz>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Sun, 24 Feb 2008, Pavel Machek wrote:

> > > What locking protects this variable? What happens when suspending_task
> > > exits? (Hmm, that would probably be bug, anyway?)
> > 
> > It's protected by whatever existing locking scheme allows only one
> > task to start a system sleep at a time.  For example, the suspending 
> > task has to get a write lock on pm_sleep_rwsem.
> 
> And readers of suspending_task are protected by?

I added a comment about that too.

> At the very least, you'd need rmb() before reading it and wmb() after
> writing to it, but I'm not sure if that's enough on every obscure
> architecture out there.

No, neither one is needed because of the way suspending_task is used.  

It's not necessary for a reader R to see the variable's actual value;  
all R needs to know is whether or not suspending_task is equal to R.  
Since the only process which can set suspending_task to R is R itself,
and since R will set suspending_task back to NULL before releasing the
write lock on pm_sleep_rwsem, there's never any ambiguity.

Alan Stern
