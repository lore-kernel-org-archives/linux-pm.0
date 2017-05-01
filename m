From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 1/2] power: supply: sbs-battery: Don't ignore the first
 external power change
Date: Mon, 1 May 2017 13:33:36 +0200
Message-ID: <20170501113336.hkfxzd2gohykbzxn@earth>
References: <20170425150905.4185-1-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pupy2y5thtiviljr"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170425150905.4185-1-contact-W9ppeneeCTY@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--pupy2y5thtiviljr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 25, 2017 at 05:09:04PM +0200, Paul Kocialkowski wrote:
> A mechanism to ignore the first external power change notification was
> put in place years ago to ignore the power_supply_register notification.
>=20
> However, this doesn't apply to the current situation anymore, as the
> first notification is always the result of a legitimate power change.
>=20
> This removes this deprecated mechanism, which puts back the driver's
> state machine to a sane state (an ignored first notification previously
> caused a charging/discharging status inversion).
>=20
> Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>

Thanks, queued.

-- Sebastian

--pupy2y5thtiviljr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHQ8ACgkQ2O7X88g7
+potcQ//YvCT52uJoJxO2Xe1G2nivcQaORk7lQX6Sh/c/J7zFbHl9QbDwpwwgJgM
32yWZSgCo5rCSkkXwAHOoOU48Ick4paYIXVRW7YFrKETloTWZ1x/1cJqgMcEc+ZN
WzyP712FJgUoA8OPcU9KKcXRtSwMJyTgvwGlkdbIsZJuKpcFwA1h5ZdLpFaVFzit
Y0oO5kmcKLfTSZ6Dwr90BiIpXsQZNC3kDjVVthPznCqouuHOr7+Z0PlCT5TBrbpc
Q9mceqegs/GDWqcauyPOoJi70QFo8SRL/xgKVvMrl+ZPw7jduL44c0Ci8Std/htA
Prs7JTP6JBtjQcQlea92ksql9TVZBrds/FKvGctwGqGhvFGLdUzt6VIY9KjhAko5
GfNdTphDd4Na/glE5I2t9l7u0STz3tKVF3vX+gJiMMwXw9kKIvRaAYTaJmihTyjn
cdsJim6VPaDLegiNd0G5awgmhoaTu1mO/pgAa6JtZ1M6RgCMx5uljm7/Pu3X2N9G
fovgktUJz24Vfm1tFuFqJzLckhyDA75ZtIIniJF8YwwsdEJk/xbxXvG3SiWnQGZT
V+cB54VdtN/HMqtaCxb9tGuwzb8xl1wdLLAU3Tw2Vnm081XCZ8kqUdotXA4Qdnkc
aoUfcu7X1PpKkP8TeL3yhHUm/Tk50TmgZ/JdUNQC6kBwJcqimMM=
=i0/l
-----END PGP SIGNATURE-----

--pupy2y5thtiviljr--
