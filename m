Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29328456DF4;
	Wed, 29 Jul 2026 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319661; cv=none; b=TkyIt9xHIVKcSwOn9LomuRVPGUknkdoMruERB5FEi7Wrg/GnyYDocNRDHX5Gv91f4cMYcF2k4V41yf2YRweRcIhBCcynqOZGzEi0EJ9yCLU905hlRRN/NPFSxGzOdGNL35H4Bx2KaKkphrBE2DOKv/Tqmfu3rSd8JtsoaM4FBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319661; c=relaxed/simple;
	bh=mpmy3RbzV7M4AY4S6nNlQc0eE+qLtws5Bem+Rv6pTUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UiFc97lc2Rh8tGYb6KyXvnb4y70LKRTXwbdUylXk5Z1AAeHdYmx/bwxq4Q9kaFQ9Gnz3DYWfvxkPBX4POB8cSGias/+NPYZ5hteIwUoQVhaH0icHQH9y4RZoBOPI6gqZ5irBxJtnxGVqZ4tdZHxKs7Y10keSjhHMS/0nuMrCIVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DEB55201D51;
	Wed, 29 Jul 2026 12:07:35 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wp1CJ-001rk1-2f;
	Wed, 29 Jul 2026 12:07:35 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wp1CJ-000000007BQ-35nf;
	Wed, 29 Jul 2026 12:07:35 +0200
Message-ID: <25ce87017f0871e10bebd5fd43194b16026aaa04.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] power: sequencing: Add Renesas RZ/G3L Power
 Ready driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Biju <biju.das.au@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Magnus Damm	 <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Prabhakar Mahadev Lad	
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Date: Wed, 29 Jul 2026 12:07:35 +0200
In-Reply-To: <20260729093112.98324-3-biju.das.jz@bp.renesas.com>
References: <20260729093112.98324-1-biju.das.jz@bp.renesas.com>
	 <20260729093112.98324-3-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mi, 2026-07-29 at 10:31 +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Add a power sequencing driver for the Renesas RZ/G3L PWRRDY module,
> which signals power readiness for various IPs (USB, DSI, CSI etc.) on the
> SoC. The driver binds as an auxiliary device to the parent SYSC driver,
> using its regmap to toggle the SYS_PWRRDY_N register bits, and exposes
> {usb,dsi,csi}-pwrrdy pwrseq targets.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Added a comment in pwrseq_rzg3l_pwrrdy_match().
>  * Dropped dev_get_regmap() from probe as regmap is now part of platform
>    data.
>  * Added a blank line before devm_pwrseq_device_register() in probe.
>  * Dropped the error message devm_pwrseq_device_register() as probe print=
s
>    failure message.
>  * Dropped local variables dev and regmap from probe().
> ---
>  drivers/power/sequencing/Kconfig              |   8 +
>  drivers/power/sequencing/Makefile             |   1 +
>  .../power/sequencing/pwrseq-renesas-pwrrdy.c  | 139 ++++++++++++++++++
>  3 files changed, 148 insertions(+)
>  create mode 100644 drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
>=20
[...]
> diff --git a/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c b/drivers/p=
ower/sequencing/pwrseq-renesas-pwrrdy.c
> new file mode 100644
> index 000000000000..723d574c3f10
> --- /dev/null
> +++ b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G3L Power Ready driver
> + *
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/module.h>
> +#include <linux/pwrseq/provider.h>
> +#include <linux/regmap.h>
> +
> +#define SYS_PWRRDY_N		0xd70
> +#define SYS_PWRRDY_N_USB_MASK	BIT(0)
> +#define SYS_PWRRDY_N_DSI_MASK	BIT(1)
> +#define SYS_PWRRDY_N_CSI_MASK	BIT(2)
> +
> +static int pwrseq_rzg3l_set_pwrrdy(struct pwrseq_device *pwrseq, u32 mas=
k, u32 val)
> +{
> +	struct regmap *regmap =3D pwrseq_device_get_drvdata(pwrseq);
> +
> +	return regmap_update_bits(regmap, SYS_PWRRDY_N, mask, val);
> +}

Did you mean to use regmap_assign_bits() with a boolean val?
See below.

> +static int pwrseq_rzg3l_usb_pwrrdy_enable(struct pwrseq_device *pwrseq)
> +{
> +	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_USB_MASK, 0);
> +}
> +
> +static int pwrseq_rzg3l_usb_pwrrdy_disable(struct pwrseq_device *pwrseq)
> +{
> +	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_USB_MASK, 1);

This happens to work correctly since SYS_PWRRDY_N_USB_MASK is 1.

> +}
> +
> +static const struct pwrseq_unit_data pwrseq_rzg3l_usb_pwrrdy_unit =3D {
> +	.name =3D "usb-pwrrdy-power-sequence",
> +	.enable =3D pwrseq_rzg3l_usb_pwrrdy_enable,
> +	.disable =3D pwrseq_rzg3l_usb_pwrrdy_disable,
> +};
> +
> +static int pwrseq_rzg3l_dsi_pwrrdy_enable(struct pwrseq_device *pwrseq)
> +{
> +	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_DSI_MASK, 0);
> +}
> +
> +static int pwrseq_rzg3l_dsi_pwrrdy_disable(struct pwrseq_device *pwrseq)
> +{
> +	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_DSI_MASK, 1);

1 is not in SYS_PWRRDY_N_DSI_MASK, so this will clear the bit. Either
set val =3D mask or use regmap_assign_bits().

> +}
> +
> +static const struct pwrseq_unit_data pwrseq_rzg3l_dsi_pwrrdy_unit =3D {
> +	.name =3D "dsi-pwrrdy-sequence",
> +	.enable =3D pwrseq_rzg3l_dsi_pwrrdy_enable,
> +	.disable =3D pwrseq_rzg3l_dsi_pwrrdy_disable,
> +};
> +
> +static int pwrseq_rzg3l_csi_pwrrdy_enable(struct pwrseq_device *pwrseq)
> +{
> +	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_CSI_MASK, 0);
> +}
> +
> +static int pwrseq_rzg3l_csi_pwrrdy_disable(struct pwrseq_device *pwrseq)
> +{
> +	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_CSI_MASK, 1);

Same issue as above.

[...]
> +static int pwrseq_rzg3l_pwrrdy_match(struct pwrseq_device *pwrseq,
> +				     struct device *dev)
> +{
> +	/*
> +	 * The pwrrdy provider does not rely on any device-tree phandle/propert=
y
> +	 * matching, so it unconditionally matches every consumer device that
> +	 * requests it.
> +	 */
> +	return PWRSEQ_MATCH_OK;
> +}
> +
> +static int pwrseq_rzg3l_pwrrdy_probe(struct auxiliary_device *adev,
> +				     const struct auxiliary_device_id *id)
> +{
> +	struct pwrseq_device *pwrseq;
> +	struct pwrseq_config config =3D {
> +		.parent =3D &adev->dev,
> +		.owner =3D THIS_MODULE,
> +		.drvdata =3D adev->dev.platform_data,
> +		.match =3D pwrseq_rzg3l_pwrrdy_match,
> +		.targets =3D pwrseq_rzg3l_pwrrdy_targets,
> +	};
> +
> +	pwrseq =3D devm_pwrseq_device_register(&adev->dev, &config);
> +
> +	return IS_ERR(pwrseq) ? PTR_ERR(pwrseq) : 0;

	return PTR_ERR_OR_ZERO(pwrseq);


regards
Philipp
