From: Sebastian Reichel <sre@kernel.org>
Subject: Re: BQ27xxx registers
Date: Wed, 21 Dec 2016 14:19:53 +0100
Message-ID: <20161221131953.ntk7kuaqumq5bfjy@earth>
References: <6da60215-4b73-8924-d5ca-48f99c70e7fb@lapa.com.au>
 <201612201234.19759@pali>
 <a354018a-a2e5-f70e-85b1-477a8d349a04@lapa.com.au>
 <201612211346.17265@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="imvbibneuyogpynj"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932811AbcLUNUD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Dec 2016 08:20:03 -0500
Content-Disposition: inline
In-Reply-To: <201612211346.17265@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: chris@lapa.com.au, afd@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--imvbibneuyogpynj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 21, 2016 at 01:46:17PM +0100, Pali Roh=E1r wrote:
> On Wednesday 21 December 2016 03:49:10 Chris Lapa wrote:
> > On 20/12/16 10:34 pm, Pali Roh=E1r wrote:
> > > On Tuesday 20 December 2016 07:00:41 Chris Lapa wrote:
> > >> I can generate a patch to fix this issue, however the bigger
> > >> problem exists as to which revision fuel gauge the
> > >> bq27xxx_battery.c driver is intended to support for each family.
> > >=20
> > > Hi! I think driver should support all revisions. There can be (and
> > > probably really is) hardware which uses old revision and such
> > > hardware should be still supported...
> >=20
> > I agree. However due to the register address changes across the
> > spectrum of revisions, each revision will have to be specified
> > individually. For example, we will need to implement a BQ27510G1,
> > BQ27510G2, BQ27510G3, BQ27520G1, BQ27520G2, BQ27520G3, BQ27520G4
> > definitions and prospective device tree additions ti,bq27510g1,
> > ti,bq27510g2 etc.
> >=20
> > The other option is to aim for bottom of the barrel support for all
> > the devices under the BQ27500 definition but my feeling is it would
> > get messier fast and be less maintainable.
> >=20
> > My preference is to go with the first option if you agree?
>=20
> Yes. If those chips have different register addresses, then those chips=
=20
> are different. Name, generation or suffix does not matter here.
>=20
> Similarly there could be chips with different name, but same addresses,=
=20
> so can use one driver/configuration without any change.
>=20
> So I'm for different name in device tree (or platform data or what is=20
> being used) to distinguish between different revisions.

Sounds fine to me. Let's keep the compatible string without revision
as deprecated alias for the version currently implemented by the
driver (for backward compatibility).

-- Sebastian

--imvbibneuyogpynj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhagXYACgkQ2O7X88g7
+popWA//YTnGsTS8hmkVzinaUmkZ/c/62//cmWoRYDiMp6xyJ5bKFpl1S7yIsmZ8
ky5rj7Nqbp7UPo3H2s0v7KJifmBiANp/2GqtIR2hClZuPuswq36B+VITItIMPF34
2ZY4c5qiDhz0gfqIIxCP2iKd3PH/Am0RiD9zKLgtKVoDkgC2dMNByODJFmoCt09f
E7FjvaBftp1FOk7R6COEojLPSLhU/N3o2XANk/KfkCtL1QZ4DnhrdBab9ixzE3RB
awZL+HVUcIKpy99R5x5VC1H0DORUbKfFSC3YqcvfeGLklSoWynulcJTEGQAc7Srn
Z2jtvLie+I3wG76GePU01E06hCofnY42vBZcwhb/59f54FApKXzsr6MJ6KE0K0wy
YNtJ6RSZzh4VsJEhVJVnqGSMFFZhDWMY8nWPFILWsaeI7VR0pEJTFXBqKX14YGqR
Hc7bxRFOanGV0M5y9nLNArYmdZxunnh8DLlnZQB8k0enib1paIuMizNcHpMWGs06
yFyP+mDZn4dSsd1U1pKK8VCCpH3lSgOJ/FyDTNSfjQfZ+YAhyMIJWIMpCcVcL71E
xb2RRYhBrS7H2LwqbyiH2dfDst912lQ65XBBpsL1vqmdql8z2qVB4U/w0AlhpOLA
W4ssUqbxms6cDHjek0aB43w2epNzpPTTBMBo0m0d/mC2M5LLioA=
=lhfM
-----END PGP SIGNATURE-----

--imvbibneuyogpynj--
