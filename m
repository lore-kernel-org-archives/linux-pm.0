From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/7] power: mxs_power: add driver for mxs power subsystem
Date: Sun, 22 Mar 2015 11:40:54 +0100
Message-ID: <20150322104053.GA5394@earth>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39627 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbbCVKlU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 22 Mar 2015 06:41:20 -0400
Content-Disposition: inline
In-Reply-To: <1426984203-9133-3-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: shawn.guo@linaro.org, dbaryshkov@gmail.com, dwmw2@infradead.org, broonie@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org, fabio.estevam@freescale.com, marex@denx.de, devicetree@vger.kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, kernel@pengutronix.de, sebastien.szymanski@armadeus.com, linux-arm-kernel@lists.infradead.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 22, 2015 at 12:29:58AM +0000, Stefan Wahren wrote:
> This patch adds a minimal driver for the Freescale i.MX23, i.MX28
> power subsystem. It's required to trigger the probing of the underlying
> drivers like on-chip regulators.
>=20
> [...]
>
> +config MXS_POWER
> +	tristate "Freescale MXS power subsystem support"
> +	depends on ARCH_MXS

please add "|| COMPILE_TEST"

> +	help
> +	  Say Y here to enable support for the Freescale i.MX23/i.MX28
> +	  power subsystem. This is a requirement to get access to on-chip
> +	  regulators, battery charger and many more.
>
> [...]
>
> +static int mxs_power_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct resource *res;
> +	struct mxs_power_data *data;
> +	struct power_supply_config psy_cfg =3D {};
> +	void __iomem *v5ctrl_addr;
> +
> +	if (!np) {
> +		dev_err(dev, "missing device tree\n");
> +		return -EINVAL;
> +	}
> +
> +	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->base_addr =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(data->base_addr))
> +		return PTR_ERR(data->base_addr);
> +
> +	psy_cfg.drv_data =3D data;
> +
> +	data->ac =3D power_supply_register(dev, &ac_desc, &psy_cfg);
> +	if (IS_ERR(data->ac))
> +		return PTR_ERR(data->ac);

You can use devm_power_supply_register to simplify the driver
a bit more.

> +	platform_set_drvdata(pdev, data);
> +
> +	v5ctrl_addr =3D data->base_addr + HW_POWER_5VCTRL_OFFSET;
> +
> +	/* Make sure the current limit of the linregs are disabled. */
> +	writel(BM_POWER_5VCTRL_ENABLE_LINREG_ILIMIT,
> +	       v5ctrl_addr + HW_POWER_CTRL_CLR);
> +
> +	return of_platform_populate(np, NULL, NULL, dev);
> +}
> +
> [...]

-- Sebastian

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVDpwyAAoJENju1/PIO/qaj1cP/jwNaC9vUo6aYkXZy9CZBaay
CIBllLt/vgmONs7ww50R+CSP98c3wjIhjWnxNsTLghFWgX1SPo+2t+fCpT34VpbX
ehTJZ1eovDbpNdJIb9muenOBZUx1uFhyh1czgNpx1xnqCvhFSxzOjhIFn8kt6iI8
qSzQGS1Y1/dQonCJZIWBc/4bLEzv3GjcXDSfe9n4L3hOweRCqDeQHTiZubT19yvd
OVMQDiqUTELvviDEX4V/f1WNtYlHClmIc40LHAHIPPoJ9mcaFPzWoeMSucOyXz11
uu70tQReZU/KLeRcEfqSb5CRxhKvn1KeceT3yj0FG+YjfVC3b/PE1kpgQElIqhau
5kGMdaOQ/XVvXcyYKqPxMQ9AB8r7xexJgLYjhM8NoHRFZ5ZSfeyzgB0ZKYXY81qj
pw74BmsjW+BK/TZHbHgAH/szS7f7BqeusbFIwJeBlVN5m3k1UnbCWZQSTOwqKuk4
O8aAgeR6stHszqP2Ho12AN2SIO8h5sykq6lyj5Aa97bPg0SIE/UYNTMKGwTlzQsr
MYJ7qpwt7Y4Snnc1pfHl/tQ8x+eHjYN+I9nOa4SGboltw0Y1i1mDh28nDd1lnqcw
jr1yDbxXObO9BWigJ5yavmSP04hbdJ96BeK+fb0J2fDsThDcfILbMA4e5wHEcVFW
8KviaXp5YxxVOoE2LWvp
=iSJ1
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
