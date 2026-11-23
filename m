Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433094;
	b=M7XbCaF4scPXr5gomqBhbw64/mx9EjZrQeO9EKAO3k+cdEnaFt0TvMuaR56PR2Q3dE9Y
	 pbZQskc1I3H9A5NUBveD/fl/hzcyaVierWx3hSX39+Yqbr4/NIQe8I5yuUntmdexR6PFP
	 vfesIHVMAkclftDm7W/5Htr8my24rdv1qxrH7PJUHr/6GQLrQnIaF412HHHwFjVgF6v1E
	 T+wvPUX9qSs/SMH/8STcEYxmCVoAg/UQH1nZ5s8msj8GwBs1H3mdPSPHtFaW/EIYi0VbM
	 FO6Vt9Yn6vScMsu0kuOxIq4QRNHpCkR6yXgxMffmjNNbEmRc81qZ3n1j3CG0SD27dLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433094;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=FDLkdAG6SH1GnUEwqnA+0+a0OunQrhtXxs1sKgVVilc=;
	b=Y4nMxvTL8D/ZqUp6atykCWhItLW4NuVT6XeTT9chUr1Q0zr1Dq5Y+pQZeOhK70tN6OBV
	 etKPIhIpBtwh8O3uTYhtuMBlsFC1q9K+c3/dwmjuvHhta6HO6IXk4OHpnH6J26uNH7kIW
	 FRavGFPWEtMu9j1NYrelEHp72LIXJiDDoSTDbCYHVOjpSpR8RXFWoaj61EhLvKoP9XnNR
	 z6/k2Hy3hSSjmPsJ2PUpVuQyEYWXyVVl+8U6lSOCefx4q5Y06+0oAp50wvtB31j7OVzON
	 0FamwirD+YPK+zFHUvUmpD26F4HowpgrYbZzs/7/o7pcvKbs6/SQjP5uY6mBmXIK1Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Ti2+aFmQ;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D7B606A31A;
	Mon, 23 Nov 2026 11:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52D7B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Ti2+aFmQ
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA13C177;
	Mon, 23 Nov 2026 12:22:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795432940;
	bh=hb4P93d/CtVlWvdjmqk9rxhiNgKlW9A8FN0kJu+NlyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ti2+aFmQsLywTbAqtWhyNj/ERQn8nDDJjLUKNhy4OCjouOkuyL6EhkyX/3YTLmDf8
	 DQ1AsbEDHhsppR3ToClGA9YlqiUWzMfHopnGL0TGh1J5kv7DbtylTGPAJfNz3WUdA/
	 neI8AomK8DIaUCNfaRHKRFHmmbR3MlnhepffjMjM=
Date: Mon, 23 Nov 2026 13:24:50 +0200
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
Subject: Re: [PATCH v5 04/15] clk: renesas: r8a78000: Add clk_hw to clk_map
Message-ID: <20261123112450.GF3010398@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <ea85d72ca37bc7abc59fda5aed4b8272578922c4.1795029012.git.geert+renesas@glider.be>
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
In-Reply-To: <ea85d72ca37bc7abc59fda5aed4b8272578922c4.1795029012.git.geert+renesas@glider.be>

