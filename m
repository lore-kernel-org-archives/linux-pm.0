From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] Re: using long instead of atomic_t when only
	set/read is required
Date: Mon, 3 Mar 2008 21:27:29 +0100
Message-ID: <200803032127.30761.rjw__31038.6671721519$1204576402$gmane$org@sisk.pl>
References: <20080225090316.GA420@elf.ucw.cz> <20080303154831.22a4eb14@core>
	<20080303172410.GA13869@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080303172410.GA13869@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, davem@davemloft.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Monday, 3 of March 2008, Pavel Machek wrote:
> Hi!
> 
> > > Ok, so linux actually atomicity of long?
>                          ^~-- assumes should be here.
> 
> > No it doesn't. And even if it did you couldn't use long for this because
> > atomic_t also ensures the points operations complete are defined. You
> > might just about get away with volatile long * objects on x86 for simple
> > assignments but for anything else gcc can and will generate code to
> > update values whichever way it feels best - which includes turning
> > 
> > 	long *x = a + b;
> > 
> > into
> > 
> > 	*x = a;
> > 	*x += b;
> 
> Ok, I can understand the gcc side. But do we actually run on an
> architecture where
> 
> long *x;
> 
> *x = 0;
> 
> racing with 
> 
> *x = 0x12345678;
> 
> can produce
> 
> *x == 0x12340000;
> 
> or something like that?

Well something like this could happen, in theory, on a "32-bit" architecture
with a 16-bit bus.  In that case, one can imagine, the first word of the
first write may be sent through the bus immediately followed by the first
word of the second write, followed by the second word of the second
write and by the second word of the first write, in this order.

> I'm told RCU relies on architectures not doing this, and I'd like to get this
> clarified.

Yes, it would be good to know that for sure.

Rafael 
