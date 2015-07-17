From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 07/19] soc: tegra: pmc: Wait for powergate state to
 change
Date: Fri, 17 Jul 2015 12:17:00 +0200
Message-ID: <20150717101658.GK3057@ulmo>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-8-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XjbSsFHOHxvQpKib"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436791197-32358-8-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--XjbSsFHOHxvQpKib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2015 at 01:39:45PM +0100, Jon Hunter wrote:
> Currently, the function tegra_powergate_set() simply sets the desired
> powergate state but does not wait for the state to change. In some
> circumstances this can be desirable. However, in most cases we should
> wait for the state to change before proceeding. Therefore, add a
> parameter to tegra_powergate_set() to indicate whether we should wait
> for the state to change.
>=20
> By adding this feature, we can also eliminate the polling loop from
> tegra30_boot_secondary().
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/mach-tegra/platsmp.c | 18 ++++--------------
>  drivers/soc/tegra/pmc.c       | 29 +++++++++++++++++++++++------
>  include/soc/tegra/pmc.h       |  2 +-
>  3 files changed, 28 insertions(+), 21 deletions(-)
>=20
> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> index b45086666648..13982b5936c0 100644
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
> +	ret =3D tegra_pmc_cpu_power_on(cpu, true);
> +	if (ret)
> +		return ret;
> =20
>  remove_clamps:
>  	/* CPU partition is powered. Enable the CPU clock. */
> @@ -162,7 +152,7 @@ static int tegra114_boot_secondary(unsigned int cpu, =
struct task_struct *idle)
>  		 * also initial power state in flow controller. After that,
>  		 * the CPU's power state is maintained by flow controller.
>  		 */
> -		ret =3D tegra_pmc_cpu_power_on(cpu);
> +		ret =3D tegra_pmc_cpu_power_on(cpu, false);
>  	}
> =20
>  	return ret;
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 300f11e0c3bb..c0635bdd4ee3 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -175,9 +175,11 @@ static void tegra_pmc_writel(u32 value, unsigned lon=
g offset)
>   * @id: partition ID
>   * @new_state: new state of the partition

The comment here isn't updated.

>   */
> -static int tegra_powergate_set(int id, bool new_state)
> +static int tegra_powergate_set(int id, bool new_state, bool wait)

Can we please not chain boolean parameters, it makes the call sites
impossible to parse for humans. Instead, can we simply leave
tegra_powergate_set() as it is and add another function, such as
tegra_powergate_set_sync() or tegra_powergate_set_and_wait(), to achieve
the same? You may have to split out a tegra_powergate_set_unlocked() or
similar to make sure you get to keep the lock across both operations:

	static int tegra_powergate_set_unlocked(int id, bool new_state)
	{
		...
	}

	static int tegra_powergate_set(int id, bool new_state)
	{
		int err;

		mutex_lock(&pmc->powergates_lock);
		err =3D tegra_powergate_set_unlocked(id, new_state);
		mutex_unlock(&pmc->powergates_lock);

		return err;
	}

	/*
	 * Must be called with pmc->powergates_lock mutex held.
	 */
	static int tegra_powergate_wait(int id, bool new_state)
	{
		...
	}

	static int tegra_powergate_set_and_wait(int id, bool new_state)
	{
		int err;

		mutex_lock(&pmc->powergates_lock);

		err =3D tegra_powergate_set_unlocked(id, new_state);
		if (err < 0)
			goto unlock;

		err =3D tegra_powergate_wait(id, new_state);
		if (err < 0)
			goto unlock;

	unlock:
		mutex_unlock(&pmc->powergates_lock);
		return err;
	}

