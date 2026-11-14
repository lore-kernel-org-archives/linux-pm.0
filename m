Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615365;
	b=KqbPMcTCVs+ZQl+7W3oARPgmo0i68geb6KMWis+ETDLajwmWxrAgVeRZ9ZyC6FBCMlEi
	 PLAZCzo+owTbJyAQA2JKlaT256K6YNjzyKU0Xl9XQz43EWqYg3tE85k9ptXT7bbD9uS8e
	 vmkBiWHgGy/EWmDiCU8NTpvuumhaLNwT2reEzLnjlrjCCEzmmFKNFsOlF09W7sjnqLmU1
	 3K8B6QXJOoXoGg9xpFOFilJkGhlYkl2UQOZ5+UkUjlzAWju1FU4k8JFRdAFbed2yApwa2
	 XQbw60Ta7BgLYxviSTKsd24HObF3rNCN607OlGRWMbvQWN+QeeKKPmTXnD+eZjO3H2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615365;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=H/O+Mo0VVNCwn6G0Coe3gZ4s1DLGig40Bsnf3oJKl+Q=;
	b=e610Wx4BXxjwYwaWcG85pIaNx4YKEtJ6iEp7jbc+VA422yGa78Ai8euXwhLJriphV36/
	 ucQM+7dQ65Go7peMpdUiwXPCWhItN1US2OnrQ10uLfrroqccluFHJM/wPTmbplTY9DL2r
	 Cb6fPkCe2G/gVxxQGYBRFUB7L0GXVe3CF7qPTde339z8NQguzcg7u11VsvsACUTIl1Z67
	 bU1TTI5MaHTIvTtb/fMEDZl/ByKr1poSGsrpMAy6FhfO14eCXYhEl0G+IzSyJVLzfNB1b
	 Nzu4uFZjSKlSYOBXHIlmBm2KBJ72e1gFc8XTF2lt70hNrJ4RTQQTK5Ru0gPH0Pq0RYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCDutom7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFFD606A32D;
	Sat, 14 Nov 2026 00:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCDutom7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFD81F000C4;
	Sat, 14 Nov 2026 00:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615365;
	bh=H/O+Mo0VVNCwn6G0Coe3gZ4s1DLGig40Bsnf3oJKl+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dCDutom77k2RDxhVXA+pNPIua+fqPi9LCaPbyP7f926WWu3xjdSU7LdPc3YHSx1Lv
	 o8gTzM51nncEAIU+63cLubC7f85H7GDLrwRb0Ggsr2WImuG3ACFXWKWpxwFx4QgHGX
	 baFSXtGFPOvsvJmyflUQ+sn0c/4aTVSogDuuAlJiiNwEg95fyZPCqUSzhoczLOIc5W
	 sRuFsARvUMds8rkuutA2mw4MWOQrB85qDK73DF76CPO0L+I3mGh81GUW6weUQI9bO9
	 8BIg8H7P8EHwTsSIvt9RocaHjHzU8rlsD9QKokyBkEq284j8RQKG4Dl0ZA7IT8jVnf
	 oKG18v0SLnrrw==
Date: Sat, 14 Nov 2026 00:15:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan
 <ldewangan@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, Konrad
 Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, Jens
 Reidel <adrian@mainlining.org>, Casey Connolly <casey.connolly@linaro.org>,
 Val Packett <val@packett.cool>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/5] thermal/drivers/generic-adc: Allow probe without
 TZ registration
Message-ID: <20261114001552.3ae8f05e@jic23-hlaptop>
In-Reply-To: <20261113-bat-temp-adc-v3-3-743979a8fd90@fairphone.com>
References: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
	<20261113-bat-temp-adc-v3-3-743979a8fd90@fairphone.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 16:56:44 +0100
Luca Weiss <luca.weiss@fairphone.com> wrote:

> If the devicetree node is not referenced in a zone under /thermal-zones,
> devm_thermal_of_zone_register() will fail with -ENODEV.
> 
> Since the driver is now also registering as an IIO device[0], allow the
> probe to continue without the thermal zone.

Papering over problems, or expected path for some devices?  If it's
expected path we probably don't want to print a message with the
word failed in it.

> 
> We also can't use gadc_thermal_get_temp() anymore because we haven't
> necessarily initialized tz_dev.
> 
> Link: https://git.kernel.org/torvalds/c/3762f5851ac5 [0]
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/thermal/thermal-generic-adc.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
> index c6a7a65aa6a6..40a34e97a515 100644
> --- a/drivers/thermal/thermal-generic-adc.c
> +++ b/drivers/thermal/thermal-generic-adc.c
> @@ -86,14 +86,16 @@ static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
>  				 int *val, int *val2, long mask)
>  {
>  	struct gadc_thermal_info *gtinfo = iio_priv(indio_dev);
> +	int iio_val;
>  	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> -		ret = gadc_thermal_get_temp(gtinfo->tz_dev, val);
> -		if (ret)
> +		ret = iio_read_channel_processed(gtinfo->channel, &iio_val);
> +		if (ret < 0)
>  			return ret;
>  
> +		*val = gadc_thermal_adc_to_temp(gtinfo, iio_val);

Maybe spin a helper that is used both in adc_thermal_get_get_temp()
and here?  Whilst it won't save much code (may actually be a touch longer)
it will put the two relevant steps in one place.


>  		return IIO_VAL_INT;
>  
>  	default:
> @@ -195,14 +197,14 @@ static int gadc_thermal_probe(struct platform_device *pdev)
>  						    &gadc_thermal_ops);
>  	if (IS_ERR(gti->tz_dev)) {
>  		ret = PTR_ERR(gti->tz_dev);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev,
> -				"Thermal zone sensor register failed: %d\n",
> -				ret);
> -		return ret;
> -	}
> +		if (ret != -ENODEV)
> +			return ret;
>  
> -	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
> +		dev_info(dev, "Thermal zone sensor register failed: %d\n",
> +			 ret);
> +	} else {
> +		devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
> +	}
>  
>  	return gadc_iio_register(&pdev->dev, gti);
>  }
> 

