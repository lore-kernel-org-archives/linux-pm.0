Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C9314D1D;
	Thu, 19 Mar 2026 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939685; cv=none; b=VXKbsHtweI52LsFOi5dioNc+VwpMyzArlJlFFHH/zS3w+P6dTbkzyqNg5h0itgKYxKN5eqLJuQO/i79lrjwZ1G3etpkb0g6qOoS0GQypYb0Gr0RkSz5yiqjVNMfIYSJu9mUkW0gbCXpNAF3ivWs+glxrJluwkBmeekaginIY/2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939685; c=relaxed/simple;
	bh=YnoHs9DDBDclY2aVIF5CrrB8I8oHOlB+aOrQ+gjX4ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8tHTJodSMZlseLy1Ko7iwbgAsvIv28APeL5M2rz4q60DaVOGm10fPcHkaOVelNtERVjOSUplOcJf2wzw4k+TgDX7l8oKka0/C3TtvHgz6VCt5lAzhuDnJgoaPNHI4zwP/trTpwk5KpajDa2FktUxyMyhTt/91PgxB7PZsQrFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhL3vCrN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhL3vCrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21068C19424;
	Thu, 19 Mar 2026 17:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773939685;
	bh=YnoHs9DDBDclY2aVIF5CrrB8I8oHOlB+aOrQ+gjX4ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhL3vCrNSHWjEUrEs5mYl/I4UDL+oM7vVzEURoI8D877o72JcfOUMQDLp86/B3YDS
	 nkC5XB4rowGcrTapLJu99yjS+DL0xASTblBjciHvfrSs7dHsw413YLRwUi5k7BovA/
	 JBSGdg608vYqXkgEvA3PtwKu6PXk7SzBrqXBSAsN2d1b6QWeGgC4hgZkbeY19s9nVg
	 SwJwvpp4lNejOMAdCWaPX0pC1lEP0RpEUbFtm14NhltqA6j0Pz7dQl7ZiwoU0Xuz7d
	 LZRK45EeZ1ZOOYLFcJYRsvQ/61KACUUmvEjZZnxpMsZxW58QrqUHgcTL26YuwizXVH
	 plsGA2AWL5xGw==
Date: Thu, 19 Mar 2026 17:01:18 +0000
From: Lee Jones <lee@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 09/11] mfd: bq257xx: Add BQ25792 support
Message-ID: <20260319170118.GP554736@google.com>
References: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
 <20260311-bq25792-v4-9-7213415d9eec@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260311-bq25792-v4-9-7213415d9eec@flipper.net>

On Wed, 11 Mar 2026, Alexey Charkov wrote:

