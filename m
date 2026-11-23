Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433960;
	b=RTY/jreG22Gy7yWVnhoP0iB7165vAOMEdrFFeDFmKlh1g1MAz+u/UcoQqCgxyxk4sqNS
	 GXAI2HfYYXSLaXFLGLWy+x2cL+DlO2sUk7Dn2FOWotjaG9PD2p4+n5dyJYFkF0FKpwajx
	 mRV6hFgyozpsfvqpP8TyxUdVgMy74ztVDIXF/5tfUYZPDacprQnhJROzH6m/UPQrXnVYf
	 rbUZg978T9Re2ebH9+XPyiS80p3vp9/zbdtBdDGExw5vKI3xc8i+cyUedyJRJkWTZc003
	 JDZRL4gtEiUiBBrF/TEs6xVtLCA2e4qLluaCfAW/c7uqMRjlaOpEbvuJUNgSvWYMfSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433960;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=HHGmLupEWefFEvnztUn4+WoF1FkERF+EXpdnacXhrEo=;
	b=XEnQY4CQ6GMCBIGUMBldmVT/8th38bOJmU0YRpMG8hG3FAFfhl+oGhvCN1bOS+a85Ifg
	 ou5U+VTHsRLRa5a1AkAsphoSCtAW5Xo2sKlw0dsnUTwoZdKKWMFp5P75unKFpg3EA152U
	 mrzGuCmpynDknVdOyI9uD7bambQrnqcWzMwsNqDfr/DLyOBzNEWNG9VijnViU6jNdXt+y
	 ZnI4F818RFGB6ZpxgZ7VxXfrjzXaF6j4s+8rBEeTfs5oPdw5mrhnQs00/C648WuW0CDdY
	 S2qs4tdwdHF1tJYdyW3QMSNnr9lCxz5RSnn17EpJh+rJrxFfLZpyCqqiqPyyvYgajBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=SEDOM6wr;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88263606A31A;
	Mon, 23 Nov 2026 11:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88263606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=SEDOM6wr
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1E58434;
	Mon, 23 Nov 2026 12:36:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795433805;
	bh=twN40ocQKuIxsUo/Hj5ZWM2UJ1adNtywfmriFNONsX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SEDOM6wrVeABopjd6nno09PgGLDk0rJ6n6z+83f1myistJ04J56SIQ/yyvkXwdcbm
	 5ktdY8RdyH5x7SBWcgbb0eXFDM+/fKsPjwA3OMHz83mbxTWlAYfG2/5opz4pPmws+4
	 6M03F/iNxa2gK5G3D3vjJtR+JBn1tA7hE4Jq+Ftk=
Date: Mon, 23 Nov 2026 13:39:15 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 12/15] pmdomain: renesas: r8a78000: Replace sentinel
 by explicit ID map size
Message-ID: <20261123113915.GI3010398@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <ee60a54c457af21277a13e8e1db36ce83209b3f5.1795029012.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee60a54c457af21277a13e8e1db36ce83209b3f5.1795029012.git.geert+renesas@glider.be>

