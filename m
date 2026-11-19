Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795111713;
	b=jw7jUh1VJvDghEjmF7tT+bx4JuknQi/uerxn1KRXQggF4nlHYp0eMxGA5Fr4Ux4g/DEW
	 jV+MqrOsS4xkC4s5lLFAd3mi2hGPyJIz465BApcAwKo1y/nJtLbJujSZH+3uycVEPuMHa
	 xnbeZICxfATJV71tNCHW6gv0MEDm+AeV5jx35Ze2qIvQuOCudAyL2bejiFFVWdlg28Arc
	 8rOzREFGMPgzVBfCtswexsxXFJmlym/d4C8b7h36AKieWPtZVWOAEik13gfl4ahiV9TDV
	 AaoIeQaoKfJF9to4vyr+SKdxsaiK9kMDdNgGiiJ2eGNNutwoqK6xErCitp/w+vYpxig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111713;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=TLJdGoS9r1T7KR95Uief3yDjoKy33GQqIlCGmqAoB1k=;
	b=5G6AzfVoiRfBp1rFG4MCBOs7awZuRHC6scvHO4DO24bCjiAHmm55rJiXdEQNSOkZMDP5
	 KMf/xbSGsTQIZxEv2JA7ZuLGqdWUS+q/wWKS0Gxgop3SpQiTeu0h1H7++gqDPSzKGIMPS
	 ZG/TLd0SN3XA7seJL2myIgoyPBuTvAkfG+OSLgbvY8wI1DGA+RjvApZakC+3LdFN+k65e
	 sKXXpVj8eU6OJyZ178nR9tPu3wNp8yddmTJjqc0VllZT4G3AnDrenlVKQ0sTgufoKjWYb
	 6Zz0faj+T/sCj4I1sDyeUtfGAPxE6U2/kMXvQQjn+Faa3xdy4439skh+APCZdA0ehiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=KjJrbJf8;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E2606A324;
	Thu, 19 Nov 2026 18:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C0E2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=KjJrbJf8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=TLJdGoS9r1T7KR95Uief3yDjoKy33GQqIlCGmqAoB1k=; b=KjJrbJf89Fy6ntCyHT2J6G20qx
	8iSQUgJ+E/LEAtfBon2l5MeYNS3hvmrcMYMqdnsbxHA9hpH2jq35LhPuFzbsFUds5q71yCI5LUwNU
	EnOKnidcooVwCxHQmBAMViV85snBZ6O7a+rbYX8WhjcK8UmmfqiLaZp5BAzT2NkcMdcn9mpi+TWCj
	x3tOMQFjf6y1SQ8TgKXvLp0ol0S/uGWtd1ha0w0xKWNCUysOXqGrNS9ANCLTZXp4KyL3dM90eIVP7
	r78hPh9Ft/RRpGNpBphmEqzK8xzSIQetweteM9rYtPSn8V3v+XPCvrSx3dpCVCsHya2AU2qxhJYm1
	Uibsr1sQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Elaine Zhang <zhangqing@rock-chips.com>,
 Ulf Hansson <ulfh@kernel.org>, 1579567540@qq.com
Cc: Cunhao Lu <1579567540@qq.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v5 2/2] pmdomain: rockchip: Add RK3572 power domains
Date: Thu, 19 Nov 2026 19:08:19 +0100
Message-ID: <z4ZFdDPMSaWK2zh19ZM7pA@sntech.de>
In-Reply-To: <20261118-add-board-ok3572-c-pmdomain-v5-2-f1af919dd434@qq.com>
References:
 <20261118-add-board-ok3572-c-pmdomain-v5-0-f1af919dd434@qq.com>
 <20261118-add-board-ok3572-c-pmdomain-v5-2-f1af919dd434@qq.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Mittwoch, 18. November 2026, 10:11:40 Mitteleurop=C3=A4ische Normalzeit =
schrieb Cunhao Lu via B4 Relay:
> From: Cunhao Lu <1579567540@qq.com>
>=20
> Add the RK3572 PMU register layout and all 14 power domains, including
> bus idle requests, memory power controls and firmware shift-ready checks.
> Control the NPU voltage domain around power transitions. Keep boot-enabled
> IMG, VOP, VOP_PRE and VO domains powered until genpd releases startup
> protection after their consumers have probed.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

There are a bunch of smaller issues below, but I guess my biggest question
is around the voltage-domain stuff.

I guess the first question is, why do you need that?
The TRMs of both RK3572 and RK3588 have the voltage-domain power-control
registers, but why do you need to control them now?


Side-question, how are voltage-domains handled on the other SoCs.
The RK3588 also has the PMU_VOL_GATE_CONx registers, so I guess
they could also be turned off?


But in general, if you need to enable the voltage-domain to enable the
power-domain inside it, this really sounds more like a power-domain of
a different type - because the wiggling inside the power-domain
handling below looks strange, and we already are handling domain
trees.


