From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch] pm: fix runtime powermanagement's
	/sys	interface
Date: Sat, 7 Jan 2006 03:36:02 -0500
Message-ID: <20060107083602.GE3184@neo.rr.com>
References: <20051227213439.GA1884@elf.ucw.cz>
	<d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
	<20051227220533.GA1914@elf.ucw.cz>
	<Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net>
	<20060104213405.GC1761@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060104213405.GC1761@elf.ucw.cz>
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
Cc: Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 04, 2006 at 10:34:05PM +0100, Pavel Machek wrote:
> On =DAt 27-12-05 20:22:04, Patrick Mochel wrote:
> We want _common_ values, anyway. So, we do not want "D0", "D1", "D2",
> "D3hot" in PCI cases. We probably want "on", "D1", "D2", "suspend",
> and I'm not sure about those "D1" and "D2" parts. Userspace should not
> have to know about details, it will mostly use "on"/"suspend" anyway.
>=20
> > > One day, when we find device that needs it, we may want to add more
> > > states. I don't know about such device currently.
> >=20
> > There are many devices already do - there are PCI, PCI-X, PCI Express=
,
> > ACPI devices, etc that do. But, you simply cannot create a single
> > decent
>=20
> I asked for an example.

Look at the ACPI spec, it has several examples...

1.) most sound cards have more than two states. (once again latency over
power savings trade offs)
2.) many PCI devices with wake support use different D-levels depending
on wake settings
3.) PCI buses have B0, B1, B2, and B3 (and yes these are very different
from D-states).  This catagory also includes cardbus bridges.
4.) IDE hard drives and other storage media have "sleep", "suspend",
etc.
5.) SATA controllers have more states than just "on" and "off".  Also
these states are independent of the PCI d-states.
6.) many video cards implement D1 and D2 as you've already seen.  This
is often more a matter of "we only know how to restore from such and such
states"
7.) Many processors support of wealth of different power states

This list is not exhaustive.  Also, embedded platforms probably have
serveral more examples.

Thanks,
Adam
