From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [patch] power: bq27xxx_battery: signedness bug in
 bq27xxx_battery_read_health()
Date: Mon, 28 Sep 2015 18:33:05 +0200
Message-ID: <20150928163304.GB3660@earth>
References: <20150928091653.GA11367@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150928091653.GA11367@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 28, 2015 at 12:16:53PM +0300, Dan Carpenter wrote:
> We need flags to be signed for the error handling to work.
>=20
> Fixes: 74aab849f342 ('power: bq27xxx_battery: Cleanup health checking')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, Andrzej Hajda was slightly fast than you, so I merged his
patch instead. I merged some of your patch description into his
patch, though.

-- Sebastian

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWCWu9AAoJENju1/PIO/qa+m4QAJdqsn+LJmXqQ3apuroL7BM6
BEpSlar3uK9qcrqwLFLTMKoxkG4jmgF1O0toyQOyLhSvJrLLTYzEfiH+4EmnwXy5
Sa08cA7hLrLin6LBi2YZHb6HWLx4dJ2CIHJY8T9HhSW2p3c7uIKBRuqKjKSXPqe5
v9Ehde/ScMeeD0un+YO7y/2z5Px61x21yVsMvhupRbwCiu55MYsN3za/CI+3dZPf
V/eZTqNT++Yk8JvMwyjAu6DM2AO/zxKWCKd3QbshvrpZTFSOSgvkXMA02d4CUiMV
HahOS0sCoRe2e+CA5KhyG360yJ+WC+r4x+AsdCvIcq960x4obGawXwzsKInH4U91
z2/sOVK7ztl19/nfbqhlDuPrgkmWyzQrBUA9QgsUOcSDVjWZzGGm5vcfoqHPjS3/
awtJmBy6wssuvtlHq7+PWHpCxXd6xYBoCNpZoFr5CS1erAjopqjp7KjDqDjZEAXW
y20O3z1+beNMNLclZ+fhHLfFdPUuriL+NR83vQXkXYWaM+y3AIRh7jpS70JwpBCm
IEdZ7pxrox5tOAXTgOJ/kzsn0N8lOYSnjswHBQLtVl86iVMbcOZlqQhzZXg4bUdO
eykuVuZpaHCHlOucGC8b3sTA6XvyST7vNAgM36mQWw+bZABSj0MelAOpXQQaLJwG
S5aAnZ7Eu3cK+gb6TWSk
=g37v
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
