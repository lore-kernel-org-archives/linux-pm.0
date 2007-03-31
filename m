From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH v2] Add suspend/resume for HPET
Date: Sat, 31 Mar 2007 10:55:42 -0700
Message-ID: <200703311055.43407.david-b@pacbell.net>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <1175358800.28263.36.camel@localhost.localdomain> <Pine.LNX.4.64.0703310943190.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0703310943190.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Maxim Levitsky <maximlevitsky@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ingo Molnar <mingo@elte.hu>, jgarzik@pobox.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 31 March 2007 9:53 am, Linus Torvalds wrote:
>=20
> On Sat, 31 Mar 2007, Thomas Gleixner wrote:
> >=20
> > Right, but clock - sources/events need to be extremly late suspende=
d and
> > early resumed. How can we ensure this ?
>=20
> Make them be at the top of the device tree by adding them early. That=
's=20
> the whole point of the device tree after all - we have an ordering th=
at is=20
> enforced by its topology, and that we sort by when things were added.

Right, but "when things get added" doesn't correlate well to
"when they should get suspended/resumed".  It's also in basic
conflict with runtime PM models, where devices may be suspended
at essentially any time.  And sysdevs are even stranger.


One way out:  rather than constructing that list as devices get
enumerated, it could be constructed by a (linear-time, non-recursive)
walk of the device tree(s) before they get suspended.

(Or equivalently:  construct lists at enumeration time, but just
adding them *right after their parent* rather than at the end of
the list.)

Would that solve the problem here?  Potentially ... if the tree is
structured to meet Thomas' rules:

> > The required resume order is:
> >=20
> > clocksources
> > timekeeping
> > clockevents
> > tick management

> So the only thing that needs to be done is to make sure that we add t=
he=20
> timer devices early during bootup - something we have to do *anyway*.=
 If a=20
> device is added early in bootup, that automatically means that it wil=
l be=20
> suspended late, and resumed early - because we maintain that order al=
l the=20
> way through..

> =A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0-- "clocksource" -- +-- HPET
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0|
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0+-- TSC
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0|
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0+-- i8259
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0|
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0+-- lapic timer
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0|
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0.. whatever else

If each of those were a device node, with "clocksource" suspend/resume
methods handling Thomas' "timekeeping" item, and simlarly for "clockeve=
nt"
devices ... I could see that all working neatly.

- Dave

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
