Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582859;
	b=X7O4RTtQYWHlSx9pVT4cjD7VmwUBvsVv2ntDAbG5YhIiWcWq8UegPerWMQISp+f0dQKS
	 lV0aXQvedilFsmHKIQ5hkxXcSkiDdXFhs+wu7cZCqZp3E0VWYjbKh0qCQYwCdvfToasoe
	 397Q06mDFCWYxxt2rJ7IkvoLKBngEHTh7ev1ZolDyYaLU5UhCOayaj77uHcYjuzlPqqOA
	 +pCo9OUYRfvuznSNKRULHUxeEkhH+0KuGZkHEbcw8M+Sa/0NthODijell2BbG5daEx1QP
	 bx9QnoPEZLgfzRsNV3Tr9Fd8SIEoNJ4CTFTEBCXulL2tB55uaNBDzwmvzn9ccGBoStA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582859;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UfRldmRYmdOXB066OSHlxeXaxLqp09q3SNbqpbUYr6E=;
	b=JluMyMmajjHlC42db5VLVmi2ght6Y4hwG7BH44iIZF0EeUfFupaHdaRkTDMENgktjV8v
	 1XES4zPSRzL1BrHXYHB8LOLxrLkKr73/CeOi4sqDKdpTwLVs5q6wfHAwOL5ym1bQMCtDt
	 dLyuCx2rc2Hjd53W2yABnb6TKYUwFs3YfN2xzDciJTs84fy2m4anBrObxRU8joyrWn6si
	 TvfFoTubhXVDaGCMNtA4q15ZWFv36ax2kF66mvf51MgjKca+6bs7NQoOPyvuDWXDTgaqQ
	 Wvovz17OaDre3RqyOxjKeNHV7/8zutYinelCi/vlg4zADpWpGvSbJmP4TSYX6WTQeFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0p68AVd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5B6606A324;
	Mon,  2 Nov 2026 01:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0p68AVd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233981F00919;
	Mon,  2 Nov 2026 01:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793582859;
	bh=UfRldmRYmdOXB066OSHlxeXaxLqp09q3SNbqpbUYr6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D0p68AVdlqZHXbsjr56QtNk+BdkIR47WcT1nfpC2a0XNCVRXnWZVgYSLzVT7IpHfL
	 pqwCPlvBDxJK8BShX1tg7dzDgfA5I3JTjrvyWa7DRKFqDww8nSCGTy+lu1Zp/s5foH
	 eWXIONLFfOLY6xaruIhxMBeHKvJL0Cya428kSP3e6k1h3suDy2WspNx1TY6oQZonhz
	 tWQyJFwYiM2vRPTjfMS/tAnfUMty3Y6E87udbkcrZVKZwNkp8kgcSCQcNvFxc0lsQv
	 u1xVEQCs14mJGLp/94Y+fx6lrGntHACR8oaLyqDZko5gxFQ5EHAn7IBdpSG/df+cJN
	 w9qREWdTKqJsg==
Date: Mon, 2 Nov 2026 01:27:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/17] iio: light: apds9960: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261102012733.435bdc94@jic23-hlaptop>
In-Reply-To: <20261021165858.v2.13.Ic0c3be7c36a602e32c04628d5ae5692556742fa8@changeid>
References: <20261021235818.3059519-1-briannorris@chromium.org>
	<20261021165858.v2.13.Ic0c3be7c36a602e32c04628d5ae5692556742fa8@changeid>
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

On Wed, 21 Oct 2026 16:57:14 -0700
Brian Norris <briannorris@chromium.org> wrote:

> This driver propagates the return value of pm_runtime_put_autosuspend(),
> which is not particularly useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> For this reason, modify this driver to simply discard the
> pm_runtime_put_autosuspend() return value. Inline the "off" helper, as
> it's trivial now, and rename to apds9960_power_on().
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

I took a look at this one and the current code is a complete mess.

I'm going to apply what you have here as a step in the right direction
simply because I can't see a quick path to fixing it properly.

If anyone wants a fun project then unwinding the mess in here would
be a good place to start.