On Wed, Nov 18, 2026 at 08:45:00PM +0100, Geert Uytterhoeven wrote:
> The use of a sentinel in the module ID mapping array will become
> cumbersome when the need arises to find out the actual number of
> elements in the array.  Rework the mapping data structure to fix this,
> also improving naming.  Let mod_id_map_find() return an index, to be
> used for indexing additional mapping target arrays later.
> Add a MOD_ID_MAP() initialization macro for brevity.
> 
> While at it, drop the check for "!map" in mod_id_map_find(), as that
> pointer can never be NULL.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v5:
>   - New.
> ---
>  drivers/pmdomain/renesas/r8a78000-mdlc.c | 49 +++++++++++++-----------
>  1 file changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> index 1ace1fb10870f646..6477abe64511e880 100644
> --- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
> +++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> @@ -16,13 +16,23 @@
>  
>  #include <dt-bindings/power/renesas,r8a78000-mdlc.h>
>  
> -struct mod_map {
> -	int hw_id;		/* Hardware module ID or -1 sentinel */
> +struct mod_id_map_entry {
> +	u32 hw_id;		/* Hardware module ID */
>  };
>  
> +struct mod_id_map {
> +	const struct mod_id_map_entry *entries;
> +	unsigned int size;
> +};
> +
> +#define MOD_ID_MAP(_entries) .mod_map = &(struct mod_id_map) {		\
> +	.entries = _entries,						\
> +	.size = ARRAY_SIZE(_entries),					\
> +}
> +
>  struct mdlc_info {
>  	u32 base;
> -	const struct mod_map *mod_map;
> +	const struct mod_id_map *mod_map;
>  };
>  
>  /**
> @@ -41,7 +51,7 @@ struct r8a78000_mdlc_priv {
>  	struct reset_controller_dev rcdev;
>  	struct device *dev;
>  	struct device_node *np;
> -	const struct mod_map *mod_map;
> +	const struct mod_id_map *mod_map;
>  };
>  
>  static struct generic_pm_domain *r8a78000_genpd_always_on;
> @@ -77,17 +87,14 @@ static struct generic_pm_domain *r8a78000_genpd_xlate(
>  #define rcdev_to_priv(_rcdev)	\
>  	container_of(_rcdev, struct r8a78000_mdlc_priv, rcdev)
>  
> -static const struct mod_map *mod_map_find(const struct mod_map *map, u32 id)
> +static int mod_id_map_find(const struct mod_id_map *map, u32 hw_id)

Same comment as in the clock driver about prefixes and namespace
clashes.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

>  {
> -	if (!map)
> -		return NULL;
> -
> -	for (; map->hw_id >= 0; map++) {
> -		if (map->hw_id == id)
> -			return map;
> +	for (unsigned int i = 0; i < map->size; i++) {
> +		if (map->entries[i].hw_id == hw_id)
> +			return i;
>  	}
>  
> -	return NULL;
> +	return -1;
>  }
>  
>  static int r8a78000_mdlc_reset_xlate(struct reset_controller_dev *rcdev,
> @@ -95,7 +102,7 @@ static int r8a78000_mdlc_reset_xlate(struct reset_controller_dev *rcdev,
>  {
>  	struct r8a78000_mdlc_priv *priv = rcdev_to_priv(rcdev);
>  	struct device *dev = priv->dev;
> -	const struct mod_map *map;
> +	int idx;
>  	u32 id;
>  
>  	if (spec->args_count != 1)
> @@ -103,8 +110,8 @@ static int r8a78000_mdlc_reset_xlate(struct reset_controller_dev *rcdev,
>  
>  	id = spec->args[0];
>  
> -	map = mod_map_find(priv->mod_map, id);
> -	if (!map) {
> +	idx = mod_id_map_find(priv->mod_map, id);
> +	if (idx < 0) {
>  		dev_err(dev, "Unknown reset 0x%x\n", id);
>  		return -ENOENT;
>  	}
> @@ -141,9 +148,8 @@ static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
>  	struct device_node *np = dev->of_node;
>  	struct r8a78000_mdlc_priv *priv;
>  	struct of_phandle_args pd_spec;
> -	const struct mod_map *map;
>  	unsigned int id;
> -	int ret;
> +	int ret, idx;
>  
>  	ret = of_parse_phandle_with_args(np, "power-domains",
>  					 "#power-domain-cells", 0, &pd_spec);
> @@ -166,8 +172,8 @@ static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
>  	id = pd_spec.args[1];
>  	of_node_put(pd_spec.np);
>  
> -	map = mod_map_find(priv->mod_map, id);
> -	if (!map) {
> +	idx = mod_id_map_find(priv->mod_map, id);
> +	if (idx < 0) {
>  		dev_err(dev, "Unknown module 0x%x\n", id);
>  		return -ENOENT;
>  	}
> @@ -292,15 +298,14 @@ static int r8a78000_mdlc_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct mod_map r8a78000_mdlc_perw_mod_default[] = {
> +static const struct mod_id_map_entry r8a78000_mdlc_perw_mod_default[] = {
>  	{ 0x54 },	/* HSCIF0 */
> -	{ -1 }
>  };
>  
>  static const struct mdlc_info r8a78000_mdlc_default[] = {
>  	{
>  		.base = 0xc05d0000,
> -		.mod_map = r8a78000_mdlc_perw_mod_default,
> +		MOD_ID_MAP(r8a78000_mdlc_perw_mod_default),
>  	},
>  	{ /* sentinel */ }
>  };

-- 
Regards,

Laurent Pinchart
