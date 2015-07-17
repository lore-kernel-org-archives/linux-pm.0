From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V3 11/19] PCI: tegra: Add support for generic PM domains
Date: Fri, 17 Jul 2015 12:45:48 +0200
Message-ID: <20150717104547.GN3057@ulmo>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-12-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rPgHZmYkQ+bUEpVC"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33692 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946008AbbGQKp4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2015 06:45:56 -0400
Content-Disposition: inline
In-Reply-To: <1436791197-32358-12-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, Vince Hsu <vinceh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--rPgHZmYkQ+bUEpVC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2015 at 01:39:49PM +0100, Jon Hunter wrote:
> Add support to the tegra PCI driver for generic PM domains. However,
> to ensure backward compatibility with older device tree blobs ensure
> that the driver can work with or without generic PM domains. In order
> to migrate to generic PM domain infrastructure the necessary changes
> are:
>=20
> 1. If the "power-domains" property is present in the DT device node then
>    generic PM domains is supported and pm_runtime_enable() should be
>    called for the device. Furthermore, the enabling and disabling of the
>    power-domain is handled via calling pm_runtime_get/put, respectively.
>=20
> 2. To ensure that clocks are managed consistently when generic PM domains
>    are used and are not used, drivers should be migrated to use the
>    tegra_powergate_power_on_legacy() and tegra_powergate_power_off_legacy=
()
>    functions instead of the current tegra_powergate_sequence_power_up()
>    and tegra_powergate_power_off(). The purpose of the
>    tegra_powergate_power_on_legacy() and tegra_powergate_power_off_legacy=
()
>    APIs is to mimick the behaviour of the tegra generic power-domain code,
>    such that if generic power domains are not supported the functionality
>    is the same.
>=20
> 3. The main difference between the tegra_powergate_sequence_power_up() API
>    and the tegra_powergate_power_on_legacy() is that the clock used to
>    enable the powergate is not kept enabled when using the
>    tegra_powergate_power_on_legacy() API. Therefore, drivers must enable
>    the clocks they need after calling tegra_powergate_power_on_legacy()
>    and disable these clocks before calling
>    tegra_powergate_power_off_legacy().

This is the same comment as in the DRM patch, and it applies to all
devices that use powergating, so it should move into the preparatory
patch rather than be repeated in all patches.

