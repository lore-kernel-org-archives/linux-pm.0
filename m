Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D502F2918
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281296; cv=none; b=keyJ8u956Tv1OATgyE9AJpPQP1cgDjzM6PfjdgEJCSMgAWfIOjHu2A7PFSM836XJa4HFd1/ETBhLScqzZfCjnKHAYEdjif3duYrHkHhcy6KZX5xTgimxH525fsKM6/otiHke33tfZGWePbEuqKIMkHn6UKw6UAEJOfVKunlxJ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281296; c=relaxed/simple;
	bh=EzPC7nqk9AgFER6/WVv2twNqV5B+PmIayWg4UAsoMyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R0FtU+nh7aBt7DRmZ+hqimYK28/zoRHIFYNhs/778aRPblbqdtSFbNlygOBSyRv8T5UtcguaL3ys21B1DRldo88zblRSz7uW3IaJso3HCTdK7GPbcE/vpBtjaPb7U9kMT5VK3/cfV9RcnjjO08D6mEYXpQ/ZDqS0fJ8uwQsa1f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wHI31-000151-3b; Mon, 27 Apr 2026 11:14:35 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wHI2y-007Sug-0S;
	Mon, 27 Apr 2026 11:14:32 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wHI2y-000000004DH-0Dxa;
	Mon, 27 Apr 2026 11:14:32 +0200
Message-ID: <871996c5a57223294c584c0ff344efd30b3b982b.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] thermal: mediatek: lvts: Add MT8189 support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: mtk36707 <kuanfu.lu@mediatek.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>,  Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Balsam CHIHI <bchihi@baylibre.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, jarried.lin@mediatek.com, 
	vince-wl.liu@mediatek.com, justin.yeh@mediatek.com
Date: Mon, 27 Apr 2026 11:14:31 +0200
In-Reply-To: <20260427065236.1685057-2-kuanfu.lu@mediatek.com>
References: <20260427065236.1685057-1-kuanfu.lu@mediatek.com>
	 <20260427065236.1685057-2-kuanfu.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On Mo, 2026-04-27 at 14:48 +0800, mtk36707 wrote:
> From: Kuanfu Lu <kuanfu.lu@mediatek.com>
>=20
> Add LVTS thermal support for MediaTek MT8189 by adding MT8189-specific
> controller/sensor topology and platform data for the MCU and AP domains.
>=20
> MT8189 differs from previous SoCs in a few aspects, so extend the driver
> to handle these variations:
> - Program the hardware thermal shutdown threshold (tshut) using raw units=
.
> - Add per-SoC feature flags to skip clock gating and reset control when
>   they are not required, and to enable Stage-3 monitor interrupt setup.
> - Pass SoC data into lvts_irq_init() and lvts_ctrl_configure() so the
>   initialization can be configured per platform.
>=20
> This enables monitoring of MT8189 CPU clusters and AP domain sensors
> (SOC/APU/GPU) with the existing LVTS driver.
>=20
> Signed-off-by: Kuanfu Lu <kuanfu.lu@mediatek.com>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 142 +++++++++++++++++++++---
>  1 file changed, 129 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index a9617d5e0077..9dbd9191e3ba 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
[...]
> @@ -1470,10 +1482,12 @@ static int lvts_probe(struct platform_device *pde=
v)
>  	if (IS_ERR(lvts_td->base))
>  		return dev_err_probe(dev, PTR_ERR(lvts_td->base), "Failed to map io re=
source\n");
> =20
> -	lvts_td->reset =3D devm_reset_control_get_by_index(dev, 0);

First of all, this should have been:

	lvts_td->reset =3D devm_reset_control_get_exclusive(dev, NULL);

since there is only a single reset control defined in the binding.

> -	if (IS_ERR(lvts_td->reset))
> -		return dev_err_probe(dev, PTR_ERR(lvts_td->reset), "Failed to get rese=
t control\n");
> -
> +	if (!lvts_data->reset_no_need) {
> +		lvts_td->reset =3D devm_reset_control_get_by_index(dev, 0);

So this can be changed to

	lvts_td->reset =3D devm_reset_control_get_optional_exclusive(dev, NULL);

instead. There is no need for the reset_no_need parameter at all.
Whether the reset control is required or not is already specified in
the device tree bindings.

> +		if (IS_ERR(lvts_td->reset))
> +			return dev_err_probe(dev, PTR_ERR(lvts_td->reset),
> +					     "Failed to get reset control\n");
> +	}
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;

regards
Philipp
