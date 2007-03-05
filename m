From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.21-rc1: known regressions (part 2)
Date: Mon, 5 Mar 2007 10:42:57 +0200
Message-ID: <20070305084257.GA4464@mellanox.co.il>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
	<20070225175559.GC12392@stusta.de>
	<20070227100202.GV3822@kernel.dk>
	<20070227102109.GG6745@elf.ucw.cz>
	<20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
	<20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070302100704.GB2293@elf.ucw.cz>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070302100704.GB2293@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Daniel Walker <dwalker@mvista.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <jens.axboe@oracle.com>, linux-pm@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

> Quoting Pavel Machek <pavel@ucw.cz>:
> Subject: Re: 2.6.21-rc1: known regressions (part 2)
> =

> Hi!
> =

> > * Jens Axboe <jens.axboe@oracle.com> wrote:
> > =

> > > f3ccb06f3b8e0cf42b579db21f3ca7f17fcc3f38 works for me, [...]
> > =

> > update: f3ccb06f3b8e0cf42b579db21f3ca7f17fcc3f38 works for me too, and =

> > 01363220f5d23ef68276db8974e46a502e43d01d is broken. I too will attempt =

> > to bisect this.
> =

> Strange; on my x60, suspend to ram works okay.
> =

> (Resume is very slow, because disks are not spinned up properly; and
> there's something wrong with timers; console beeps take way too long).
> =

> dmesg attached.
> =

> That's with
> =

> commit 7b965e0884cee430ffe5dc81cdb117b9316b0549
> tree 754dce6432258e0a8c3a758e13a34eb3a1d22ee1
> parent 5a39e8c6d655b4fe8305ef8cc2d9bbe782bfee5f
> author Trond Myklebust <Trond.Myklebust@netapp.com> Wed, 28 Feb 2007
> 20:13:55 -0800
> committer Linus Torvalds <torvalds@woody.linux-foundation.org> Thu, 01
> Mar 2007 14:53:39 -0800
> =

>     [PATCH] VM: invalidate_inode_pages2_range() should not exit early
> =

>     Fix invalidate_inode_pages2_range() so that it does not
> immediately exit
>     just because a single page in the specified range could not be
> removed.
> =

>     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Pavel, I tried with your .config, and indeed the system came back to life a=
fter
2-3 minutes after I press Fn/F4, indeed the issue seems to be with the disk.
It could be that the same takes place with my original .config - maybe
I just wasn't patient enough. I'll need to re-test that.

However, I noticed that, after resume, when the system is presumably functi=
onal,
if I try to suspend to ram again, this second suspend hangs, displaying
the following on screen:

[   17.170000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -=
> IRQ 20
[   17.170000] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   17.250000] e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width=
 x1) 00:16:41:5
4:6c:47
[   17.330000] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connecti=
on

the crescent LED starts blinking and does not seem to stop for at lest 10 m=
in,
I've run out of patience after that. It could be that it's just very slow a=
gain.

Pavel, did you try suspend to RAM after a successfull resume from RAM?

Under 2.6.20, the system suspends/resumes to memory within about 20 sec
any number of times.

-- =

MST
