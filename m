Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793584720;
	b=5OMrXmrs65CToa5orWjHf1GbjnexcEVebLT9JWjLAeBv5kX8NIpR1WxaOsrRU6HK984J
	 7s3FSZfZzRiDYe6MXVaud1MYiJvQsJYRODHtf6A0UKPxk+CbH3SrR7zrttBrK/fa1p8oY
	 q7f1waf1L8KvE+hLGSzFyRF817UtFDgjP3u+y6TGhKMMFxem2ILSgSIumhzgMv7n9gm7h
	 OJVnix51oOUtCGxyLmIvprozME4LbGyNYamH4YpjAz/wB7MaVS+pX1mLMXDxMAGbcuzdY
	 WQwqcMV7R1tnfOmjraZ2H80ZxL6XVm0WsIKmsKOFx/4O7Dw9+DHhAq0o1aZ7lvSNeWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793584720;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mhRVqiYq+ePDA2NvwBd3ChCoiSdjgNpL+sEWmLZjAq0=;
	b=KYXROPU6g9CgOsI/0P2rTdE/uk4mpts8kO4BSHMLrocV5nJzuKU4agAEzU8s49yXpu1i
	 MV9WDhF/l6rern4GsBVvAbS/KusAcybcR9QaRx9X+iDRsk65ZxlOhEjSbseL+avQhRlGc
	 jFUvGbK3W4vsEOXrYkeeuqqH6mUQPbXtXyKIozhmOzSQeCbK2Z5QjQlM3m7YU+MtPN8Oa
	 EBUCRR58BTNqFrZ1gEqr90n7+B6ihLPLp0zHL39XMLF6N2NOIs6eSqRoYgmqR01U8NJxL
	 qCrhTwpKMvKxKY1O6l3vf4TcohOcbJMEkeEdvu7oKUvAH/9CrDoPKwMtKTSiqzznsIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A54SXCmm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A990606A324;
	Mon,  2 Nov 2026 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A54SXCmm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D211F000C1;
	Mon,  2 Nov 2026 01:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793584719;
	bh=mhRVqiYq+ePDA2NvwBd3ChCoiSdjgNpL+sEWmLZjAq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A54SXCmmrU0CWruUEsp2I/RJfkUrvlGIypr3AmBaVF+YmLZIXSTtUfWkHiK17Cy5n
	 mxSVdHnKE24IEGhs0yahQE0FuhpwcZCIjSLmCCT03VvBXeA/ar7E3IS50IbnZyC9Z0
	 JThp1I5URyg1lJXMq/x8yg8mEZe6gv9v/eJrri/xZyWnKnUJntPHz43zH6ed5m7sP0
	 e9iuij+BegYJEvz2lnZAYGw0mMljsl7ee10s4qmsLZBzhb5Z8kdbzYiluo6+3nxEX/
	 3prU4pOK4Yuho7MllH3EjPVQpudibbjVwFcen6biudgC3b2b9oQYGKn+ztHz3IPSg4
	 ABbDkeONkqeRw==
Date: Mon, 2 Nov 2026 01:58:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/17] iio: accel: mma955x: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261102015834.18155f42@jic23-hlaptop>
In-Reply-To: <20261021165858.v2.4.Ie9a9de6adbe98d063c6c45b2f59e143303586067@changeid>
References: <20261021235818.3059519-1-briannorris@chromium.org>
	<20261021165858.v2.4.Ie9a9de6adbe98d063c6c45b2f59e143303586067@changeid>
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

On Wed, 21 Oct 2026 16:57:05 -0700
Brian Norris <briannorris@chromium.org> wrote:

> These drivers propagate the return value of
> pm_runtime_put_autosuspend(), which is not particularly useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> For this reason, modify these drivers to simply discard the
> pm_runtime_put_autosuspend() return value, and inline the pm_runtime
> helpers now that they behave the same with and without CONFIG_PM.
> 
> While at it, I see that mma9553_write_event_config() mismanages the
> runtime PM reference count. It should only put() a reference after it's
> done touching the hardware, not before. Resolve this ordering issue.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Mostly for my own reference, this looks fine to me, but if there
is time it would be nice to use some ACQUIRE magic to simplify some error
handling etc.

