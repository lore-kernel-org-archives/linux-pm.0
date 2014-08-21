From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/9] ARM: zynq: PM: Enable A9 internal clock gating feature
Date: Thu, 21 Aug 2014 14:19:51 +0200
Message-ID: <26994133-6c3c-45c0-af09-3cb55ad35b13@BY2FFO11FD028.protection.gbl>
References: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com>
 <1408567315-28479-2-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="u9B6IdofbnURCF0hptOP8LLwkN7nPivIW"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1408567315-28479-2-git-send-email-soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--u9B6IdofbnURCF0hptOP8LLwkN7nPivIW
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/20/2014 10:41 PM, Soren Brinkmann wrote:
> Signed-off-by: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/mach-zynq/common.c  |  6 ++++++
>  arch/arm/mach-zynq/common.h  | 11 +++++++++++
>  arch/arm/mach-zynq/platsmp.c |  9 +++++++++
>  3 files changed, 26 insertions(+)
>=20
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 31a6fa40ba37..3cb7c198615a 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -98,6 +98,11 @@ static int __init zynq_get_revision(void)
>  	return revision;
>  }
> =20
> +static void __init zynq_init_late(void)
> +{
> +	zynq_core_pm_init();
> +}
> +
>  /**
>   * zynq_init_machine - System specific initialization, intended to be
>   *		       called from board specific initialization.
> @@ -204,6 +209,7 @@ DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Platfor=
m")
>  	.map_io		=3D zynq_map_io,
>  	.init_irq	=3D zynq_irq_init,
>  	.init_machine	=3D zynq_init_machine,
> +	.init_late	=3D zynq_init_late,
>  	.init_time	=3D zynq_timer_init,
>  	.dt_compat	=3D zynq_dt_match,
>  	.reserve	=3D zynq_memory_init,
> diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
> index f652f0a884a6..596ef0b5067c 100644
> --- a/arch/arm/mach-zynq/common.h
> +++ b/arch/arm/mach-zynq/common.h
> @@ -40,4 +40,15 @@ extern void __iomem *zynq_scu_base;
>  /* Hotplug */
>  extern void zynq_platform_cpu_die(unsigned int cpu);
> =20
> +static inline void zynq_core_pm_init(void)
> +{
> +	/* A9 clock gating */
> +	asm volatile ("mrc  p15, 0, r12, c15, c0, 0\n"
> +		      "orr  r12, r12, #1\n"
> +		      "mcr  p15, 0, r12, c15, c0, 0\n"
> +		      : /* no outputs */
> +		      : /* no inputs */
> +		      : "r12");
> +}
> +
>  #endif
> diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.=
c
> index abc82ef085c1..616b99e07c60 100644
> --- a/arch/arm/mach-zynq/platsmp.c
> +++ b/arch/arm/mach-zynq/platsmp.c
> @@ -112,6 +112,14 @@ static void __init zynq_smp_prepare_cpus(unsigned =
int max_cpus)
>  	scu_enable(zynq_scu_base);
>  }
> =20
> +/*
> + * This function is in the hotplug path. Don't move it into the init s=
ection!!
> + */

Worth to use kernel-doc format here.

Thanks,
Michal


--u9B6IdofbnURCF0hptOP8LLwkN7nPivIW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlP14+cACgkQykllyylKDCF06wCaAxSiK5U5pSBIg7xsHPvP+Epq
OykAoJETtPKdaaopxOSH4si8TSQ/Hkid
=7ib3
-----END PGP SIGNATURE-----

--u9B6IdofbnURCF0hptOP8LLwkN7nPivIW--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
