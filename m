From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: reset: zx-reboot: put device node in
 zx_reboot_probe()
Date: Fri, 6 Jul 2018 13:33:22 +0200
Message-ID: <20180706113322.xrei7gcd4577rbii@earth.universe>
References: <1527978125-29850-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rv4e66jnbo2gjkem"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1527978125-29850-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, Julia Lawall <julia.lawall@lip6.fr>, sil2review@lists.osadl.org
List-Id: linux-pm@vger.kernel.org


--rv4e66jnbo2gjkem
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 03, 2018 at 01:22:05AM +0300, Alexey Khoroshilov wrote:
> zx_reboot_probe() increments refcnt of zx296702-pcu device node by
> of_find_compatible_node() and leaves it undecremented on both
> successful and error paths.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---

Thanks, queued to power-supply-next.

-- Sebastian

--rv4e66jnbo2gjkem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/U4IACgkQ2O7X88g7
+pr1Qw/9FXdw7LKy4b4MijHs2cgryF73ws0u1GcPk+TfDHxkpCZiD6YmxNJ+D+UD
v6iwHVdQ0IAPDYfTCJuF4F7d7cEl3k/Bc9dfiKPeNnV/7V3SoeZPM7U18CVLW64n
zJyRdqAs3xFNaoZmqcH7AsHIffeXMZvnNcQPclwGr6wPDLjwMbYxU3Og6rb7abnh
XAWydAca2kE1NCd7imQa4Ic2IZLxjNx6brXoJ++YK5PhKhgk4qyTQ0YGbxAcrmUq
qpVNth75k+I84UX8LzI+TrmfBBwiTqLDUzyQ1W99U4GH42noK7qrtDBdvI/bVxWU
Nei2nBNalA8KJPKOPcCROEfocSy4OIbS0CzrsB8kJ80YdLeftj2YYeVe05xPEjKL
HRP30bptXbmm5eE7vcjfcU0Z3NaGMzB26Zsd6HSb3ScZoIOdIzdVwNHFS77nB8en
ydEijcVZzQ9QBebPRTiRMjAYNo/5sxWqs5CCVxcgp3lWIlM5nAFF7/bxKFz9Zmkx
6Qph7jU1G0Van2z+0sw2gWy/GapAAqf1oRgozaOAR0Lv2wuFU0PUxjUPDcoNqgYu
IlT+e22EBxuF+se5/gdHz507CEFOWQv1OVqmM17GEh7zqfjJ41uRvz0643uRitu/
XhLNpN9fAr/FM5Srt6PSluSFR+PDCFGpbxXUtGJ7HhQ1hqUVOsw=
=n80N
-----END PGP SIGNATURE-----

--rv4e66jnbo2gjkem--
