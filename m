From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] MAINTAINERS: Remove power-supply co-maintainers
Date: Wed, 31 Aug 2016 16:28:37 +0200
Message-ID: <20160831142837.x7mtcdhz4o6ce4f3@earth>
References: <1471440001-10423-1-git-send-email-sre@kernel.org>
 <1471440001-10423-2-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tewehu7w4sh3md62"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934861AbcHaO2m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Aug 2016 10:28:42 -0400
Content-Disposition: inline
In-Reply-To: <1471440001-10423-2-git-send-email-sre@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--tewehu7w4sh3md62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 17, 2016 at 03:20:01PM +0200, Sebastian Reichel wrote:
> This documents the status quo and keeps everyones
> cc/to-list a bit shorter.
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/CREDITS b/CREDITS
> index 2a3fbcd229e6..af13d1d2f4fb 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -1090,6 +1090,10 @@ S: 6350 Stoneridge Mall Road
>  S: Pleasanton, CA 94588
>  S: USA
> =20
> +N: Dmitry Eremin-Solenikov
> +E: dbaryshkov@gmail.com
> +D: Power Supply Maintainer from v3.14 - v3.15
> +
>  N: Doug Evans
>  E: dje@cygnus.com
>  D: Wrote Xenix FS (part of standard kernel since 0.99.15)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 923b138836b9..9074e68baa47 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9326,8 +9326,6 @@ F:	drivers/powercap/
> =20
>  POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
>  M:	Sebastian Reichel <sre@kernel.org>
> -M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> -M:	David Woodhouse <dwmw2@infradead.org>
>  L:	linux-pm@vger.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-sup=
ply.git
>  S:	Maintained
> @@ -11329,8 +11327,6 @@ F:	drivers/mfd/syscon.c
> =20
>  SYSTEM RESET/SHUTDOWN DRIVERS
>  M:	Sebastian Reichel <sre@kernel.org>
> -M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> -M:	David Woodhouse <dwmw2@infradead.org>
>  L:	linux-pm@vger.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-sup=
ply.git
>  S:	Maintained

queued into power-supply's for-next branch.

-- Sebastian

--tewehu7w4sh3md62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXxumVAAoJENju1/PIO/qaCukQAJkjoirNJGqTRZ9zHfGySNoz
0Pw18uyKWU4hKg1JQt+y3dxC6n6y2Ijcy/yozLYdsyRyeBCnCZiciiTe53zDNijf
Xayr0hLEvCpyzi8OheNcfE4cji+8z3yGOvViBC0xbEBerD93pOuOK2E2ZuWAuwws
h1XGr9i37U+9U80cTG2rqvk/r22lvCdGN/Hk+nDlFGoNs6/AMyqFxWiH99OD9NPf
vW+d6iH7sn+VObHqTzGoHZiMboLcIi5Wpnc5e0bnEH6D+gaHhJHvvs7KkRorf4uv
nKODTa305nzI7tRVoIN/8uFNoTYjjJdeW1UXQC8SjcWhUyS7PiThM7wJnHvlnkXN
KSS8+L3CMlnCfejnNfZovhQ6qfmsr+FBB5F0G6cMw4zFfTqbrgSKrhb49Xor1ZL5
IbQtks0AQX7PNDhULfn6Q2oXw4GXIyCnpBbSnZ1R3swxMXTweExci8kZvOz1gPu4
QId5Sr1KMcqHh0lcdRUvZneWlayPMWb4yCDQ45va5t5/nulgrRrrbwXjh5v6yNlk
bqr55p8wWSW6DS62xEzuSAVsB1w7K7H4jQgAomOHRgA/TQC/pkrmABlsF3WVGlau
aZey7NV6ZIeYCLYi2Xn11RVWWWozzWvt91KdgytZvwsV+L6zOo3CX4TYRfZwG/vT
Tm97s5SHc5uNTG5O9/HG
=apjy
-----END PGP SIGNATURE-----

--tewehu7w4sh3md62--
