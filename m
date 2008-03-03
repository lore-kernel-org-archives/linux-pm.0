From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] Re: using long instead of atomic_t when only
 set/read is required
Date: Mon, 3 Mar 2008 15:53:30 +0000
Message-ID: <20080303155330.39e45ad4__42852.9647099369$1204560894$gmane$org@core>
References: <20080303120842.GA28369@elf.ucw.cz>
	<Pine.LNX.4.44L0.0803031023550.3611-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803031023550.3611-100000@iolanthe.rowland.org>
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
Cc: Andrew Morton <akpm@osdl.org>, Kernel@smtp1.linux-foundation.org, Zdenek@smtp1.linux-foundation.org, development list <linux-kernel@vger.kernel.org>, Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, davem@davemloft.net, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org


> Atomicity of reads of write for pointers and integral types (other than 
> long long) should be documented.

NAK.

Atomicity of reads or writes for pointers and integral types is NOT
guaranteed. Gcc doesn't believe in your guarantee.

Alan
