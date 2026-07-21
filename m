Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AAF4195A6;
	Tue, 21 Jul 2026 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620435; cv=none; b=SYBggtOJYhF3vxUJjIf6GPkczqTuHiYyOwXgB13pG5m1NlcEHkoVcuQ9oM8P7/qSaXtILgABa27jSAgAeAJgEmLlUAtfDc17vmFswtUjwBwwbYKuRh5NIBD7K2scxU/iptveO1EJqrM6i/04juOnhs4u3j1cw71oSgXjxd5x8H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620435; c=relaxed/simple;
	bh=OUH8eZkAOPsJGRZdgINF/kAsQijgdD446fFfPPjVR7w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K8ts/i22wNRQ4/hE0G/2VG/W/Nt+UsQGcYQaGXvjvSl9y1zwzIZ+/ciUaC5FYBintFQHO6Akh8Odxt1SEeIcj/ZQxaVyTzKuaggTbpup0gAEE9PZq5Cc9FvddMtHT+/RLKAQL5d2jhaYgFlFrzqcuDGoCn+YOa2E417b06IqvjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 88AB42028EE;
	Tue, 21 Jul 2026 09:53:43 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wm5IN-000XJf-1W;
	Tue, 21 Jul 2026 09:53:43 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wm5IN-000000002rJ-1YNa;
	Tue, 21 Jul 2026 09:53:43 +0200
Message-ID: <16651472d6a782bdef63e1c9742444de08c59f1e.camel@pengutronix.de>
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Make reset
 optional for MT8196
From: Philipp Zabel <p.zabel@pengutronix.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	rafael@kernel.org
Cc: daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	matthias.bgg@gmail.com, laura.nao@collabora.com, fshao@chromium.org, 
	wenst@chromium.org, jiapeng.chong@linux.alibaba.com,
 frank-w@public-files.de, 	linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 	kernel@collabora.com
Date: Tue, 21 Jul 2026 09:53:43 +0200
In-Reply-To: <20260720144244.88877-1-angelogioacchino.delregno@collabora.com>
References: <20260720144244.88877-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mo, 2026-07-20 at 16:42 +0200, AngeloGioacchino Del Regno wrote:
> Depending on the SoC+Firmware combination, the LVTS hardware may be
> may be actively used by one or even multiple concurrent MCUs!
> In this case, resetting it may produce either a severe slowdown of
> the entire system, or even a thermal protection AP reset, as some
> MCU(s) may be reading a very high or very low temperature while the
> LVTS is being reset.
>=20
> On those, don't fail if no reset is found as that may be omitted on
> purpose, but still check if there's one, because some board(s) may
> be running on a different bootchain with reduced firmwares or using
> firmwares with reduced functionality.
>=20
> Add a new "optional_reset" member to lvts_data and use it to check
> whether the resets should be mandatory or not.
>=20
> Also, while at it, since devm_reset_control_get_by_index() is now
> deprecated, change the probe function to instead call function
> devm_reset_control_get_exclusive_by_index(), which does the same.

Why is this using _by_index() at all? mediatek,lvts-thermal.yaml
specifies a single reset, so the driver should just
devm_reset_control_get_exclusive(dev, NULL).

>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 29 ++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index 92711896ce24..6670b5458f2c 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -160,6 +160,7 @@ struct lvts_data {
>  	int gt_calib_bit_offset;
>  	unsigned int def_calibration;
>  	u16 msr_offset;
> +	bool optional_reset;

No need to complicate things. It's not the driver's business to check
device tree correctness. Just make the reset optional, as the commit
message says.

>  };
> =20
>  struct lvts_sensor {
> @@ -1473,9 +1474,29 @@ static int lvts_probe(struct platform_device *pdev=
)
>  	if (IS_ERR(lvts_td->base))
>  		return dev_err_probe(dev, PTR_ERR(lvts_td->base), "Failed to map io re=
source\n");
> =20
> -	lvts_td->reset =3D devm_reset_control_get_by_index(dev, 0);
> -	if (IS_ERR(lvts_td->reset))
> -		return dev_err_probe(dev, PTR_ERR(lvts_td->reset), "Failed to get rese=
t control\n");
> +	/*
> +	 * Depending on the SoC+Firmware combination, the LVTS hardware may be
> +	 * may be actively used by one or even multiple concurrent MCUs!
> +	 * In this case, resetting it may produce either a severe slowdown of
> +	 * the entire system, or even a thermal protection AP reset, as some
> +	 * MCU(s) may be reading a very high or very low temperature while the
> +	 * LVTS is being reset.
> +	 *
> +	 * On those, don't fail if no reset is found as that may be omitted on
> +	 * purpose, but still check if there's one, because some board(s) may
> +	 * be running on a different bootchain with reduced firmwares or using
> +	 * firmwares with reduced functionality.
> +	 */
> +	lvts_td->reset =3D devm_reset_control_get_exclusive_by_index(dev, 0);

So this should be:

	lvts_td->reset =3D devm_reset_control_get_optional_exclusive(dev, NULL);

> +	if (IS_ERR(lvts_td->reset)) {
> +		if (lvts_data->optional_reset) {
> +			dev_dbg(dev, "No reset found. LVTS may be used by firmware.\n");
> +			lvts_td->reset =3D NULL;

This is not necessary then.

> +		} else {
> +			return dev_err_probe(dev, PTR_ERR(lvts_td->reset),
> +					     "Failed to get reset control\n");
> +		}

And this part could be kept as before.

> +	}
> =20
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0)
> @@ -2163,6 +2184,7 @@ static const struct lvts_data mt8196_lvts_mcu_data =
=3D {
>  	.num_cal_offsets =3D LVTS_NUM_CAL_OFFSETS_MT8196,
>  	.msr_offset =3D LVTS_MSR_OFFSET_MT8196,
>  	.ops =3D &lvts_platform_ops_mt8196,
> +	.optional_reset =3D true,

But mediatek,lvts-thermal.yaml still specifies the reset as required
for mediatek,mt8196-lvts-ap. That should be changed instead.

>  };
> =20
>  static const struct lvts_data mt8196_lvts_ap_data =3D {
> @@ -2175,6 +2197,7 @@ static const struct lvts_data mt8196_lvts_ap_data =
=3D {
>  	.num_cal_offsets =3D LVTS_NUM_CAL_OFFSETS_MT8196,
>  	.msr_offset =3D LVTS_MSR_OFFSET_MT8196,
>  	.ops =3D &lvts_platform_ops_mt8196,
> +	.optional_reset =3D true,

Same as above, but for mediatek,mt8196-lvts-mcu.

regards
Philipp
