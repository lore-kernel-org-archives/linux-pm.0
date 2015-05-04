From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
Date: Mon, 4 May 2015 13:36:48 +0100
Message-ID: <20150504123648.GU15510@sirena.org.uk>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0149849540362123708=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Mark Rutland <mark.rutland@arm.com>, fabio.estevam@freescale.com, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, sebastien.szymanski@armadeus.com, Shawn Guo <shawn.guo@linaro.org>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============0149849540362123708==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O0IT7rLmWuveAsNR"
Content-Disposition: inline


--O0IT7rLmWuveAsNR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 29, 2015 at 10:32:26PM +0000, Stefan Wahren wrote:

> +static struct regulator_ops mxs_dcdc_ops = {
> +	.is_enabled		= regulator_is_enabled_regmap,
> +};

Why do we have an is_enabled() operation but no enable or disable
operation?  I'm also not 100% clear what code the DCDCs and LDOs are
sharing here...

> +	initdata = of_get_regulator_init_data(dev, dev->of_node, &info->desc);
> +	if (!initdata) {
> +		dev_err(dev, "missing regulator init data\n");
> +		return -EINVAL;
> +	}

This is not an error, init data is totally optional.

> +	rdev = devm_regulator_register(dev, &info->desc, &config);
> +	if (IS_ERR(rdev)) {
> +		int ret = PTR_ERR(rdev);
> +
> +		dev_err(dev, "%s: failed to register regulator(%d)\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	if (!of_property_read_u32(dev->of_node, "switching-frequency",
> +				  &switch_freq))
> +		mxs_set_dcdc_freq(rdev, switch_freq);

why are we registering the regulator before we've finished parsing the
DT - I'd expect us to do this first rather than have things potentially
start using the regulator with the confguration not completed.

> +	platform_set_drvdata(pdev, rdev);

This looks unsafe - either we don't need to set this at all or one of
the ops could be invoked when the regulator is registered and try to use
the driver data before it is set.

--O0IT7rLmWuveAsNR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR2fgAAoJECTWi3JdVIfQlyQH/jeeZ9yFd3xeZ6utDoCdzHO+
G7COOPMAErf+jnkRV4Z/LkLmmgq80mEVO+o86QiCl6Vbv5v/po+XVzoCglIWVu1r
60X7Uqf/Dyux7XzM4T55mjpOUPsjh+Dsl7U0/BZ1fXySF4tOSVfhIPmPLZYpnQfP
S/XdM9G6QHN/y3atS80vtFtpLwMi8LgQBI7IxpeTD0ncF2WtGIM9faZTakLR0oJT
1SPvvAhKOv5NvaF8Pb0v+jDx8iobL0DqTLRgU1b8Mg4mfhwxGazeV+wcroC4Gz5f
b8VmsNVEgqRDT+WPva4xSTOO/rM0W1YSgl5M/K+QhLG+zfPhy92MZz5yyEavv1s=
=dF2D
-----END PGP SIGNATURE-----

--O0IT7rLmWuveAsNR--


--===============0149849540362123708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0149849540362123708==--
