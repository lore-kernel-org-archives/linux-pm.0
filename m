From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: config SOC_DRA7XX?
Date: Mon, 15 Jul 2013 07:37:45 -0400
Message-ID: <51E3DF09.4070109@ti.com>
References: <1373813686.1370.55.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2TMCWTAIEVBPORIITNKLP"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41276 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755765Ab3GOLh5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Jul 2013 07:37:57 -0400
In-Reply-To: <1373813686.1370.55.camel@x61.thuisdomein>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org

------enig2TMCWTAIEVBPORIITNKLP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On 14-07-2013 10:54, Paul Bolle wrote:
> 0) Mainline commit 8926fa4f9b6160b1953ca44852d6044b58a829e1 ("thermal:
> ti-soc-thermal: add thermal data for DRA752 chips") added a Kconfig
> entry for DRA752_THERMAL.
>=20
> 1) That symbol depends on SOC_DRA7XX. But SOC_DRA7XX doesn't exist. Thi=
s
> means that currently the code depending on DRA752_THERMAL can't be
> build.
>=20
> 2) Why is this dependency on SOC_DRA7XX needed? And what would
> SOC_DRA7XX actually be? Some searches on the web returned nothing that
> could show me what it is.

That is the config which says the kernel has the support for the DRA7XX
soc family. The core support didnt make for 3.11. But I had already sent
this code for review and merge by then. The core code can be seen here:
git://github.com/rrnayak/linux.git for-3.12/dra-core-data

for instance.

>=20
>=20
> Paul Bolle
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2TMCWTAIEVBPORIITNKLP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHj3w4ACgkQCXcVR3XQvP09zgEAjIE/d/fB2fq73oSKnsO9Z0/j
1VvmAhEe/pbfrijb9DMA/RarqWpLlo+K6QbThJvZwDubYCJORJA+6WmBhlzCBQIM
=/Z2G
-----END PGP SIGNATURE-----

------enig2TMCWTAIEVBPORIITNKLP--