>  {
> +	unsigned long timeout;
>  	bool status;
> +	int ret =3D 0;
> =20
>  	mutex_lock(&pmc->powergates_lock);
> =20
> @@ -190,9 +192,23 @@ static int tegra_powergate_set(int id, bool new_stat=
e)
> =20
>  	tegra_pmc_writel(PWRGATE_TOGGLE_START | id, PWRGATE_TOGGLE);
> =20
> +	if (wait) {
> +		timeout =3D jiffies + msecs_to_jiffies(100);
> +		ret =3D -ETIMEDOUT;
> +
> +		while (time_before(jiffies, timeout)) {
> +			status =3D !!(tegra_pmc_readl(PWRGATE_STATUS) & BIT(id));
> +			if (status =3D=3D new_state) {
> +				ret =3D 0;
> +				break;
> +			}
> +			udelay(10);
> +		}
> +	}
> +
>  	mutex_unlock(&pmc->powergates_lock);
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  /**
> @@ -204,7 +220,7 @@ int tegra_powergate_power_on(int id)
>  	if (!pmc->soc || id < 0 || id >=3D pmc->soc->num_powergates)
>  		return -EINVAL;
> =20
> -	return tegra_powergate_set(id, true);
> +	return tegra_powergate_set(id, true, true);
>  }
> =20
>  /**
> @@ -216,7 +232,7 @@ int tegra_powergate_power_off(int id)
>  	if (!pmc->soc || id < 0 || id >=3D pmc->soc->num_powergates)
>  		return -EINVAL;
> =20
> -	return tegra_powergate_set(id, false);
> +	return tegra_powergate_set(id, false, true);
>  }
>  EXPORT_SYMBOL(tegra_powergate_power_off);
> =20
> @@ -351,8 +367,9 @@ bool tegra_pmc_cpu_is_powered(int cpuid)
>  /**
>   * tegra_pmc_cpu_power_on() - power on CPU partition
>   * @cpuid: CPU partition ID
> + * @wait:  Wait for CPU state to transition
>   */
> -int tegra_pmc_cpu_power_on(int cpuid)
> +int tegra_pmc_cpu_power_on(int cpuid, bool wait)

This one is probably fine since it's the only boolean parameter so far.
That said, I see that we call this exactly twice, so I wonder if there'd
be any harm in having the second occurrence wait as well and hence get
rid of the parameter.

Thierry

--XjbSsFHOHxvQpKib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVqNYYAAoJEN0jrNd/PrOh5yEQAJawpQAEf1AJrpNe4nwDsbvB
9sOvK6uty880b1IOUoZprZ6NJYKKaIXBMHX40MrXeW66W2MF73s8QG2O8kbX/n4Y
2dHxsm7lGJ+NTZBOHBpEw2SomQVu2t8vYPqAbQC4UxTiNgmNTftt+7B8HQvcJ/2q
OMic2rm8GMxiVEYZsCqUkBSlyo6aTvetZIBZHlF0YFrq3MKD0DqM7nPFIFxu1msL
4P+mfIEjJt4phh5j5NC7VXvO4I0LJEjgIvCrNFyoB2Gfz+fz08j0A0REbZUota+4
xpU50wXN0BFI4prdtY4izG/W/2h344VNs8r7eHVZfY9tA1xDU6zlaX0Nk+SlEqGN
93GulrjXoc6JocDSbDpTLEi+kzxhc4KhQyTEgPTp4oeB2ELF9yJTW0hzmI85XXFK
IC37DOjkXWW0ryxRkUVQQ/16u4qQ1KSyX3BNPHUP2JNhzaKt4EHueA9nEWoa17pD
lwTKL3rIvNmd2Q8kKt5WZTJEMW7E46UQTORf2yQ/y2gYoWBGmLnRT0PzT8jyDSb/
wN37lUuCPUwWHmYHBliUVxso/6mUQaIg1utZ3vTlMVml1TKhV8qp/zM8KcQ9CK0Y
5jRZHwbYWdpFX8hqMTnxC6azbMlj9lrqOWmz3EIWsjPP+rzToJKtD97Bt/ZqPq4y
kfI9oT3MKmVlCjJj0g7N
=Gndd
-----END PGP SIGNATURE-----

--XjbSsFHOHxvQpKib--
