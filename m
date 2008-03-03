From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [patch] Re: using long instead of atomic_t when only
	set/read is required
Date: Mon, 3 Mar 2008 09:31:57 -0800
Message-ID: <20080303173157.GC12453__37013.5617246435$1204567590$gmane$org@linux.vnet.ibm.com>
References: <20080303120842.GA28369@elf.ucw.cz>
	<Pine.LNX.4.44L0.0803031023550.3611-100000@iolanthe.rowland.org>
	<20080303155330.39e45ad4@core>
	<200803040416.33937.nickpiggin@yahoo.com.au>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803040416.33937.nickpiggin@yahoo.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, davem@davemloft.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 04, 2008 at 04:16:33AM +1100, Nick Piggin wrote:
> On Tuesday 04 March 2008 02:53, Alan Cox wrote:
> > > Atomicity of reads of write for pointers and integral types (other than
> > > long long) should be documented.
> >
> > NAK.
> >
> > Atomicity of reads or writes for pointers and integral types is NOT
> > guaranteed. Gcc doesn't believe in your guarantee.
> 
> Are you sure gcc doesn't? Or is it just "C"?
> 
> Linux wouldn't work today if gcc did something non-atomic there
> (presuming you're talking about naturally aligned pointers/ints).
> It is widely used and accepted.
> 
> RCU users are far from the only places to rely on this, although
> I guess they are the main ones when it comes to assigning pointers
> atomically.

It is true that gcc can refetch pointers/ints if it runs out of registers,
which is why rcu_dereference() recently had an ACCESS_ONCE() added to it.

But such refetching cannot result in a mish-mash of two different
pointer values, confusing though it might be to the affected code.

						Thanx, Paul
