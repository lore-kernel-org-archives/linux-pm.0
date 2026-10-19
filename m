Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425384;
	b=GjwdL8ZvKCDhQJtGvfMGsa/GPYQhGsfnTjdOG08dPe1TkkZ0iMfJikoiBS055pNy8cRJ
	 ag12urGq/mLmQrwksY6qz2TLvja4Ct9jYP2qcrB6Lq+KqvpURGMUmwgFKUp4BZxiLIfFf
	 clGYj0yj3QzJVyrlJ8iGCTNOD59+50pnOJCC94MD1kUPeFhU4qxZB00ZYGJPYaUs0MHvA
	 P92bHfOAdTk0ICvkzzU1Q/3RiFSinne018VjpDCdf0yEsECsFWmPO54DNosqX76cvIsaX
	 +WBz7DT4cKFzNKJ8NequK8SRVO+dnR/MlkEpc2amr3ByDAMyh2fQfWMQIuLCIsIVyiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425384;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=522dSgSX8QDg4IeydtuZ1AFaoV8ZpxNqAXq0w4tKQaU=;
	b=QUpMFJjrsxO7byJRi69xL0eb7QVpNW/iSGNbwccc7EDJA+NDDKQMcMmGCEFwh1sfMPWU
	 tKEBiOc826rjwygq1XdxjIVQWIMwskP11H8bc1xkMNdKrgwWhk/LrWlABj0Eqd+ertw4t
	 /yXcH45cQtfe6w3DTuXUXLz2hy0+9p+MKi21LjVXsb7/ZZxbOwYNK/m2xzgp4nd62afat
	 1QPz1u9yvgqWtHTseHhZFICw64iVfDQJCv2BwXc8DknuqzefQxNmeWgPvhcac+P9hhZYo
	 xaJJ3/4YfEe2/H+ErZsIkWidwSmfPhXmHGgoVeypHtlcXjvF7Sp7pvEXsL73tddgxdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=QeSUwDeh;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F7606AAC9;
	Mon, 19 Oct 2026 15:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 656F7606AAC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=QeSUwDeh
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E1E82D0;
	Mon, 19 Oct 2026 17:54:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792425255;
	bh=9uCPKIsEr/8+KuBqoPLaVUoPiPXEjoFfr9QWURIr6aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QeSUwDehkhxrrH591BEFl/mwIa5Lg0XyL0OAF1o4NQmUFpzj6s6p6mfyZvFH7UhRe
	 FTu9nWzUZmHVuOOIZq1K2/lSn3tqWcRrApQ4GOsGtVr5wMJw3LYO/MZC73GfWsnEwr
	 rhjruCETvAoqwmGwKXbKHUFlmu2pKpNBuryrILH8=
Date: Mon, 19 Oct 2026 18:56:19 +0300
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
Subject: Re: [PATCH v4 2/8] clk: renesas: r8a78000: Add SCMI remapping support
Message-ID: <20261019155619.GB3705@killaraus.ideasonboard.com>
References: <cover.1792163045.git.geert+renesas@glider.be>
 <c38d744c09dffff550a9b882051c211b572b8daf.1792163045.git.geert+renesas@glider.be>
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
In-Reply-To: <c38d744c09dffff550a9b882051c211b572b8daf.1792163045.git.geert+renesas@glider.be>

Hi Geert,

Thank you for the patch.

