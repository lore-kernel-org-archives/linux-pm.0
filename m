From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch] Re: using long instead of atomic_t when only
	set/read is required
Date: Tue, 4 Mar 2008 04:16:33 +1100
Message-ID: <200803040416.33937.nickpiggin@yahoo.com.au>
References: <20080303120842.GA28369@elf.ucw.cz>
	<Pine.LNX.4.44L0.0803031023550.3611-100000@iolanthe.rowland.org>
	<20080303155330.39e45ad4@core>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080303155330.39e45ad4@core>
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
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, davem@davemloft.net, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Tuesday 04 March 2008 02:53, Alan Cox wrote:
> > Atomicity of reads of write for pointers and integral types (other than
> > long long) should be documented.
>
> NAK.
>
> Atomicity of reads or writes for pointers and integral types is NOT
> guaranteed. Gcc doesn't believe in your guarantee.

Are you sure gcc doesn't? Or is it just "C"?

Linux wouldn't work today if gcc did something non-atomic there
(presuming you're talking about naturally aligned pointers/ints).
It is widely used and accepted.

RCU users are far from the only places to rely on this, although
I guess they are the main ones when it comes to assigning pointers
atomically.
