From: Pavel Machek <pavel@suse.cz>
Subject: Re: Runtime device power management in userspace
Date: Tue, 27 Dec 2005 20:22:54 +0100
Message-ID: <20051227192254.GJ1822@elf.ucw.cz>
References: <20051223143047.GC16463@f192.suse.de>
	<Pine.LNX.4.50.0512230706530.13289-100000@monsoon.he.net>
	<20051224004029.GC16043@elf.ucw.cz>
	<Pine.LNX.4.50.0512261234350.12383-100000@monsoon.he.net>
	<20051226223325.GE1974@elf.ucw.cz>
	<Pine.LNX.4.50.0512271054350.30915-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0512271054350.30915-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On =DAt 27-12-05 10:59:44, Patrick Mochel wrote:
>=20
> On Mon, 26 Dec 2005, Pavel Machek wrote:
>=20
> > On Po 26-12-05 12:43:43, Patrick Mochel wrote:
> > > > Is there enough locking in driver core to make this safe?
> > >
> > > The issue I stated is actually orthogonal to locking the device; bu=
t the
> > > answer to your question is: probably not. We should probably be tak=
ing the
> > > per-device semaphore to prevent against competing events that are t=
rying
> > > to add/remove a device or driver.
> >
> > Ok, thanks. That means that some races are still there, but they
> > probably don't matter for non-hotpluggable stuff like PCI, right?
>=20
> Well, the semapohre blocks against driver probing and removing, too.

Ahha, so rmmod while banging .../power is not a good idea. Ok.

> > Noone uses .../power API just now (except Holger :-), so I think we
> > can still change it. Currently it is horribly broken -- taking 0/2 an=
d
> > passing it directly to pm_message_t.event. I don't think we can solve
> > worlds hunger today... but what about at least changing interface so
> > that it lists two states ("on" and "suspend") that are more or less
> > common to all drivers?
>=20
> I don't think we want to do something from the core that is common to a=
ll
> drivers in that area. The PM values and semantics are so different acro=
ss
> that I don't think we could effectively abstract something for
> everything.

Well... at least "fully-on" and
"power-down-hardware-as-much-as-possible" are common to all the
drivers. And Ben on ppc does not freeze userspace while doing suspend,
so we are not really exposing anything new.

> What we could do is remove the file from being added in the core, and h=
ave
> the PCI core add it for all PCI devices that have PM capabilities and s=
how
> all the states that appear in the config space. From there, we could
> start

I don't really think we want complexity of putting PCI device into
D0/D1/D2/D3hot/D3cold. All that userspace should care about is device
working/device suspended, and we could not test all 5 states, anyway.

								Pavel
--=20
Thanks, Sharp!
