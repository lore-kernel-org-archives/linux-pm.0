From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V4 08/16] soc: tegra: pmc: Fix checking of valid
 partitions
Date: Thu, 14 Jan 2016 15:11:58 +0100
Message-ID: <20160114141158.GC23082@ulmo>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-9-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449241037-22193-9-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2015 at 02:57:09PM +0000, Jon Hunter wrote:
> The tegra power partitions are referenced by a numerical ID which are
> the same values programmed into the PMC registers for controlling the
> partition. For a given device, the valid partition IDs may not be
> contiguous and so simply checking that an ID is not greater than the
> maximum ID supported may not mean it is valid. Fix this by computing
> a bit-mask of the valid partition IDs for a device and add a macro that
> will test if the partition is valid based upon this mask.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 28d3106d3add..0967bba13947 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -103,6 +103,7 @@
>  #define GPU_RG_CNTRL			0x2d4
> =20
>  #define PMC_PWRGATE_STATE(status, id)	((status & BIT(id)) !=3D 0)
> +#define PMC_PWRGATE_IS_VALID(id)	(pmc->powergates_mask & BIT(id))

I'd prefer a static inline function here, too. If you do that you will
also need to move the static inline below the struct tegra_pmc to avoid
build errors. Also don't forget to check for id < 0, because it
technically could be. It may also be worth checking for an upper bound
just in case anybody was going to pass in a value other that the ones
defined in include/soc/tegra/pmc.h.

>  struct tegra_pmc_soc {
>  	unsigned int num_powergates;
> @@ -134,6 +135,7 @@ struct tegra_pmc_soc {
>   * @cpu_pwr_good_en: CPU power good signal is enabled
>   * @lp0_vec_phys: physical base address of the LP0 warm boot code
>   * @lp0_vec_size: size of the LP0 warm boot code
> + * @powergates_mask: Bit mask of valid power gates
>   * @powergates_lock: mutex for power gate register access
>   */
>  struct tegra_pmc {
> @@ -158,6 +160,7 @@ struct tegra_pmc {
>  	bool cpu_pwr_good_en;
>  	u32 lp0_vec_phys;
>  	u32 lp0_vec_size;
> +	u32 powergates_mask;

This seems rather risky. The highest partition ID that we currently have
is 29, so there is potential that 32 bits will be exceeded in the near
future. It'd be more future-proof to turn this into a bitmap from the
start so that we never have to worry about it.

> =20
>  	struct mutex powergates_lock;
>  };
> @@ -213,7 +216,7 @@ static int tegra_powergate_set(int id, bool new_state)
>   */
>  int tegra_powergate_power_on(int id)
>  {
> -	if (!pmc->soc || id < 0 || id >=3D pmc->soc->num_powergates)
> +	if (!PMC_PWRGATE_IS_VALID(id))
>  		return -EINVAL;

In a similar vein I've been meaning, for a long time, to make the ID an
unsigned integer. It might be worth doing that, even with this patch
applied, but it can be a separate patch.

>  	return tegra_powergate_set(id, true);
> @@ -225,7 +228,7 @@ int tegra_powergate_power_on(int id)
>   */
>  int tegra_powergate_power_off(int id)
>  {
> -	if (!pmc->soc || id < 0 || id >=3D pmc->soc->num_powergates)
> +	if (!PMC_PWRGATE_IS_VALID(id))
>  		return -EINVAL;
> =20
>  	return tegra_powergate_set(id, false);
> @@ -240,7 +243,7 @@ int tegra_powergate_is_powered(int id)
>  {
>  	u32 status;
> =20
> -	if (!pmc->soc || id < 0 || id >=3D pmc->soc->num_powergates)
> +	if (!PMC_PWRGATE_IS_VALID(id))
>  		return -EINVAL;
> =20
>  	status =3D tegra_pmc_readl(PWRGATE_STATUS);
> @@ -256,7 +259,7 @@ int tegra_powergate_remove_clamping(int id)
>  {
>  	u32 mask;
> =20
> -	if (!pmc->soc || id < 0 || id >=3D pmc->soc->num_powergates)
> +	if (!PMC_PWRGATE_IS_VALID(id))
>  		return -EINVAL;
> =20
>  	/*
> @@ -1084,7 +1087,7 @@ static int __init tegra_pmc_early_init(void)
>  	struct device_node *np;
>  	struct resource regs;
>  	bool invert;
> -	u32 value;
> +	u32 value, i;

I'd prefer an unsized type (unsigned int) for i because there is no
reason why it should be sized.

Thierry

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWl6ysAAoJEN0jrNd/PrOhfR4QALGzHL90iYYtQ2giUm9OwSnB
84+RGGq+znkQtLYIp1yACLECwnRkPGl8KxxHbc+4LOZU3gUBZwFKEkamctxAvvev
Jw5ImIFqIzakcuVB4Cct3vdGc9R1GHqmh1+HlsGxW6DV3kMEUZCdKayw8hM6bifj
G/m32CN9xlwDLNzKT6AL7r9fzxAiwwdbABGS+sB6lntZaFlrRvkTVElSgHbodBDn
oIz9V2takjcfkSLeDhwdKL7nZOO+XYMOuwiGjLpHy0sFTtBjq71H7pp1VOrzTJkj
8I8bUlCrn7UGcyC016zVkEjTAuL9OZ9PNUDWuKmHK6h4HLwblXMvf3MQ39azYyIh
LWiLLnKA+iMCE1Jjk9KHxpildDtCYqPOu+VAtn4pwCtzAsSvazbbXus2F6GoubvB
L8pjLB6R8ml+CGAyZGIb3AeIeQGm0tPYyjEOHcVUsdTzyzAjLOxR9A8ksMDxPH5k
lpdlr8rSra223MPLTnJPum3CAL76XS7N4phZZKp4e4kwb/tjkb7cJ+nluaBbhX6J
E/q7y2feISksoVE885DCO22Yj0mM9Jw4SH51kocX6pthtHQGUWEvwCFA0NV09UEw
DWK6dzFoyRmmHyX0Vfo+9Vt+E3DYGFxBOIUoNE1FQCbu48/BX6WqMcIYkTzIpNUq
bkFNgBAJ59kUEm/vqrAi
=N6j2
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
