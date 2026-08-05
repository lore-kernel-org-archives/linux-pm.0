Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0ED45C6F8;
	Wed,  5 Aug 2026 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932026; cv=none; b=YvIgq7E6JSG45eoKdi516+94XVf49h/Y/zT3VdN6AOoFsG1+ysL0IX7QYFD4sDcaz21jmLrvSl/ImHss/oAloVFkKYfbTBnG2DmLhBSW4L3LGXfd27cnlqeWM4EDbVlCuVGalEwtU9a80LI+Y1sxRN5gfyD+eP33EPj47utQxjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932026; c=relaxed/simple;
	bh=qPmUCOr+9MGj4dzFyL2caBXocsNG0nEiU8hCXK/8ZJI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m8Wm5c9Ova60eic98CWxmW1g3rEpPXNHSR9N38Pi6JbuqzSkrAN/wLxFjLsE8rRIXmIrAcjEzDHNKKQ2Fmsf/yo9dVikjivjGr+HLYuojHD0JZqeWnVvsLBnCjSvI6cEpGQXlzSK/6u4fD0rVteu62hGvp8KsV3dSyd9D0qoTRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0AF8D201281;
	Wed, 05 Aug 2026 14:13:41 +0200 (CEST)
Message-ID: <58c85258b5c3aaa4bf26dbcdb7eea01549864a08.camel@pengutronix.de>
Subject: Re: [RFC PATCH v5 v5 5/8] pmdomain/rockchip: cycle optional
 power-domain resets on power-on
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, 	will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
 ogabbay@kernel.org, 	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, alchark@flipper.net, chaoyi.chen@rock-chips.com, 
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Wed, 05 Aug 2026 14:13:40 +0200
In-Reply-To: <20260805063826.95682-6-gahing@gahingwoo.com>
References: <20260805063826.95682-1-gahing@gahingwoo.com>
	 <20260805063826.95682-6-gahing@gahingwoo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mi, 2026-08-05 at 18:38 +1200, Jiaxing Hu wrote:
> Some Rockchip domains come out of power-on with their bus interface in
> an undefined state. On the RK3576 NPU this shows up as a hang on the
> first access after a cold power-on; the vendor kernel cycles the
> domain's resets at this point and that clears it.
>=20
> Take the domain node's resets if it has any, and pulse them between
> releasing idle and restoring QoS. The resets are optional, so domains
> that do not declare any behave exactly as before.
>=20
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index e1857f878..82051f600 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -19,6 +19,7 @@
>  #include <linux/of_clk.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/reset.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/mfd/syscon.h>
> @@ -103,6 +104,7 @@ struct rockchip_pm_domain {
>  	struct clk_bulk_data *clks;
>  	struct device_node *node;
>  	struct regulator *supply;
> +	struct reset_control *resets;
>  };
> =20
>  struct rockchip_pmu {
> @@ -688,6 +690,13 @@ static int rockchip_pd_power(struct rockchip_pm_doma=
in *pd, bool power_on)
>  		if (pd->info->delay_us)
>  			udelay(pd->info->delay_us);
> =20
> +		/* Optional: some domains need their resets cycled after power-on. */
> +		if (pd->resets) {
> +			reset_control_assert(pd->resets);
> +			udelay(10);
> +			reset_control_deassert(pd->resets);
> +		}
> +
>  		rockchip_pmu_restore_qos(pd);
>  	}
> =20
> @@ -857,6 +866,14 @@ static int rockchip_pm_add_one_domain(struct rockchi=
p_pmu *pmu,
>  	if (error)
>  		goto err_put_clocks;
> =20
> +	pd->resets =3D of_reset_control_array_get_optional_exclusive(node);

Why is this using of_reset_control_array_get_optional_exclusive()
instead of devm_reset_control_array_get_optional_exclusive() when pd is
allocated with devm_kzalloc()?

> +	if (IS_ERR(pd->resets)) {
> +		error =3D PTR_ERR(pd->resets);
> +		dev_err(pmu->dev, "%pOFn: failed to get resets: %d\n", node, error);

dev_err_probe() to avoid printing on -EPROBE_DEFER.


regards
Philipp
