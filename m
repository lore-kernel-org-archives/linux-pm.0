Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA9360EE4;
	Mon,  6 Jul 2026 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334120; cv=none; b=INqMYeb0ZtAYtWHKwcFIQAbS4DJQw/oNo9IqA3NyFGFzVfvw6YcgR6sMhAU7baSkQfqgtqESpAHRglZPfIFClQFPwad+SENoq2WsIBKuZRMa6aWWHCgZQMQO9Q6c4My1MlEeTk0Gi2wR+iWPbK0XU3th45sfOBpypudp4b9pC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334120; c=relaxed/simple;
	bh=sUHK124mufIKOHmMJggzku9b783c+lCeJzO6zBU9rPQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lh6E+rp1jpWzJtmO51OBdPSfXhHsxh/SfkRR4hDtqh7+d3rxdEZHdUmfStswruJyonj8Bpp/Rlg6Ts/0rZ2Fh4EHF7i4U2JbJGJd48hiLli+zcIqe4qUepS1D9kiKab4lAEgHc7Zohdgt7b+RU+B4YwoK1ZcZzfWgbcEcJS53qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DD5C0201544;
	Mon, 06 Jul 2026 12:35:14 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wggfS-000OQS-2e;
	Mon, 06 Jul 2026 12:35:14 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wggfS-00000000BL5-32JF;
	Mon, 06 Jul 2026 12:35:14 +0200
Message-ID: <4030fdf119191dfe38618b8057090c710a45880d.camel@pengutronix.de>
Subject: Re: [PATCH v5 2/5] thermal/drivers/sun8i: replace
 devm_reset_control_get to devm_reset_control_get_shared_deasserted
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Mikhail Kalashnikov <iuncuim@gmail.com>, Vasily Khoruzhick	
 <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, "Rafael J .
 Wysocki"	 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui	 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
 Herring	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej
 Skrabec	 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Mon, 06 Jul 2026 12:35:14 +0200
In-Reply-To: <20260704171411.1413349-3-iuncuim@gmail.com>
References: <20260704171411.1413349-1-iuncuim@gmail.com>
	 <20260704171411.1413349-3-iuncuim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On So, 2026-07-05 at 01:14 +0800, Mikhail Kalashnikov wrote:
> The A523 processor has two temperature controllers, but they share a
> common reset line. Make it shared with the shared variant of
> devm_reset_control_get(), and also simplify the driver by switching to
> devm_reset_control_get_shared_deasserted().
>=20
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
> ---
>  drivers/thermal/sun8i_thermal.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>=20
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_ther=
mal.c
> index 226747906..df0c26970 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -342,11 +342,6 @@ static int sun8i_ths_calibrate(struct ths_device *tm=
dev)
>  	return ret;
>  }
> =20
> -static void sun8i_ths_reset_control_assert(void *data)
> -{
> -	reset_control_assert(data);
> -}
> -
>  static struct regmap *sun8i_ths_get_sram_regmap(struct device_node *node=
)
>  {
>  	struct platform_device *sram_pdev;
> @@ -389,19 +384,10 @@ static int sun8i_ths_resource_init(struct ths_devic=
e *tmdev)
>  		return PTR_ERR(tmdev->regmap);
> =20
>  	if (tmdev->chip->has_bus_clk_reset) {
> -		tmdev->reset =3D devm_reset_control_get(dev, NULL);
> +		tmdev->reset =3D devm_reset_control_get_shared_deasserted(dev, NULL);

Nothing wrong with your patch, but why is this stored on struct
ths_device at all? It's never used. You could turn this into a local
variable while you're at it. Either way,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>


regards
Philipp
