From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 1/5] dt-bindings: power: Add battery types
Date: Wed, 2 Aug 2017 13:38:20 +0200
Message-ID: <20170802113820.GA2765@amd>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-2-git-send-email-marek.belisko@open-nandra.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501620926-22669-2-git-send-email-marek.belisko@open-nandra.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek.belisko@open-nandra.com>
Cc: sre@kernel.org, robh+dt@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-pm@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-08-01 22:55:22, Marek Belisko wrote:
> From: Marek Belisko <marek.belisko@gmail.com>
>=20
> Signed-off-by: Marek Belisko <marek.belisko@gmail.com>
> ---
>  include/dt-bindings/power/power.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 include/dt-bindings/power/power.h
>=20
> diff --git a/include/dt-bindings/power/power.h b/include/dt-bindings/powe=
r/power.h
> new file mode 100644
> index 0000000..ea36d7f
> --- /dev/null
> +++ b/include/dt-bindings/power/power.h
> @@ -0,0 +1,11 @@
> +#ifndef _DT_BINDINGS_POWER_H
> +#define _DT_BINDINGS_POWER_H
> +
> +#define POWER_SUPPLY_TECHNOLOGY_NiMH 1
> +#define POWER_SUPPLY_TECHNOLOGY_LION 2

Nice animal :-), but I guess this should be "LiION" or something.

> +#define POWER_SUPPLY_TECHNOLOGY_LIPO 3

Make it "LiPo" for consistency.

There's no differnce between Li-ion and Li-Po from the software side,
AFAICT, but I guess we can keep both..

> +#define POWER_SUPPLY_TECHNOLOGY_LiFe 4
> +#define POWER_SUPPLY_TECHNOLOGY_NiCd 5
> +#define POWER_SUPPLY_TECHNOLOGY_LiMn 6
> +
> +#endif /* _DT_BINDINGS_POWER_H */

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmBuawACgkQMOfwapXb+vIg2wCfYL98nQeICF78MuleooLt2SjE
iH8An0NfgWelHvr9f65RbC7aicj3WUc9
=MoxA
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