I'd also ideally like some eyes on the actual functional changes
were reordering occurs just in case there is something subtle
going on.


> ---
> 
> Changes in v2:
>  * Split iio patch into per-driver patches
>  * Inlining
>  * Refcount ordering
> 
>  drivers/iio/accel/mma9551.c      | 21 +++++++++--------
>  drivers/iio/accel/mma9551_core.c | 39 ++++----------------------------
>  drivers/iio/accel/mma9551_core.h |  1 -
>  drivers/iio/accel/mma9553.c      | 36 ++++++++++++++++++++---------
>  4 files changed, 42 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index 182f488edab1..4c549fb106bc 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -71,9 +71,11 @@ static int mma9551_read_incli_chan(struct i2c_client *client,
>  		return -EINVAL;
>  	}
>  
> -	ret = mma9551_set_power_state(client, true);
> -	if (ret < 0)
> +	ret = pm_runtime_resume_and_get(&client->dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to resume: %d\n", ret);
>  		return ret;
> +	}
>  
>  	ret = mma9551_read_status_byte(client, MMA9551_APPID_TILT,
>  				       reg_addr, &angle);
> @@ -96,7 +98,7 @@ static int mma9551_read_incli_chan(struct i2c_client *client,
>  	ret = IIO_VAL_INT;
>  
>  out_poweroff:
> -	mma9551_set_power_state(client, false);
> +	pm_runtime_put_autosuspend(&client->dev);
>  	return ret;
>  }
>  
> @@ -178,9 +180,7 @@ static int mma9551_config_incli_event(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		ret = mma9551_set_power_state(data->client, false);
> -		if (ret < 0)
> -			return ret;
> +		pm_runtime_put_autosuspend(&data->client->dev);
>  	} else {
>  		int bitnum;
>  
> @@ -200,15 +200,18 @@ static int mma9551_config_incli_event(struct iio_dev *indio_dev,
>  		}
>  
>  
> -		ret = mma9551_set_power_state(data->client, true);
> -		if (ret < 0)
> +		ret = pm_runtime_resume_and_get(&data->client->dev);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "failed to resume: %d\n",
> +				ret);
>  			return ret;
> +		}
>  
>  		ret = mma9551_gpio_config(data->client,
>  					  (enum mma9551_gpio_pin)mma_axis,
>  					  MMA9551_APPID_TILT, bitnum, 0);
>  		if (ret < 0) {
> -			mma9551_set_power_state(data->client, false);
> +			pm_runtime_put_autosuspend(&data->client->dev);
>  			return ret;
>  		}
>  	}
> diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> index 2ccb1fb19b96..68df195d5b24 100644
> --- a/drivers/iio/accel/mma9551_core.c
> +++ b/drivers/iio/accel/mma9551_core.c
> @@ -654,37 +654,6 @@ int mma9551_set_device_state(struct i2c_client *client, bool enable)
>  }
>  EXPORT_SYMBOL_NS(mma9551_set_device_state, "IIO_MMA9551");
>  
> -/**
> - * mma9551_set_power_state() - sets runtime PM state
> - * @client:	I2C client
> - * @on:		Use true to power on device, false to power off
> - *
> - * Resume or suspend the device using Runtime PM.
> - * The device will suspend after the autosuspend delay.
> - *
> - * Returns: 0 on success, negative value on failure.
> - */
> -int mma9551_set_power_state(struct i2c_client *client, bool on)
> -{
> -#ifdef CONFIG_PM
> -	int ret;
> -
> -	if (on)
> -		ret = pm_runtime_resume_and_get(&client->dev);
> -	else
> -		ret = pm_runtime_put_autosuspend(&client->dev);
> -	if (ret < 0) {
> -		dev_err(&client->dev,
> -			"failed to change power state to %d\n", on);
> -
> -		return ret;
> -	}
> -#endif
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_NS(mma9551_set_power_state, "IIO_MMA9551");
> -
>  /**
>   * mma9551_sleep() - sleep
>   * @freq:	Application frequency
> @@ -741,9 +710,11 @@ int mma9551_read_accel_chan(struct i2c_client *client,
>  		return -EINVAL;
>  	}
>  
> -	ret = mma9551_set_power_state(client, true);
> -	if (ret < 0)
> +	ret = pm_runtime_resume_and_get(&client->dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to resume: %d\n", ret);
>  		return ret;
> +	}
>  
>  	ret = mma9551_read_status_word(client, MMA9551_APPID_AFE,
>  				       reg_addr, &raw_accel);
> @@ -755,7 +726,7 @@ int mma9551_read_accel_chan(struct i2c_client *client,
>  	ret = IIO_VAL_INT;
>  
>  out_poweroff:
> -	mma9551_set_power_state(client, false);
> +	pm_runtime_put_autosuspend(&client->dev);
>  	return ret;
>  }
>  EXPORT_SYMBOL_NS(mma9551_read_accel_chan, "IIO_MMA9551");
> diff --git a/drivers/iio/accel/mma9551_core.h b/drivers/iio/accel/mma9551_core.h
> index 543454a31dc0..1d55fdfd0a92 100644
> --- a/drivers/iio/accel/mma9551_core.h
> +++ b/drivers/iio/accel/mma9551_core.h
> @@ -62,7 +62,6 @@ int mma9551_gpio_config(struct i2c_client *client, enum mma9551_gpio_pin pin,
>  			u8 app_id, u8 bitnum, int polarity);
>  int mma9551_read_version(struct i2c_client *client);
>  int mma9551_set_device_state(struct i2c_client *client, bool enable);
> -int mma9551_set_power_state(struct i2c_client *client, bool on);
>  void mma9551_sleep(int freq);
>  int mma9551_read_accel_chan(struct i2c_client *client,
>  			    const struct iio_chan_spec *chan,
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 5a36d415a837..2ccb68dfbcd4 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -610,10 +610,16 @@ static int mma9553_write_raw(struct iio_dev *indio_dev,
>  		if (data->stepcnt_enabled == !!val)
>  			return 0;
>  		mutex_lock(&data->mutex);
> -		ret = mma9551_set_power_state(data->client, val);
> -		if (ret < 0) {
> -			mutex_unlock(&data->mutex);
> -			return ret;
> +		if (val) {
> +			ret = pm_runtime_resume_and_get(&data->client->dev);
> +			if (ret < 0) {
> +				dev_err(&data->client->dev,
> +					"failed to resume: %d\n", ret);
> +				mutex_unlock(&data->mutex);
> +				return ret;
> +			}
> +		} else {
> +			pm_runtime_put_autosuspend(&data->client->dev);
>  		}
>  		data->stepcnt_enabled = val;
>  		mutex_unlock(&data->mutex);
> @@ -737,24 +743,32 @@ static int mma9553_write_event_config(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&data->mutex);
>  
> -	ret = mma9551_set_power_state(data->client, state);
> -	if (ret < 0)
> -		goto err_out;
> +	if (state) {
> +		ret = pm_runtime_resume_and_get(&data->client->dev);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "failed to resume: %d\n",
> +				ret);
> +			goto err_out;
> +		}
> +	}
> +
>  	event->enabled = state;
>  
>  	ret = mma9553_conf_gpio(data);
>  	if (ret < 0)
>  		goto err_conf_gpio;
>  
> +	if (!state)
> +		pm_runtime_put_autosuspend(&data->client->dev);
> +
>  	mutex_unlock(&data->mutex);
>  
>  	return 0;
>  
>  err_conf_gpio:
> -	if (state) {
> -		event->enabled = false;
> -		mma9551_set_power_state(data->client, false);
> -	}
> +	if (state)
> +		pm_runtime_put_autosuspend(&data->client->dev);
> +	event->enabled = !state;
>  err_out:
>  	mutex_unlock(&data->mutex);
>  	return ret;