Anyhow, applied this one.

thanks,

Jonathan

> ---
> I'm not sure if apds9960_write_event_config()'s existing logic is
> correct, but I don't want to mess with it.
> 
> Changes in v2:
>  * Split iio patch into per-driver patches
>  * Inline the put() helper
> 
>  drivers/iio/light/apds9960.c | 48 ++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index afe520de60e2..0e084ffba1a6 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -476,38 +476,23 @@ static int apds9960_set_als_gain(struct apds9960_data *data, int val)
>  	return ret;
>  }
>  
> -#ifdef CONFIG_PM
> -static int apds9960_set_power_state(struct apds9960_data *data, bool on)
> +static void apds9960_power_on(struct apds9960_data *data)
>  {
>  	struct device *dev = &data->client->dev;
> -	int ret = 0;
> +	int suspended;
>  
>  	mutex_lock(&data->lock);
>  
> -	if (on) {
> -		int suspended;
> -
> -		suspended = pm_runtime_suspended(dev);
> -		ret = pm_runtime_get_sync(dev);
> +	suspended = pm_runtime_suspended(dev);
> +	pm_runtime_get_sync(dev);
>  
> -		/* Allow one integration cycle before allowing a reading */
> -		if (suspended)
> -			usleep_range(data->als_adc_int_us,
> -				     APDS9960_MAX_INT_TIME_IN_US);
> -	} else {
> -		ret = pm_runtime_put_autosuspend(dev);
> -	}
> +	/* Allow one integration cycle before allowing a reading */
> +	if (suspended)
> +		usleep_range(data->als_adc_int_us,
> +			     APDS9960_MAX_INT_TIME_IN_US);
>  
>  	mutex_unlock(&data->lock);
> -
> -	return ret;
>  }
> -#else
> -static int apds9960_set_power_state(struct apds9960_data *data, bool on)
> -{
> -	return 0;
> -}
> -#endif
>  
>  static int apds9960_read_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
> @@ -522,7 +507,7 @@ static int apds9960_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		apds9960_set_power_state(data, true);
> +		apds9960_power_on(data);
>  		switch (chan->type) {
>  		case IIO_PROXIMITY:
>  			ret = regmap_read(data->regmap, chan->address, val);
> @@ -540,7 +525,7 @@ static int apds9960_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			ret = -EINVAL;
>  		}
> -		apds9960_set_power_state(data, false);
> +		pm_runtime_put_autosuspend(&data->client->dev);
>  		break;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		/* RGB + ALS sensors only have integration time */
> @@ -767,7 +752,6 @@ static int apds9960_write_event_config(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  		data->pxs_int = state;
> -		apds9960_set_power_state(data, state);
>  		break;
>  	case IIO_INTENSITY:
>  		if (data->als_int == state)
> @@ -777,12 +761,16 @@ static int apds9960_write_event_config(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  		data->als_int = state;
> -		apds9960_set_power_state(data, state);
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> +	if (state)
> +		apds9960_power_on(data);
> +	else
> +		pm_runtime_put_autosuspend(&data->client->dev);
> +
>  	return 0;
>  }
>  
> @@ -1078,7 +1066,7 @@ static int apds9960_probe(struct i2c_client *client)
>  	pm_runtime_set_autosuspend_delay(&client->dev, 5000);
>  	pm_runtime_use_autosuspend(&client->dev);
>  
> -	apds9960_set_power_state(data, true);
> +	apds9960_power_on(data);
>  
>  	ret = apds9960_regfield_init(data);
>  	if (ret)
> @@ -1105,12 +1093,12 @@ static int apds9960_probe(struct i2c_client *client)
>  	if (ret)
>  		goto error_power_down;
>  
> -	apds9960_set_power_state(data, false);
> +	pm_runtime_put_autosuspend(&client->dev);
>  
>  	return 0;
>  
>  error_power_down:
> -	apds9960_set_power_state(data, false);
> +	pm_runtime_put_autosuspend(&client->dev);
>  
>  	return ret;
>  }

