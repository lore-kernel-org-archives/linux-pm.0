From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 7/7] power: bq24190_charger: Set bq24190-battery
 device .type=unknown
Date: Wed, 29 Mar 2017 16:12:48 +0200
Message-ID: <20170329141247.nl5s6zglvl3onzab@earth>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-8-liam@networkimprov.net>
 <20170323105221.qnyw2m4cgjcb24cl@earth>
 <CAKvHMgROkDF43sGgvPG8Eb+z=yjuTOL9UXkOREkd=APL47DMvw@mail.gmail.com>
 <20170324093949.rno2olzywz4cds6k@earth>
 <CAKvHMgTVvytGyzxR_ay7v216qwYnekn_c3O72XzdPANhX7zwtQ@mail.gmail.com>
 <20170324112215.uleonp3hu4oxprau@earth>
 <CAKvHMgTrsLCL_rxLUmVS_qNVeaa8n2kbh49o2iup746BiGBVUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z664tnzbfpvmdvpy"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751828AbdC2OM6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Mar 2017 10:12:58 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgTrsLCL_rxLUmVS_qNVeaa8n2kbh49o2iup746BiGBVUQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>


--z664tnzbfpvmdvpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2017 at 04:56:34AM -0700, Liam Breck wrote:
> On Fri, Mar 24, 2017 at 4:22 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi,
> >
> > On Fri, Mar 24, 2017 at 03:44:51AM -0700, Liam Breck wrote:
> >> On Fri, Mar 24, 2017 at 2:39 AM, Sebastian Reichel <sre@kernel.org> wr=
ote:
> >> > On Thu, Mar 23, 2017 at 01:47:23PM -0700, Liam Breck wrote:
> >> > > On Thu, Mar 23, 2017 at 3:52 AM, Sebastian Reichel <sre@kernel.org=
> wrote:
> >> > > > That still leaves the health status reading, though. From
> >> > > > userspace's point-of-view this should be merged into the
> >> > > > battery device, if fuel-gauge can't provide that information.
> >> > >
> >> > > You mean merged into the -charger device? -battery is the one
> >> > > we're dropping.
> >> > >
> >> > > If you did mean -battery, could you elaborate?
> >> >
> >> > I was not talking about bq24190-battery. I meant the battery
> >> > device provided by the fuel-gauge. From userspace's point of
> >> > view a battery device, which is usually derived from the
> >> > fuel-gauge should contain battery related information.
> >>
> >> It doesn't sound right to ask every gauge to absorb features from a
> >> specific charger. Userspace apps are already watching both USB and
> >> battery power supply types for a given battery. They'll pick up a
> >> health issue if we merge -battery and -charger health. Isn't that
> >> enough?
> >
> > Technically it's not correct, since high battery temperature is a
> > much bigger safety risk than high charger chip temperature. I guess
> > it's good enough, though. I guess the battery temperature health is
> > related to charging anyways, which is different from the ones making
> > the battery itself dangerous. So I'm fine with that solution.
> >
> >> > Since the battery health information is battery related it
> >> > should somehow be merged into the data from the fuel-gauge.
> >> > That's what Hans implemented with the function-pointer
> >> > construct and what you suggested to implement in this mail:
> >> >
> >> > http://marc.info/?l=3Dlinux-pm&m=3D149026871313238&w=3D2
> >>
> >> The merge I suggested was of properties from all power drivers into a
> >> single sysfs device. Which I would work on if you are eager to have
> >> it. I realize it would take a while to be merged.
> >
> > Only the devices belonging to the same battery should be
> > exposed as one device. Also charger is extra device, since
> > it may be used to charge multiple batteries. So far its
> > pretty uncommon, that charger chip provides information
> > about the battery, so you would spent lots of time for
> > a single corner case. So while I would like to have it,
> > I don't think its worth the time to implement it.
>=20
> Don't most battery-powered boxes register separate TYPE_BATTERY and
> TYPE_USB/MAINS power supplies? This would unify properties from both
> under a single sysfs node, so it's probably lots of cases.

Well that will be problematic for systems providing USB and MAINS
and can use both at the same time. The only thing, that should be
unified are properties for the same battery with charger !=3D battery.
Instead ".supplied_to" should be set correctly for the charger, so
that the system knows, that a charger supplies its energy to a
specific battery.

> A charger aware of multiple batteries would register properties at a
> named supply (sysfs node) for each battery. There would be no charger
> sysfs node. Maybe there would be a "DC in" node for its common
> regulator functions.
>=20
> There would be no more chip names appearing as sysfs nodes. System
> config (DT, etc) would name the power sysfs nodes.
>=20
> Hm, the first to-do is mock-up sysfs trees for various use cases...

I don't see any advantage in that. It also breaks userspace ABI by
removing the charger node and results in work being done by the kernel,
that can easily be done in userspace.

-- Sebastian

--z664tnzbfpvmdvpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljbwN0ACgkQ2O7X88g7
+prNHg//aDQIL7Jn6uZUrm8Wvdq+fa/LPwDSbPtu9Z8mPo/qj/HEtPayfy2GD+1A
VnkgmI34V9JCvUTVkarC28eE5l7EmFNj6NHCa5D4evpvaC0O+p7iQA4ZPvpcJ8VW
okIHccvV8VXnNdUmTfJlYQ6/FtSG71jHjyipNnVzvl15J5OzQRs/PkwbHc3z1yOs
0/e1RKxFrI6or3Okx/2ohRnsB8KvqQukMBqSVBVfgICALHmNxKeyj0HD7gAZUf2A
jLpYz1gBYhx63sldUm2lu9W7zDQ7K3z2LHrg4L1MwyxE90N+FCn1zGgy/YnFFj7t
ZTQZ7FI39T4pft/R7k2SNS6Cz9n36dH6gm2juZkd3DkZfdOTqc7jh3wr+LuH79St
9Ig956/s2Nm/sPWB1GHfv9YrVlQM2lvqGYGzNLinLYS/FvHnd80vHup8xOF6mB9W
Q+62gL5TXsTYVD/wKf3aBzXVAA7ieM0SJbzPl+/0/PzNTZYyBIOhSU7W77fdAz9a
FOLuumwUG0L+95mnHjPeT5+2yulaknC73SPB5bn35Dn+3TY+vjjuGCJtb/lJaSGq
KCAIcSjXTyDkchjRSZuabaOfgqm5eysZPVMeIV2I0/JbxxESj8fPhfbM1Mnaksre
ksNtEHJaSUH7mxzQLcY3t1GnTwk1E4+SKt9VdMJH2Ejtw2JxywA=
=wzR3
-----END PGP SIGNATURE-----

--z664tnzbfpvmdvpy--
