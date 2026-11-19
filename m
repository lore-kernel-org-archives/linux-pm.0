Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091626;
	b=MdfxHjNtOKruuCmRan5zb5oi9/EZI+VeXCNpmA8urQ00pYCngF4NV8vRxckxrsBN03h0
	 iXUFWnV+DaE95jGkmpCKiR3lOXi983sArJ+VdCNFeCoBBk3a4mtoqH0g0GOvWEykikf4I
	 TSu0Ka5WEcFViMJ4CjzBrFHCMAHY3czjwoMmuzeFtSVZutaMhLPqvMDoqhXs+zBkcZP1b
	 OWWjo22WEhVANR22/9kTVur5WhfzIAc3FmeOvB6VE2/HmToXhAbLHnXUzSoEHiPcO8t9u
	 +X1GVOkh4uB8n6WYHzEx4c5MUfea7Z10DipCJ2LGFiW4XaGtXJO6AlHSLLkFUlB1K7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091626;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=tASzR4wXMMc0YCUiYCKzn7cgOIVewXX+hCln4mp/s0Y=;
	b=k49HS1g/OclQpPAZawzbBcndmGHQNebLhYh+IA7hbDMytl1sy87mth0JciYmYue8pKq4
	 W4WzEiirbzpqxzZUX+MQGgVmRAm6KHxZBcDJ4t5eGXUGXVhzxZ7PCN6h2GsR6Mm90qs6v
	 XuwVllrRY9JwVoCsDkuIMsav3p0nSs66Jr8CDaeLDvUD4A6sUYqVyL7QgISSSKCZCnOy6
	 VA6MtYbrHzGOIhn/NcqGGx9zVVOxI93X/QxUJF0z86DMzwsBO0FZ3MXDziy+1P0l6VGHY
	 RMQXd0IghUh8PPOEIdmRcqDseSaKrvnamZ2zg9LV+rAlVgrWv+1wjyOzlBF4Ge/EClw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=m0b8hBMx;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02C606A32F;
	Thu, 19 Nov 2026 12:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B02C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=m0b8hBMx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=tASzR4wXMMc0YCUiYCKzn7cgOIVewXX+hCln4mp/s0Y=; b=m0b8hBMxJPiifKd5Vrc1LUdxvo
	C/9lFoUO7AwB5+4VNJDtVLiKW6e1/PvUg3h8YwNppqqGxD8J9FtBKkVzaQRwg6u+ATgOmBW1Am/Sr
	spKP/EE+/EncvF2JkAQa6cc5Gj9tXjblT39lDR1BeR5G3HLX/hd//ePFePfNtvUQf5A/5+lVmVn+m
	bR09+Oj5XOHHN6qpeDZ1fBfcYu+f9LWA8KrWVbRbp3+ZntukKDgjqWugwDHYKOxEJWh2adqw3x6a3
	2OcYfOo/ejFAcVtfn15LA5q9btjRrwChiYIb5NpEywE+++Yjf+szUWO0v+8jfBNSFyXSxARb+l90a
	dXi+CK4w==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Ulf Hansson <ulfh@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Peter Geis <pgwipeout@gmail.com>, 1579567540@qq.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Cunhao Lu <1579567540@qq.com>
Subject:
 Re: [PATCH v2] pmdomain: rockchip: Roll back power-on when leaving idle fails
Date: Thu, 19 Nov 2026 13:33:40 +0100
Message-ID: <X4VYa84sR92_76QOKnT74g@sntech.de>
In-Reply-To:
 <20261118-fix-rockchip-pmdomain-power-on-rollback-v2-1-3e4e93a19996@qq.com>
References:
 <20261118-fix-rockchip-pmdomain-power-on-rollback-v2-1-3e4e93a19996@qq.com>
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

