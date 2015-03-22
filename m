From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/7] regulator: add mxs regulator driver
Date: Sun, 22 Mar 2015 16:14:25 +0000
Message-ID: <20150322161425.GC6643@sirena.org.uk>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-5-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52491 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbbCWFED (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2015 01:04:03 -0400
Content-Disposition: inline
In-Reply-To: <1426984203-9133-5-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: shawn.guo@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org, fabio.estevam@freescale.com, marex@denx.de, kernel@pengutronix.de, rjw@rjwysocki.net, viresh.kumar@linaro.org, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 22, 2015 at 12:30:00AM +0000, Stefan Wahren wrote:

> +	/* Accept only values recommend by Freescale */
> +	switch (khz) {
> +	case 19200:
> +		val |= HW_POWER_MISC_FREQSEL_19200_KHZ << SHIFT_FREQSEL;
> +		break;
> +	case 20000:
> +		val |= HW_POWER_MISC_FREQSEL_20000_KHZ << SHIFT_FREQSEL;
> +		break;
> +	case 24000:
> +		val |= HW_POWER_MISC_FREQSEL_24000_KHZ << SHIFT_FREQSEL;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	if (ret)
> +		return ret;

Just return directly, it'd be a bit easier to follow.  It'd also be
better to print an error message saying we're rejecting the value - that
will make it easier for someone writing a DT to figure out that they
have made a typo or whatever.

> +static int mxs_ldo_set_voltage_sel(struct regulator_dev *reg, unsigned sel)
> +{
> +	struct mxs_ldo *ldo = rdev_get_drvdata(reg);
> +	struct regulator_desc *desc = &ldo->desc;
> +	unsigned long start;
> +	u32 regs;
> +	int uV;
> +	u8 power_source = HW_POWER_UNKNOWN_SOURCE;
> +
> +	uV = regulator_list_voltage_linear(reg, sel);

This would be strange execpt uV doesn't seem to be referenced at all so
it could be removed instead.

> +	if (ldo->get_power_source)
> +		power_source = ldo->get_power_source(reg);
> +
> +	switch (power_source) {
> +	case HW_POWER_LINREG_DCDC_OFF:
> +	case HW_POWER_LINREG_DCDC_READY:
> +	case HW_POWER_EXTERNAL_SOURCE_5V:
> +		usleep_range(1000, 2000);
> +		return 0;
> +	}

I'd expect the switch to be in the if here?

> +
> +	usleep_range(15, 20);
> +	start = jiffies;
> +	while (1) {
> +		if (readl(ldo->status_addr) & BM_POWER_STS_DC_OK)
> +			return 0;
> +
> +		if (time_after(jiffies, start +	msecs_to_jiffies(20)))
> +			break;
> +
> +		schedule();
> +	}

So, this isn't actually quite a busy wait because we do a schedule()
rather than a cpu_relax() but still it could devolve into that - 20ms
seems a long time to burn doing that.  If we're expecting this to finish
very quickly can we do an initial busy wait then fall back to something
with an actual sleep or soemthing?

> +static int mxs_ldo_get_voltage_sel(struct regulator_dev *reg)
> +{
> +	struct mxs_ldo *ldo = rdev_get_drvdata(reg);
> +	struct regulator_desc *desc = &ldo->desc;
> +	int ret, uV;
> +
> +	ret = readl(ldo->base_addr) & desc->vsel_mask;
> +	uV = regulator_list_voltage_linear(reg, ret);
> +
> +	return ret;
> +}

Again with the uV lookup...

> +static int mxs_ldo_is_enabled(struct regulator_dev *reg)
> +{
> +	struct mxs_ldo *ldo = rdev_get_drvdata(reg);
> +	u8 power_source = HW_POWER_UNKNOWN_SOURCE;
> +
> +	if (ldo->get_power_source)
> +		power_source = ldo->get_power_source(reg);
> +
> +	switch (power_source) {
> +	case HW_POWER_LINREG_DCDC_OFF:
> +	case HW_POWER_LINREG_DCDC_READY:
> +	case HW_POWER_DCDC_LINREG_ON:
> +		return 1;
> +	}
> +
> +	return 0;
> +}

Some comments explaining what the logic here is might be helpful, it's
all a bit surprising.

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDupgAAoJECTWi3JdVIfQZdgH/A7beEsLJl1GdT2uui0BsUWf
hhxtuAFIc/UBwwCApmYZZanaK1dC98RTeq+q6QkIrTg1mFBWJYbEOQcj8UAk2iPI
aELjS9Ko7Dbd4buGY/ui5JgFktzdlPcFhFY95bXaT4IHmmNxJshmkB7t/dIgimj6
BWoAvx9unGh9OQF8KBYxpb7+H86sG+7bsYIt1vHBK0djoj1eVm4hZPGsNdXSPRWk
oFPlw8MUNHGw7UyQzco9EQssaeBznkDA/2E2oc5w8LNDOmK4CrntcfmQqnH/nWGJ
Md/UtILgv2rHW7LnijHodUTII96vX6s6LPjAHWtfcI0ImaBH0EZfBQ+KFVtsFg0=
=ObGq
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
