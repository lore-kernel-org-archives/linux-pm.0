From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 5/6] regulator: max77843: Add max77843 regulator driver
Date: Tue, 3 Feb 2015 16:25:37 +0000
Message-ID: <20150203162536.GQ21293@sirena.org.uk>
References: <1422939846-29955-1-git-send-email-jaewon02.kim@samsung.com>
 <1422939846-29955-6-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PdA1PHnkxfF9WYwU"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:49323 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932332AbbBCQZp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 11:25:45 -0500
Content-Disposition: inline
In-Reply-To: <1422939846-29955-6-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Beomho Seo <beomho.seo@samsung.com>


--PdA1PHnkxfF9WYwU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2015 at 02:04:05PM +0900, Jaewon Kim wrote:
> This patch adds new regulator driver to support max77843
> MFD(Multi Function Device) chip`s regulators.
> The Max77843 has two voltage regulators for USB safeout.

This looks mostly good, a couple of very small things:

> +static const struct regulator_desc max77843_supported_regulators[] = {
> +	[MAX77843_SAFEOUT1] = {
> +		.name		= "SAFEOUT1",
> +		.id		= MAX77843_SAFEOUT1,
> +		.ops		= &max77843_regulator_ops,
> +		.of_match	= of_match_ptr("SAFEOUT1"),
> +		.regulators_node = of_match_ptr("regulators"),
> +		.type		= REGULATOR_VOLTAGE,
> +		.owner		= THIS_MODULE,
> +		.n_voltages	= MAX77843_SUPPORTED_VOLTAGE_NUM,
> +		.volt_table	= max77843_regulator_table,

It's better to make n_voltages be ARRAY_SIZE() for the table, that way
there's no need to keep the define and array lined up if someone extends
the driver.  A name like _safeout_voltage_table might be clearer too.

--PdA1PHnkxfF9WYwU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0PaAAAoJECTWi3JdVIfQz8kH/ijvmoKtCPg7Ju1PeSNkLlTr
k8Oy4+rK55JMvKEWE4F++7e6q6BLKMrKx98TV+VlrXnGt9POxadtRfJaGvYQrDS7
coAocT8y5jtrEFzIMBIBxfq8QRoBSxORmaEjV+oyIT5w5gBvkH+Efd3KEGydQXRS
KPjjdfYklBACgwnEhElUVz66McP1rwP++7ynS5JuFdfaP0pBSapfA1NEPi7F8ulh
j6eOGqfKIXfN09QZA/jMzlIYF0szWV3FAa7YjEqiDpK6OQepZB3OfZaRXyq9Gr7U
6l/vWQb2EZKlwJtELqTkom8/XgFKbKeJuCR26mfDbhnH5MmVW21w4w07bPVT/PQ=
=mIjx
-----END PGP SIGNATURE-----

--PdA1PHnkxfF9WYwU--
