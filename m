From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Sat, 7 Jan 2006 01:08:26 +0100
Message-ID: <20060107000826.GC20399@elf.ucw.cz>
References: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
	<Pine.LNX.4.44L0.0601061035090.5127-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601061035090.5127-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On P=E1 06-01-06 10:42:24, Alan Stern wrote:
> On Thu, 5 Jan 2006, Patrick Mochel wrote:
> > On Fri, 6 Jan 2006, Pavel Machek wrote:
> > > On 05-01-06 16:04:07, Patrick Mochel wrote:
> >=20
> > > > A better point, and one that would actually be useful, would be t=
o remove
> > > > the file altogether. Let Dominik export a power file, with comple=
te
> > > > control over the values, for each pcmcia device. Then you never h=
ave to
> > > > worry about breaking PCMCIA again.
> > >
> > > Fine with me.
> >=20
> > ACK, you beat me to it.
> >=20
> > And, appended is a patch to export PM controls for PCI devices. The f=
ile
> > "pm_possible_states" exports the states a device supports, and "pm_st=
ate"
> > exports the current state (and provides the interface for entering a
> > state).
> >=20
> > Eventually, some drivers will want to fix up those values so that it =
can
> > mask of states that it doesn't support, as well as offer possible dev=
ice-
> > specific states.
> >=20
> > What's interesting is that with this patch, I can see that two more
> > devices on my system support D1 and D2 -- the cardbus controllers, wh=
ich
> > are actually bridges whose PM capabilities aren't exported via lspci.
>=20
> This trend is extremely alarming!!

It scares me a bit, too.=20

> It's a very bad idea to make bus drivers export and manage the syfs pow=
er=20
> interface.  It means that lots of code gets repeated and different buse=
s=20
> do things differently.
>=20
> Already we have PCI exporting "pm_possible_states" and "pm_state" while=
=20
> PCMCIA exports "suspend".  How many other different schemes are going t=
o=20
> crop up?  How much bus-specific information will have to be built into =
a=20
> user utility?
>=20
> If possible states are represented as arrays of pointers to strings, th=
en=20
> the PM core can easily supply the sysfs interface.  If Patrick's patch=20
> were re-written so that the sysfs interface were moved into the PM core=
,=20
> leaving only the PCI-specific portions in the PCI drivers, I would be m=
uch=20
> happier.  This would also mean that Dominik's patch could be replaced b=
y=20
> something a good deal smaller.
>=20
> And it wouldn't hurt to add some mechanism for indicating which of the=20
> possible states is the generic "suspend" state (usually D3 for PCI=20
> devices, but not necessarily).

I think we should start with string-based interface, with just two
states ("on" and "off"). That is easily extensible into future, and
suits current PCMCIA nicely. It also allows us to experiment with PCI
power management... I can cook up a patch, but it will be simple
reintroduction of .../power file under different name.
								Pavel
--=20
Thanks, Sharp!
