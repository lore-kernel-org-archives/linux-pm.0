From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 27/47] power/reset: vexpress-poweroff: Register with
 kernel poweroff handler
Date: Wed, 22 Oct 2014 23:34:19 +0200
Message-ID: <20141022213419.GF28840@earth.universe>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-28-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1413864783-3271-28-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
List-Id: linux-pm@vger.kernel.org


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 20, 2014 at 09:12:43PM -0700, Guenter Roeck wrote:
> Register with kernel poweroff handler instead of setting pm_power_off
> directly. Select default priority to reflect that the original code sets
> pm_power_off unconditionally.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUSCLbAAoJENju1/PIO/qaTX0P+gKJpo5aDxxAUnn4KI/IqQyY
2R9T+0SNxAN9Sv9JuMGQJpZGZxMaGFC96Hs/RCsCkMtFRsez7kemq8qoIObMGwDQ
5H/KH+a3oUy2avPWjMiOD0mdFNpeRVW28ayMifswhTaOlxWyMVVDKhk2IiEb+GNG
faKs92Yx+/xvMxcpMVsC3fGTjsCHCAnBj680IQKYGpZ3blU3JLwn4bFcM4x1pHSx
5b15DOZLHBidD3B9S27eQPa7wpGbQFOCk9s88/Txe+FExE4RsAUMN3cJwc+DsTm5
RScoCsw1llz4QqDjshQZvjKVdJSzdhVOantLVn6rmuxXCxBsgaT0XmsNffccTAey
m7iFj3Sq6JF1mSXtp0ycO/gQX6GxVeshcwaXES/C7hbAB7yFNJtVPyXEusHzioIf
ClwdLOpP/VimOUxo+JspHiat4WgpE+5zeaj/GPHZvG7LreKL8EZcX1WQsLU1sgJh
/Cq1DdN7L1tagmuVnbH08kEpTz0PHVczWRK68mxQD1zxOvr9VvQHvMtE1XSxO2yz
aZAku+4BbfvgtSvkV8FRhjAB43mts8KWSyh+R3rVqgAKdrYo9SmKR9jQxKhGf68h
2uZ5wupBPJqSWcGU2CVyUfLkaI/p7XyMbBivNOIHrSFIVaso9GSDmnl3Hv5y29EA
OTXpho1NPjzmp+6gveba
=EBNP
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
