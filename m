From: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/2] Support to tune governor in run time
Date: Mon, 13 Jan 2014 11:42:20 -0400
Message-ID: <52D4095C.205@ti.com>
References: <1389611863-7812-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PVWO1MH0n8kHd1qE7deXxfR7bauWjWMi5"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389611863-7812-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: eduardo.valentin-l0cyMroinI0@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--PVWO1MH0n8kHd1qE7deXxfR7bauWjWMi5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wei,

Thanks for your patches. Please help me out to properly understand your
intentions here.

On 13-01-2014 07:17, Wei Ni wrote:
> This serie can support to turn governor for thermal zone in
> run time.

Can you please explain why this is needed? Are you facing troubles with
current way to switch governors? If yes, can you please report them?

> Adds avaiable_policies attribute, so the user can get available
> governor policies and change te governor to a new one.

OK. This one I understand the need and you are explaining its motivation.=


> Adds thermal_update_governor() function, so the thermal platform
> driver can use it to update governor.

Here I cannot see why the platform driver would need to update a
governor, instead of a zone. Platform drivers are not supposed to be
aware of governors. For updating a zone we already have an API for that,
please check documentation.

>=20
> Changes from v1:
> 1. split avaiable_policies part to the "patch 1/2", and add document
> for it.
> 2. add document for the thermal_update_governor.
>=20
> Wei Ni (2):
>   thermal: add available policies attribut
>   thermal: add interface to support tune governor in run-time
>=20
>  Documentation/thermal/sysfs-api.txt |   11 ++++
>  drivers/thermal/thermal_core.c      |  105 +++++++++++++++++++++++++++=
+++++---
>  include/linux/thermal.h             |   12 ++++
>  3 files changed, 119 insertions(+), 9 deletions(-)
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--PVWO1MH0n8kHd1qE7deXxfR7bauWjWMi5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLUCVwACgkQCXcVR3XQvP0f3QEA5ZJzBr65Eb43RpSwZZLlaMdD
AevoI6rTPdUHFuNQEJMBAJ6D8N53hzmFJ6G/EN2SNwFddcn0Ynno7NU9+De1Sw+L
=AdMO
-----END PGP SIGNATURE-----

--PVWO1MH0n8kHd1qE7deXxfR7bauWjWMi5--
