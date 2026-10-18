Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B1C2F8E93;
	Sun, 18 Oct 2026 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792354697; cv=none; b=gTc6hSaU1AxARltJgppzPN0A121ykVcZveCmMUn2p172hCnTmmrBfBvTwnsylxQC/2Wz8rBy4kPU+x8hlD7X9wZjEsjx6+HLjp6xNPf8juhVNG8k3+ITyXAJPXYBiEDQ5Nn7kfiJhksI2h9COds9k5bNFagTr8UWz1T7p82I25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792354697; c=relaxed/simple;
	bh=K5mJyePaaLGYc2dboDj9SjxiNRwTCd05Nwuzqt4btDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQMtLx2bbH5gzEybaubzcE08loR34cCz8Ut5PBaNBrrfOKo4vCaeL4/CVBL7Y7Ia+onxXux8qJ1dAWASPyesoAvw/3akH+d/63QmnwnENG17a+/P++3RP1g+4q7VLyTYOrj6UiYuo85oN/TMYP5gnPUTLMcftJbTg1rYlBaOpDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdM1r7nf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdM1r7nf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6862F1F000C4;
	Sun, 18 Oct 2026 20:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792354695;
	bh=3cFgYstirMi1yxbDA94qwYeigS8zXyY2Oxz1o7B2EnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZdM1r7nffBhMW1CwDty0alDz6WaeZSP9aVCpAn+yMnST/p6p6pKYEed8mQrWIewTt
	 6GrPQAyuWQ9ZkV5ZiwY5lihsPAyZnxPVHFPRI3zLQ/+OKf8prb7W2XfceAwBRBSSpL
	 X955LSCpzrDKhTnHk6guOWepYkgJnOhYTAbJk/nNz3UDCyeAl3Dts6BxqRRYj1rD09
	 q4V89x1jP9Nriyc/qv+nDeBzP5hPWastZCvDefuNJ6NvJo5fPUYdPZgzh5IHNhOOT2
	 Q2PHRLV86TxmBWOO7wKF5P8kPfAA8Cec2uxznmJHbxsi8uMzhUmKErVu0BNKpLwxNm
	 DhVqUg6SYVSUQ==
Date: Sun, 18 Oct 2026 21:18:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, Ulf
 Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rui Miguel Silva <rmfrfs@gmail.com>,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 03/13] iio: Discard pm_runtime_put_autosuspend() return
 values
Message-ID: <20261018211807.66bfea0d@jic23-hlaptop>
In-Reply-To: <20261006161337.3.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
References: <20261006231900.3230373-1-briannorris@chromium.org>
	<20261006161337.3.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Oct 2026 16:13:31 -0700
Brian Norris <briannorris@chromium.org> wrote:

> Multiple IIO drivers inspect or propagate the return value of
> pm_runtime_put_autosuspend(), which is not particularly useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> For this reason, modify these drivers to simply discard the
> pm_runtime_put_autosuspend() return value, and change the return types
> of fxls8962af_power_off() and fxas21002c_pm_put() to void.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> This patch is independent of the rest of the series, except for the end
> (changing the return type). I expect it can be applied by individual
> maintainers, and we pick up the end once the dust is settled.
> 
> I couldn't decide if I should split this up by individual driver, or
> just 1 for the whole drivers/iio/ subsystem. Many of these drivers have
> borrowed the same patterns, so I chose to just send 1. Let me know if I
> should split it up.

Hi Brian,

Great that you are doing this, but sadly it opens the can of worms that
are the helpers a lot of these drivers have.  They just about made
sense before various recent runtime_pm useability improvements.
Now they make very little sense at all. Dropping the return value
here also removes the reason for a bunch of odd defensive ifdefs.

As such, I'm requesting some slightly more involved changes. Some of
them I think are coupled tightly to what you are doing here so should
be in this series, others can be left for later.

With that in mind, I think the changes will become a little more
complex and so we probably end up with one patch per driver.

Jonathan

p.s. I'm feeling a bit mean asking for so many additional changes,
so if you don't have time say that and I'll see if I can find some
time (or someone else!) to do the extra work.

