Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0723AA1B2;
	Wed, 22 Jul 2026 06:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784702841; cv=none; b=VHYJdKNWdXJzfLYasWpiHvwRsDXfAQWQQQZDvzL3kir1zzVHsHP7SYZTsj4VU+2wh6wny0HgB9sMUOY6PJaZIOswFgXJzD2DD10rfGXJmQYj5dWXM41Nt6MGWIvzmTlUaTbscv338SEPbdYg4QeqnECfHeFhievyw5JqhXLmIIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784702841; c=relaxed/simple;
	bh=qkLa1bxG34xtbDo6lvdht+wvP/x3tMWjJ4QVyBK8zcU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sDfucfPyBRR6PE8jqWwyrx5nU4XXWVkmChO1X7OM6/r6/XhkSFUM/Zh1q24HC5fBOk8ToINYcDApWWqaLPyVFSkaCGpuz7Ytk1Z4FrJvQT4Ui+uW6q69XkeifeSIuWWUJnvAo9l03F5/NLaBq+JUlbcyMLhB/ftRCx328zH2iT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EB0EE200A6A;
	Wed, 22 Jul 2026 08:47:15 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wmQjb-000h6i-2q;
	Wed, 22 Jul 2026 08:47:15 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wmQjb-000000003DA-3DQo;
	Wed, 22 Jul 2026 08:47:15 +0200
Message-ID: <cd13a97b78f3d940d23b52f94b39f99c52212d0a.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] thermal/drivers/mediatek/lvts_thermal: Make
 reset optional for MT8196
From: Philipp Zabel <p.zabel@pengutronix.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	rafael@kernel.org
Cc: daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, 	laura.nao@collabora.com, fshao@chromium.org,
 wenst@chromium.org, 	jiapeng.chong@linux.alibaba.com,
 frank-w@public-files.de, bchihi@baylibre.com, 	linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-mediatek@lists.infradead.org,
 kernel@collabora.com
Date: Wed, 22 Jul 2026 08:47:15 +0200
In-Reply-To: <20260721105230.101906-3-angelogioacchino.delregno@collabora.com>
References: 
	<20260721105230.101906-1-angelogioacchino.delregno@collabora.com>
	 <20260721105230.101906-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Di, 2026-07-21 at 12:52 +0200, AngeloGioacchino Del Regno wrote:
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
> So, use devm_reset_control_get_optional_exclusive() instead, as the
> LVTS controller always had only one reset and retrieving that by
> index, specifically, always made little sense anyway.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index 92711896ce24..8b779fc5e970 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -1473,7 +1473,20 @@ static int lvts_probe(struct platform_device *pdev=
)
>  	if (IS_ERR(lvts_td->base))
>  		return dev_err_probe(dev, PTR_ERR(lvts_td->base), "Failed to map io re=
source\n");
> =20
> -	lvts_td->reset =3D devm_reset_control_get_by_index(dev, 0);
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
> +	lvts_td->reset =3D devm_reset_control_get_optional_exclusive(dev, NULL)=
;

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