On Fri, Oct 16, 2026 at 05:55:41PM +0200, Geert Uytterhoeven wrote:
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
> ---
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
>  drivers/clk/renesas/r8a78000-cpg.c | 149 ++++++++++++++++++++++++++---
>  1 file changed, 138 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
> index 5ffd7b89cb48e41c..758cfe78ae58e0fb 100644
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
> @@ -12,21 +13,27 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/scmi_protocol.h>
>  #include <linux/slab.h>
>  
>  #include <dt-bindings/clock/renesas,r8a78000-cpg.h>
>  
>  struct clk_map_in {
>  	int dt_id;		/* DT binding clock ID or -1 sentinel */
> -	u32 fw_id;		/* FIXED_CLK() ID */
> +	u32 fw_id;		/* SCMI firmware clock ID or FIXED_CLK() ID */
>  };
>  
>  struct clk_map {
>  	int dt_id;		/* DT binding clock ID or -1 sentinel */
> -	u32 fw_id;		/* FIXED_CLK() ID */
> +	u32 fw_id;		/* SCMI firmware clock ID or FIXED_CLK() ID */
>  	struct clk_hw *hw;
>  };
>  
> +struct cpg_data {
> +	const struct clk_map_in *default_map;
> +	const struct clk_map_in *fw_map;
> +};
> +
>  enum fixed_clk {
>  	FIXED_CLK_66M,
>  	FIXED_CLK_133M,
> @@ -39,13 +46,14 @@ static const unsigned long fixed_clk_rates[] = {
>  	[FIXED_CLK_266M] = 266660000,
>  };
>  
> -#define FIXED_CLK(rate)		FIXED_CLK_ ## rate
> +#define FIXED_CLK_OFFSET	0x80000000
> +#define FIXED_CLK(rate)		FIXED_CLK_OFFSET + FIXED_CLK_ ## rate

#define FIXED_CLK(rate)		(FIXED_CLK_OFFSET + FIXED_CLK_ ## rate)

>  
>  /**
>   * struct r8a78000_cpg_priv - Clock Pulse Generator Private Data
>   *
>   * @dev: CPG device
> - * @map: Mapping from DT clock IDs to fixed-rate clocks
> + * @map: Mapping from DT clock IDs to SCMI or fixed-rate clocks
>   */
>  struct r8a78000_cpg_priv {
>  	struct device *dev;
> @@ -85,8 +93,19 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec,
>  		return ERR_PTR(-ENOENT);
>  	}
>  
> -	dev_dbg(dev, "Mapping DT clock %u to fixed clock %u\n", id, map->fw_id);
> +	if (map->fw_id < FIXED_CLK_OFFSET)
> +		dev_dbg(dev, "Mapping DT clock %u to SCMI clock %u\n", id,
> +			map->fw_id);
> +	else
> +		dev_dbg(dev, "Mapping DT clock %u to fixed clock %u\n", id,
> +			 map->fw_id - FIXED_CLK_OFFSET);
> +
>  	hw = map->hw;
> +	if (!hw) {
> +		/* CLOCK_ATTRIBUTES is not supported */
> +		dev_err(dev, "Clock %u is not available\n", id);
> +		return ERR_PTR(-ENOENT);
> +	}
>  
>  	dev_dbg(dev, "clock %u is %s at %lu Hz\n", id, clk_hw_get_name(hw),
>  		clk_hw_get_rate(hw));
> @@ -94,6 +113,21 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec,
>  	return hw;
>  }
>  
> +static struct device_node *scmi_find_proto(struct device_node *scmi, u32 proto)