> 
>  drivers/iio/accel/bmc150-accel-core.c         | 14 +++++-----
>  drivers/iio/accel/fxls8962af-core.c           | 11 +++-----
>  drivers/iio/accel/kxcjk-1013.c                | 15 ++++++-----
>  drivers/iio/accel/mma8452.c                   | 15 +++++------
>  drivers/iio/accel/mma9551_core.c              | 15 +++++------
>  drivers/iio/adc/rcar-gyroadc.c                |  4 +--
>  drivers/iio/adc/ti-ads1015.c                  |  8 +++---
>  drivers/iio/chemical/atlas-sensor.c           |  4 +--
>  .../common/hid-sensors/hid-sensor-trigger.c   | 14 ++++------
>  drivers/iio/gyro/bmg160_core.c                | 17 +++++-------
>  drivers/iio/gyro/fxas21002c_core.c            | 12 +++------
>  drivers/iio/imu/kmx61.c                       | 17 ++++++------
>  drivers/iio/light/apds9960.c                  |  2 +-
>  drivers/iio/light/isl29028.c                  | 15 +++--------
>  drivers/iio/light/pa12203001.c                |  3 ++-
>  drivers/iio/light/rpr0521.c                   | 15 +++++------
>  drivers/iio/light/tsl2583.c                   | 27 +++----------------
>  drivers/iio/light/us5182d.c                   |  3 ++-
>  18 files changed, 80 insertions(+), 131 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 46bb36d9366e..2f7fe28e3e0b 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -332,14 +332,14 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
>  	struct device *dev = regmap_get_device(data->regmap);
This driver could do with modernizing to use the stuff that
lets the compiler drop unused pm functions.  That is a bit
of a bigger change though so entirely optional wrt to this set.

>  	int ret;
>  
> -	if (on)
> +	if (on) {
>  		ret = pm_runtime_resume_and_get(dev);
> -	else
> -		ret = pm_runtime_put_autosuspend(dev);
> -	if (ret < 0) {
> -		dev_err(dev,
> -			"Failed: %s for %d\n", __func__, on);
> -		return ret;
> +		if (ret < 0) {
> +			dev_err(dev, "%s: failed to resume: %d\n", __func__, ret);
> +			return ret;
> +		}
> +	} else {
> +		pm_runtime_put_autosuspend(dev);
>  	}
>  
>  	return 0;
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 18d7b09bddd2..3a2c4ce0557c 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -216,16 +216,11 @@ static int fxls8962af_power_on(struct fxls8962af_data *data)
>  	return ret;
>  }
>  
> -static int fxls8962af_power_off(struct fxls8962af_data *data)
> +static void fxls8962af_power_off(struct fxls8962af_data *data)

This helper is completely pointless after you cleanup. Please drop
it.  The _on() one just exists to print an error. So ideally drop
that one as well.

>  {
>  	struct device *dev = regmap_get_device(data->regmap);
> -	int ret;
> -
> -	ret = pm_runtime_put_autosuspend(dev);
> -	if (ret)
> -		dev_err(dev, "failed to power off\n");
>  
> -	return ret;
> +	pm_runtime_put_autosuspend(dev);
>  }
>  
>  static int fxls8962af_standby(struct fxls8962af_data *data)
> @@ -692,7 +687,7 @@ fxls8962af_write_event_config(struct iio_dev *indio_dev,
>  			return -EBUSY;
>  
>  		/* Not in buffered mode so disable power */
> -		ret = fxls8962af_power_off(data);
> +		fxls8962af_power_off(data);
>  
>  		iio_device_release_direct(indio_dev);
>  	}
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 166fb786425f..f068753469a8 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -633,14 +633,15 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)

Same as the one below. 

>  #ifdef CONFIG_PM
>  	int ret;
>  
> -	if (on)
> +	if (on) {
>  		ret = pm_runtime_resume_and_get(&data->client->dev);
> -	else
> -		ret = pm_runtime_put_autosuspend(&data->client->dev);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev,
> -			"Failed: %s for %d\n", __func__, on);
> -		return ret;
> +		if (ret < 0) {
> +			dev_err(&data->client->dev,
> +				"%s: failed to resume: %d\n", __func__, ret);
> +			return ret;
> +		}
> +	} else {
> +		pm_runtime_put_autosuspend(&data->client->dev);
>  	}
>  #endif
>  
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 7d683686dd9d..711689db8694 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -224,15 +224,14 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)

