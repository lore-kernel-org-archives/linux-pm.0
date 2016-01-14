From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 06/16] soc: tegra: pmc: Wait for powergate state to
 change
Date: Thu, 14 Jan 2016 15:01:05 +0100
Message-ID: <20160114140105.GB23082@ulmo>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-7-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449241037-22193-7-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2015 at 02:57:07PM +0000, Jon Hunter wrote:
> Currently, the function tegra_powergate_set() simply sets the desired
> powergate state but does not wait for the state to change. In most cases
> we should wait for the state to change before proceeding. Currently, there
> is a case for tegra114 and tegra124 devices where we do not wait when
> starting the secondary CPU as this is not necessary. However, this is only
> done at boot time and so waiting here will only have a small impact on bo=
ot
> time. Therefore, update tegra_powergate_set() to wait when setting the
> powergate.
>=20
> By adding this feature, we can also eliminate the polling loop from
> tegra30_boot_secondary().
>=20
> A macro has also been adding for checking the status of the powergate and

"added"

> so update the tegra_powergate_is_powered() to use this macro as well.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/mach-tegra/platsmp.c | 16 +++-------------
>  drivers/soc/tegra/pmc.c       | 21 +++++++++++++++------
>  2 files changed, 18 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> index b45086666648..40cb761e7c95 100644
> --- a/arch/arm/mach-tegra/platsmp.c
> +++ b/arch/arm/mach-tegra/platsmp.c
> @@ -108,19 +108,9 @@ static int tegra30_boot_secondary(unsigned int cpu, =
struct task_struct *idle)
>  	 * be un-gated by un-toggling the power gate register
>  	 * manually.
>  	 */
> -	if (!tegra_pmc_cpu_is_powered(cpu)) {
> -		ret =3D tegra_pmc_cpu_power_on(cpu);
> -		if (ret)
> -			return ret;
> -
> -		/* Wait for the power to come up. */
> -		timeout =3D jiffies + msecs_to_jiffies(100);
> -		while (!tegra_pmc_cpu_is_powered(cpu)) {
> -			if (time_after(jiffies, timeout))
> -				return -ETIMEDOUT;
> -			udelay(10);
> -		}
> -	}
> +	ret =3D tegra_pmc_cpu_power_on(cpu);
> +	if (ret)
> +		return ret;
> =20
>  remove_clamps:
>  	/* CPU partition is powered. Enable the CPU clock. */

I vaguely remember this being very brittle. I assume you've tested this
extensively and made sure it doesn't regress?

> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index fdd1a8d0940f..f94d970089ce 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -28,6 +28,7 @@
>  #include <linux/export.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
> @@ -101,6 +102,8 @@
> =20
>  #define GPU_RG_CNTRL			0x2d4
> =20
> +#define PMC_PWRGATE_STATE(status, id)	((status & BIT(id)) !=3D 0)
> +

This looks suspiciously like a register or register field definition.
Maybe turn this into a static inline function, such as:

	static inline bool tegra_powergate_state(u32 status, int id)
	{
		return (status & BIT(id)) !=3D 0;
	}

?

>  struct tegra_pmc_soc {
>  	unsigned int num_powergates;
>  	const char *const *powergates;
> @@ -181,22 +184,27 @@ static void tegra_pmc_writel(u32 value, unsigned lo=
ng offset)
>   */
>  static int tegra_powergate_set(int id, bool new_state)
>  {
> -	bool status;
> +	u32 status;
> +	int err =3D 0;

Initialization to 0 doesn't seem necessary here.

Thierry

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWl6ofAAoJEN0jrNd/PrOhtnoQAIexe7X0xQiIpYROJ1NOJdBn
8ve6SAuq9EEuDk3MQhe8OCkLhEH2p2tNMr2we+I+DEfRKon5dYLf6kfCQsXHGBcO
hiVWCTWWGVawYrs44Ce6uPFJV3GThRqv0jB3yZGPsFP74IT4xTKwmTz4BhUG9kpd
ecVYPTwHT/2tdfX6Y3RM0CsRUkc0pgsGlIQlV4hUlRw7nIIaWNfYov5iwvYRh7Oz
kr8Pi49o9YLROvFEUH6kdiTq6pOY9/eI7nnfRx8cETwGm08REygJaxd9PQ2u3Roh
tNpLrJjCae7gDgn4CI+lefOfHrKiqyvOZlWJvq42FuDICiwlDH5Ww5jinitKVlmX
BfjJCQZkrG87ixlkCI+FEaBflukAJk1KZIDxb6n6BEKNowpYHHfngF9NLJ557W/B
Tw3NqarYNC+1m0FkOlLYshecW5fOEN0K0f3GW8L2P+8qUDzBZK1PvHZG/+Ll5FJd
1Xx0pombKg+yTWfTqRI0+TFK/ckAUp1a9TyTq9pIAQwTBD2w1GEu4qW4K/a0qm6p
6djQovB4PWv1b9OUeoXLxspCsDlN3uVDpyk6XdJFp+FsGLJf17if0NB92pZocO53
w+uJr0mpv2eJj4u2a/NjgI9GbWwDhNmKzZdFd5HjxJrHctaLB59Loxhuzu9akC0W
1gSlirSmNrgiybFqsMIq
=4EzA
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