> Add register definitions and a new 'type' enum to be passed via MFD
> private data to support the BQ25792, which is a newer variant of the
> BQ257xx family.
> 
> BQ25792 shares similar logic of operation with the already supported
> BQ25703A but has a completely different register map and different
> electrical constraints.
> 
> Tested-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  drivers/mfd/bq257xx.c       |  54 +++++-
>  include/linux/mfd/bq257xx.h | 414 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 465 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/bq257xx.c b/drivers/mfd/bq257xx.c
> index e9d49dac0a16..4445ded5b2eb 100644
> --- a/drivers/mfd/bq257xx.c
> +++ b/drivers/mfd/bq257xx.c
> @@ -39,13 +39,47 @@ static const struct regmap_config bq25703_regmap_config = {
>  	.val_format_endian = REGMAP_ENDIAN_LITTLE,
>  };
>  
> -static const struct mfd_cell cells[] = {
> +static const struct regmap_range bq25792_writeable_reg_ranges[] = {
> +	regmap_reg_range(BQ25792_REG00_MIN_SYS_VOLTAGE,
> +			 BQ25792_REG18_NTC_CONTROL_1),
> +	regmap_reg_range(BQ25792_REG28_CHARGER_MASK_0,
> +			 BQ25792_REG30_ADC_FUNCTION_DISABLE_1),
> +};
> +
> +static const struct regmap_access_table bq25792_writeable_regs = {
> +	.yes_ranges = bq25792_writeable_reg_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(bq25792_writeable_reg_ranges),
> +};
> +
> +static const struct regmap_range bq25792_volatile_reg_ranges[] = {
> +	regmap_reg_range(BQ25792_REG19_ICO_CURRENT_LIMIT,
> +			 BQ25792_REG27_FAULT_FLAG_1),
> +	regmap_reg_range(BQ25792_REG31_IBUS_ADC,
> +			 BQ25792_REG47_DPDM_DRIVER),
> +};
> +
> +static const struct regmap_access_table bq25792_volatile_regs = {
> +	.yes_ranges = bq25792_volatile_reg_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(bq25792_volatile_reg_ranges),
> +};
> +
> +static const struct regmap_config bq25792_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = BQ25792_REG48_PART_INFORMATION,
> +	.cache_type = REGCACHE_MAPLE,
> +	.wr_table = &bq25792_writeable_regs,
> +	.volatile_table = &bq25792_volatile_regs,
> +};
> +
> +static struct mfd_cell cells[] = {

This was `static const` before. And I don't see any code in here making
changes to it.  Was the `const` dropped intentionally?

>  	MFD_CELL_NAME("bq257xx-regulator"),
>  	MFD_CELL_NAME("bq257xx-charger"),
>  };
>  
>  static int bq257xx_probe(struct i2c_client *client)
>  {
> +	const struct regmap_config *rcfg;
>  	struct bq257xx_device *ddata;
>  	int ret;
>  
> @@ -53,9 +87,21 @@ static int bq257xx_probe(struct i2c_client *client)
>  	if (!ddata)
>  		return -ENOMEM;
>  
> +	ddata->type = (uintptr_t)device_get_match_data(&client->dev);

This logic seems a bit fragile. For non-DeviceTree platforms,
`device_get_match_data()` will return `NULL` since the `i2c_device_id`
table doesn't provide any match data. Casting `NULL` to `uintptr_t` will
result in `0`, which corresponds to `BQ25703A`. This means the new
`bq25792` will be misidentified as a `bq25703a` when instantiated
without a DeviceTree node.  Even with DeviceTree, if a compatible string
is matched but has no `.data` property, the same misidentification will
occur.

Perhaps it would be safer to explicitly handle the `NULL` case and make the
identification logic more robust?  Or perhaps start your IDs from 1.

>  	ddata->client = client;
>  
> -	ddata->regmap = devm_regmap_init_i2c(client, &bq25703_regmap_config);
> +	switch (ddata->type) {
> +	case BQ25703A:
> +		rcfg = &bq25703_regmap_config;
> +		break;
> +	case BQ25792:
> +		rcfg = &bq25792_regmap_config;
> +		break;
> +	default:
> +		return dev_err_probe(&client->dev, -EINVAL, "Unsupported device type\n");

Given the potential for `device_get_match_data()` to return `NULL` (which
becomes `0`), this `default` case might not be reachable for invalid or
un-matchable devices. A more explicit check on the match data before this
`switch` might be better.

> +	}
> +
> +	ddata->regmap = devm_regmap_init_i2c(client, rcfg);
>  	if (IS_ERR(ddata->regmap)) {
>  		return dev_err_probe(&client->dev, PTR_ERR(ddata->regmap),
>  				     "Failed to allocate register map\n");
> @@ -74,12 +120,14 @@ static int bq257xx_probe(struct i2c_client *client)
>  
>  static const struct i2c_device_id bq257xx_i2c_ids[] = {
>  	{ "bq25703a" },
> +	{ "bq25792" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, bq257xx_i2c_ids);
>  
>  static const struct of_device_id bq257xx_of_match[] = {
> -	{ .compatible = "ti,bq25703a" },
> +	{ .compatible = "ti,bq25703a", .data = (void *)BQ25703A },
> +	{ .compatible = "ti,bq25792", .data = (void *)BQ25792 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, bq257xx_of_match);

[...]

-- 
Lee Jones [李琼斯]