>=20
> The helper functions for handling the powering on and off of the PCI
> controller have been updated to support generic PM domains. The
> tegra_pcie_power_off() was missing code to disable the clocks enabled in
> the tegra_pcie_power_on() function and so this has been added.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/pci/host/pci-tegra.c | 49 +++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 37 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 10c05718dbfd..acd1f311eee5 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -40,6 +40,7 @@
>  #include <linux/pci.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> @@ -908,19 +909,32 @@ static int tegra_pcie_enable_controller(struct tegr=
a_pcie *pcie)
> =20
>  static void tegra_pcie_power_off(struct tegra_pcie *pcie)
>  {
> +	const struct tegra_pcie_soc_data *soc =3D pcie->soc_data;
>  	int err;
> =20
> -	/* TODO: disable and unprepare clocks? */
> -
>  	err =3D phy_power_off(pcie->phy);
>  	if (err < 0)
>  		dev_warn(pcie->dev, "failed to power off PHY: %d\n", err);
> =20
>  	reset_control_assert(pcie->pcie_xrst);
>  	reset_control_assert(pcie->afi_rst);
> -	reset_control_assert(pcie->pex_rst);
> =20
> -	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
> +	clk_disable_unprepare(pcie->pll_e);
> +	if (soc->has_cml_clk)
> +		clk_disable_unprepare(pcie->cml_clk);
> +	clk_disable_unprepare(pcie->afi_clk);
> +	clk_disable_unprepare(pcie->pex_clk);
> +
> +	if (pm_runtime_enabled(pcie->dev)) {
> +		err =3D pm_runtime_put_sync(pcie->dev);
> +	} else {
> +		err =3D tegra_powergate_power_off_legacy(TEGRA_POWERGATE_PCIE,
> +						       pcie->pex_clk,
> +						       pcie->pex_rst);
> +	}
> +
> +	if (err < 0)
> +		dev_warn(pcie->dev, "powergate power-down failed: %d\n", err);
> =20
>  	err =3D regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
>  	if (err < 0)
> @@ -934,20 +948,28 @@ static int tegra_pcie_power_on(struct tegra_pcie *p=
cie)
> =20
>  	reset_control_assert(pcie->pcie_xrst);
>  	reset_control_assert(pcie->afi_rst);
> -	reset_control_assert(pcie->pex_rst);
> -
> -	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
> =20
>  	/* enable regulators */
>  	err =3D regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
>  	if (err < 0)
>  		dev_err(pcie->dev, "failed to enable regulators: %d\n", err);
> =20
> -	err =3D tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
> -						pcie->pex_clk,
> -						pcie->pex_rst);
> -	if (err) {
> -		dev_err(pcie->dev, "powerup sequence failed: %d\n", err);
> +	if (pm_runtime_enabled(pcie->dev)) {
> +		err =3D pm_runtime_get_sync(pcie->dev);
> +	} else {
> +		err =3D tegra_powergate_power_on_legacy(TEGRA_POWERGATE_PCIE,
> +						      pcie->pex_clk,
> +						      pcie->pex_rst);
> +	}
> +
> +	if (err < 0) {
> +		dev_err(pcie->dev, "powergate power-up failed: %d\n", err);
> +		return err;
> +	}
> +
> +	err =3D clk_prepare_enable(pcie->pex_clk);
> +	if (err < 0) {
> +		dev_err(pcie->dev, "failed to enable PEX clock: %d\n", err);
>  		return err;
>  	}
> =20

Couldn't we simply move the above code into suspend/resume functions and
then call pm_runtime_get() and pm_runtime_put() instead of
tegra_pcie_power_on() and tegra_pcie_power_off()?

> @@ -2001,6 +2023,9 @@ static int tegra_pcie_probe(struct platform_device =
*pdev)
> =20
>  	pcibios_min_mem =3D 0;
> =20
> +	if (of_property_read_bool(pdev->dev.of_node, "power-domains"))
> +		pm_runtime_enable(&pdev->dev);

Then of course we'd have to call pm_runtime_enable() irrespective of the
property and check for the presence of power domain support via another
method (like the dev->pm_domain field).

Thierry

--rPgHZmYkQ+bUEpVC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVqNzbAAoJEN0jrNd/PrOhDewP/AwlT+9yDNXe45bfw1qjDdUi
JzWgkkcJeCmIvsAIMsnckPe/ww+6+HNyE86qRN1voXGlEtVHx6bqGrabdIP/HM6f
SvQKFto4q/bPtsVC6EbyoyMqs78VZA6o/FY9bfXLpUUwaJCA8IC4sl9wOxti5VEB
3eHGw89OSbeZ11OIeEUJbJL+N66vSivTpXGX3NKr8seEzbUzN8ea4L7K6jae/i3t
23DiWCG2dr1zk+h5WgH77MkPMv+OeuUhXCGpdQjUEgB77KlBpBsVibZwzFViZJkA
DpVSEV0cRnkYZ3ZHxhSjYG6kprFhWrGXKNnlEwdS+oLqOjMxDROYZRT4PV2cwR6f
B6znA6vSbJSTYsIfrPEGzrxB2FYrkUrDyB4SCmYSazWFOZZSbUG/0naJY0LcSmY/
BBLw10p6vPCM000om9xqBKOhqDdzbm5XLMgJLG0xa5JjILI4FcHEH0oHj5cOncZd
EgfwAsxhOGI3KXI7NigttapoJ0vBAU78Z14D1R5iSQdIA9TXEBVQVtWfg2YwTqtN
Pp+LtRifP83GaZsilx1qnkvciMhM6DibgGAm9Qa+KLcusP6uFr6O+rMe3lL2iNbj
NCx7VqcYGyBgAyJhtxarrU8XXIPqF6PL6lwxCoVsC/wjaqfr+eATyzdST0JdqBFg
EcOnAD14CJh0C9fcjGKT
=YqwP
-----END PGP SIGNATURE-----

--rPgHZmYkQ+bUEpVC--
