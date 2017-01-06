From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 01/11] power: supplies: bq275xx: rename BQ27500 allow
 for deprecation in future.
Date: Fri, 6 Jan 2017 18:36:50 +0100
Message-ID: <20170106173650.7ue6jcgrwqckmb7g@earth>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1482451507-37676-1-git-send-email-chris@lapa.com.au>
 <1482451507-37676-2-git-send-email-chris@lapa.com.au>
 <20170105235957.jfoffcnlqqpw36vp@earth>
 <45a0f589-6a11-dcee-8a12-ec89763de501@lapa.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="atyd2om3dtipbnxr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752690AbdAFRg4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Jan 2017 12:36:56 -0500
Content-Disposition: inline
In-Reply-To: <45a0f589-6a11-dcee-8a12-ec89763de501@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>
Cc: pali.rohar@gmail.com, afd@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--atyd2om3dtipbnxr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 06, 2017 at 11:29:19AM +1100, Chris Lapa wrote:
> On 6/1/17 10:59 am, Sebastian Reichel wrote:
> > Hi Chris,
> >=20
> > On Fri, Dec 23, 2016 at 11:04:57AM +1100, Chris Lapa wrote:
> > > From: Chris Lapa <chris@lapa.com.au>
> > >=20
> > > The BQ275XX definition exists only to satisfy backwards compatibility.
> > >=20
> > > tested: yes
> > >=20
> > > Signed-off-by: Chris Lapa <chris@lapa.com.au>
> > >=20
> > > [...]
> > >=20
> > >  static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di,=
 u16 flags)
> > >  {
> > > -	if (di->chip =3D=3D BQ27500 || di->chip =3D=3D BQ27541 || di->chip =
=3D=3D BQ27545)
> > > +	if (di->chip =3D=3D BQ275XX || di->chip =3D=3D BQ27541 || di->chip =
=3D=3D BQ27545)
> > >  		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
> > >  	if (di->chip =3D=3D BQ27530 || di->chip =3D=3D BQ27421)
> > >  		return flags & BQ27XXX_FLAG_OT;
> >=20
> > This is really getting out of hands in this patchset. Please
> > add a patch at the beginning of the patchset, which converts
> > this construct into the following:
> >=20
> > switch (di->chip) {
> > case A:
> > case B:
> > case C:
> > case D:
> >     return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
> > case E:
> > case F:
> >     return flags & BQ27XXX_FLAG_OT;
> > default:
> >     return false;
> > }
> >=20
> > -- Sebastian
> >=20
>=20
> I was advised to move these tests into a function which I've done in the
> 10th patch. I have no issue with changing it to a switch statement, but
> should I drop the bq27xxx_has_multiple_overtemp_flags() function I added?

I'm fine with or without the extra function. But please introduce
the switch at the beginning of the patchseries, since it also eases
patch-reviewing.

-- Sebastian

--atyd2om3dtipbnxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhv1bIACgkQ2O7X88g7
+poBzQ//Vj3622sN2NUrwnV7OpFAX9kSP8dzTOEGdaiDrCf6FunS0ZOiBRsAQiDM
u0y2q2xGq5stSnSQadLdGOWsDXLr8DxAboLsyKiSB/h3aGiFU/IlnCncEXLaEJmM
ScbE8lxm8RIsqvu6+S8Zpwz6T+QPyD0NjMN/FAED65D7MFcOKTN4gO/sAgYwk7Oe
wW2WRtiJLQmNJTKCdb2QND49ma8zZspCjKv/6JHSFWg1kdNJodstUp0omgqt16Z1
kx6Kr2kcVRa1TPNBrsNXbGNGiG/RBAjl98uMK7PmCaOx4JUixPDHGJXzco2uDgqQ
YoN6o5qpyGPDVO8LhjaEcr8y7rU8BlbEsWX0Hrk1sFT8H3uPABXAUtjmuJJlSwwR
KIkgcDBAA3XrgCdDctKB5ieqjqzTZ4GVk24iA7L+1RXdxejRDhMZfoyGSCooECdz
z7pUCObDsM4vJIEoAPPB/84HUZsdJYBJERWTGjD/Ogy050uaLGAz2QG+ZAqlFhHM
fia8MPWwVcW1aeQlvsrj+DgkD3I9+AInXCAg/TpsN6TZpjtCqIedni1IsESaB0g1
iSZGqnPzpLvfjZKVGEANZdeHYnhk0xaaJkVcywfH0D9R3Crxd0cOco48HAItiXXm
95vdRt09C8fHFOeSsEnT01C3D7Ririga3+FZhCX5uef1CmhNvC8=
=nuw0
-----END PGP SIGNATURE-----

--atyd2om3dtipbnxr--
