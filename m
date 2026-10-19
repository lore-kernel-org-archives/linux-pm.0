Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BC44C8465;
	Mon, 19 Oct 2026 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420982; cv=none; b=Vo8L/TNs0dxY5UhnkDpunqdbV8J+oIOZIAtvMhj2dvoPUkvgbWUlkgY8SVltWUg0wd2PkgKIGtY1i596rucT7OVLLNmdpM3p0DWU5P8TR4DTcGnvntbX8KtswyIHxG7baRsbWP0TZ0+wZyyC1yIrngJwTZhUWY+Ddywp8d1VXXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420982; c=relaxed/simple;
	bh=WBjydfmSdmjAb4yteidOozxR8jQfv722RUew5WbpzPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YD/umZe5l1jW/g0ROoe449sRAGtc+ObLEUu5fgdiu9lejMQLV8OgEQOgTTRO5s7XCwiWXZz+vxZ9l3O7e6rULPBeEsCAIAX5rvJuDiqZyoJSt+PsOtMqhBNPQOvi1F5UdOLhEIGvykFDidQLqhLrAFrY7wL+PU+XhT0QGdUQ6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=DYaxapsY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DYaxapsY"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 82FE334;
	Mon, 19 Oct 2026 16:40:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792420851;
	bh=WBjydfmSdmjAb4yteidOozxR8jQfv722RUew5WbpzPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYaxapsYKK7FHJTSj6LUPZ5UXAa5DA0aKXN77z1fFVichWqH7BG5XIeHnMXlYcsDV
	 //y/szcLEdtUj8rWXnT8a9VT6JQPgl6wh+0q77PxPxJu4Qb07dpSLSV8I9suIznrAM
	 m420vPm6rZ0LL3AyoIT8ed5hJrOFKJS3xkVxZ88g=
Date: Mon, 19 Oct 2026 17:42:56 +0300
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
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 1/8] clk: renesas: r8a78000: Add clk_hw to clk_map
Message-ID: <20261019144256.GC763679@killaraus.ideasonboard.com>
References: <cover.1792163045.git.geert+renesas@glider.be>
 <1d7da50cfb58232c6dd4c4afefb938fd7e62fdcd.1792163045.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d7da50cfb58232c6dd4c4afefb938fd7e62fdcd.1792163045.git.geert+renesas@glider.be>

