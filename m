From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.21-rc1: known regressions (part 2)
Date: Fri, 9 Mar 2007 07:44:40 +0100
Message-ID: <20070309064440.GD1983@elf.ucw.cz>
References: <20070225175559.GC12392@stusta.de>
	<20070227100202.GV3822@kernel.dk>
	<20070227102109.GG6745@elf.ucw.cz>
	<20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
	<20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070302100704.GB2293@elf.ucw.cz>
	<20070305084257.GA4464@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070305084257.GA4464@mellanox.co.il>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Daniel Walker <dwalker@mvista.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Pavel, I tried with your .config, and indeed the system came back to life=
 after
> 2-3 minutes after I press Fn/F4, indeed the issue seems to be with the di=
sk.
> It could be that the same takes place with my original .config - maybe
> I just wasn't patient enough. I'll need to re-test that.
> =

> However, I noticed that, after resume, when the system is presumably func=
tional,
> if I try to suspend to ram again, this second suspend hangs, displaying
> the following on screen:
> =

> [   17.170000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low)=
 -> IRQ 20
> [   17.170000] PCI: Setting latency timer of device 0000:02:00.0 to 64
> [   17.250000] e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:Wid=
th x1) 00:16:41:5
> 4:6c:47
> [   17.330000] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connec=
tion
> =

> the crescent LED starts blinking and does not seem to stop for at lest 10=
 min,
> I've run out of patience after that. It could be that it's just very slow=
 again.
> =

> Pavel, did you try suspend to RAM after a successfull resume from
> RAM?

Seems to work ok in -rc3... as long as I do not mix s2ram with s2disk.

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
