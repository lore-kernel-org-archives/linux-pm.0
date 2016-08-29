From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] power: bq24735-charger: Assume not charging when
 charger is missing
Date: Mon, 29 Aug 2016 02:40:51 +0200
Message-ID: <20160829004050.qtyth34v6xijk5sx@earth>
References: <20160828173446.32728-1-contact@paulk.fr>
 <20160828173446.32728-2-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gggmw2kvrcrwmr4b"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160828173446.32728-2-contact-W9ppeneeCTY@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--gggmw2kvrcrwmr4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 28, 2016 at 07:34:46PM +0200, Paul Kocialkowski wrote:
> When the charger is missing (disconnected), it is safe to assume that
> the charger chip is no charging.
>=20
> This is especially relevant when a status GPIO is present and the
> charger is getting disconnected. bq24735_charger_is_charging will be
> triggered due to the interrupt then, it will attempt to read whether it
> is charging through i2c, which will fail as the charger is disconnected.
>=20
> This also fixes that specific issue.

Thanks, I queued this one into my for-next branch.

-- Sebastian

--gggmw2kvrcrwmr4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXw4SSAAoJENju1/PIO/qatrIQAKTe3GrxKQDDBCSX7Ax0Xvw9
Gk99WTVInwsDM0PhZmuuiA/pbz7HlNuYCqitiMfc39FaksSmHU3g9/EPRkIZTtPQ
E9wXHnLO/y/PbfzqIKi7/jTFXz9lY80ah5WF2UGjus/JnC/St8I4YKLLgLhr+rII
QqvPDhyoqUDM/K0pUbJw8UBzeVwG+UR1eYfeYwG+VHh6L4qXcQKoz15KUPn8eF/U
STIycPfMP4npqwPP32ldZpbUNvZq2zLcq0wAG0A8eerCZrJxqGz+kXL7AOCVgBxE
KzG6vlM/a48DxiA1P0KHtCceCn7WNiD6SarYrlgnQtkq4fi4eBeUrAuSuSmOkhYi
/eXBQ6DQhp9DMc0moJHeU7VzVJfVyq4Yoei7niHnIEWOWUkeUxCO0vFE5juqkLhL
tgj3TGnuBorIhkl+ylxNpXl039ck/9oS/gSl1OmhyhJfAaGT2BGE7PN3gFx8SCkc
3ekRIiebh8V0LQRvWhuEoCg47rCJ2WDk4OVIQsFT1YbzdlDyQ1zY5vJ2Nxa1d8x9
DNR335GO25gOxLcQzxBOnLtbSg/3gkts2moyzQJRdwGZadtkM+ZDW/pBVxSZAHvX
KC3ao5aAbwXCKky0sGi9DgLprHGJUtZOmArsVWeGbx+aoOlOrKziVbzWEdmlK0p5
4ObZ181K3Vq45rLEMVnt
=//OK
-----END PGP SIGNATURE-----

--gggmw2kvrcrwmr4b--