On Fri, Oct 16, 2026 at 05:55:40PM +0200, Geert Uytterhoeven wrote:
> Prepare for mapping to other than fixed-rate clocks by adding a clk_hw
> pointer to the clk_map structure, and populating it up-front.
> 
> Move r8a78000_cpg_priv.fixed_hws into fill_clk_map(), as it is no longer
> needed afterwards, and drop NUM_FIXED_CLKS.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>   - No changes,
> 
> v3:
>   - New.
> ---
>  drivers/clk/renesas/r8a78000-cpg.c | 78 +++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
> index b8024e76743ea53d..5ffd7b89cb48e41c 100644
> --- a/drivers/clk/renesas/r8a78000-cpg.c
> +++ b/drivers/clk/renesas/r8a78000-cpg.c
> @@ -16,19 +16,24 @@
>  
>  #include <dt-bindings/clock/renesas,r8a78000-cpg.h>
>  
> +struct clk_map_in {

The "_in" suffix isn't very explicit.

> +	int dt_id;		/* DT binding clock ID or -1 sentinel */
> +	u32 fw_id;		/* FIXED_CLK() ID */
> +};
> +
>  struct clk_map {
>  	int dt_id;		/* DT binding clock ID or -1 sentinel */
>  	u32 fw_id;		/* FIXED_CLK() ID */
> +	struct clk_hw *hw;
>  };
>  
>  enum fixed_clk {
>  	FIXED_CLK_66M,
>  	FIXED_CLK_133M,
>  	FIXED_CLK_266M,
> -	NUM_FIXED_CLKS
>  };
>  
> -static const unsigned long fixed_clk_rates[NUM_FIXED_CLKS] = {
> +static const unsigned long fixed_clk_rates[] = {
>  	[FIXED_CLK_66M] = 66666000,
>  	[FIXED_CLK_133M] = 133330000,
>  	[FIXED_CLK_266M] = 266660000,
> @@ -41,12 +46,10 @@ static const unsigned long fixed_clk_rates[NUM_FIXED_CLKS] = {
>   *
>   * @dev: CPG device
>   * @map: Mapping from DT clock IDs to fixed-rate clocks
> - * @fixed_hws: Fixed rate clocks
>   */
>  struct r8a78000_cpg_priv {
>  	struct device *dev;
>  	const struct clk_map *map;
> -	struct clk_hw *fixed_hws[NUM_FIXED_CLKS];
>  };
>  
>  static const struct clk_map *clk_map_find(const struct clk_map *map, u32 id)
> @@ -83,8 +86,7 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec,
>  	}
>  
>  	dev_dbg(dev, "Mapping DT clock %u to fixed clock %u\n", id, map->fw_id);
> -
> -	hw = priv->fixed_hws[map->fw_id];
> +	hw = map->hw;
>  
>  	dev_dbg(dev, "clock %u is %s at %lu Hz\n", id, clk_hw_get_name(hw),
>  		clk_hw_get_rate(hw));
> @@ -92,35 +94,69 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec,
>  	return hw;
>  }
>  
> -static int register_fixed_clks(struct r8a78000_cpg_priv *priv)
> +static struct clk_hw **register_fixed_clks(struct device *dev)
>  {
> -	struct device *dev = priv->dev;
> +	unsigned int n = ARRAY_SIZE(fixed_clk_rates);
> +	struct clk_hw **hws, *hw;
>  	unsigned long rate;
> -	struct clk_hw *hw;
>  	const char *name;
>  
> -	for (unsigned int i = 0; i < ARRAY_SIZE(fixed_clk_rates); i++) {
> +	hws = devm_kcalloc(dev, n, sizeof(*hws), GFP_KERNEL);
> +	if (!hws)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (unsigned int i = 0; i < n; i++) {
>  		rate = fixed_clk_rates[i];
>  		name = devm_kasprintf(dev, GFP_KERNEL, "cpg-%lu", rate);
>  		if (!name)
> -			return -ENOMEM;
> +			return ERR_PTR(-ENOMEM);
>  
>  		hw = devm_clk_hw_register_fixed_rate(dev, name, NULL, 0, rate);
>  		if (IS_ERR(hw))
> -			return PTR_ERR(hw);
> +			return ERR_CAST(hw);
>  
> -		priv->fixed_hws[i] = hw;
> +		hws[i] = hw;
>  	}
>  
> -	return 0;
> +	return hws;
> +}
> +
> +static const struct clk_map *fill_clk_map(struct r8a78000_cpg_priv *priv,
> +					  const struct clk_map_in *map_in)
> +{
> +	struct device *dev = priv->dev;
> +	struct clk_hw **fixed_hws;
> +	struct clk_map *map;
> +	unsigned int i;
> +
> +	fixed_hws = register_fixed_clks(dev);
> +	if (IS_ERR(fixed_hws))
> +		return ERR_CAST(fixed_hws);
> +
> +	for (i = 0; map_in[i].dt_id >= 0; i++) { }

This is avoidable by passing { map, ARRAY_SIZE(map) } as match data
instead of just the map.

> +
> +	map = devm_kcalloc(dev, i + 1, sizeof(*map), GFP_KERNEL);
> +	if (!map)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; ; i++) {
> +		map[i].dt_id = map_in[i].dt_id;
> +		if (map[i].dt_id < 0)
> +			break;
> +
> +		map[i].fw_id = map_in[i].fw_id;
> +		map[i].hw = fixed_hws[map[i].fw_id];
> +	}
> +
> +	devm_kfree(dev, fixed_hws);

Why not plain kcalloc/kfree ?

> +	return map;
>  }
>  
>  static int r8a78000_cpg_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct r8a78000_cpg_priv *priv;
> -	const struct clk_map *map;
> -	int ret;
> +	const struct clk_map_in *map;
>  
>  	map = of_device_get_match_data(dev);
>  	if (!map)
> @@ -131,16 +167,14 @@ static int r8a78000_cpg_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	priv->dev = dev;
> -	priv->map = map;
> -
> -	ret = register_fixed_clks(priv);
> -	if (ret)
> -		return ret;
> +	priv->map = fill_clk_map(priv, map);
> +	if (IS_ERR(priv->map))
> +		return PTR_ERR(priv->map);
>  
>  	return devm_of_clk_add_hw_provider(dev, r8a78000_clk_get, priv);
>  }
>  
> -static const struct clk_map r8a78000_cpg_default[] = {
> +static const struct clk_map_in r8a78000_cpg_default[] = {
>  	{ R8A78000_CPG_SGASYNCD4_PERW_BUS,	FIXED_CLK(266M) },
>  	{ R8A78000_CPG_SGASYNCD8_PERW_BUS,	FIXED_CLK(133M) },
>  	{ R8A78000_CPG_SGASYNCD16_PERW_BUS,	FIXED_CLK(66M) },

-- 
Regards,

Laurent Pinchart
