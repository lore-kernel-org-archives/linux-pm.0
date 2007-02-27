From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: 2.6.21-rc1: known regressions (part 2)
Date: Tue, 27 Feb 2007 11:30:21 +0100
Message-ID: <20070227103021.GA2250@kernel.dk>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
	<20070225175559.GC12392@stusta.de>
	<20070227100202.GV3822@kernel.dk>
	<20070227102109.GG6745@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070227102109.GG6745@elf.ucw.cz>
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
Cc: linux-pm@lists.osdl.org, Thomas Gleixner <tglx@linutronix.de>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Daniel Walker <dwalker@mvista.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 27 2007, Pavel Machek wrote:
> Hi!
> =

> > > This email lists some known regressions in 2.6.21-rc1 compared to 2.6=
.20
> > > that are not yet fixed in Linus' tree.
> > > =

> > > If you find your name in the Cc header, you are either submitter of o=
ne
> > > of the bugs, maintainer of an affectected subsystem or driver, a patch
> > > of you caused a breakage or I'm considering you in any other way poss=
ibly
> > > involved with one or more of these issues.
> > > =

> > > Due to the huge amount of recipients, please trim the Cc when answeri=
ng.
> > > =

> > > =

> > > Subject    : ThinkPad T60: system doesn't come out of suspend to RAM
> > >              (CONFIG_NO_HZ)
> > > References : http://lkml.org/lkml/2007/2/22/391
> > > Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
> > >              Thomas Gleixner <tglx@linutronix.de>
> > > Handled-By : Ingo Molnar <mingo@elte.hu>
> > > Status     : unknown
> > =

> > x60 doesn't resume from S2R either, it doesn't matter if CONFIG_NO_HZ is
> > set or not though. 2.6.20 worked fine.
> =

> It somehow works for me. As long as I do not play with bluetooth and
> suspend to disk...

It locks solid here on resume, going back to 2.6.20 makes it work
perfectly again. In between 2.6.20 and 2.6.21-rc1 some ACPI change broke
resume, but that got fixed. Some other change later snuck in that broke
it AGAIN for me, sigh.

I don't use bluetooth nor suspend to disk.

-- =

Jens Axboe
