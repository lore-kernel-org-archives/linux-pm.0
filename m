From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.21-rc1: known regressions (part 2)
Date: Thu, 1 Mar 2007 11:41:17 +0100
Message-ID: <20070301104117.GA22788@elte.hu>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
	<20070225175559.GC12392@stusta.de>
	<20070227100202.GV3822@kernel.dk>
	<20070227102109.GG6745@elf.ucw.cz>
	<20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
	<20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070301093450.GA8508@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-pm@lists.osdl.org, Thomas Gleixner <tglx@linutronix.de>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Daniel Walker <dwalker@mvista.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> update: f3ccb06f3b8e0cf42b579db21f3ca7f17fcc3f38 works for me too, and =

> 01363220f5d23ef68276db8974e46a502e43d01d is broken. I too will attempt =

> to bisect this.

hm. There's some weird bisection artifact here. Here are the commits i =

tested, in git-log order:

#1 commit 01363220f5d23ef68276db8974e46a502e43d01d bad
#2 commit ee404566f97f9254433399fbbcfa05390c7c55f7 bad
#3 commit f3ccb06f3b8e0cf42b579db21f3ca7f17fcc3f38 good
#4 commit c827ba4cb49a30ce581201fd0ba2be77cde412c7 bad

if i tell git-bisect that #1 is bad and #3 is good, then it offers me #2 =

- that's OK. But when i tell it that #2 is bad, it offers #4 - which is =

out of order! The bisection goes off into la-la land after that and =

never gets back to a commit that is /after/ the good commit. How is this =

possible? (I upgraded from git-1.4.4 to 1.5.0 to make sure this isnt =

some git bug that's already fixed.)

i'll try to straighten this out manually, perhaps #3 is in some merge =

branch that confuses bisection. Or maybe i misunderstood how git-bisect =

works.

	Ingo
