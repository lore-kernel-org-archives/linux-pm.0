From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH -next] power: supply: ltc3651-charger: Fix wrong pointer
 passed to PTR_ERR()
Date: Wed, 7 Jun 2017 22:16:21 +0200
Message-ID: <20170607201621.bmovt25hqo2s7udu@earth>
References: <20170517121132.7052-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vrzbz5l3rtpiiimt"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbdFGUQ0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jun 2017 16:16:26 -0400
Content-Disposition: inline
In-Reply-To: <20170517121132.7052-1-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, linux-pm@vger.kernel.org


--vrzbz5l3rtpiiimt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 17, 2017 at 12:11:32PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> PTR_ERR should access the value just tested by IS_ERR, otherwise
> the wrong error code will be returned.

I queued the same patch from Dan, which had the better description
incl. a Fixes, but added your Signed-off-by.

-- Sebastian

--vrzbz5l3rtpiiimt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk4XxUACgkQ2O7X88g7
+pqhXw/+PxUg6mGxQpeQ6zla6lJb4J7Cbnue4CR5F4iU9TAViC6MrIo5P9spgM35
c+cqj0i1SYbacZaeRSxSC4cZHl48J9n1fNPLiInK/XXc8WfGry0TWKoHVy1LH2YO
RBZXOL4rlDVcFnTj5cNILkFEq2NiS6GfiuGTVucAc4qoNGqVg/EU+K5z6EqTN0d7
3qymGstezOdXZcz/j4kjLhZvr/icdIt0r/FNABtIt49tOUYwwvvUvik8Kuicr/UI
oV2CMgAcNi8KUfYFOKb2N3mTC4n15b8NouhdfoQJ4lAFvzLtkHbKbyB354uXHBs5
vKvxiT1o+bF307K6RZ1Lu6ELKBCDvrUJowpwhdX1E43nvoNnLAdXiN1DVP+kXzyB
334VwsXqjcwElW/TI4BIVZbeSpKbo91AWAGWuCknP2CH2jNb1DbqzFzl68JYvWlR
u1CsfL15LIXBSvILDTHwPMuNoT9whkN/DDytBwbz6tX1mQvRh9jJMmX2iFgSo6xx
WpIBHl5ELEnO2XA4rMnVFmuqrJGfVwkFmHoQR/hlO/ZBNPEG5pMg6MRBGfJAzGw9
RAIzLG6Iuglf+XQLEMTDHuAbqWG1jtj0/OCi4jYTcw31xxMF04o29IzofAsi/rwm
HpvYQyjLTh4pZ4pJKVlr67oeJXD3/8Jca+VGQP0t31SmV7xhqug=
=35ta
-----END PGP SIGNATURE-----

--vrzbz5l3rtpiiimt--
