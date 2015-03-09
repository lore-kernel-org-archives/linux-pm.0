From: 'Sebastian Reichel' <sre@kernel.org>
Subject: Re: [RFC 1/4] power_supply: Introduce charging object table
Date: Mon, 9 Mar 2015 15:08:32 +0100
Message-ID: <20150309140831.GA950@earth>
References: <20ADAB092842284E95860F279283C5642EEC90C3@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20ADAB092842284E95860F279283C5642EEC90C3@BGSMSX104.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Tc, Jenny" <jenny.tc@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, "jonghwa3.lee@samsung.com" <jonghwa3.lee@samsung.com>, "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>, "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
List-Id: linux-pm@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 09, 2015 at 12:26:21PM +0000, Tc, Jenny wrote:
> > > +	char name[PSY_MAX_BAT_NAME_LEN];
> >=20
> > char *name;
> >=20
> > No need for arbitrary length limitation.
>=20
> The length limitation is introduced to form a packed structure so that
> the data can be read directly from memory without parsing.

This reason is ok for a device driver, but not for a kernel
subsystem.

-- Sebastian

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU/alcAAoJENju1/PIO/qa+SUQAJCgptly6RlNIBGhFDzq/uPE
SOpGpEmsIx/ATSXOyzMNu5doYD/VA8xno1pZEGg1M8hwO/uIJiYV/okDjH9Ciz/N
Rh8Dod5pcMcSenYFxVuaQ4rO2gaUe4hTeCiL0Y94wOKz4mXvFQmKIwH2wCgKJj1n
8qtJQYhWoKS/8wFhbE/Wknp9t4SyBCbZaW0NarreFovbtrMZBTbmcnjT97cVUZDR
NYvc6O+zmIxi6FoJZ6oxYoe0NinAgzZQ2BbG0UAn4Di9bbPgb5nJsgaDruR9+HXJ
Cnm5XReZWldz6ayVX5rSUOzA6ggi5UxH/GIIJkmdpC7V+/i9KYQivxfm0/6kojKw
DfYZoKCRwrB4hRLvEJq+3INRtaS5nDHCSmRBeDTutXavkHrUyVHtUiqtGXEvexdR
wYWKG4o33wRO1GTfVydJNou8j5DDAa202j9qQ0L58xIZmIzZB4mk5xO045rek9MZ
o56Stm4+ZhWg2EVkml3ocB4I1XqKu+JOtTD4z7YC94CpIaLyFn5mxdlrbB1cIiRy
fkPv0p2qlLNjZO+n9NWeXDeMX/xZfVOZU3v13D13imiGk3isZENLEgOEI7ucIyOI
vKddeCU3N0LdpVDncwo2FpWv3pK6oqMdmvoq+KJtCCF8ZFbCzTuGYSJhNeCOK3oU
PoMkMLl6OSEIcvupg4x4
=KLad
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