> @@ -377,15 +417,16 @@ static bool rockchip_pmu_domain_is_idle(struct rock=
chip_pm_domain *pd)
>  	const struct rockchip_domain_info *pd_info =3D pd->info;
>  	unsigned int val;
> =20
> -	regmap_read(pmu->regmap, pmu->info->idle_offset, &val);
> +	regmap_read(pmu->regmap, pmu->info->idle_offset + pd_info->status_offse=
t, &val);
>  	return (val & pd_info->idle_mask) =3D=3D pd_info->idle_mask;
>  }
> =20
> -static unsigned int rockchip_pmu_read_ack(struct rockchip_pmu *pmu)
> +static unsigned int rockchip_pmu_read_ack(struct rockchip_pm_domain *pd)
>  {
> +	struct rockchip_pmu *pmu =3D pd->pmu;
>  	unsigned int val;
> =20
> -	regmap_read(pmu->regmap, pmu->info->ack_offset, &val);
> +	regmap_read(pmu->regmap, pmu->info->ack_offset + pd->info->status_offse=
t, &val);
>  	return val;
>  }
> =20
> @@ -394,7 +435,7 @@ static int rockchip_pmu_ungate_clk(struct rockchip_pm=
_domain *pd, bool ungate)
>  	const struct rockchip_domain_info *pd_info =3D pd->info;
>  	struct rockchip_pmu *pmu =3D pd->pmu;
>  	unsigned int val;
> -	int clk_ungate_w_mask =3D pd_info->clk_ungate_mask << 16;
> +	u32 clk_ungate_w_mask =3D (u32)pd_info->clk_ungate_mask << 16;

why does it need to be u32 now?
Yes, the mask should probably be u32, but why not change simply change
the global type then?

> =20
>  	if (!pd_info->clk_ungate_mask)
>  		return 0;
> @@ -404,7 +445,8 @@ static int rockchip_pmu_ungate_clk(struct rockchip_pm=
_domain *pd, bool ungate)
> =20
>  	val =3D ungate ? (pd_info->clk_ungate_mask | clk_ungate_w_mask) :
>  			clk_ungate_w_mask;
> -	regmap_write(pmu->regmap, pmu->info->clk_ungate_offset, val);
> +	regmap_write(pmu->regmap,
> +		     pmu->info->clk_ungate_offset + pd_info->clk_ungate_offset, val);

both the clk_ungate_offset + status_offset addition should probably be
separate patches, as they should get a descriptive commit message on
why they are needed.

As this then also includes the changes to rockchip_pmu_set_idle_request()
and rockchip_pmu_read_ack (pmu -> pd parameter change), this would also
bring this diff down a lot :-)

I assume the reason is that Rockchip engineers again sprinkled necessary
information bits in even more random places.


> =20
>  	return 0;
>  }
> @@ -433,9 +475,8 @@ static int rockchip_pmu_set_idle_request(struct rockc=
hip_pm_domain *pd,
> =20
>  	wmb();
> =20
> -	/* Wait util idle_ack =3D 1 */
>  	target_ack =3D idle ? pd_info->ack_mask : 0;
> -	ret =3D readx_poll_timeout_atomic(rockchip_pmu_read_ack, pmu, val,
> +	ret =3D readx_poll_timeout_atomic(rockchip_pmu_read_ack, pd, val,
>  					(val & pd_info->ack_mask) =3D=3D target_ack,
>  					0, 10000);
>  	if (ret) {
> @@ -547,6 +588,9 @@ static bool rockchip_pmu_domain_is_chain_on(struct ro=
ckchip_pm_domain *pd)
>  	regmap_read(pmu->regmap,
>  		    pmu->info->chain_status_offset + pd->info->mem_offset, &val);
> =20
> +	if (pmu->info->chain_status_inverted)
> +		return !(val & pd->info->mem_status_mask);
> +

again, introducing this new parameter should get its own commit and
descriptive message on what this does.


>  	/* 1'b1: power on, 1'b0: power off */
>  	return val & pd->info->mem_status_mask;
>  }
> @@ -671,9 +715,37 @@ static void rockchip_pd_power_on_rollback(struct roc=
kchip_pm_domain *pd)
>  			pd->genpd.name, ret);
>  }
> =20
> +static void rockchip_pmu_vd_on(struct rockchip_pm_domain *pd, bool on)
> +{
> +	const struct rockchip_domain_info *pd_info =3D pd->info;
> +	struct rockchip_pmu *pmu =3D pd->pmu;
> +	unsigned int val;
> +
> +	if (!pd_info->vd_en)
> +		return;
> +
> +	val =3D on ? pd_info->pwr_w_mask : pd_info->pwr_mask | pd_info->pwr_w_m=
ask;
> +	regmap_write(pmu->regmap, pmu->info->vd_offset + pd_info->pwr_offset, v=
al);
> +}
> +
> +static int rockchip_pmu_wait_fw_shift_ready(struct rockchip_pm_domain *p=
d)
> +{
> +	struct rockchip_pmu *pmu =3D pd->pmu;
> +	u32 mask =3D pd->info->fw_mask;
> +	unsigned int val;
> +
> +	if (!mask)
> +		return 0;
> +
> +	return regmap_read_poll_timeout(pmu->grf, pmu->info->fw_status_offset,
> +				       val, (val & mask) =3D=3D mask, 0, 10000);
> +}

this definitly also needs way more explanation