This is the kind of function name that looks prone to a namespace clash.
I'd name it r8a78000_clk_scmi_find_proto().

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
> @@ -122,11 +156,16 @@ static struct clk_hw **register_fixed_clks(struct device *dev)
>  }
>  
>  static const struct clk_map *fill_clk_map(struct r8a78000_cpg_priv *priv,
> -					  const struct clk_map_in *map_in)
> +					  const struct clk_map_in *map_in,
> +					  const struct clk_map_in *fallback,
> +					  struct device_node *scmi_clk_np)
>  {
> +	struct of_phandle_args scmi_spec;
>  	struct device *dev = priv->dev;
>  	struct clk_hw **fixed_hws;
>  	struct clk_map *map;
> +	struct clk_hw *hw;
> +	struct clk *clk;
>  	unsigned int i;
>  
>  	fixed_hws = register_fixed_clks(dev);
> @@ -145,7 +184,46 @@ static const struct clk_map *fill_clk_map(struct r8a78000_cpg_priv *priv,
>  			break;
>  
>  		map[i].fw_id = map_in[i].fw_id;
> -		map[i].hw = fixed_hws[map[i].fw_id];
> +		if (map[i].fw_id >= FIXED_CLK_OFFSET) {
> +			enum fixed_clk idx = map[i].fw_id - FIXED_CLK_OFFSET;
> +
> +			map[i].hw = fixed_hws[idx];
> +			continue;
> +		}
> +
> +		scmi_spec.np = scmi_clk_np;

This seems to be safe because a NULL scmi_clk_np implies usage of the
default map, which only contains fixed clock offsets, but that makes the
code a bit too fragile for my taste.

> +		scmi_spec.args_count = 1;
> +		scmi_spec.args[0] = map[i].fw_id;
> +
> +		clk = of_clk_get_from_provider(&scmi_spec);
> +		if (IS_ERR(clk))
> +			return dev_err_cast_probe(dev, clk,
> +				"Failed to get SCMI clock %u\n", map[i].fw_id);
> +
> +		hw = __clk_get_hw(clk);
> +		if (!hw && fallback != map_in) {

And if the above is correct, fallback should always be different from
map_in when fw_id corresponds to an SCMI clock.

What issue does this catch ? Should the fw map contain a fixed clock
entry for clocks not available in SCMI ?

> +			for (unsigned int j = 0; fallback[j].dt_id >= 0; j++) {
> +				if (fallback[j].dt_id == map_in[i].dt_id) {
> +					enum fixed_clk idx = fallback[j].fw_id - FIXED_CLK_OFFSET;
> +
> +					map[i].hw = fixed_hws[idx];
> +					break;
> +				}
> +			}
> +			if (map[i].hw)
> +				continue;
> +		}
> +
> +		if (!hw) {
> +			/* CLOCK_ATTRIBUTES is not supported */
> +			dev_warn(dev, "SCMI clock %u is NULL\n", map[i].fw_id);
> +			continue;
> +		}
> +
> +		dev_dbg(priv->dev, "SCMI clock %u is %s at %lu Hz\n",
> +			map[i].fw_id, clk_hw_get_name(hw), clk_hw_get_rate(hw));
> +
> +		map[i].hw = hw;
>  	}
>  
>  	devm_kfree(dev, fixed_hws);
> @@ -154,20 +232,55 @@ static const struct clk_map *fill_clk_map(struct r8a78000_cpg_priv *priv,
>  
>  static int r8a78000_cpg_probe(struct platform_device *pdev)
>  {
> +	struct device_node *scmi_clk_np __free(device_node) = NULL;
> +	struct device_node *scmi __free(device_node) = NULL;
>  	struct device *dev = &pdev->dev;
> +	const struct cpg_data *cpg_data;
>  	struct r8a78000_cpg_priv *priv;
>  	const struct clk_map_in *map;
>  
> -	map = of_device_get_match_data(dev);
> -	if (!map)
> +	cpg_data = of_device_get_match_data(dev);
> +	if (!cpg_data)
>  		return -ENODEV;
>  
> +	map = cpg_data->default_map;
> +
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
>  	priv->dev = dev;
> -	priv->map = fill_clk_map(priv, map);
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
> +	/*
> +	 * We cannot do lazy look-up in r8a78000_clk_get(), as that function is
> +	 * called with of_clk_mutex already held.
> +	 */
> +	priv->map = fill_clk_map(priv, map, cpg_data->default_map, scmi_clk_np);
>  	if (IS_ERR(priv->map))
>  		return PTR_ERR(priv->map);
>  
> @@ -181,10 +294,24 @@ static const struct clk_map_in r8a78000_cpg_default[] = {
>  	{ -1 }
>  };
>  
> +static const struct clk_map_in r8a78000_cpg_fw[] = {
> +	{ R8A78000_CPG_SGASYNCD4_PERW_BUS,	1661 },
> +	{ R8A78000_CPG_SGASYNCD8_PERW_BUS,	1662 },
> +	{ R8A78000_CPG_SGASYNCD16_PERW_BUS,	1663 },
> +	{ R8A78000_CPG_MSO_SCP_MAIN,		1459 },
> +	{ R8A78000_CPG_MSOCK_PERW_BUS,		1667 },
> +	{ -1 }
> +};
> +
> +static const struct cpg_data r8a78000_cpg_data = {
> +	.default_map = r8a78000_cpg_default,
> +	.fw_map = r8a78000_cpg_fw,
> +};
> +
>  static const struct of_device_id r8a78000_cpg_match[] = {
>  	{
>  		.compatible = "renesas,r8a78000-cpg",
> -		.data = &r8a78000_cpg_default,
> +		.data = &r8a78000_cpg_data,
>  	},
>  	{ /* sentinel */ }
>  };

-- 
Regards,

Laurent Pinchart
