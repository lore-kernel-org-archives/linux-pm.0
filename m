Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587FF3C1963;
	Sun, 27 Sep 2026 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546431; cv=none; b=eiKrRZbSE5a7G+UFpxlp1axotVHr5ccKI8dt+wi1KxJ/L91mFn5+rfD58oHw976tZ5sMSIyD2C2nEbDCCvViivM0PH12kA9U1leUL7+r9Ngptu2efuZbr68hw9qG2u+JDKvzE/zPKSue9FRSQVovX/wMkd3Nye+k62mEUVoylOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546431; c=relaxed/simple;
	bh=PuwVL9Bavt7Mga9nKspVu8azcUW/tQQWNs4VzKq/TW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSbaPILl7/pgt+D4xRq3pexpaNvgBUvuGMkJ2LKalI2lgzWsGznfVuFT0plcHYd+Xl4PY74L7vTtk8hRmbmlIJagNzFsyHdt2DzJWBmK1V5CbpQoNwAeZuBik9TZye1oxpNCLrRti9YyJxgxdFAy/N04wUkxunPLha+9g7W4EZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZzS2zSb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZzS2zSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E131F0089D;
	Sun, 27 Sep 2026 22:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790546425;
	bh=MefXymOHLZsBxXcXnx29cV/krbl0X0uyYXLfDMcg98I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nZzS2zSb3zHwXSpC/H72emFe1TsO0BWe/sCaVXSjMMdv9EF2b2P2N0+Co4+8JOovy
	 KUzpe+b9yVHMZpuEZ3CxWZYiQXIE8v8eJHuO1Jmf1Ztyj/fZHKFUO7yjR6Wr0bsVuk
	 /3xLBB+Z95+S9WdntJiaw1Oz7HwVJYzbSTiHVW5ZfxmRwUw88mJaGhS2j3wU/yub1A
	 h+Q7owPBVpmppeHzfSZ/+6YJJhXVU1BsM33XXyuJVlCMM15FUmlJ5RQ/ixlaNK4uKr
	 hsbT62HEbVUQnBsVxKZegbWXYsIdEPnYEs3hWB5kqlaLvC+Wruvg/VGqS6n3iCYIPx
	 IbK30CiHegbvg==
Received: by pali.im (Postfix)
	id B99A2AB8; Mon, 28 Sep 2026 00:00:26 +0200 (CEST)
Date: Mon, 28 Sep 2026 00:00:26 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
Cc: linux-pm@vger.kernel.org, sre@kernel.org, afd@ti.com,
	konrad.dybcio@oss.qualcomm.com, david@ixit.cz, krzk@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] power: supply: bq27xxx: detect bq27541 behind bq27411
 compatible
Message-ID: <20260927220026.hxwnm6mbfs7s7swu@pali>
References: <20260928-master-v4-1-052c73ec1767@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-master-v4-1-052c73ec1767@gmail.com>
User-Agent: NeoMutt/20180716

On Monday 28 September 2026 00:17:17 Rinat Muhamedgaliev via B4 Relay wrote:
> From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
> 
> OnePlus 6 and 6T replacement battery packs may contain either a bq27411 or a bq27541 fuel gauge at I2C address 0x55. The device tree currently identifies the gauge as bq27411, but a bq27541 uses a different register map and then reports invalid battery values.
> 
> Read the DeviceType control subcommand when probing a bq27411. Keep the existing profile for DeviceType 0x0421, but select the bq27541 profile for DeviceType 0x0541. This retains the established DT ABI and supports replacement packs without introducing a generic compatible.

Hello! I have not read the previous versions of the patch or its
discussion. But I have two points which could useful for future.

In a past I was solving similar problem (there are more possible
endpoint types in DT and hardcoding any of them cause replugging
issues). And the solution was to "improve" bootloader to load the DTB
file (from the storage) and then on-the-fly in RAM modify it to contains
current configuration of endpoint device. This allowed to boot new
kernel, and also old kernel without any modification of kernel or DTB
file. So it retained the established DT ABI for kernel too.

