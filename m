From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] cpupower: Use conventional shared library versioning
Date: Wed, 15 Jun 2016 12:13:33 +0100
Message-ID: <1465989213.3529.264.camel@decadent.org.uk>
References: <20160610010554.GR7555@decadent.org.uk>
	 <2753168.d7n2N2ZaIy@skinner>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-O0G4sHjsZDIUEneG4M42"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:57155 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752575AbcFOLNn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 07:13:43 -0400
In-Reply-To: <2753168.d7n2N2ZaIy@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pm@vger.kernel.org


--=-O0G4sHjsZDIUEneG4M42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2016-06-15 at 13:03 +0200, Thomas Renninger wrote:
> Hi Ben,
>=20
> On Friday, June 10, 2016 02:05:54 AM Ben Hutchings wrote:
> > The current choice of variable names is rather confusing.=C2=A0=C2=A0LI=
B_MIN is
> > used for the soname version, which would normally be the *major* part
> > of the version.
> >=20
> > - Rename LIB_MAJ (the full version) to LIB_VER and LIB_MIN (the soname
> > =C2=A0 version) to LIB_SONAME_VER
> > - Define LIB_SONAME_VER to be the first component of LIB_VER
> > - Bump the full version to 1.0.0, since the soname version is currently=
 1
>=20
> I am currently working on adding rapl/powercapping things into
> cpupower.
> I will collect/integrate your patches and send them altogether.

The ABI break has already happened, so changing the soname version is a
bug fix that should go into 4.7. =C2=A0But I agree this second patch doesn'=
t
need to.

Ben.

--=20
Ben Hutchings
Reality is just a crutch for people who can't handle science fiction.

--=-O0G4sHjsZDIUEneG4M42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXYThdAAoJEOe/yOyVhhEJQ1QQAJqobIh6+u+8Uc69pDvgVwyy
xeSHF/SRfMODQyyiLlVHbUd6qvLwW3ltVHxsziuqTbskMX/j61I6YAFmK3ohdhDZ
H6VrhPK77yMolQAZ/UnKSrI45rIgYQ7hBtDXvlbvqW5FE519aLSrCOInVBK9iDxO
Y+Q864lvfZOci4gwxFhbTWus6ub4iah669k2Ot0v4V72KtCHVdgfM+bUsYsC527r
H30F5GJVdNXjXfQcmNh6PqnihqpprfcG5ZqZlMy3bnza6s8ncE1baAevbqKRiEAz
k2TsHgwqe8HpBLJMNdxGD9ACAPDLGszTLS0YKzSnmW1n1LuiQ3kCAPrUvyNgoAtS
dW0gZogo89a/Wnk2zdq7ptmzKMy2maFhDP0pLUEF5gQ59fwzystd/gsC4Ve0i/vl
hUyW1DIOe8DqbIBXKmRVoBuFpVTXliZvWACpdheUZQiCwsIK0GK7z9H7tCiKBfa2
/N2f6IZ8m+vMX9a5xqxP9IL7RbG/0b191XBVpoFZcOXbFnJHxbuPkoMkfwcmMr08
BAtfrvLEfEWJKPDrTT2paBmUMuVgzLLPWa+nY9muK144OmCkHMRMbRRHEZx0aj0e
Eq98Dw4CTjQ09AmTQRdbX11VDtKYxGXVzIWhPX9TN0FL4/oZCNaddbA+zE3o7zrJ
qTxPhG5iOLmIM/qtYCZ2
=nSB/
-----END PGP SIGNATURE-----

--=-O0G4sHjsZDIUEneG4M42--
