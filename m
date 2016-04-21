From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: Re: [PATCH 1/8] cpufreq: berlin: Use generic platdev driver
Date: Thu, 21 Apr 2016 11:05:30 +0200
Message-ID: <20160421090530.GE3685@kwain>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
 <4be5e8c38aed34a4aae08db2cae39ca8ece54d29.1461228081.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:54389 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751767AbcDUJFm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 05:05:42 -0400
Content-Disposition: inline
In-Reply-To: <4be5e8c38aed34a4aae08db2cae39ca8ece54d29.1461228081.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, Antoine Tenart <antoine.tenart@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 21, 2016 at 02:13:47PM +0530, Viresh Kumar wrote:
> The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
> device now, reuse that and remove similar code from platform code.
>=20
> Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Thanks!

Antoine

> ---
>  arch/arm/mach-berlin/berlin.c        | 6 ------
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>  2 files changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
> index 25d73870ccca..ac181c6797ee 100644
> --- a/arch/arm/mach-berlin/berlin.c
> +++ b/arch/arm/mach-berlin/berlin.c
> @@ -18,11 +18,6 @@
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/mach/arch.h>
> =20
> -static void __init berlin_init_late(void)
> -{
> -	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> -}
> -
>  static const char * const berlin_dt_compat[] =3D {
>  	"marvell,berlin",
>  	NULL,
> @@ -30,7 +25,6 @@ static const char * const berlin_dt_compat[] =3D {
> =20
>  DT_MACHINE_START(BERLIN_DT, "Marvell Berlin")
>  	.dt_compat	=3D berlin_dt_compat,
> -	.init_late	=3D berlin_init_late,
>  	/*
>  	 * with DT probing for L2CCs, berlin_init_machine can be removed.
>  	 * Note: 88DE3005 (Armada 1500-mini) uses pl310 l2cc
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufr=
eq-dt-platdev.c
> index f2ae7ad99a3c..3b3e6804cf14 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -12,6 +12,8 @@
>  #include <linux/platform_device.h>
> =20
>  static const struct of_device_id machines[] =3D {
> +	{ .compatible =3D "marvell,berlin", },
> +
>  	{ .compatible =3D "samsung,exynos3250", },
>  	{ .compatible =3D "samsung,exynos4210", },
>  	{ .compatible =3D "samsung,exynos4212", },
> --=20
> 2.7.1.410.g6faf27b
>=20

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXGJfZAAoJEFxNi8it27zYC0EP/2iC4AcEmcdBEqxHLjh7bjdp
iXehVzUY2havwGIG0zJJnul76k+DdseERfGuay4VGu8zcEaxjoDwBAzHB1viwnpL
OhbKyQwgU5GcWnHnfgTS7Nq9sbhPesWfbemhyso40D5zuJVZaCnd4AtT/Lh8HWHS
HVaJB9EiOf1ksMAOZhVPjUNxYezEuiImTZwLfmQWoLWreC6qtoM+uGN38Y1vB8x2
jfK89PO0YTxzWro5lKzMWgCB6Opw05W7+AsgYQOhK3Bsra3OTPYcotCTgkrRAj2c
fbMghSyfz8FEYV6PFDkH8TP3fgzzrd7iDilJ3CYk5J1h2LBmwgVf+FhvGGMn0DSb
CNhASuqHzbXW3cmn5AJVXH0ac9sOQrRecCogwSzXuty7tKOTE1b2lvofW0o78/Vd
dxayR5skGwD5S8TWOTlTULJDmQqL2hiB/4mlJVZAVAK4XztCfZwW+xiG1SPNUmhf
N9NbUtfKXMpl5PaZbJ/UnusF2dnPuJXTSb4VMdwvg+r4SrcBQ4HL/+kW9oEioh5T
uo8jesn4co7aeLeh3HrCLk4Ex7z0qsVAKmA9mHqTQFc9bK36EOCl0CadhJoLVFP2
zTb+ZEh32IrVKO0oTPF01KBeoboyntg5Torv4k7hdS8XS2gIwlMCm4ZOxl+TjzgP
+XowDhteVetD8L158Gos
=Hb0k
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--
