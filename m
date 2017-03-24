From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 7/7] power: bq24190_charger: Set bq24190-battery
 device .type=unknown
Date: Fri, 24 Mar 2017 12:22:15 +0100
Message-ID: <20170324112215.uleonp3hu4oxprau@earth>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-8-liam@networkimprov.net>
 <20170323105221.qnyw2m4cgjcb24cl@earth>
 <CAKvHMgROkDF43sGgvPG8Eb+z=yjuTOL9UXkOREkd=APL47DMvw@mail.gmail.com>
 <20170324093949.rno2olzywz4cds6k@earth>
 <CAKvHMgTVvytGyzxR_ay7v216qwYnekn_c3O72XzdPANhX7zwtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zdnu5hbn76aj6mfs"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbdCXLWV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Mar 2017 07:22:21 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgTVvytGyzxR_ay7v216qwYnekn_c3O72XzdPANhX7zwtQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>


--zdnu5hbn76aj6mfs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 24, 2017 at 03:44:51AM -0700, Liam Breck wrote:
> On Fri, Mar 24, 2017 at 2:39 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > On Thu, Mar 23, 2017 at 01:47:23PM -0700, Liam Breck wrote:
> > > On Thu, Mar 23, 2017 at 3:52 AM, Sebastian Reichel <sre@kernel.org> w=
rote:
> > > > That still leaves the health status reading, though. From
> > > > userspace's point-of-view this should be merged into the
> > > > battery device, if fuel-gauge can't provide that information.
> > >
> > > You mean merged into the -charger device? -battery is the one
> > > we're dropping.
> > >
> > > If you did mean -battery, could you elaborate?
> >
> > I was not talking about bq24190-battery. I meant the battery
> > device provided by the fuel-gauge. From userspace's point of
> > view a battery device, which is usually derived from the
> > fuel-gauge should contain battery related information.
>=20
> It doesn't sound right to ask every gauge to absorb features from a
> specific charger. Userspace apps are already watching both USB and
> battery power supply types for a given battery. They'll pick up a
> health issue if we merge -battery and -charger health. Isn't that
> enough?

Technically it's not correct, since high battery temperature is a
much bigger safety risk than high charger chip temperature. I guess
it's good enough, though. I guess the battery temperature health is
related to charging anyways, which is different from the ones making
the battery itself dangerous. So I'm fine with that solution.

> > Since the battery health information is battery related it
> > should somehow be merged into the data from the fuel-gauge.
> > That's what Hans implemented with the function-pointer
> > construct and what you suggested to implement in this mail:
> >
> > http://marc.info/?l=3Dlinux-pm&m=3D149026871313238&w=3D2
>=20
> The merge I suggested was of properties from all power drivers into a
> single sysfs device. Which I would work on if you are eager to have
> it. I realize it would take a while to be merged.

Only the devices belonging to the same battery should be
exposed as one device. Also charger is extra device, since
it may be used to charge multiple batteries. So far its
pretty uncommon, that charger chip provides information
about the battery, so you would spent lots of time for
a single corner case. So while I would like to have it,
I don't think its worth the time to implement it.

-- Sebastian

--zdnu5hbn76aj6mfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljVAWUACgkQ2O7X88g7
+ppkiA//bPpGSRgaXN7pIhUqovevygolbtrcQ2bg+qpvkqgm7EqtDBGfD9eyrj8F
iYPFioFzXAae5kBo4LTRpQ87ePstYlGR0leZFZeFPNZr44heWt+pYKjkAz5pMY3f
D35//sTdSt5ymuvqywa6aUQw/oKZUrkMju/QzDIQxWBu/2dNQ1d+E/kQ9h8m4+BN
Scb/mTLEvnidroYIHwMazkXo89E9mDwjfRNNdZE0aJlgB30kHpDWyJasfhms+dhB
Xpi1PUtcYTOnQ3LEPUdkH/1TsnaloFOHpXwHR4E9dbSXDV4Xsocv9CVWEsZ7WOgd
Ne76J5vbVOPbzGvTrZRqXiS7F2CEsYJabTS5ueM3NDPOTarJmEtHx+V9QjfsJBbY
b2OfFhN5a58ZbYEiY37xc5oSIB3y94S71rxWgZSBGUmC48xJ4DfhocB5rN2D0GSX
C1RY40/w4QJfmzof7xCj7Ab33z6aI1YW8hXmmm/JxpV933A9cBL4MFlCTHwwu8XR
o/WRP4C/pJI7WePNIWbLxt1lHD3gfdP4g81kpdcmXw+GMtWRh7PrJ+k0MsEp82Rm
OTb+7cEmmzoFQ6U63NbwDtx9/401ZR9mOeMV83OODvp/7gIzv+U2FR95w+JtDet4
0g3YPnBUijneJZCfDPxj6nMZuviTKlSKGNp4VwSDggWp0Zz9xSw=
=uzZO
-----END PGP SIGNATURE-----

--zdnu5hbn76aj6mfs--
