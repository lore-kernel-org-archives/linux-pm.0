From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: lp8788-charger: initialize boolean 'found'
Date: Thu, 3 Mar 2016 15:19:54 +0100
Message-ID: <20160303141954.GB29689@earth>
References: <1456577651-5644-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456577651-5644-1-git-send-email-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Milo Kim <milo.kim@ti.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 27, 2016 at 12:54:11PM +0000, Colin King wrote:
> The boolean 'found' is not initialized and hence garbage. It should
> be initialized as false.
>=20
> Found with static analysis using CoverityScan

Thanks, queued.

-- Sebastian

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW2EgKAAoJENju1/PIO/qaMhkQAKIFkwuTl+GUR/5ajeQg37Mi
RqEeoysl3dedBkLFLSzehvC3Pz0YplGBPiGKmiZ6cmSrpI8j3uI3Fp2rKGBr+liU
740W6BIAg7DbNuAyQmAX0CxcNBgnBGiPWs4tkBQFdXOeUNUhnpdy0kLWGe440h6k
q83AaqjtguzxnM+/63w2KFiNhNdoWkmMkL43yIfFIepwTnqj+qUJ4SsUSSmDZzrN
+6ipF+x4/rJpPDNqjDBTjok4g5pL8w7+yCcwOdKjl0YV/htxC2RFjwbRgjdHXt/t
BOdUSr2hKVKi7Vtjvs/GorSjREjEfcok4ZzsDsfMbnqLdLhWrP0+7hdQmtOgZv/e
LdknsNWYddxVE+l+ck0mh+pscunRVDJ4z8zIgRpUew8/so5v7aOaWvcg/NXC5Zb0
S7KBvUl6miXByJQD1W5OKItqPko6nJDw2mZYaVA0XjTNHiec2la9i3j605DaSjLg
OYXET25WBX1XTbPKuWawpU4pPhB/W7MwemRAj2+gfWuE3bmcHWYjzYEjWjzf8HUt
WjMiWy1fHZKojRJw7Y694o4m1iAr/5jGQAFVDbkCxU4hWvvYYPHNTiw0PG2CXLNh
lQ3DSjzFyK5f+ZZJ2lrMPzbOHm1fnJPoijW1KcG8366HaSX8qE3xyS64zfAiRtbp
05KH5bqChEl2vThJ6Q+r
=yzsy
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
