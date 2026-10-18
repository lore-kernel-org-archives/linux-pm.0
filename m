Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0401939E164;
	Sun, 18 Oct 2026 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361830; cv=none; b=uTKZFBSxhvNRD3U1qfcaoZBjNdCbF6WF4lxzh5gBgrv980dEGBF7JXkJ72Lxw4PcQyjA3Mj10tNDnKohWy0nE5LOYutxmzeWDMxAG5lF1gCi/boT74bJeqqmo77TeqgjaD+B9k1MU0oePokQsaiDsFMaXMDlAq2HCp+OaszK5BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361830; c=relaxed/simple;
	bh=SvhNGhOEbCTd8VfY9SRoWVjGv4wCDw0h+B6OWIL6QdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqIRZLtSHiV0UPLjcOZHaFLT1s4oZzaQJDqkBDjJzHrQq/dhmgWinGos+I91cQOQCsXmer0sSBGuatIIy6TDMBNA+5XwHCD5FVO1sIVibzkjHYFMbP8ijMr5hMISDyZsz+xUpXmUzqb06Lk+v7bYURNEw1xkG6R+CK1y1tptTKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=Wnwi0Rbc; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="Wnwi0Rbc"
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id CF04E53402B0;
	Mon, 19 Oct 2026 00:17:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1792361826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oD9Nnq+2dQo6ClH+FSfZOnSV+NNBLuALLaa9RbVSkNk=;
	b=Wnwi0Rbcg+FJs3nGVruAOKye+iDKCItS2U4DnQzZdXxRE4nJ4tiYoiDLNGlOb2LypsmJ8+
	vOdU1ZVr7fEa/23DmxttHTwtfChzfSCJZfuGf90v/Jyhro2Dv0ySYbiX8J3GqyoXKwT6iH
	25qhq7vUuYk8ouE+mv/Pih4QnP9tFp4=
Message-ID: <923282d7-cc31-400e-89e7-f3646edd06c8@ixit.cz>
Date: Mon, 19 Oct 2026 00:17:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] power: supply: bq27xxx: detect bq27541 behind bq27411
 compatible
To: rinat.muhamedgaliev@gmail.com, linux-pm@vger.kernel.org
Cc: pali@kernel.org, sre@kernel.org, afd@ti.com,
 konrad.dybcio@oss.qualcomm.com, krzk@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261019-master-v6-0-c4b36129721e@gmail.com>
 <20261019-master-v6-1-c4b36129721e@gmail.com>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20261019-master-v6-1-c4b36129721e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/10/2026 23:15, Rinat Muhamedgaliev via B4 Relay wrote:
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
>   drivers/power/supply/bq27xxx_battery_i2c.c | 57 ++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
> index 94b00bb89c17..0b957888ad2b 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -16,6 +16,11 @@
>   static DEFINE_IDR(battery_id);
>   static DEFINE_MUTEX(battery_mutex);
>   
> +#define BQ27XXX_REG_CTRL		0x00
> +#define BQ27XXX_DEVICE_TYPE		0x0001
> +#define BQ27411_DEVICE_TYPE		0x0421
> +#define BQ27541_DEVICE_TYPE		0x0541
> +
>   static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *data)
>   {
>   	struct bq27xxx_device_info *di = data;
> @@ -136,6 +141,46 @@ static int bq27xxx_battery_i2c_bulk_write(struct bq27xxx_device_info *di,
>   	return 0;
>   }
>   
> +static int bq27xxx_battery_i2c_check_device_type(struct bq27xxx_device_info *di)
> +{
> +	enum bq27xxx_chip detected_chip;
> +	int expected_type;
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
> +	expected_type = di->chip == BQ27411 ? BQ27411_DEVICE_TYPE :
> +		BQ27541_DEVICE_TYPE;

This is not that generic, I would go for extensible design, something like:

switch (di->chip) {
case BQ27411:
     expected_type = BQ27411_DEVICE_TYPE
case BQ27541:
     expected_type = BQ27541_DEVICE_TYPE
default:
     dev_warn(di->dev, "expected chip undefined\n");
}


> +	dev_warn(di->dev,
> +		 "detected DeviceType 0x%04x instead of expected 0x%04x\n",
> +		 ret, expected_type);
> +	di->chip = detected_chip;
> +
> +	return 0;
> +}
> +
>   static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>   				     const struct i2c_device_id *id)
>   {
> @@ -169,6 +214,18 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>   	di->bus.read_bulk = bq27xxx_battery_i2c_bulk_read;
>   	di->bus.write_bulk = bq27xxx_battery_i2c_bulk_write;
>   
> +	/* BQ27411 and BQ27541 may be interchanged in replacement battery packs. */

We can see this from the code. The comment should imply the list should be 
extended with devices which can be detected over i2c.

For all devices supporting reporting it's ID - if we can check at boot it's 
really reporting, it brings the value - e.g. broken or different device will not 
show 0 or 100% of battery charge, but fail to load.

Otherwise IMHO looks good.
Thanks

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
>   	ret = bq27xxx_battery_setup(di);
>   	if (ret)
>   		goto err_failed;
> 

