Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5793E23395D;
	Sun, 18 Oct 2026 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792367268; cv=none; b=We70CE3SyF493kv8ooQL3pVnw+mfmaoBMy+yzCMzLkAhrteyoDCzSyvXwyJktpqEqD349LT/I2AROhHucRt78MgLMZpaDrXIc3HlU34xpwt42r2Vyjo8rIfDsWaM+h6w6IVaB5HYPGWAJQM4+oO12+aD8AVikeVN8U77fai6JBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792367268; c=relaxed/simple;
	bh=qs9HfytuQ2urLx7/3CKd6aCxyG+hugIW7qbG3KU3waY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDG+72JSN4WSdX9BaBiU2qryS5zcnXGttaGkppjl0DnBHgnRY4OWKHQbarb3YLsiazdAu2ns4F2PulS+cT8wq7tRT19j603bsEMBGv3D2Treoh/yLh368Y1FqW6rZnMZs67HsLGSfi/BcovOxskry76rw1BnNddCy5nWs4HNRZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY9TLGnv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XY9TLGnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8991F000C4;
	Sun, 18 Oct 2026 23:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792367266;
	bh=j6sbRbJY7M6CvF0tYdWhCb3sL/PPJRQrxGV2v2ZGbUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XY9TLGnv7sNVF0Zyl757nwZ12YFYayGLxhyPYE+PT0/1J/8Xu5OhiJsszBaUztZDl
	 7SC9rd+0jsNRV3LDH4CRFIqXmuFbhhiaZ1vjAmeI3DfgS29jV3rMB0vurDxttYG3VT
	 Qt1p53l3mBUfAV5kR9wC8zzEf8O4qDfUOicJbgOEteDuC7v+4oGVFgTgu7GrOkW6IJ
	 3CczaqlwQ3K6uCTL/2pb9K8sXqIES46djFvsu34k0kPS8R2X6N8yplzm+5XJMKJ/Lv
	 dbW8ZKAwyKmYfgGwvXFRxJcTbLEAWRXGxdHnBxn/uf5AUT18F3pmLSnvU/jLXZYT9H
	 aC0TisWwo2gxA==
Received: by pali.im (Postfix)
	id 3CF52790; Mon, 19 Oct 2026 01:47:49 +0200 (CEST)
Date: Mon, 19 Oct 2026 01:47:49 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
Cc: linux-pm@vger.kernel.org, sre@kernel.org, afd@ti.com,
	konrad.dybcio@oss.qualcomm.com, david@ixit.cz, krzk@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] power: supply: bq27xxx: detect bq27541 behind bq27411
 compatible
Message-ID: <20261018234749.ph6voihuof7q5gm3@pali>
References: <20261019-master-v7-0-a1fc488d9c77@gmail.com>
 <20261019-master-v7-1-a1fc488d9c77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-master-v7-1-a1fc488d9c77@gmail.com>
User-Agent: NeoMutt/20180716

On Monday 19 October 2026 02:03:39 Rinat Muhamedgaliev via B4 Relay wrote:
> From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
> 
> OnePlus 6 and 6T replacement battery packs may contain either a bq27411
> or a bq27541 fuel gauge at I2C address 0x55. The device tree currently
> identifies the gauge as bq27411, but a bq27541 uses a different register
> map and then reports invalid battery values.
> 
> Read the DeviceType control subcommand when probing a bq27411. Keep the
> existing profile for DeviceType 0x0421, but select the bq27541 profile
> for DeviceType 0x0541. This retains the established DT ABI and supports
> replacement packs without introducing a generic compatible.
> 
> Tested on OnePlus 6T (fajita) with DeviceType 0x0541: voltage, state of
> charge, and temperature were reported correctly. Testing on hardware with
> DeviceType 0x0421 would be appreciated.
> 
> Signed-off-by: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
> ---
>  drivers/power/supply/bq27xxx_battery_i2c.c | 67 ++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
> index 94b00bb89c17..a9982953e4f2 100644
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
> @@ -136,6 +141,56 @@ static int bq27xxx_battery_i2c_bulk_write(struct bq27xxx_device_info *di,
>  	return 0;
>  }
>  
> +static int bq27xxx_battery_i2c_check_device_type(struct bq27xxx_device_info *di)
> +{
> +	enum bq27xxx_chip detected_chip;
> +	int expected_type;
> +	int ret;
> +
> +	switch (di->chip) {
> +	case BQ27411:
> +		expected_type = BQ27411_DEVICE_TYPE;
> +		break;
> +	case BQ27541:
> +		expected_type = BQ27541_DEVICE_TYPE;
> +		break;
> +	default:
> +		dev_warn(di->dev, "expected DeviceType undefined\n");
> +		return 0;
> +	}
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
> +		detected_chip = BQ27411;
> +		break;
> +	case BQ27541_DEVICE_TYPE:
> +		detected_chip = BQ27541;
> +		break;
> +	default:
> +		dev_err(di->dev, "unrecognized DeviceType 0x%04x\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	if (detected_chip == di->chip)
> +		return 0;
> +
> +	dev_warn(di->dev,
> +		 "detected DeviceType 0x%04x instead of expected 0x%04x\n",
> +		 ret, expected_type);
> +	di->chip = detected_chip;
> +
> +	return 0;
> +}
> +
>  static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>  				     const struct i2c_device_id *id)
>  {
> @@ -169,6 +224,18 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>  	di->bus.read_bulk = bq27xxx_battery_i2c_bulk_read;
>  	di->bus.write_bulk = bq27xxx_battery_i2c_bulk_write;
>  
> +	/* Add fuel gauges with supported DeviceType reporting to this list. */
> +	switch (di->chip) {
> +	case BQ27411:
> +	case BQ27541:
> +		ret = bq27xxx_battery_i2c_check_device_type(di);
> +		if (ret)
> +			goto err_failed;
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	ret = bq27xxx_battery_setup(di);
>  	if (ret)
>  		goto err_failed;
> 
> -- 
> 2.56.0
> 
> 

Hello, my understanding is that this whole code is not i2c specific as
it uses the bq27xxx_device_info abstraction APIs. Therefore should not
be this code rather part of the bus-neutral bq27xxx_battery_setup()
function which is in the bq27xxx_battery.c file? Also that file already
contains definitions of register maps. This change is adding new
register reading/writing which looks to be inconsistent with the way how
the whole driver is structured and how it access registers. For example
the BQ27XXX_REG_CTRL is already defined in the bq27xxx_battery.c file.
And there is also enum /* control register params */ where the
BQ27XXX_DEVICE_TYPE constant should belong (as there are all other
commands defined).