Am Mittwoch, 18. November 2026, 10:03:46 Mitteleurop=C3=A4ische Normalzeit =
schrieb Cunhao Lu via B4 Relay:
> From: Cunhao Lu <1579567540@qq.com>
>=20
> When NIU idle exit fails after PMU power-on, clocks and the regulator
> reference are released while the domain remains powered. genpd treats
> it as off and may power off its parents.
>=20
> Request idle again and, if successful, use the low-level power-off path
> before releasing resources. This preserves saved QoS and notifies
> firmware while retaining the original error.
>=20
> If rollback fails, resources are still released and genpd may power off
> the parents.
>=20
> Fixes: 6b2690df3f03 ("pmdomain: rockchip: fix rockchip_pd_power error han=
dling")
> Signed-off-by: Cunhao Lu <1579567540@qq.com>


Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> This pre-existing idle-exit failure case was reported by Sashiko AI
> during the RK3572 mainlining work:
> https://sashiko.dev/#/patchset/20261022-add-board-ok3572-c-v1-0-0b0fd85a3=
1ee@qq.com?part=3D10
>=20
> If leaving NIU idle fails after PMU power-on, the domain remains powered
> while genpd treats it as off. The error path releases the clocks and
> regulator reference, and genpd may power off the parent domains.
>=20
> This patch requests idle again and, if successful, powers the domain
> off before releasing those resources. It preserves the saved QoS state
> and original error, and uses the low-level path to notify firmware.
>=20
> Validation:
>=20
> - All 48 host simulations passed, covering power cycles, idle-exit and
>   rollback failures, QoS preservation and error propagation. No sanitizer
>   findings.
>=20
> - Hardware testing on OK3572-C: 20 patched and 50 unpatched NVM1 power
>   cycles passed. Request-write injection caused native idle-exit polling
>   timeouts. The fix powered the domain off in 3/3 cases; the original
>   driver left it ON. QoS and the original error were preserved, and
>   retries succeeded after removing the injection.
>=20
> Persistent rollback idle and power-off timeouts were also tested:
> resources were still released with the domain ON and genpd OFF. These
> failure paths remain unresolved, and genpd may still power off the parent=
s.
>=20
> AI assistance:
>=20
> - Codex / DeepSeek V4.1 Flash were used for:
>   - Reviewing and adjusting code style to follow community conventions
>   - Automating tests
>   - Collecting data
> ---
> Changes in v2:
> - Rebase onto the next branch of Ulf Hansson's linux-pm.git tree.
> - Link to v1:
>   https://patch.msgid.link/20261101-fix-rockchip-pmdomain-power-on-rollba=
ck-v1-1-59a45783e33e@qq.com
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 6abef60a5b4c..2c021784316a 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -648,6 +648,29 @@ static int rockchip_do_pmu_set_power_domain(struct r=
ockchip_pm_domain *pd,
>  	return 0;
>  }
> =20
> +/*
> + * The caller holds the PMU lock and transition resources. Use the low-l=
evel
> + * power-off path to avoid overwriting the saved QoS state.
> + */
> +static void rockchip_pd_power_on_rollback(struct rockchip_pm_domain *pd)
> +{
> +	int ret;
> +
> +	ret =3D rockchip_pmu_set_idle_request(pd, true);
> +	if (ret < 0) {
> +		dev_err(pd->pmu->dev,
> +			"failed to idle domain '%s' on rollback: %d\n",
> +			pd->genpd.name, ret);
> +		return;
> +	}
> +
> +	ret =3D rockchip_do_pmu_set_power_domain(pd, false);
> +	if (ret < 0)
> +		dev_err(pd->pmu->dev,
> +			"failed to power off domain '%s' on rollback: %d\n",
> +			pd->genpd.name, ret);
> +}
> +
>  static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_o=
n)
>  {
>  	struct rockchip_pmu *pmu =3D pd->pmu;
> @@ -682,8 +705,10 @@ static int rockchip_pd_power(struct rockchip_pm_doma=
in *pd, bool power_on)
>  	if (power_on) {
>  		/* if powering up, leave idle mode */
>  		ret =3D rockchip_pmu_set_idle_request(pd, false);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			rockchip_pd_power_on_rollback(pd);
>  			goto out;
> +		}
> =20
>  		rockchip_pmu_restore_qos(pd);
>  	}
>=20
> ---
> base-commit: 6f5c8ec9302c5ad8904dbdfe8cf2a538ff835572
> change-id: 20261101-fix-rockchip-pmdomain-power-on-rollback-c11e1014ef11
>=20
> Best regards,
> -- =20
> Cunhao Lu <1579567540@qq.com>
>=20
>=20
>=20




