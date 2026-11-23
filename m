Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433785;
	b=SKwDaaYw73ZCGop01rxWpLZgcEoY6eyTuQOGMPxscOuIEDDf26aDolNRyDhHiM4ORhDv
	 ie24bNOPZNExiX7TuILUietr4jiQYs9YhPWLfnbk1arZV//viSdBugC+3Eh3T6CwnF24J
	 xfpz5E9wT8ce17jyPxfL1+STPxPY1Dx1DzxgceX9MwXO0dH0xMQKzgDE4IcNZc8tUDCvg
	 ttBR+mqWlGh+55K21FPyDI4dXmU7vvylhwUIQklGtzPmGanRJMfNughLxVJiSNOWcL7nO
	 A9JCyw6f0QcPsGnuitC2TLqZmhQVKObnMLrBqJM2+sl12t1Pad0J1nOj/fRkqlqy+MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433785;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=AqKDkVCc+ma8DfZzvwmYcLwZzBow+0g4RNWtKgVpuno=;
	b=Pp4DIhswMxhkvZCdbY/lwBomLWZq5XsgFMBmkythcXm07wxV763ZcR6ndCaQAm8lEWFl
	 UT28za88BaXaeWdcW+8EUx/vGPrQcYVDWksOXWarBM6XLjwa0+YuFQz/VF4WbkHVs6fe3
	 Or6TwXc1MoDOrFHpv2W7d88zYIRE65jix0hRhqGFZp9PiKlqzD/pCFJ5fqxrOQz3oXFSY
	 ELfLkVP5zLjWZ46FmC96C9JG6ZiixEPeAYJhbzNbNL6EPiZITT07m6zaXfUFdynjofcEK
	 JFFIrKMpP6qp1qJQ5RIH2OrqwFDwvg2JeWQhXq0ZvDNgzQ9tt/umUjfWUraDdE3hrsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=CPBca2Ww;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7246C606A321;
	Mon, 23 Nov 2026 11:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7246C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=CPBca2Ww
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9137B73E;
	Mon, 23 Nov 2026 12:33:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795433628;
	bh=r/VyJRxouv14sVztniDLkuimITGGQSgCIZTM7u5do8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPBca2WwY2nKuSdUuPpw/AQcV5NfgQ4l9v8srMvn8cbj7vyWBBoBBCt+bDsscueiP
	 Eq4SG7wj7md3sQhx936PMh7NIRwAkQVDWdsr1cn9+eMSdHaAfE4e2C4s7lBfr63Zuw
	 nDYzuSyKmhWK4HBkP8m0sEBa4xK9Y5qna6VK0jeQ=
Date: Mon, 23 Nov 2026 13:36:19 +0200
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
Subject: Re: [PATCH v5 05/15] clk: renesas: r8a78000: Add SCMI remapping
 support
Message-ID: <20261123113619.GG3010398@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <e01baebc546ed6f1b71a0487a59cda73239ea7f1.1795029012.git.geert+renesas@glider.be>
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
In-Reply-To: <e01baebc546ed6f1b71a0487a59cda73239ea7f1.1795029012.git.geert+renesas@glider.be>

