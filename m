Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477788;
	b=nCPvv2rfIjSMCvXK0aW/OkHU+jVRRcXeotpyHk+hp7jt5y/SRCxb/fuTcz49QVpeBi3V
	 6TgiQq3FNZZQCal4YwwTo+iDrQEzo2rjfpu+xoki+IkYU4KahhwSLONIxYdz0583H+dq6
	 scmEdXq4QI3m+MhkqGGCqKFP5Y4U0/5xRI2neb/dZgQY1Nk0mbNKM0XzxTaXqZqitK5Tq
	 XNnLCN9wjcbO8s3kvMZvmDSitc5ulGSo4FTWmz/BjnVmhQEJTivn2/FZC0Zz9H3jh4k9P
	 JBTQ99X7uUAicwC6JFfTo/e2q11jfweNhVALUAwHO//WBGw3KC2EtiCjiz+3kGztqyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477788;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=UzH9Gy8A8A7Gmczo+15yN7CtFIAX2kMFLOJ6FJfiQxU=;
	b=Ld9F/X8zOZqraENoGq+2IqY4z8loO0hcvZL9JHJCe8X3GISVFAoOZlI8qZeQHxz9LVrx
	 1w2lKEDB4DwLlDrTrPsQRzwBsA8hKEW2I5In+ijGmxfSrmRMXcf4ArMcScEB5kekemLMx
	 /e79nVu4hfj9/sWPlVafgZc9mk7/aD+FnWnjqfm0ifYhv01wLTEZU6I8wLWCtpZmWftn4
	 hx3IpeQws26Zk9HMP34mLhxtdwOh0eFiGdIazv2rMmRCCTRZ0LBrc3EUJpVPiWjm3P1Gx
	 BzggtD7JPxG9fSpXHAzfNAuCsMthqLRZnvv+En75J5fURREkLO51ltLPN61lomMmULA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=EQ9GHSp+;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7CC606A321;
	Thu, 12 Nov 2026 10:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A7CC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=EQ9GHSp+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=UzH9Gy8A8A7Gmczo+15yN7CtFIAX2kMFLOJ6FJfiQxU=; b=EQ9GHSp+a9kQYf/l6W8j65o+MU
	kH9QRH7JGNkpidLJMRYIJnpHAd25fzuyjBsJGUurment3Z9oks+Hyqn/74APOhjT1fTc8O6zDTZ4f
	ROLFUHmxG3u34ViWDeItxhxnGcHUvVU92K1nb+hnzLxsHg20K76v9UnmJv3WYiMjltKNmAvfvQIkc
	JGkrtbgZHHQTEmFSaTbLKgAJlGQbh4SoNRO4TVMe/q5k1c5jGIZpiKIj7uzSibErUT+bQd8QAYIBb
	TvhAO9GyTUrwfc/I49RTM4Mm0uuv7P8akWIvujyAhZ6CpnMiGvP9BCm7aOfdivxCl+rPUzz0iZVGA
	1zoXZ6Uw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Ulf Hansson <ulfh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Kevin Hilman <khilman@linaro.org>, Caesar Wang <wxt@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, aiyengar1990@gmail.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yao Zi <me@ziyao.cc>, Igor Pecovnik <igor@armbian.com>,
 Arun Iyengar <aiyengar1990@gmail.com>
Subject: Re: [PATCH v2 2/2] pmdomain: rockchip: report domain errors once,
 with dev_err_probe()
Date: Thu, 12 Nov 2026 11:02:55 +0100
Message-ID: <vl0MwP82Qg6ZXLwjtntobA@sntech.de>
In-Reply-To: <20261112-pmdomain-rockchip-v2-2-5cd942a23df7@gmail.com>
References:
 <20261112-pmdomain-rockchip-v2-0-5cd942a23df7@gmail.com>
 <20261112-pmdomain-rockchip-v2-2-5cd942a23df7@gmail.com>
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

