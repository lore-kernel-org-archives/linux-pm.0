From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V4 05/16] soc: tegra: pmc: Avoid extra remapping of PMC
 registers
Date: Thu, 14 Jan 2016 14:45:26 +0100
Message-ID: <20160114134526.GA23082@ulmo>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-6-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449241037-22193-6-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2015 at 02:57:06PM +0000, Jon Hunter wrote:
> During early initialisation, the PMC registers are mapped and the PMC SoC
> data is populated in the PMC data structure. This allows other drivers
> access the PMC register space, via the public tegra PMC APIs, prior to
> probing the PMC device.
>=20
> When the PMC device is probed, the PMC registers are mapped again and if
> successful the initial mapping is freed. If the probing of the PMC device
> fails after the registers are remapped, then the registers will be
> unmapped and hence the pointer to the PMC registers will be invalid. This
> could lead to a potential crash, because once the PMC SoC data pointer is
> populated, the driver assumes that the PMC register mapping is also valid
> and a user calling any of the public tegra PMC APIs could trigger an
> exception because these APIs don't check that the mapping is still valid.
>=20
> Rather than adding a test to see if the PMC register mapping is valid,
> fix this by removing the second mapping of the PMC registers and reserve
> the memory region for the PMC registers during early initialisation where
> the initial mapping is created. During the probing of the PMC simply check
> that the PMC registers have been mapped.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

devm_ioremap_resource() was used on purpose to make sure we get a proper
name assigned to the memory region in /proc/iomem. As it is, there will
be no name associated with it, which I think is unfortunate. As such I'd
prefer keeping that call and instead fix the issue with the invalid
mapping by making sure that pmc->base is assigned only after nothing can
fail in probe anymore.

> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index e60fc2d33c94..fdd1a8d0940f 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -807,22 +807,17 @@ out:
> =20
>  static int tegra_pmc_probe(struct platform_device *pdev)
>  {
> -	void __iomem *base =3D pmc->base;

The alternative that I proposed above would entail not setting this...

> -	struct resource *res;
>  	int err;
> =20
> +	if (!pmc->base) {
> +		dev_err(&pdev->dev, "base address is not configured\n");
> +		return -ENXIO;
> +	}
> +
>  	err =3D tegra_pmc_parse_dt(pmc, pdev->dev.of_node);
>  	if (err < 0)
>  		return err;
> =20
> -	/* take over the memory region from the early initialization */
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	pmc->base =3D devm_ioremap_resource(&pdev->dev, res);

=2E.. and storing the result of the mapping in "base" instead...

> -	if (IS_ERR(pmc->base))
> -		return PTR_ERR(pmc->base);
> -
> -	iounmap(base);

=2E.. and move the unmap to the very end of the probe function, which
would look something like:

	/* take over the memory region from the early initialization */
	iounmap(pmc->base);
	pmc->base =3D base;

That way the mapping in "base" will automatically be undone upon error
and the pmc->base will only be overridden when it's certain that the
probe will succeed.

What do you think?

Thierry

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWl6ZzAAoJEN0jrNd/PrOhwt0QALiLsgn8/ZX5N4ziMzHYYPdi
GP1IBL0nwkDCbLDwzHc/aA/xKwzNsouHRV+1otCXnIocPNgfo3EhKc2svSyc8ir/
1tqeN6o+6om3okKIBlLdiZ3aWo9YBTvv5tojrM4MKbrBc0KMGR2PVWdF5k7VvAXi
3uznqng+AVIDFEWTjiNRFedaiqzjP5qoBItV8H5JCzJhPwYuflWlPbX9EBov5Mxi
M68lSQCAaqrTVc1cVvpkfE4/TfMlyzAj+/IjAsE2HAN/t7FvKO4a7Klq0dMa+4Wo
e5xhQZYmEwATNWShlkulCyhN2z/J8xHX/d7FymmcEKZZuZuTs+2ycSfOOYCKqZwZ
NLysJL3fMXynQ7omvK220RHWpYv7CqDvuX1MQj0rTzJbBpbWncrt8BgvRE3Jnz/o
MvwaW6VsQWAKLkCZGer1Z/feBEDCz3TPlSkhT56+54lker/seQsIZa1a2+8rwmAw
cK86lUQf1EHdzdGtWzFrapCkuYDl1ETruIQwTNUlX17iiut05FisWSgxnVOY6t7G
DQmi0+dP4rYLZ7z4oHtJ3qKZ9C/igtw4lTGpLfy5bFjwA+RlVUzETlQk2pexmpBY
43h1PtLaKA78tLG8g1Fl/He/jNJyko/c6apLU2Az9y58bYizBxW/WYWLc5WL8FIu
XPyrJ1IXsfAfA6YPAsyv
=LRR3
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
