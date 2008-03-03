From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] Re: using long instead of atomic_t when only
	set/read	is required
Date: Mon, 3 Mar 2008 18:44:22 +0100
Message-ID: <20080303174422.GB13869__43694.576182361$1204566453$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0803031207120.3611-100000@iolanthe.rowland.org>
	<alpine.LFD.1.00.0803030921420.17889@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803030921420.17889@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, davem@davemloft.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Consider a routine like the following:
> > 
> > 	static task_struct *the_task;
> > 
> > 	void store_task(void)
> > 	{
> > 		the_task = current;
> > 	}
> > 
> > Is it possible to say whether readers examining "the_task" are 
> > guaranteed to see a coherent value?
> 
> Yes, we do depend on this.  All the RCU stuff (and in general *anything* 
> that depends on memory ordering as opposed to full locking, and we have 
> quite a lot of it) is very fundamentally dependent on the fact that things 
> like pointers get read and written atomically.
> 
> HOWEVER, it is worth pointing out that it's generally true in a 
> "different" sense than the actual atomic accesses. For example, if you 
> test a single bit of a word, it's still quite possible that gcc will have 
> turned that "atomic" read into a single byte read, so it's not necessarily 
> the case that we'll actually even read the whole word. 
> 
> (Writes are different: if you do things like bitwise updates they simply 
> *will*not* be atomic, but that's simply not what we depend on anyway).

Ok... can we get Alan Stern's patch into Documentation/atomic_ops.txt
, then? I was not aware of this, and there seems to be lot of
confusion around...

Plus... I really don't think we can "just access" this as normal
pointers... due to the compiler issues Alan Cox mentioned, and due to
the ACCESS_ONCE() issue.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