Am Donnerstag, 12. November 2026, 09:23:30 Mitteleurop=C3=A4ische Normalzei=
t schrieb Arun Iyengar via B4 Relay:
> From: Arun Iyengar <aiyengar1990@gmail.com>
>=20
> When a power domain clock is not available yet,
> rockchip_pm_add_one_domain() returns -EPROBE_DEFER, and both it and its
> callers rockchip_pm_domain_probe() and rockchip_pm_add_subdomain() print
> that with dev_err():
>=20
>   rockchip-pm-domain ...: power-domain: failed to get clk at index 1: -517
>   rockchip-pm-domain ...: failed to handle node power-domain: -517
>=20
> once per probe attempt, and the second line twice for a nested domain.
> On an RK3588 board whose NPU domain clock appears late this is more than
> 20 error lines before the domain finally probes, and the reason of the
> deferral is not recorded. Other failures are reported twice (once where
> they happen and once by the callers), or only by the callers, which name
> the node but not what failed: a missing pm_qos phandle and a pm_qos node
> without a regmap print nothing in rockchip_pm_add_one_domain(), and a
> failed clk_bulk_prepare() only has the message of the clk core, which
> names neither the device nor the domain.
>=20
> Report every error once, where it happens, with dev_err_probe(), and
> drop the "failed to handle (subdomain) node" messages from the callers.
> A deferral is then quiet and keeps its specific reason in
> /sys/kernel/debug/devices_deferred, such as "failed to get clk at index
> 1", and -ENOMEM, which the callers used to print, is quiet as well. The
> return values are unchanged, except that a failed
> syscon_node_to_regmap() for a pm_qos node now returns its own error
> instead of -ENODEV: it can be -EPROBE_DEFER (a syscon regmap that is
> not registered yet, or a syscon clock or hwlock that is not available
> yet), which must not turn into a probe failure.
>=20
> Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain drive=
r")
> Fixes: 6be05b5ec161 ("soc: rockchip: power-domain: add support for sub-po=
wer domains")
> Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

code change itself looks fine, but pretty please cut down the text length
in all your patches a lot.

You're simply converting to dev_err_probe here to not show defer messages.
This does definitly not need 3 quite long paragraphs of text.

This applys for all patches you sent recently :-) .

Same is true for the big'ish comment blocks you have in patch1 of this
series (and other series too). They should be short and to the point.

If needed people can get deeper information reading the actual code.


Thanks
Heiko


> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 98 +++++++++++++++-------------=
=2D-----
>  1 file changed, 43 insertions(+), 55 deletions(-)
>=20
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 00c7e78f89b5..be077fb52f40 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -804,28 +804,22 @@ static int rockchip_pm_add_one_domain(struct rockch=
ip_pmu *pmu,
>  	int error;
> =20
>  	error =3D of_property_read_u32(node, "reg", &id);
> -	if (error) {
> -		dev_err(pmu->dev,
> -			"%pOFn: failed to retrieve domain id (reg): %d\n",
> -			node, error);
> -		return -EINVAL;
> -	}
> +	if (error)
> +		return dev_err_probe(pmu->dev, -EINVAL,
> +				     "%pOFn: failed to retrieve domain id (reg)\n",
> +				     node);
> =20
> -	if (id >=3D pmu->info->num_domains) {
> -		dev_err(pmu->dev, "%pOFn: invalid domain id %d\n",
> -			node, id);
> -		return -EINVAL;
> -	}
> +	if (id >=3D pmu->info->num_domains)
> +		return dev_err_probe(pmu->dev, -EINVAL,
> +				     "%pOFn: invalid domain id %d\n", node, id);
>  	/* RK3588 has domains with two parents (RKVDEC0/RKVDEC1) */
>  	if (pmu->genpd_data.domains[id])
>  		return 0;
> =20
>  	pd_info =3D &pmu->info->domain_info[id];
> -	if (!pd_info->pwr_mask && !pd_info->req_mask) {
> -		dev_err(pmu->dev, "%pOFn: undefined domain id %d\n",
> -			node, id);
> -		return -EINVAL;
> -	}
> +	if (!pd_info->pwr_mask && !pd_info->req_mask)
> +		return dev_err_probe(pmu->dev, -EINVAL,
> +				     "%pOFn: undefined domain id %d\n", node, id);
> =20
>  	pd =3D devm_kzalloc_obj(pmu->dev, *pd);
>  	if (!pd)
> @@ -849,17 +843,20 @@ static int rockchip_pm_add_one_domain(struct rockch=
ip_pmu *pmu,
>  	for (i =3D 0; i < pd->num_clks; i++) {
>  		pd->clks[i].clk =3D of_clk_get(node, i);
>  		if (IS_ERR(pd->clks[i].clk)) {
> -			error =3D PTR_ERR(pd->clks[i].clk);
> -			dev_err(pmu->dev,
> -				"%pOFn: failed to get clk at index %d: %d\n",
> -				node, i, error);
> +			error =3D dev_err_probe(pmu->dev,
> +					      PTR_ERR(pd->clks[i].clk),
> +					      "%pOFn: failed to get clk at index %d\n",
> +					      node, i);
>  			goto err_put_clocks;
>  		}
>  	}
> =20
>  	error =3D clk_bulk_prepare(pd->num_clks, pd->clks);
> -	if (error)
> +	if (error) {
> +		dev_err_probe(pmu->dev, error,
> +			      "%pOFn: failed to prepare clocks\n", node);
>  		goto err_put_clocks;
> +	}
> =20
>  	pd->num_qos =3D of_count_phandle_with_args(node, "pm_qos",
>  						 NULL);
> @@ -884,13 +881,18 @@ static int rockchip_pm_add_one_domain(struct rockch=
ip_pmu *pmu,
>  		for (j =3D 0; j < pd->num_qos; j++) {
>  			qos_node =3D of_parse_phandle(node, "pm_qos", j);
>  			if (!qos_node) {
> -				error =3D -ENODEV;
> +				error =3D dev_err_probe(pmu->dev, -ENODEV,
> +						      "%pOFn: failed to get pm_qos %d\n",
> +						      node, j);
>  				goto err_unprepare_clocks;
>  			}
>  			pd->qos_regmap[j] =3D syscon_node_to_regmap(qos_node);
>  			of_node_put(qos_node);
>  			if (IS_ERR(pd->qos_regmap[j])) {
> -				error =3D -ENODEV;
> +				error =3D dev_err_probe(pmu->dev,
> +						      PTR_ERR(pd->qos_regmap[j]),
> +						      "%pOFn: failed to get pm_qos %d regmap\n",
> +						      node, j);
>  				goto err_unprepare_clocks;
>  			}
>  		}
> @@ -1038,39 +1040,31 @@ static int rockchip_pm_add_subdomain(struct rockc=
hip_pmu *pmu,
>  		u32 idx;
> =20
>  		error =3D of_property_read_u32(parent, "reg", &idx);
> -		if (error) {
> -			dev_err(pmu->dev,
> -				"%pOFn: failed to retrieve domain id (reg): %d\n",
> -				parent, error);
> -			return error;
> -		}
> +		if (error)
> +			return dev_err_probe(pmu->dev, error,
> +					     "%pOFn: failed to retrieve domain id (reg)\n",
> +					     parent);
>  		parent_domain =3D pmu->genpd_data.domains[idx];
> =20
>  		error =3D rockchip_pm_add_one_domain(pmu, np);
> -		if (error) {
> -			dev_err(pmu->dev, "failed to handle node %pOFn: %d\n",
> -				np, error);
> +		if (error)
>  			return error;
> -		}
> =20
>  		error =3D of_property_read_u32(np, "reg", &idx);
> -		if (error) {
> -			dev_err(pmu->dev,
> -				"%pOFn: failed to retrieve domain id (reg): %d\n",
> -				np, error);
> -			return error;
> -		}
> +		if (error)
> +			return dev_err_probe(pmu->dev, error,
> +					     "%pOFn: failed to retrieve domain id (reg)\n",
> +					     np);
>  		child_domain =3D pmu->genpd_data.domains[idx];
> =20
>  		error =3D pm_genpd_add_subdomain(parent_domain, child_domain);
> -		if (error) {
> -			dev_err(pmu->dev, "%s failed to add subdomain %s: %d\n",
> -				parent_domain->name, child_domain->name, error);
> -			return error;
> -		} else {
> -			dev_dbg(pmu->dev, "%s add subdomain: %s\n",
> -				parent_domain->name, child_domain->name);
> -		}
> +		if (error)
> +			return dev_err_probe(pmu->dev, error,
> +					     "%s failed to add subdomain %s\n",
> +					     parent_domain->name, child_domain->name);
> +
> +		dev_dbg(pmu->dev, "%s add subdomain: %s\n",
> +			parent_domain->name, child_domain->name);
> =20
>  		error =3D rockchip_pm_add_subdomain(pmu, np);
>  		if (error)
> @@ -1141,18 +1135,12 @@ static int rockchip_pm_domain_probe(struct platfo=
rm_device *pdev)
> =20
>  	for_each_available_child_of_node_scoped(np, node) {
>  		error =3D rockchip_pm_add_one_domain(pmu, node);
> -		if (error) {
> -			dev_err(dev, "failed to handle node %pOFn: %d\n",
> -				node, error);
> +		if (error)
>  			goto err_out;
> -		}
> =20
>  		error =3D rockchip_pm_add_subdomain(pmu, node);
> -		if (error < 0) {
> -			dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
> -				node, error);
> +		if (error < 0)
>  			goto err_out;
> -		}
>  	}
> =20
>  	if (error) {
>=20
>=20




