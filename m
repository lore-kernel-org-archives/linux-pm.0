From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch] Re: using long instead of atomic_t when only
 set/read is required
Date: Mon, 3 Mar 2008 14:23:40 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803031422180.2979@woody.linux-foundation.org>
References: <20080225090316.GA420@elf.ucw.cz> <20080303154831.22a4eb14@core>
	<20080303172410.GA13869@elf.ucw.cz>
	<200803032127.30761.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803032127.30761.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, davem@davemloft.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org



On Mon, 3 Mar 2008, Rafael J. Wysocki wrote:
> 
> Well something like this could happen, in theory, on a "32-bit" architecture
> with a 16-bit bus.

No it couldn't.

That would only be true if there is no cache, and no cache coherency.

Basically, Linux requires a cache-coherent architecture to work in SMP. 
Anything else is insane (except as a cluster).

So there is no way we can see partial updates, except with terminally 
broken hardware that we would never support anyway for tons of other 
reasons.

		Linus
