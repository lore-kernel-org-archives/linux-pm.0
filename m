From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V3 08/19] soc: tegra: pmc: Clean-up PMC helper functions
Date: Fri, 17 Jul 2015 12:25:47 +0200
Message-ID: <20150717102546.GL3057@ulmo>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-9-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EEx6GiKZGZ1wKUra"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37124 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756674AbbGQKZy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2015 06:25:54 -0400
Content-Disposition: inline
In-Reply-To: <1436791197-32358-9-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, Vince Hsu <vinceh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--EEx6GiKZGZ1wKUra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2015 at 01:39:46PM +0100, Jon Hunter wrote:
> The following clean-ups have been made to the PMC code:
>=20
> 1. Add a macro for determining the state of a PMC powergate
> 2. Use the readx_poll_timeout() function instead of implementing a local
>    polling loop with a timeout.
> 3. Use a case-statement in the function that removes the powergate clamp
>    instead of multiple if-statements to improve readability.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 72 ++++++++++++++++++++++++-------------------=
------
>  1 file changed, 35 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index c0635bdd4ee3..180d434deec5 100644
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
> @@ -56,6 +57,8 @@
>  #define  PWRGATE_TOGGLE_START		(1 << 8)
> =20
>  #define REMOVE_CLAMPING			0x34
> +#define  REMOVE_CLAMPING_VDEC		(1 << 3)
> +#define  REMOVE_CLAMPING_PCIE		(1 << 4)
> =20
>  #define PWRGATE_STATUS			0x38
> =20
> @@ -101,6 +104,8 @@
> =20
>  #define GPU_RG_CNTRL			0x2d4
> =20
> +#define PMC_PWRGATE_STATE(val, id)	(!!(val & BIT(id)))

I find double-negations very difficult to read. ((value & BIT(id)) !=3D 0)
is clearer in my opinion. Also I'd suggest status or value as the first
parameter name, for consistency with other parts of the driver.