On Wed, Nov 18, 2026 at 08:44:52PM +0100, Geert Uytterhoeven wrote:
> Prepare for mapping to other than fixed-rate clocks by adding an array
> of clk_hw pointers, indexed by the clock map entry index, and populating
> it up-front.
> 
> Move r8a78000_cpg_priv.fixed_hws into get_hws(), as it is no longer
> needed afterwards, and drop NUM_FIXED_CLKS.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> v5:
>   - Add Tested-by,
>   - Rebase,
>   - Use kzalloc_objs() and __free() instead of devm_k{calloc,free}() for
>     the temporary array of fixed clocks,
>   - Replace devm_kcalloc() by devm_kzalloc_objs(),
>   - Replace unified clk_map by keeping the original clk_id_map and
>     adding a separate array of clk_hw pointers,
>   - Let clk_id_map_find() return an index,
>   - Replace fill_clk_map() by get_hws(),
> 
> v4:
>   - No changes,
> 
> v3:
>   - New.
> ---
>  drivers/clk/renesas/r8a78000-cpg.c | 71 ++++++++++++++++++++----------
>  1 file changed, 48 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
> index 236c638834703f95..fd97e1558d423f95 100644
> --- a/drivers/clk/renesas/r8a78000-cpg.c
> +++ b/drivers/clk/renesas/r8a78000-cpg.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2026 Glider bv
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/dev_printk.h>
> @@ -35,10 +36,9 @@ enum fixed_clk {
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
> @@ -51,31 +51,30 @@ static const unsigned long fixed_clk_rates[NUM_FIXED_CLKS] = {
>   *
>   * @dev: CPG device
>   * @map: Mapping from DT clock IDs to fixed-rate clock IDs
> - * @fixed_hws: Fixed rate clocks
> + * @hws: Clocks, indexed by @map entry index
>   */
>  struct r8a78000_cpg_priv {
>  	struct device *dev;
>  	const struct clk_id_map *map;
> -	struct clk_hw *fixed_hws[NUM_FIXED_CLKS];
> +	struct clk_hw **hws;
>  };
>  
> -static const struct clk_id_map_entry *clk_id_map_find(const struct clk_id_map *map,
> -						u32 dt_id)
> +static int clk_id_map_find(const struct clk_id_map *map, u32 dt_id)

While at it, I'd recommend adding a r8a78000_ prefix to this and other
functions below to avoid future namespace clashes.

>  {
>  	for (unsigned int i = 0; i < map->size; i++) {
>  		if (map->entries[i].dt_id == dt_id)
> -			return &map->entries[i];
> +			return i;
>  	}
>  
> -	return NULL;
> +	return -1;
>  }
>  
>  static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec, void *data)
>  {
>  	struct r8a78000_cpg_priv *priv = data;
> -	const struct clk_id_map_entry *entry;
>  	struct device *dev = priv->dev;
>  	struct clk_hw *hw;
> +	int idx;
>  	u32 id;
>  
>  	if (spec->args_count != 1)
> @@ -83,13 +82,13 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec, void *data)
>  
>  	id = spec->args[0];
>  
> -	entry = clk_id_map_find(priv->map, id);
> -	if (!entry) {
> +	idx = clk_id_map_find(priv->map, id);
> +	if (idx < 0) {
>  		dev_err(dev, "Unknown clock %u\n", id);
>  		return ERR_PTR(-ENOENT);
>  	}
>  
> -	hw = priv->fixed_hws[entry->fw_id];
> +	hw = priv->hws[idx];
>  
>  	dev_dbg(dev, "Mapping DT clock %u to %s at %lu Hz\n", id,
>  		clk_hw_get_name(hw), clk_hw_get_rate(hw));
> @@ -97,27 +96,54 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec, void *data)
>  	return hw;
>  }
>  
> -static int register_fixed_clks(struct r8a78000_cpg_priv *priv)
> +static struct clk_hw **register_fixed_clks(struct device *dev)

I would have kept the r8a78000_cpg_priv argument for consistency. Not a
big deal, up to you.

>  {
> -	struct device *dev = priv->dev;
> +	unsigned int n = ARRAY_SIZE(fixed_clk_rates);
>  	unsigned long rate;
>  	struct clk_hw *hw;
>  	const char *name;

Those three variables can be moved within the loop. Also up to you.

>  
> -	for (unsigned int i = 0; i < ARRAY_SIZE(fixed_clk_rates); i++) {
> +	struct clk_hw **hws __free(kfree) = kzalloc_objs(*hws, n);
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
> +
> +		hws[i] = hw;
> +	}
> +
> +	return_ptr(hws);
> +}
>  
> -		priv->fixed_hws[i] = hw;
> +static struct clk_hw **get_hws(struct r8a78000_cpg_priv *priv)
> +{
> +	const struct clk_id_map *map = priv->map;
> +	struct device *dev = priv->dev;
> +	struct clk_hw **hws;
> +	u16 fw_id;

This can also be moved within the loop.

> +
> +	struct clk_hw **fixed_hws __free(kfree) = register_fixed_clks(dev);
> +	if (IS_ERR(fixed_hws))
> +		return ERR_CAST(fixed_hws);
> +
> +	hws = devm_kzalloc_objs(dev, *hws, map->size);
> +	if (!hws)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (unsigned int i = 0; i < map->size; i++) {
> +		fw_id = map->entries[i].fw_id;
> +		hws[i] = fixed_hws[fw_id];
>  	}
>  
> -	return 0;
> +	return hws;
>  }
>  
>  static int r8a78000_cpg_probe(struct platform_device *pdev)
> @@ -125,7 +151,6 @@ static int r8a78000_cpg_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct r8a78000_cpg_priv *priv;
>  	const struct clk_id_map *map;
> -	int ret;
>  
>  	map = of_device_get_match_data(dev);
>  	if (!map)
> @@ -138,9 +163,9 @@ static int r8a78000_cpg_probe(struct platform_device *pdev)
>  	priv->dev = dev;
>  	priv->map = map;
>  
> -	ret = register_fixed_clks(priv);
> -	if (ret)
> -		return ret;
> +	priv->hws = get_hws(priv);
> +	if (IS_ERR(priv->hws))
> +		return PTR_ERR(priv->hws);
>  
>  	return devm_of_clk_add_hw_provider(dev, r8a78000_clk_get, priv);
>  }

-- 
Regards,

Laurent Pinchart
