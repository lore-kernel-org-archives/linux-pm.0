From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's
	/sys	interface
Date: Sat, 7 Jan 2006 11:20:13 +0100
Message-ID: <20060107102013.GB9225@elf.ucw.cz>
References: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
	<Pine.LNX.4.44L0.0601061035090.5127-100000@iolanthe.rowland.org>
	<20060107000826.GC20399@elf.ucw.cz>
	<20060107075851.GD3184@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060107075851.GD3184@neo.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>, Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On So 07-01-06 02:58:51, Adam Belay wrote:
> On Sat, Jan 07, 2006 at 01:08:26AM +0100, Pavel Machek wrote:
> > On P=E1 06-01-06 10:42:24, Alan Stern wrote:
> > > On Thu, 5 Jan 2006, Patrick Mochel wrote:
> > > It's a very bad idea to make bus drivers export and manage the syfs=
 power=20
> > > interface.  It means that lots of code gets repeated and different =
buses=20
> > > do things differently.
> > >=20
> > > Already we have PCI exporting "pm_possible_states" and "pm_state" w=
hile=20
> > > PCMCIA exports "suspend".  How many other different schemes are goi=
ng to=20
> > > crop up?  How much bus-specific information will have to be built i=
nto a=20
> > > user utility?
> > >=20
> > > If possible states are represented as arrays of pointers to strings=
, then=20
> > > the PM core can easily supply the sysfs interface.  If Patrick's pa=
tch=20
> > > were re-written so that the sysfs interface were moved into the PM =
core,=20
> > > leaving only the PCI-specific portions in the PCI drivers, I would =
be much=20
> > > happier.  This would also mean that Dominik's patch could be replac=
ed by=20
> > > something a good deal smaller.
> > >=20
> > > And it wouldn't hurt to add some mechanism for indicating which of =
the=20
> > > possible states is the generic "suspend" state (usually D3 for PCI=20
> > > devices, but not necessarily).
> >=20
> > I think we should start with string-based interface, with just two
> > states ("on" and "off"). That is easily extensible into future, and
> > suits current PCMCIA nicely. It also allows us to experiment with PCI
> > power management... I can cook up a patch, but it will be simple
> > reintroduction of .../power file under different name.
>=20
> The driver core can provide some infustructure, but let's leave the sta=
tes
> up to the drivers.  Afterall, some drivers might only be interested in =
"on"
> during runtime.  Also, drivers might support some sort of partial-off
> but not "off".

Then they map "off" to "as much off as I can". Big deal.

> And no, this does not allow us to experiment with PCI power
> management.

Well, suse was already doing experiments with 2.6.14 sysfs...

> Also there's nothing "runtime" about the PCMCIA PM API.  It's much more
> like calling ->remove() as it disabled the device all together. =20

It looks enough runtime to me.

> I'm more
> interested in saving power without crippling functionality.

You are on wrong mailing list, then. Seriously. If you can save power
without affecting functionality, then just doing, you don't need any
userland interface.
							Pavel

--=20
Thanks, Sharp!