> +
>  struct tegra_pmc_soc {
>  	unsigned int num_powergates;
>  	const char *const *powergates;
> @@ -177,15 +182,14 @@ static void tegra_pmc_writel(u32 value, unsigned lo=
ng offset)
>   */
>  static int tegra_powergate_set(int id, bool new_state, bool wait)
>  {
> -	unsigned long timeout;
> -	bool status;
>  	int ret =3D 0;
> +	u32 val;
> =20
>  	mutex_lock(&pmc->powergates_lock);
> =20
> -	status =3D tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
> +	val =3D tegra_pmc_readl(PWRGATE_STATUS);
> =20
> -	if (status =3D=3D new_state) {
> +	if (PMC_PWRGATE_STATE(val, id) =3D=3D new_state) {
>  		mutex_unlock(&pmc->powergates_lock);
>  		return 0;
>  	}
> @@ -193,17 +197,9 @@ static int tegra_powergate_set(int id, bool new_stat=
e, bool wait)
>  	tegra_pmc_writel(PWRGATE_TOGGLE_START | id, PWRGATE_TOGGLE);
> =20
>  	if (wait) {
> -		timeout =3D jiffies + msecs_to_jiffies(100);
> -		ret =3D -ETIMEDOUT;
> -
> -		while (time_before(jiffies, timeout)) {
> -			status =3D !!(tegra_pmc_readl(PWRGATE_STATUS) & BIT(id));
> -			if (status =3D=3D new_state) {
> -				ret =3D 0;
> -				break;
> -			}
> -			udelay(10);
> -		}
> +		ret =3D readx_poll_timeout(tegra_pmc_readl, PWRGATE_STATUS,
> +				val, PMC_PWRGATE_STATE(val, id) =3D=3D new_state,
> +				10, 100000);
>  	}
> =20
>  	mutex_unlock(&pmc->powergates_lock);
> @@ -242,13 +238,10 @@ EXPORT_SYMBOL(tegra_powergate_power_off);
>   */
>  int tegra_powergate_is_powered(int id)
>  {
> -	u32 status;
> -
>  	if (!pmc->soc || id < 0 || id >=3D pmc->soc->num_powergates)
>  		return -EINVAL;
> =20
> -	status =3D tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
> -	return !!status;
> +	return PMC_PWRGATE_STATE(tegra_pmc_readl(PWRGATE_STATUS), id);

I'd prefer to keep the two steps here. As a general rule I try never to
mix reading or writing a register with other code on the same line.

>  }
> =20
>  /**
> @@ -257,34 +250,39 @@ int tegra_powergate_is_powered(int id)
>   */
>  int tegra_powergate_remove_clamping(int id)
>  {
> -	u32 mask;
> +	u32 val, reg;

Side note: Please use value instead of val since that's the form used
elsewhere in the driver. Also reg would be more appropriately called
offset or similar because that's what it really is. It would also be
more naturally an unsized type, such as unsigned int. But...

> =20
>  	if (!pmc->soc || id < 0 || id >=3D pmc->soc->num_powergates)
>  		return -EINVAL;
> =20
>  	/*
> -	 * On Tegra124 and later, the clamps for the GPU are controlled by a
> -	 * separate register (with different semantics).
> +	 * In most cases the bit for removing the IO clamping is the same as
> +	 * the powergate partition ID, however, this is not always the case.
> +	 * Furthermore, on Tegra124 and later, the clamps for the GPU are
> +	 * controlled by a separate register (with different semantics). The
> +	 * following case-statement handles these exceptions.
>  	 */
> -	if (id =3D=3D TEGRA_POWERGATE_3D) {
> +	val =3D 1 << id;
> +	reg =3D REMOVE_CLAMPING;
> +
> +	switch (id) {
> +	case TEGRA_POWERGATE_3D:
>  		if (pmc->soc->has_gpu_clamps) {
> -			tegra_pmc_writel(0, GPU_RG_CNTRL);
> -			return 0;
> +			val =3D 0;
> +			reg  =3D GPU_RG_CNTRL;
>  		}
> +		break;
> +	case TEGRA_POWERGATE_VDEC:
> +		val =3D REMOVE_CLAMPING_VDEC;
> +		break;
> +	case TEGRA_POWERGATE_PCIE:
> +		val =3D REMOVE_CLAMPING_PCIE;
> +		break;
> +	default:
> +		break;
>  	}
> =20
> -	/*
> -	 * Tegra 2 has a bug where PCIE and VDE clamping masks are
> -	 * swapped relatively to the partition ids
> -	 */
> -	if (id =3D=3D TEGRA_POWERGATE_VDEC)
> -		mask =3D (1 << TEGRA_POWERGATE_PCIE);
> -	else if (id =3D=3D TEGRA_POWERGATE_PCIE)
> -		mask =3D (1 << TEGRA_POWERGATE_VDEC);
> -	else
> -		mask =3D (1 << id);
> -
> -	tegra_pmc_writel(mask, REMOVE_CLAMPING);
> +	tegra_pmc_writel(val, reg);

=2E.. to be honest, I think the previous code was more straightforward, so
I'd prefer if you dropped this particular hunk.

Thierry

--EEx6GiKZGZ1wKUra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVqNgqAAoJEN0jrNd/PrOh2IIQAKJoPVGUOCTakDDbcxEY+Dn3
0q7FlWfmMMeU5Vqa62ilpEAXQmak4jB4+DIVq5c9+aSypq4d7HN+5LVL2u/vrILk
GT0WsbzV3MgKXTAGFXtyFdwgj3hfV+2xKXbJAIVx1qgT6rTYdboW1wtkiSyzG6QK
zh3Upae/lpYhK8XlZMTfcddZ5Pmq24UuAU9SDiRD4Y6t6Woogp26E4F1FYl/AbXG
rh91EdCnxWXWYdDv2BgZonbmjhdMqLFmVAK6WZ9uxVYmBI9Lsnily/VQuhg8fMMK
XyZeryhdXHAZ4ISMyFvJ2wmC7ZmBb/OVUgohePaKz1DcJZCSuyHoS4hhzLCXoZTA
szFxRnNflVZR7DFPaeb92jQe71J6a5n9h0MMvU0apnf9uo7CmFmW/8+NbHxXusxl
6R79wHSN+6LeKnZNrck0GXB1xyNotjZF51jBXG72zHOMi8QrdPMfSEjNjZbjSzK+
nq+i/UBQjBro2lZ7OjJyhIDACLuZvVl3pZ+9YBptjjw/z3IO8Y0uBIGyTxwa5t/I
4zlDG2fysPphBEnFcvUmSjSNynEY2OfO32pz2DM62Mju0X1XAfbAuO4iwRRYbiwP
GLURD0X2KZg7nBDEu35dJLeP+78wT3QpypVRHvzwgl2KDgnBB7GGKe81KEH2MlLl
Tuv0PPgCyjW6jZq2dCZ0
=fGzw
-----END PGP SIGNATURE-----

--EEx6GiKZGZ1wKUra--
