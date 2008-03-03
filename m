From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] Re: using long instead of atomic_t when only
	set/read	is required
Date: Mon, 3 Mar 2008 18:24:10 +0100
Message-ID: <20080303172410.GA13869@elf.ucw.cz>
References: <20080225090316.GA420@elf.ucw.cz>
	<Pine.LNX.4.44L0.0802250943410.3549-100000@iolanthe.rowland.org>
	<20080303120842.GA28369@elf.ucw.cz> <20080303154831.22a4eb14@core>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080303154831.22a4eb14@core>
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
Cc: Andrew Morton <akpm@osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, davem@davemloft.net, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Ok, so linux actually atomicity of long?
                         ^~-- assumes should be here.

> No it doesn't. And even if it did you couldn't use long for this because
> atomic_t also ensures the points operations complete are defined. You
> might just about get away with volatile long * objects on x86 for simple
> assignments but for anything else gcc can and will generate code to
> update values whichever way it feels best - which includes turning
> 
> 	long *x = a + b;
> 
> into
> 
> 	*x = a;
> 	*x += b;

Ok, I can understand the gcc side. But do we actually run on an
architecture where

long *x;

*x = 0;

racing with 

*x = 0x12345678;

can produce

*x == 0x12340000;

or something like that? I'm told RCU relies on architectures not doing
this, and I'd like to get this clarified.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
