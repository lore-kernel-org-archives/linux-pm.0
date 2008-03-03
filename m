From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] Re: using long instead of atomic_t when only
 set/read is required
Date: Mon, 3 Mar 2008 15:48:31 +0000
Message-ID: <20080303154831.22a4eb14__11982.0015774623$1204560718$gmane$org@core>
References: <20080225090316.GA420@elf.ucw.cz>
	<Pine.LNX.4.44L0.0802250943410.3549-100000@iolanthe.rowland.org>
	<20080303120842.GA28369@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080303120842.GA28369@elf.ucw.cz>
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
Cc: Andrew Morton <akpm@osdl.org>, Kernel@smtp1.linux-foundation.org, Zdenek@smtp1.linux-foundation.org, development list <linux-kernel@vger.kernel.org>, Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, davem@davemloft.net, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

> Ok, so linux actually atomicity of long?

No it doesn't. And even if it did you couldn't use long for this because
atomic_t also ensures the points operations complete are defined. You
might just about get away with volatile long * objects on x86 for simple
assignments but for anything else gcc can and will generate code to
update values whichever way it feels best - which includes turning

	long *x = a + b;

into

	*x = a;
	*x += b;

Alan
