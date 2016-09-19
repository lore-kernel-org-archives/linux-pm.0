From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: reset: zx-reboot: Unmap region obtained by
 of_iomap
Date: Mon, 19 Sep 2016 21:26:04 +0200
Message-ID: <20160919192603.gwandp2jkta6q4ei@earth>
References: <57d92f28.8796620a.e4584.df58@mx.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3pgxgkwpyxy52whr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752028AbcIST0L (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Sep 2016 15:26:11 -0400
Content-Disposition: inline
In-Reply-To: <57d92f28.8796620a.e4584.df58@mx.google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: arvind.yadav.cs@gmail.com
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--3pgxgkwpyxy52whr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 14, 2016 at 04:35:31PM +0530, arvind.yadav.cs@gmail.com wrote:
> From: Arvind Yadav <arvind.yadav.cs@gmail.com>
>=20
> Free memory mapping, if probe is not successful.
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Thanks, queued.

-- Sebastian

--3pgxgkwpyxy52whr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX4DvLAAoJENju1/PIO/qaP6EQAJl/pK/cg/zxWTNTHu1gEm1A
RD3gFvSlwj2vDlVMEdtIkg4p+3N2BkwUDLx+B7Suq8WpSxdaYZjh0VsDOiJQX2Gb
nEs4XpqwBlNtWPOAe/XTkeHo7v4dx8Dtl7x7go6fhR92Xszg7m8if7ZHVsUrBqwu
FlCY2vfPb6H/+ZZ3+odcw6fUlU+K/SfwekHkGLWqfyRMfQ51/eWArkYvWpaNTNv7
7TNjMdO8VwrgXaOuUMA8l6ww1j1gQokrvidRwbE8ssjbpEci+fRcoQ7/GfAkp7MK
kkw+1KqWd79gUrbcT1Ao/pLBBrONm5igX9ZV2RJ/xr8UwpDjtOfnw/ZUiuSm+iFS
GweBBtrQWo3SXCpURHNGgHFIz0yb1nu4EDwVH9KOynG3b7gFdHo0Fs77QUb9VUPV
AZK2qgM5rlpo1aU4NQc6WD+/gLC9oatQa29cYqkk6kBgfy0mvu8KoD7QwaOmQnm0
bTHFzRDDvGaqegNRUNMyMK4cjkb8FF9R69TXMCBwvIj1eJPg/EYiOwPk82GjVWC7
MKz2/R7gRNim9UrrnI52tGPvbwwzAkyzaht90zvvR3v8icSp0JkbC1rvcdZrC7nH
DRGbir2aCmd313WSOGm7KQo9JUjQoljmOboCfXWPV1hPkPN+TM2rXAykOxYvSHwA
9cmhlEQo18KUsLhq4Ebh
=h6EL
-----END PGP SIGNATURE-----

--3pgxgkwpyxy52whr--
