From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Re: Hotplug events during sleep transition
Date: Mon, 26 Dec 2005 17:50:25 -0500
Message-ID: <200512261750.26186.dtor_core@ameritech.net>
References: <Pine.LNX.4.44L0.0512242115030.9591-100000@netrider.rowland.org>
	<Pine.LNX.4.50.0512261301090.12383-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0512261301090.12383-100000@monsoon.he.net>
Content-Disposition: inline
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Monday 26 December 2005 16:20, Patrick Mochel wrote:
> > > =A0Unbinding and
> > > rebinding do a whole lot more. A device does an entire round trip t=
hrough
> > > the driver core, which does a lot of crap. There are several memory
> > > allocations, perhaps dozens of sysfs files created, and a handful o=
f locks
> > > taken adn lists traversed.
> >
> > No, you're thinking of unregistering and re-registering a device or
> > driver. =A0Unbinding and rebinding is much simpler, although still so=
mewhat
> > complex.
>=20
> Ah, point taken; I was thinking that all USB devices were still
> disconnected during a suspend transition..
>=20

Device removal could happen at any point, even during suspend transition.
The kernel should be able to handle this scenario therefore implementatio=
n
that assumes that device tree is frozen in flawed. As far as I understand
the only thing that does not work at the moment is invoking hotplug handl=
er.

--=20
Dmitry
