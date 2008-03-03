From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch] Re: using long instead of atomic_t when only
 set/read is required
Date: Mon, 3 Mar 2008 09:26:24 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803030921420.17889@woody.linux-foundation.org>
References: <Pine.LNX.4.44L0.0803031207120.3611-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803031207120.3611-100000@iolanthe.rowland.org>
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
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, davem@davemloft.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org



On Mon, 3 Mar 2008, Alan Stern wrote:
> 
> Consider a routine like the following:
> 
> 	static task_struct *the_task;
> 
> 	void store_task(void)
> 	{
> 		the_task = current;
> 	}
> 
> Is it possible to say whether readers examining "the_task" are 
> guaranteed to see a coherent value?

Yes, we do depend on this.  All the RCU stuff (and in general *anything* 
that depends on memory ordering as opposed to full locking, and we have 
quite a lot of it) is very fundamentally dependent on the fact that things 
like pointers get read and written atomically.

HOWEVER, it is worth pointing out that it's generally true in a 
"different" sense than the actual atomic accesses. For example, if you 
test a single bit of a word, it's still quite possible that gcc will have 
turned that "atomic" read into a single byte read, so it's not necessarily 
the case that we'll actually even read the whole word. 

(Writes are different: if you do things like bitwise updates they simply 
*will*not* be atomic, but that's simply not what we depend on anyway).

So in that sense, the atomicity guarantees are a lot weaker than the ones 
we do for IO accesses, but that's all fine. Memory isn't IO, and doesn't 
have side effects.

			Linus
