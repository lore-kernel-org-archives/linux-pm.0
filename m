From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] ab8500_fg: use jiffies_to_msecs for jiffies
 conversion
Date: Wed, 25 Feb 2015 22:51:55 +0100
Message-ID: <20150225215154.GM13695@earth>
References: <1423502465-31298-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iUV/lbBrmPtUT9dM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423502465-31298-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--iUV/lbBrmPtUT9dM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 09, 2015 at 12:21:05PM -0500, Nicholas Mc Guire wrote:
> Converting jiffies to milliseconds by "val * 1000 / HZ" is technically
> OK but jiffies_to_msecs(val) is the cleaner solution and handles all
> corner cases correctly. This is a minor API consolidation only and
> should make things more readable.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Thanks, applied to battery-2.6.git.

-- Sebastian

--iUV/lbBrmPtUT9dM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7kP6AAoJENju1/PIO/qaT+0P/2e2UCGc+teWVPW2whW3MiXR
hRtv9cNYAYwUK01jRSlnaEvuA1/Vr+R2p/BEQxZBJAspk2QMzCcEgCd06UWfzHyw
BdyiENKXdhSeYCEQy1ylOWZpGvET18E/CoH3VKXAveoh5D0eqAxb6ENAdFWZ2rhn
4eWP7Yvw56oCyh8gljsywX9ScNki1jyEMs2QFQBNqSzHTYWzZl049Agebocx33F9
qHKZgPQXj5bDgsYxhaS1RbH8BTYNWw1drazxpyWQ43TnGT6ett0Oh/wjRUgS39j3
sABSDELF2lbL3Tg01lrGpRtmh2wtmZW7ITrnYJN/yIubk9SC/FzADFtTqBV6m6iC
ZGxhOqNtk4fP7PWIo2ukQ7TDecih5TlWt+FhvAlhFGUGYTMAfNGG+xEsNWH4SUDi
0a5UmEL+/R9vyj9NaYmBfxSy0M4bqnldpExjqj2icLFA0FJTeLoImTDbM6hPkzCS
e91ItHeZA1j3z4oTBVx/HZZCkfII6Eg0ps4k2GSn4hIMaLXQG29truuEQx/pdEi9
EeR4tW6AXoCyjbsMDeF2ki7skee/s9D0UosEqlCnJrygsS1W7MishDd4iRMBmmmq
BT8H5AMGRy2IVUUAiRb4hhLnGu+041NOtgigfAxBbPavrYLvrAxOepoOfxTAK/EN
cfvmQQ0LHKlBM7MKi2UJ
=j8xq
-----END PGP SIGNATURE-----

--iUV/lbBrmPtUT9dM--
