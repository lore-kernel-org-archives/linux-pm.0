From: David Brownell <david-b@pacbell.net>
Subject: Re: [3/6] 2.6.21-rc4: known regressions
Date: Thu, 29 Mar 2007 17:09:14 -0700
Message-ID: <200703291709.17085.david-b__44186.7467052818$1175213386$gmane$org@pacbell.net>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<200703291533.38002.david-b@pacbell.net>
	<200703300129.27474.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703300129.27474.maximlevitsky@gmail.com>
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
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, linux-acpi@vger.kernel.org, jgarzik@pobox.com, linux-pm@lists.linux-foundation.org, gregkh@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Thursday 29 March 2007 4:29 pm, Maxim Levitsky wrote:
> On Friday 30 March 2007 00:33:35 David Brownell wrote:
> > On Wednesday 28 March 2007 2:27 pm, Maxim wrote:

> > > 	So the only way out is to emulate RTC using HPET,
> > > 	It is done this way in old rtc driver, rtc-cmos should do the same.
> > =

> > No.  Patches like
> > =

> >   http://marc.info/?l=3Dlinux-kernel&m=3D117219531503973&w=3D2

also:   http://marc.info/?l=3Dlinux-kernel&m=3D117219531526317&w=3D2

> > should be merged (I hope they're in the 2.6.22 queue!), making
> > HPET run in "Standard Mode" so that HPET can stop sticking its
> > fingers in code where they don't belong.
> >
> > ...
>
> 	It is not that simple,
> =

> 	Only in legacy replacement mode HPET can be put on IRQ0 (and sadly  IRQ8)
> 	At least this is true on some systems, on mine for example

Right, that's the entire point of legacy replacement mode.

But so what?  In standard mode, HPET just uses other IRQs.
Nothing would care about irq0, and irq8 would be used by
the RTC as necessary.


> 	this will make it difficult to use it as a clockevents source

Why?  It's not like the clockevent logic cares what IRQ a given
programmable timer uses.  So long as the HPET driver can receive
its IRQ, it'll make a fine clockevent.  There's no reason to have
HPET prevent other drivers from working, by insisting it use that
nasty "prevent other hardware from issuing IRQs" mode.

The patches from Venkatesh sure seem to have behaved for him.
And while he might have complained about difficulty, I think
that'd be more likely due to the SMP issues he also addressed
than because of some (historical?) attachment to irq0.


> 	Not to mention the fact that current code assumes that BIOS
> 	assigned IRQs to all timers which is not true on my system. =


Getting IRQ routing sorted out is a problem that's been solved
numerous times before.  And again, the patches referenced above
seem to have resolved any such issues.


> 	What is wrong with relying on HPET to provide RTC IRQ ?

For starters, it's not an RTC.  Why in the world would you want to
make the OS think it's an RTC ... unless you're Microsoft, and are
desperate to get another periodic timer (and don't much care about
the other RTC functionality?


... that's all off-topic for 2.6.21 regressions though; it's too
late to merge x86_64 clockevent support, or fix HPET issues like
not using "standard mode".

- Dave
