Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795349025;
	b=5kP/1mWHFKd/2Dald1GornJYB0VyXZkRDiICyyYy37wI2oi6QKFeDhdUXOtQOkp0KHrm
	 svtsAxM5q/Yeo9aivcnnOTgeT/qsc+9bR8EGIPI0t3MA1ZqeOH6BO9aTxzYZyP4S0axhh
	 zEUhWva4AFw5iy4wswqKa0AsX2qQ2jai1VcMX7eR95Y1ehlz3Bv5Q9RMYurgWQzRfPCyW
	 bq1OEuJudlV0hyAkt1yz8bid7P2DUWag9JLU1T4h5cTpUbXNZIqzBn1GlTCJ8Mi5e8jdm
	 FwQRpx9pXpx9Z6hMOUPG/y85wkERQ6ZNp43KQHUdRqcrI3pIvV+dnaX/eVY9xWcspOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795349025;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent;
	bh=LWrfe6nVZsdf+UKrFAvNop3QSEW2DaRBTT+EgiuhyJc=;
	b=ZZUegxhNHOKcJsV5Tb3GoqtKwW8snRWb2yilAo5KUO7o7iy1/izt8HB492yxyLA/Ux9a
	 jimok1MJ71uVUlZiqvn3f32xcglto1JaQ7S0RARjxxwXEFdOI4+FsGXiQwx5G7Ge2COYr
	 1dWbwctK6WAplB5NlIQzWMkL7YlgKQ5Iw3bUqxvGKJUWQ5LL8pbbbYWz+bTPB632H6W2E
	 3LkVdVZTzXZSiBwW0SYNAH6djaakn+cjuYl7W5AP7G6dNMKh9BbflpVx6vk5WGAe+sq7w
	 U41VsEMxYJLrNcqXaNpETF/Y1tzKxd2gzjE4ynZOLU0OqdOVsfVmWyiRT15O0yauahw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIWiriod;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6B7606A320;
	Sun, 22 Nov 2026 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIWiriod
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43EF1F000C6;
	Sun, 22 Nov 2026 12:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795349024;
	bh=LWrfe6nVZsdf+UKrFAvNop3QSEW2DaRBTT+EgiuhyJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eIWiriod9b6NIC2auRYFlx5pX8kPMRyoMSs+VobFEil9Q6d/xP+wzvZcaWkwPlIyd
	 OppUL4Fcubzaez4hVtux62B1CwNfydNF4sulUDU4dCCIA3Wk9z5CnISYyirEbmjA9X
	 2sFCF9Dv8QvxOaNYMBMIuG3Mw7QOq0APDOGQ0q7ZJZmDQwZXn+NW2y/+QEIV1fcLr8
	 KuDJ1pljt5U3vpTkygORNzV8/igys5d66CrSY3Ppk3hIqzmDocUKjoo+icjpEaQ2Ln
	 5G/VgZEAka1ThmRhjFYHCok2gn1uz18FHCUo0axesfrAIK0xgvd5QmOyshTj7I2ASY
	 c+/pf9KRGtqtw==
Received: by pali.im (Postfix)
	id 3CFA4812; Sun, 22 Nov 2026 13:03:41 +0100 (CET)
Date: Sun, 22 Nov 2026 13:03:41 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Michael Auer <mick@yoxcu.de>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] power: supply: bq27xxx: retry a failed register read
 once
Message-ID: <20261122120341.runjq4rjjgvob5y6@pali>
References: <20261121204137.848173-1-mick@yoxcu.de>
 <20261121204137.848173-3-mick@yoxcu.de>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121204137.848173-3-mick@yoxcu.de>
User-Agent: NeoMutt/20180716

On Saturday 21 November 2026 21:41:36 Michael Auer wrote:
> A bq27541 on a OnePlus 6 now and then NAKs an I2C read right after
> system resume (-ENXIO on i2c-qcom-geni). If that is the flags read of
> the update queued at resume, the driver caches the error: for the next
> 5 s "present" reads 0 and every other property fails.

So... should not be there rather a resume hook in the driver which waits
until the battery is ready (instead of adding retires on many places in
the driver)?

> UPower then
> reports the battery as missing at 0 %, and the desktop starts its
> critical battery action on a battery that is at 25 %:
> 
>   power_supply bq27541-0: driver failed to report `status' property: -6
> 
> The I2C read already retries -EBUSY. Retry any other failed read once
> after 10 ms, in the bus independent read helper, but not -ENODEV (no
> I2C adapter). A gauge that does not answer at all now costs 10 ms more
> per read.
> 
> Signed-off-by: Michael Auer <mick@yoxcu.de>
> ---
> I did not put the retry into the I2C read next to the -EBUSY retry,
> because the error code for a NAK differs between adapters (-ENXIO,
> -EREMOTEIO, -EIO).
> 
>  drivers/power/supply/bq27xxx_battery.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 032eea030f2f..dccb0f84ea1d 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1141,6 +1141,17 @@ static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
>  		return -EINVAL;
>  
>  	ret = di->bus.read(di, di->regs[reg_index], single);
> +	if (ret < 0 && ret != -ENODEV) {
> +		/*
> +		 * The gauge can miss a single transfer, e.g. right after system
> +		 * resume (bq27541 NAKs it). Without the retry the whole update
> +		 * fails and userspace sees the battery as absent.
> +		 */
> +		dev_dbg(di->dev, "failed to read register 0x%02x (index %d): %d, retrying\n",
> +			di->regs[reg_index], reg_index, ret);
> +		usleep_range(10000, 11000);
> +		ret = di->bus.read(di, di->regs[reg_index], single);
> +	}
>  	if (ret < 0)
>  		dev_dbg(di->dev, "failed to read register 0x%02x (index %d)\n",
>  			di->regs[reg_index], reg_index);
> -- 
> 2.43.0
> 
