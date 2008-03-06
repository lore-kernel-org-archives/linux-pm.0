From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch] Re: using long instead of atomic_t when only
 set/read is required
Date: Thu, 6 Mar 2008 08:11:59 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803060807120.12253__23559.0742122897$1204820186$gmane$org@woody.linux-foundation.org>
References: <Pine.LNX.4.44L0.0803031207120.3611-100000@iolanthe.rowland.org>
	<alpine.LFD.1.00.0803030921420.17889@woody.linux-foundation.org>
	<47D014A6.9090300@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47D014A6.9090300@rtr.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Lord <lkml@rtr.ca>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, davem@davemloft.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org



On Thu, 6 Mar 2008, Mark Lord wrote:
> 
> But also consider something like this:
> 
> 	void store_task(void)
> 	{
> 		*the_task = current;
> 	}
> 
> In this case, there is no guarantee that the assignment
> can be done atomically on all CPU types.  Some RISC archs
> (eg. MIPS R2xxx) require an (interruptible) instruction pair
> to store values to a potentially unaligned address.

You'd better not be using unaligned accesses for memory-ordering-sensitive 
things (I think x86 happens get even that right for most cases, but I 
don't think the architecture specification guarantees it, and I'm pretty 
sure that you might find problems on cache crossing writes, for example)

But quite frankly, if you have an architecture that can't do the above as 
a single write when it's a pointer, then you have a totally broken 
architecture. It's not worth supporting.

(There are data structures that are harder than native words: bytes and 
shorts can require load-modify-write cycles, and "u64" and friends can 
obviously be multiple words, so you shouldn't depend on things for those 
"complex" cases. But we *definitely* depend on atomicity for regular word 
accesses).

		Linus
