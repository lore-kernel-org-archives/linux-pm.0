From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 1/5] dt-bindings: power: Add battery types
Date: Wed, 2 Aug 2017 13:43:04 +0200
Message-ID: <20170802114304.GB2765@amd>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-2-git-send-email-marek.belisko@open-nandra.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51699 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbdHBLnG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Aug 2017 07:43:06 -0400
Content-Disposition: inline
In-Reply-To: <1501620926-22669-2-git-send-email-marek.belisko@open-nandra.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Belisko <marek.belisko@open-nandra.com>
Cc: sre@kernel.org, robh+dt@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek.belisko@gmail.com>


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

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
> +#define POWER_SUPPLY_TECHNOLOGY_LIPO 3
> +#define POWER_SUPPLY_TECHNOLOGY_LiFe 4

Actually I'd add comments here, such as "/* LiFePO4 */, because
otherwise it is a bit ambiguous.

> +#define POWER_SUPPLY_TECHNOLOGY_NiCd 5
> +#define POWER_SUPPLY_TECHNOLOGY_LiMn 6
> +
> +#endif /* _DT_BINDINGS_POWER_H */

The rest of series is ok, you can add

Acked-by: Pavel Machek <pavel@ucw.cz>

, but I guess someone would want a little more verbose changelogs.

BTW what hardware are you working with?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmBusgACgkQMOfwapXb+vLr3QCgrkkhOd8aSFo+4I3+QsBcKwIJ
1a0An1Vh67BNyYLS3k4QCSC8mvrjafoH
=jF+n
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