On Wed, Nov 18, 2026 at 08:44:53PM +0100, Geert Uytterhoeven wrote:
> Extend the Clock Pulse Generator driver for R-Car X5H with SCMI support,
> to remap DT clock IDs to abstractions (clocks) offered by the SCMI
> firmware when running on a system with SCMI, and SCMI support is
> enabled.  Take into account some peculiarities of the current SCMI
> firmware implementations, and fall-back to fixed-rate clocks as
> replacements for SCMI clocks that are not available.
> Support for bus clocks used by serial, I2C, and SPI devices is included.
> 
> This lets us avoid putting SCMI IDs in DT, and allows us to use the same
> hardware description in SoC DTS for systems with and without SCMI
> firmware.
> 
> For now, it is assumed SCMI clock IDs are stable, and match SCP FW
> SDKv4.31.0 and later.
> 
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> v5:
>   - Add Tested-by,
>   - Rebase,
>   - Shrink firmware clock IDs to 16 bits,
>   - Add parentheses to FIXED_CLK() macro definition,
>   - Extract get_fallback() and simplify fallback code,
>   - Rework mapping data structures,
>   - Add missing clk_put() after of_clk_get_from_provider() in get_hws(),
> 
> v4:
>   - Drop unneeded IS_ERR() check after __clk_get_hw(),
>   - Mark scmi_clk_np __free(device_node),
>   - Assume all SCMI clock IDs are stable, and drop support for handling
>     different ID spaces,
>   - Include initial mapping table for SCP FW SDKv4.31.0 and later,
>   - Try SCMI clocks first, and fall back to the default fixed-frequency
>     clocks when not available, as recent firmware versions no longer
>     restrict access to some bus clocks,
>   - Drop renesas,scmi-firmware support, just find an arm,scmi node
>     instead,
>   - Fall back to the non-SCMI defaults when SCMI clock support is
>     disabled,
> 
> v3:
>   - Rebase,
>   - Consistently use /* sentinel */ for zero sentinels,
>   - s/firmware/renesas,scmi-firmware/,
>   - Reword,
> 
> v2:
>   - Spin off from "clk: renesas: Add R-Car X5H CPG SCMI remapping
>     driver",
>   - Use reverse xmas ordering in r8a78000_cpg_probe(),
>   - Propagate error codes from scmi_get_base_info() now it can return
>     -EPROBE_DEFER,
>   - Improve error message on scmi_get_base_info() failure,
>   - Check if SCMI firmware node is available,
>   - Replace the scmi_clk_np member of struct r8a78000_cpg_priv by a
>     local variable in r8a78000_cpg_probe(), and pass it to
>     fill_clk_map(),
>   - Join split short lines,
>   - Fall back to the default support when SCMI support or firmware is
>     not available, or when the detected SCMI firmware version is not
>     supported by the driver,
>   - Drop mapping tables.
> ---
>  drivers/clk/renesas/r8a78000-cpg.c | 138 ++++++++++++++++++++++++++---
>  1 file changed, 128 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
> index fd97e1558d423f95..9a6e4f76581e4c24 100644
> --- a/drivers/clk/renesas/r8a78000-cpg.c
> +++ b/drivers/clk/renesas/r8a78000-cpg.c
> @@ -13,13 +13,14 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/scmi_protocol.h>
>  #include <linux/slab.h>
>  
>  #include <dt-bindings/clock/renesas,r8a78000-cpg.h>
>  
>  struct clk_id_map_entry {
>  	u16 dt_id;		/* DT binding clock ID */
> -	u16 fw_id;		/* FIXED_CLK() ID */
> +	u16 fw_id;		/* SCMI firmware clock ID or FIXED_CLK() ID */
>  };
>  
>  struct clk_id_map {
> @@ -32,6 +33,11 @@ struct clk_id_map {
>  	.size = ARRAY_SIZE(_entries),			\
>  }
>  
> +struct cpg_data {
> +	const struct clk_id_map *default_map;
> +	const struct clk_id_map *fw_map;
> +};
> +
>  enum fixed_clk {
>  	FIXED_CLK_66M,
>  	FIXED_CLK_133M,
> @@ -44,13 +50,14 @@ static const unsigned long fixed_clk_rates[] = {
>  	[FIXED_CLK_266M] = 266660000,
>  };
>  
> -#define FIXED_CLK(rate)		FIXED_CLK_ ## rate
> +#define FIXED_CLK_OFFSET	0x8000
> +#define FIXED_CLK(rate)		(FIXED_CLK_OFFSET + FIXED_CLK_ ## rate)
>  
>  /**
>   * struct r8a78000_cpg_priv - Clock Pulse Generator Private Data
>   *
>   * @dev: CPG device
> - * @map: Mapping from DT clock IDs to fixed-rate clock IDs
> + * @map: Mapping from DT clock IDs to SCMI or fixed-rate clock IDs
>   * @hws: Clocks, indexed by @map entry index
>   */
>  struct r8a78000_cpg_priv {
> @@ -89,6 +96,11 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec, void *data)
>  	}
>  
>  	hw = priv->hws[idx];
> +	if (!hw) {
> +		/* CLOCK_ATTRIBUTES is not supported */
> +		dev_err(dev, "Clock %u is not available\n", id);
> +		return ERR_PTR(-ENOENT);
> +	}
>  
>  	dev_dbg(dev, "Mapping DT clock %u to %s at %lu Hz\n", id,
>  		clk_hw_get_name(hw), clk_hw_get_rate(hw));
> @@ -96,6 +108,21 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec, void *data)
>  	return hw;
>  }
>  
> +static struct device_node *scmi_find_proto(struct device_node *scmi, u32 proto)