If there are more requests for these replugging support in bq27xxx, what
about improving the whole bq27xxx driver to do autodetection of any
plugged battery and take any explicit device tree identifier as a
generic? If I remember correctly, it is not possible detect the whole
type, but at least something is possible. This could solve this problem
too, but would require some larger rewrite of driver. And it would make
sense only if there are more requests for such functionality. I agree
that it would probably do not make sense for one device.

I'm not opposing the change, I'm just writing ideas for future, maybe
they could be useful for some future decisions...

> Tested on OnePlus 6T (fajita) with DeviceType 0x0541: voltage, state of charge, and temperature were reported correctly. Testing on hardware with DeviceType 0x0421 would be appreciated.
> 
> Signed-off-by: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
> ---
> OnePlus 6 and 6T replacement battery packs can contain either a bq27411 or a
> bq27541 fuel gauge. The latter requires a different register map and produces
> invalid battery readings when interpreted as a bq27411.
> 
> v4 drops the proposed generic DT compatible and DTS changes. The I2C driver
> instead reads DeviceType while probing the existing bq27411 compatible, and
> selects the bq27541 profile if the device reports 0x0541.
> 
> The bq27541 path was tested on a OnePlus 6T. Testing on an OnePlus 6 or 6T
> whose fuel gauge reports DeviceType 0x0421 (bq27411) would be appreciated.
> 
> Changes in v4:
> - Drop the generic compatible and binding update.
> - Keep the established OnePlus DTS unchanged.
> - Detect bq27541 from DeviceType in the bq27411 probe path.
> - Send as a new thread.
> ---
>  drivers/power/supply/bq27xxx_battery_i2c.c | 37 ++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
> index 94b00bb89c17..732164423423 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -16,6 +16,11 @@
>  static DEFINE_IDR(battery_id);
>  static DEFINE_MUTEX(battery_mutex);
>  
> +#define BQ27XXX_REG_CTRL		0x00
> +#define BQ27XXX_DEVICE_TYPE		0x0001
> +#define BQ27411_DEVICE_TYPE		0x0421
> +#define BQ27541_DEVICE_TYPE		0x0541
> +
>  static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *data)
>  {
>  	struct bq27xxx_device_info *di = data;
> @@ -136,6 +141,32 @@ static int bq27xxx_battery_i2c_bulk_write(struct bq27xxx_device_info *di,
>  	return 0;
>  }
>  
> +static int bq27xxx_battery_i2c_check_device_type(struct bq27xxx_device_info *di)
> +{
> +	int ret;
> +
> +	ret = di->bus.write(di, BQ27XXX_REG_CTRL, BQ27XXX_DEVICE_TYPE,
> +			    false);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = di->bus.read(di, BQ27XXX_REG_CTRL, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (ret) {
> +	case BQ27411_DEVICE_TYPE:
> +		return 0;
> +	case BQ27541_DEVICE_TYPE:
> +		dev_warn(di->dev, "detected bq27541 instead of bq27411\n");
> +		di->chip = BQ27541;
> +		return 0;
> +	default:
> +		dev_err(di->dev, "unsupported device type 0x%04x\n", ret);
> +		return -ENODEV;
> +	}
> +}
> +
>  static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>  				     const struct i2c_device_id *id)
>  {
> @@ -169,6 +200,12 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>  	di->bus.read_bulk = bq27xxx_battery_i2c_bulk_read;
>  	di->bus.write_bulk = bq27xxx_battery_i2c_bulk_write;
>  
> +	if (di->chip == BQ27411) {
> +		ret = bq27xxx_battery_i2c_check_device_type(di);
> +		if (ret)
> +			goto err_failed;
> +	}
> +
>  	ret = bq27xxx_battery_setup(di);
>  	if (ret)
>  		goto err_failed;
> 
> ---
> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
> change-id: 20260927-master-bd0afd9696ef
> 
> Best regards,
> --  
> Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
> 
> 