As with so many of the others. This is now a pointless function.
The reason for the ifdef is gone I believe after this patch so dropping
that would be minimum. Better would be to get rid of the helper
and just make the runtime pm calls directly wherever this
was called.

>  #ifdef CONFIG_PM
>  	int ret;
>  
> -	if (on)
> +	if (on) {
>  		ret = pm_runtime_resume_and_get(&client->dev);
> -	else
> -		ret = pm_runtime_put_autosuspend(&client->dev);
> -	if (ret < 0) {
> -		dev_err(&client->dev,
> -			"failed to change power state to %d\n", on);
> -
> -		return ret;
> +		if (ret < 0) {
> +			dev_err(&client->dev, "failed to resume: %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		pm_runtime_put_autosuspend(&client->dev);
>  	}
>  #endif
>  
> diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> index 2ccb1fb19b96..d8aa0a062779 100644
> --- a/drivers/iio/accel/mma9551_core.c
> +++ b/drivers/iio/accel/mma9551_core.c
> @@ -669,15 +669,14 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
>  #ifdef CONFIG_PM
>  	int ret;

Another one where I think the ifdef was for the return value of stubbed
pm_runtime_put_autosuspend.  So we can drop that.
Also the function no longer has any real purpose - so if you don't
mind going a little further, dropping this helper and calling
the pm_runtime functions inline would be much nicer.

>  
> -	if (on)
> +	if (on) {
>  		ret = pm_runtime_resume_and_get(&client->dev);
> -	else
> -		ret = pm_runtime_put_autosuspend(&client->dev);
> -	if (ret < 0) {
> -		dev_err(&client->dev,
> -			"failed to change power state to %d\n", on);
> -
> -		return ret;
> +		if (ret < 0) {
> +			dev_err(&client->dev, "failed to resume: %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		pm_runtime_put_autosuspend(&client->dev);
>  	}
>  #endif
>  

> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 0fbfa4e499aa..817ec1c73df4 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -370,15 +370,13 @@ static const struct iio_chan_spec tla2024_channels[] = {
>  #ifdef CONFIG_PM
>  static int ads1015_set_power_state(struct ads1015_data *data, bool on)
>  {
> -	int ret;
>  	struct device *dev = regmap_get_device(data->regmap);
>  
>  	if (on)
> -		ret = pm_runtime_resume_and_get(dev);
> -	else
> -		ret = pm_runtime_put_autosuspend(dev);
> +		return pm_runtime_resume_and_get(dev);
>  
> -	return ret < 0 ? ret : 0;
> +	pm_runtime_put_autosuspend(dev);
> +	return 0;
>  }
>  
>  #else /* !CONFIG_PM */

I think the ifdef stuff here was to paper over the return value
you are removing.  Should be able to drop it now.


> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index d611341a0e2a..e8e511daa7c4 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -319,18 +319,15 @@ static int bmg160_set_power_state(struct bmg160_data *data, bool on)
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
>  
> -	if (on)
> +	if (on) {
>  		ret = pm_runtime_get_sync(dev);

gah.  Please just change this to use pm_runtime_resume_and_get() whilst you
are here.

Ideally squash the helper in favour of direct calls to the runtime
pm.  Yet another pace that the recent improvements in runtime pm useability
have made what was of minor benefit entirely pointless.

The ifdef can go away as well as I think the only thing that helped with
was the return value of the put you are removing.

> -	else
> -		ret = pm_runtime_put_autosuspend(dev);
> -
> -	if (ret < 0) {
> -		dev_err(dev, "Failed: bmg160_set_power_state for %d\n", on);
> -
> -		if (on)
> +		if (ret < 0) {
> +			dev_err(dev, "%s: failed to resume: %d\n", __func__, ret);
>  			pm_runtime_put_noidle(dev);
> -
> -		return ret;
> +			return ret;
> +		}
> +	} else {
> +		pm_runtime_put_autosuspend(dev);
>  	}
>  #endif
>  
> diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> index a88670207cec..408f88f12fe7 100644
> --- a/drivers/iio/gyro/fxas21002c_core.c
> +++ b/drivers/iio/gyro/fxas21002c_core.c
> @@ -369,11 +369,11 @@ static int  fxas21002c_pm_get(struct fxas21002c_data *data)
>  	return pm_runtime_resume_and_get(regmap_get_device(data->regmap));
>  }
>  
> -static int  fxas21002c_pm_put(struct fxas21002c_data *data)
> +static void fxas21002c_pm_put(struct fxas21002c_data *data)
The two runtime pm helpers in here have evolved to become a terrible
idea.

Can we just drop them as part of your change and make the
runtime pm calls directly instead?  The dev is always available
at the call sites so this should be trivial.

>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  
> -	return pm_runtime_put_autosuspend(dev);
> +	pm_runtime_put_autosuspend(dev);
>  }
>  
>  static int fxas21002c_temp_get(struct fxas21002c_data *data, int *val)
> @@ -396,9 +396,7 @@ static int fxas21002c_temp_get(struct fxas21002c_data *data, int *val)
>  
>  	*val = sign_extend32(temp, 7);
>  
> -	ret = fxas21002c_pm_put(data);
> -	if (ret < 0)
> -		goto data_unlock;
> +	fxas21002c_pm_put(data);
>  
>  	ret = IIO_VAL_INT;
>  
> @@ -430,9 +428,7 @@ static int fxas21002c_axis_get(struct fxas21002c_data *data,
>  
>  	*val = sign_extend32(be16_to_cpu(axis_be), 15);
>  
> -	ret = fxas21002c_pm_put(data);
> -	if (ret < 0)
> -		goto data_unlock;
> +	fxas21002c_pm_put(data);
>  
>  	ret = IIO_VAL_INT;
>  

> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index afe520de60e2..611e59d6b027 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c

Not needed for this series but...

Another one that has become rather pointless and should just be split
into separate functions for enable and disable (where disable one
is just pm_runtime_put_autosuspend)

> @@ -495,7 +495,7 @@ static int apds9960_set_power_state(struct apds9960_data *data, bool on)
>  			usleep_range(data->als_adc_int_us,
>  				     APDS9960_MAX_INT_TIME_IN_US);
>  	} else {
> -		ret = pm_runtime_put_autosuspend(dev);
> +		pm_runtime_put_autosuspend(dev);
>  	}
>  
>  	mutex_unlock(&data->lock);
> diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> index 33deb1726689..190ce67d2efe 100644
> --- a/drivers/iio/light/isl29028.c
> +++ b/drivers/iio/light/isl29028.c
> @@ -395,9 +395,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = pm_runtime_put_autosuspend(dev);
> -	if (ret < 0)
> -		return ret;
> +	pm_runtime_put_autosuspend(dev);
>  
>  	return 0;
>  }
> @@ -408,7 +406,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct isl29028_chip *chip = iio_priv(indio_dev);
>  	struct device *dev = regmap_get_device(chip->regmap);
> -	int ret, pm_ret;
> +	int ret;

Not one for this series (the patch for this LGTM),
but if anyone is reading and bored, cleanup.h magic would simplify
this code nicely.


>  
>  	ret = pm_runtime_resume_and_get(dev);
>  	if (ret < 0)
> @@ -464,14 +462,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	/**
> -	 * Preserve the ret variable if the call to
> -	 * pm_runtime_put_autosuspend() is successful so the reading
> -	 * (if applicable) is returned to user space.
> -	 */
> -	pm_ret = pm_runtime_put_autosuspend(dev);
> -	if (pm_ret < 0)
> -		return pm_ret;
> +	pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }
> diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
> index c0f4db8d95f7..d4e197e05d26 100644
> --- a/drivers/iio/light/pa12203001.c
> +++ b/drivers/iio/light/pa12203001.c
> @@ -188,7 +188,8 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
>  	if (on)
>  		return pm_runtime_resume_and_get(&data->client->dev);
>  
> -	return pm_runtime_put_autosuspend(&data->client->dev);
> +	pm_runtime_put_autosuspend(&data->client->dev);
> +	return 0;

This function has evolved to the point of silliness.
Given how minor your change is, feel free to ignore the following however!

There is zero shared code in here between the on and off paths so
rename the function pa12203001_runtime_enable() and cover only the
'on' case.  Then just put the pm_runtime_put_autosuspend() in wherever
on was previously false.

Given that presumably one of the things is being turned on whenever
we enable it, also pull the mutex out of the if blocks and use
guard() to simplify that.

>  
>  err:
>  	mutex_unlock(&data->lock);
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 7d82efc31f3a..60c5e85bac2c 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -357,15 +357,14 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
>  	 * Note: If either measurement is re-enabled before _suspend(),
>  	 * both stay enabled until _suspend().

Not asking for it in your series as beyond the scope, but
this function should just be split in two.  Almost no code is shared
between the get and put paths.

However...

>  	 */
> -	if (on)
> +	if (on) {
>  		ret = pm_runtime_resume_and_get(&data->client->dev);
> -	else
> -		ret = pm_runtime_put_autosuspend(&data->client->dev);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev,
> -			"Failed: rpr0521_set_power_state for %d, ret %d\n",
> -			on, ret);
> -		return ret;
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Failed to resume: %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		pm_runtime_put_autosuspend(&data->client->dev);
>  	}
>  
>  	if (on) {

This no longer makes any sense so maybe it is better to just split the
code as part of your change set or at minimum change to

	if (!on) {
		pm_runtime_put_autosuspend(&data->client->dev);

		return 0;
	}

	ret = pm_runtime_resume_and_get(&data->client->dev);
	if (ret < 0) {
		dev_err(&data->client->dev, "Failed to resume: %d\n", ret);
		return ret;
	}

	/* If _resume() was not called, enable measurement now. */
	if (data->als_ps_need_en) {
		ret = rpr0521_als_enable(data, RPR0521_MODE_ALS_ENABLE);
		if (ret)
			return ret;
		data->als_ps_need_en = false;
	}

	if (data->pxs_ps_need_en) {
		ret = rpr0521_pxs_enable(data, RPR0521_MODE_PXS_ENABLE);
		if (ret)
			return ret;
		data->pxs_ps_need_en = false;
	}
#endif //mess that makes sense with more context!
	return 0;
}
> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index 53fd423aa7ae..deaa71485468 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -640,7 +640,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -	int ret, pm_ret;
> +	int ret;
>  
>  	ret = pm_runtime_resume_and_get(&chip->client->dev);
>  	if (ret < 0)
> @@ -709,19 +709,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
>  read_done:
>  	mutex_unlock(&chip->als_mutex);
>  
> -	if (ret < 0) {
> -		pm_runtime_put_autosuspend(&chip->client->dev);
> -		return ret;
> -	}
> -
> -	/*
> -	 * Preserve the ret variable if the call to
> -	 * pm_runtime_put_autosuspend() is successful so the reading
> -	 * (if applicable) is returned to user space.
> -	 */
> -	pm_ret = pm_runtime_put_autosuspend(&chip->client->dev);
> -	if (pm_ret < 0)
> -		return pm_ret;
> +	pm_runtime_put_autosuspend(&chip->client->dev);
>  
>  	return ret;
>  }
> @@ -773,16 +761,9 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
>  
>  	mutex_unlock(&chip->als_mutex);
>  
> -	if (ret < 0) {
> -		pm_runtime_put_autosuspend(&chip->client->dev);
> -		return ret;
> -	}
> +	pm_runtime_put_autosuspend(&chip->client->dev);
>  
> -	ret = pm_runtime_put_autosuspend(&chip->client->dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> +	return ret;
Yuck this was indeed a mess, so great to clean that up!

Not asking for it in this series, but this is a great place to use
some cleanup.h magic for the mutex and the runtime pm.


>  }
>  
>  static const struct iio_info tsl2583_info = {
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index ab518311fd79..e76c40b422f4 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -366,7 +366,8 @@ static int us5182d_set_power_state(struct us5182d_data *data, bool on)
>  	if (on)
>  		return pm_runtime_resume_and_get(&data->client->dev);
>  
> -	return pm_runtime_put_autosuspend(&data->client->dev);
> +	pm_runtime_put_autosuspend(&data->client->dev);

Prefer a blank line here.  Always nice before a simple return like this.

> +	return 0;
>  }
>  
>  static int us5182d_read_value(struct us5182d_data *data,

