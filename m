From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] Re: using long instead of atomic_t when only
 set/read is required
Date: Mon, 3 Mar 2008 17:33:40 +0000
Message-ID: <20080303173340.55a38c6b@core>
References: <20080303120842.GA28369@elf.ucw.cz>
	<Pine.LNX.4.44L0.0803031023550.3611-100000@iolanthe.rowland.org>
	<20080303155330.39e45ad4@core>
	<200803040416.33937.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Andrew Morton <akpm@osdl.org>, Kernel@smtp1.linux-foundation.org, Zdenek@smtp1.linux-foundation.org, development list <linux-kernel@vger.kernel.org>, Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, davem@davemloft.net, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

> Are you sure gcc doesn't? Or is it just "C"?

gcc doesn't

> Linux wouldn't work today if gcc did something non-atomic there
> (presuming you're talking about naturally aligned pointers/ints).
> It is widely used and accepted.

Yes and we've had tty layer traces in the past clearly showing it isn't
always safe, especially if any math is involved anywhere near the
assignment. That may be why pointer flipping happens to work.

Alan