r8a78000_ prefix. Same below.

> +{
> +	for_each_available_child_of_node_scoped(scmi, child) {
> +		u32 reg;
> +
> +		if (of_property_read_u32(child, "reg", &reg))
> +			continue;
> +
> +		if (reg == proto)
> +			return_ptr(child);
> +	}
> +
> +	return NULL;
> +}
> +
>  static struct clk_hw **register_fixed_clks(struct device *dev)
>  {
>  	unsigned int n = ARRAY_SIZE(fixed_clk_rates);
> @@ -123,11 +150,26 @@ static struct clk_hw **register_fixed_clks(struct device *dev)
>  	return_ptr(hws);
>  }
>  
> -static struct clk_hw **get_hws(struct r8a78000_cpg_priv *priv)
> +static struct clk_hw *get_fallback(const struct clk_id_map *map, u16 dt_id,
> +				   struct clk_hw **fixed_hws)
> +{
> +	for (unsigned int i = 0; i < map->size; i++) {
> +		if (map->entries[i].dt_id == dt_id)

			if (WARN_ON(map->entries[i].fw_id < FIXED_CLK_OFFSET))
				return NULL;

may make catching future mistakes easier. Up to you.

> +			return fixed_hws[map->entries[i].fw_id - FIXED_CLK_OFFSET];
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct clk_hw **get_hws(struct r8a78000_cpg_priv *priv,
> +			       const struct clk_id_map *fallback,
> +			       struct device_node *scmi_clk_np)
>  {
>  	const struct clk_id_map *map = priv->map;
> +	struct of_phandle_args scmi_spec;
>  	struct device *dev = priv->dev;
> -	struct clk_hw **hws;
> +	struct clk_hw **hws, *hw;
> +	struct clk *clk;
>  	u16 fw_id;
>  
>  	struct clk_hw **fixed_hws __free(kfree) = register_fixed_clks(dev);
> @@ -140,7 +182,35 @@ static struct clk_hw **get_hws(struct r8a78000_cpg_priv *priv)
>  
>  	for (unsigned int i = 0; i < map->size; i++) {
>  		fw_id = map->entries[i].fw_id;
> -		hws[i] = fixed_hws[fw_id];
> +		if (fw_id >= FIXED_CLK_OFFSET) {
> +			hws[i] = fixed_hws[fw_id - FIXED_CLK_OFFSET];
> +			continue;
> +		}
> +
> +		scmi_spec.np = scmi_clk_np;
> +		scmi_spec.args_count = 1;
> +		scmi_spec.args[0] = fw_id;
> +
> +		clk = of_clk_get_from_provider(&scmi_spec);
> +		if (IS_ERR(clk))
> +			return dev_err_cast_probe(dev, clk,
> +				"Failed to get SCMI clock %u\n", fw_id);
> +
> +		hw = __clk_get_hw(clk);
> +		clk_put(clk);

Doesn't that leave the hw pointer possibly dangling, shouldn't you keep
the reference to the clock ?

> +		if (!hw)
> +			hw = get_fallback(fallback, map->entries[i].dt_id,
> +					  fixed_hws);
> +		if (!hw) {
> +			/* CLOCK_ATTRIBUTES is not supported */
> +			dev_warn(dev, "SCMI clock %u is NULL\n", fw_id);
> +			continue;
> +		}
> +
> +		dev_dbg(priv->dev, "SCMI clock %u is %s at %lu Hz\n", fw_id,
> +			clk_hw_get_name(hw), clk_hw_get_rate(hw));
> +
> +		hws[i] = hw;
>  	}
>  
>  	return hws;
> @@ -148,22 +218,57 @@ static struct clk_hw **get_hws(struct r8a78000_cpg_priv *priv)
>  
>  static int r8a78000_cpg_probe(struct platform_device *pdev)
>  {
> +	struct device_node *scmi_clk_np __free(device_node) = NULL;
> +	struct device_node *scmi __free(device_node) = NULL;
>  	struct device *dev = &pdev->dev;
> +	const struct cpg_data *cpg_data;
>  	struct r8a78000_cpg_priv *priv;
>  	const struct clk_id_map *map;
>  
> -	map = of_device_get_match_data(dev);
> -	if (!map)
> +	cpg_data = of_device_get_match_data(dev);
> +	if (!cpg_data)
>  		return -ENODEV;
>  
> +	map = cpg_data->default_map;
> +
>  	priv = devm_kzalloc_obj(dev, *priv);
>  	if (!priv)
>  		return -ENOMEM;
>  
>  	priv->dev = dev;
> +
> +	if (!IS_ENABLED(CONFIG_COMMON_CLK_SCMI)) {
> +		dev_dbg(dev, "SCMI clock support is disabled\n");
> +		goto fallback;
> +	}
> +
> +	scmi = of_find_compatible_node(NULL, NULL, "arm,scmi");
> +	if (!scmi) {
> +		dev_dbg(dev, "Cannot find SCMI firmware node\n");
> +		goto fallback;
> +	}
> +
> +	if (!of_device_is_available(scmi)) {
> +		dev_dbg(dev, "SCMI firmware node is not available\n");
> +		goto fallback;
> +	}
> +
> +	scmi_clk_np = scmi_find_proto(scmi, SCMI_PROTOCOL_CLOCK);
> +	if (!scmi_clk_np) {
> +		dev_dbg(dev, "Cannot find SCMI clock management protocol\n");
> +		goto fallback;
> +	}
> +
> +	map = cpg_data->fw_map;
> +
> +fallback:
>  	priv->map = map;
>  
> -	priv->hws = get_hws(priv);
> +	/*
> +	 * We cannot do lazy look-up in r8a78000_clk_get(), as that function is
> +	 * called with of_clk_mutex already held.
> +	 */
> +	priv->hws = get_hws(priv, cpg_data->default_map, scmi_clk_np);
>  	if (IS_ERR(priv->hws))
>  		return PTR_ERR(priv->hws);
>  
> @@ -176,10 +281,23 @@ static const struct clk_id_map_entry r8a78000_cpg_default[] = {
>  	{ R8A78000_CPG_SGASYNCD16_PERW_BUS,	FIXED_CLK(66M) },
>  };
>  
> +static const struct clk_id_map_entry r8a78000_cpg_fw[] = {
> +	{ R8A78000_CPG_SGASYNCD4_PERW_BUS,	1661 },
> +	{ R8A78000_CPG_SGASYNCD8_PERW_BUS,	1662 },
> +	{ R8A78000_CPG_SGASYNCD16_PERW_BUS,	1663 },
> +	{ R8A78000_CPG_MSO_SCP_MAIN,		1459 },
> +	{ R8A78000_CPG_MSOCK_PERW_BUS,		1667 },
> +};
> +
> +static const struct cpg_data r8a78000_cpg_data = {
> +	.default_map = CLK_ID_MAP(r8a78000_cpg_default),
> +	.fw_map = CLK_ID_MAP(r8a78000_cpg_fw),
> +};
> +
>  static const struct of_device_id r8a78000_cpg_match[] = {
>  	{
>  		.compatible = "renesas,r8a78000-cpg",
> -		.data = CLK_ID_MAP(r8a78000_cpg_default),
> +		.data = &r8a78000_cpg_data,
>  	},
>  	{ /* sentinel */ }
>  };

-- 
Regards,

Laurent Pinchart
