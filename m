Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0DC328B56;
	Tue, 10 Mar 2026 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147800; cv=none; b=R73FoJL1YDPMNREWlAM2s10bNsyVXHkzXMv7TZiuVB07j+VU05UCrM4MzfGPaYKlbzhe97dbXJ0TtxNr5xSh5eMBtjKR6s5dagBS8+Zt6dcRrrA4rXmHUedS5N8BTxqrq9X5b4kjLTXfGEdvawiOFf4jVbbjkN7PrrwTtwW2DpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147800; c=relaxed/simple;
	bh=o1LWvNwWPHg9SCrFAE8Um9VpEsqInCgeI1zE3tb2NhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8fUn+r82/qrEMcP5T2Dc1sHX5dylLq5QzMqZkxtu/5CELYO4DTg66FJIeSCXpsJ6QQp7rJw47LVPOIxoqxQ0tcXOtvoC35EZrHy65jC25DcIntdxQrVcxlZhK6u/r+q5ifRMqKhIIUCaXEdg+ImUad7fMLldXrSJnAtL8mEHpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvnITmIw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvnITmIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF497C19423;
	Tue, 10 Mar 2026 13:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773147800;
	bh=o1LWvNwWPHg9SCrFAE8Um9VpEsqInCgeI1zE3tb2NhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WvnITmIwmdkyx5P0ENj8ioYxqZMTGSCybErySCKGwPyyXB4wMFudMGsfVZeFGQfxD
	 5PetJDGKXFv5fSxjF26VIBez8JDpumdLW3RZedwJFaJDUjRQA/icJ5N9Va4/cOoi35
	 hcM+qAL6Fdj/u6/O9l8hyEnihBL+jgeFLA+WIiuO6zGC/InJDuyWX0Yq4/Tk+CALTu
	 Xozcb4GCGavFuO6Q1D3W+XFNZZc1a9RSRVj6Y0ilMMW/9p8CTuatS2dgrNZTuO3GvE
	 c/FLrWSN4Vmwg9/KTLfGj/KmrrgZ6Vei67Iz9EZfc02mjY0venZbU+TpIVpc59X7ET
	 nfULy+1VLUB5w==
Date: Tue, 10 Mar 2026 13:03:15 +0000
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
Subject: Re: [PATCH v3 09/11] mfd: bq257xx: Add BQ25792 support
Message-ID: <20260310130315.GK183676@google.com>
References: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
 <20260310-bq25792-v3-9-02f8e232d63b@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310-bq25792-v3-9-02f8e232d63b@flipper.net>

On Tue, 10 Mar 2026, Alexey Charkov wrote:

> Add register definitions and a new 'type' enum to be passed in MFD
> platform data to support the BQ25792, which is a newer variant of the
> BQ257xx family.
> 
> BQ25792 shares similar logic of operation with the already supported
> BQ25703A but has a completely different register map and different
> electrical constraints.
> 
> Tested-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  drivers/mfd/bq257xx.c       |  64 ++++++-
>  include/linux/mfd/bq257xx.h | 417 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 477 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/bq257xx.c b/drivers/mfd/bq257xx.c
> index e9d49dac0a16..7516e2ec00e6 100644
> --- a/drivers/mfd/bq257xx.c
> +++ b/drivers/mfd/bq257xx.c
> @@ -10,6 +10,11 @@
>  #include <linux/mfd/core.h>
>  #include <linux/regmap.h>
>  
> +struct bq257xx_match_data {
> +	const struct bq257xx_plat plat;
> +	const struct regmap_config *regmap_config;
> +};
> +
>  static const struct regmap_range bq25703_readonly_reg_ranges[] = {
>  	regmap_reg_range(BQ25703_CHARGER_STATUS, BQ25703_MANUFACT_DEV_ID),
>  };
> @@ -39,15 +44,64 @@ static const struct regmap_config bq25703_regmap_config = {
>  	.val_format_endian = REGMAP_ENDIAN_LITTLE,
>  };
>  
> -static const struct mfd_cell cells[] = {
> +static const struct bq257xx_match_data bq25703a_match_data = {
> +	.plat = { .type = BQ25703A },
> +	.regmap_config = &bq25703_regmap_config,
> +};
> +
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
> +static const struct bq257xx_match_data bq25792_match_data = {
> +	.plat = { .type = BQ25792 },
> +	.regmap_config = &bq25792_regmap_config,
> +};
> +
> +static struct mfd_cell cells[] = {
>  	MFD_CELL_NAME("bq257xx-regulator"),
>  	MFD_CELL_NAME("bq257xx-charger"),
>  };
>  
>  static int bq257xx_probe(struct i2c_client *client)
>  {
> +	const struct bq257xx_match_data *md = device_get_match_data(&client->dev);
>  	struct bq257xx_device *ddata;
> -	int ret;
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(cells); i++) {
> +		cells[i].platform_data = &md->plat;
> +		cells[i].pdata_size = sizeof(md->plat);
> +	}
>  
>  	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
>  	if (!ddata)
> @@ -55,7 +109,7 @@ static int bq257xx_probe(struct i2c_client *client)
>  
>  	ddata->client = client;
>  
> -	ddata->regmap = devm_regmap_init_i2c(client, &bq25703_regmap_config);
> +	ddata->regmap = devm_regmap_init_i2c(client, md->regmap_config);
>  	if (IS_ERR(ddata->regmap)) {
>  		return dev_err_probe(&client->dev, PTR_ERR(ddata->regmap),
>  				     "Failed to allocate register map\n");
> @@ -74,12 +128,14 @@ static int bq257xx_probe(struct i2c_client *client)
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
> +	{ .compatible = "ti,bq25703a", .data = &bq25703a_match_data },
> +	{ .compatible = "ti,bq25792", .data = &bq25792_match_data },

Instead of passing through the data structure, pass an identifier to
match on, like:

	 { .compatible = "ti,bq25703a", .data = (void *)BQ25703A },

Then add the ID to ddata which is already obtainable from the child
devices via i2c_set_clientdata().  This saves passing it as separate
platform data.

	ddata->type = device_get_match_data(&client->dev);

Then use that to initialise a local 'struct regmap_config'.

	switch(ddata->type) {
	case BQ25703A:
		regmap_config = &bq25703_regmap_config
		break;
	[...]

By doing so, you save on a lot of additional complexity and mitigate the
introduction of some unnecessary data structures.

-- 
Lee Jones [李琼斯]
