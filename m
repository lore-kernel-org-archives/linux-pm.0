From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's
	/sys	interface
Date: Sat, 7 Jan 2006 11:25:54 +0100
Message-ID: <20060107102554.GC9225@elf.ucw.cz>
References: <20051227213439.GA1884@elf.ucw.cz>
	<d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
	<20051227220533.GA1914@elf.ucw.cz>
	<Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net>
	<20060104213405.GC1761@elf.ucw.cz>
	<20060107083602.GE3184@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060107083602.GE3184@neo.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>, Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On So 07-01-06 03:36:02, Adam Belay wrote:
> On Wed, Jan 04, 2006 at 10:34:05PM +0100, Pavel Machek wrote:
> > On =DAt 27-12-05 20:22:04, Patrick Mochel wrote:
> > We want _common_ values, anyway. So, we do not want "D0", "D1", "D2",
> > "D3hot" in PCI cases. We probably want "on", "D1", "D2", "suspend",
> > and I'm not sure about those "D1" and "D2" parts. Userspace should no=
t
> > have to know about details, it will mostly use "on"/"suspend" anyway.
> >=20
> > > > One day, when we find device that needs it, we may want to add mo=
re
> > > > states. I don't know about such device currently.
> > >=20
> > > There are many devices already do - there are PCI, PCI-X, PCI Expre=
ss,
> > > ACPI devices, etc that do. But, you simply cannot create a single
> > > decent
> >=20
> > I asked for an example.
>=20
> Look at the ACPI spec, it has several examples...
>=20
> 1.) most sound cards have more than two states. (once again latency ove=
r
> power savings trade offs)

What is the latency in typical "most sound card" case?

> 2.) many PCI devices with wake support use different D-levels depending
> on wake settings

...can be done internally in driver.

> 4.) IDE hard drives and other storage media have "sleep", "suspend",
> etc.

Yep; but spindown takes 5 seconds, so if you need to reset ide bus or
not to get it back is driver detail. Plus notice how power consuption
in sleep and suspend is almost same; motor not running is big deal
there. Ouch and hdparm already handles these.

> 5.) SATA controllers have more states than just "on" and "off".  Also
> these states are independent of the PCI d-states.

...so "bus provides list of states" ideas do not really work.

> 6.) many video cards implement D1 and D2 as you've already seen.  This
> is often more a matter of "we only know how to restore from such and su=
ch
> states"

Excatly, so "on"/"off" is enough for them.

> 7.) Many processors support of wealth of different power states

Processors are handled specially, anyway.
								Pavel
--=20
Thanks, Sharp!
