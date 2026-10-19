Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792447335;
	b=1fEU7S3973Lw37L8uo2EYOGWcr6A7DwQZT/mCPnO5aWP9oeVQ6/nXCUgdAD6wtVGPlKb
	 z6Kq70+LzOBVI+fMmXJTrtajceX/IqPphmUtT2VndeD9u6ZzevQGGuhQghkvYNXbGUpvL
	 1wj7LTWfiSxJSAxls8h0xdKd3ChbY0Hjs/jai4c0ufAEu0gHuGQUC7Yem4ai9wzA1YQPx
	 KraBCUNsM1CImjk5D05q4StvbWNs1JdP+1WFyTV4qXAl8jTav3puIWm5FGzDhG/GTGWtj
	 XnecQVHeBlPpdVAD2x4kP+2NrySHJiIUaqyn+5b5QuOGamwfWWo3ACgPfVJS6V5/kuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=B2T7IEZCRbl9FocUwUazqp5V2uJWIVnD2e1z1NFYYw0=;
	b=i7v9c7lAohmmHZ07qhuwJaR7Bgw1GPkXOC8urHDqOK73owJfWfM2GLcCNH1o7A96MwXN
	 PtiRFWF0W7MclAalGURhs5w6idCR9ndw1DyCB5qZC0K0H/AVXUEj4HiIFvaUUdU933PCp
	 ExMhVjxT69x6TXDDuOvthi5uxmFNT9ac2ZIQG96YSINVaTA6yHpCbJFClLP3P0OBDDcrr
	 A2mH/a9EAZXfPm11Zm+gjn5RgYG+zqxrcuiZIboYni/9vLvFAipYuOoZWVN+3Ychoc8XY
	 Km6G1JBzwkajylNl+UxeiUUDtxlkaJVs17vjiEZMlqQW8UiC+KeN8JUrbid+WKCcoIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QQzTlX7z;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B549606A31D
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 22:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B549606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QQzTlX7z
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so5594345eec.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792447333; x=1793052133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B2T7IEZCRbl9FocUwUazqp5V2uJWIVnD2e1z1NFYYw0=;
        b=QQzTlX7zTjFNmflXi1V2iuLR0hVniQzwiq1nlSBHzbj+1Zat/UTl6LrT7uaUmWfYqT
         rO3YU17vKHmoegWYAZ17R1VBTxHmKXC/M5dML6TzqHIUm+1KmLfIg9Xe5Eo+4GjyLSoo
         d/2+yvdtYlG0y5awl54WADSVnRN5VU7pl0cP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792447333; x=1793052133;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B2T7IEZCRbl9FocUwUazqp5V2uJWIVnD2e1z1NFYYw0=;
        b=PGMgfJ8B9RTwj1HeZY+54bCG1w9EYbqAC3pYCpzwENs5fTm/zInQKUObsa9n1DiN6L
         h/4N4NmeAo7t8GbSz1MxJcNbctNhHzvTFffovid2LWb14RQNT5dPTyvg9pt40UCaT87C
         tWD6q8zfVV4Z/FZ63pXzVUqp41tCE9OD9nHS3nlCAffGYwKBsIkFj8fusFQOhSv4sbE7
         h7JsFZ/yWlAAwdqGynmaksolRXOYvlgsVeY25UwazYO5uGXmcpZCBNuvAlgqcfgIgG3g
         gp5KmkCZCfRvnm+tGV47it4eFANVU5zoQFjuY2t4GfEX+XpGnvwDt5kRMZH8RpZyLxCy
         EoIw==
X-Forwarded-Encrypted: i=1; AKwUvBzKEIBA3dYQjHv57Z2M8IaUZD42JJawlUFopiTZ6cF8cv0iBj4hVS3RupWVEGRCrF5xfr1BByGrSg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLJI6EcSh56i5PDg6JzfA7ZP4pUFb/HS1X6r81ORavN8Ui/IVkl
	ZqP3uIBG09IzUbAZERHXpac5qa4tmGqp4PGtNrfVf8usfCcxQdBVFQR4Zqi37rq1bw==
X-Gm-Gg: AYBFou2PEClk472D76Jq3adHPQZAibW32pD/6T5I6SvmB8n0tskOsD6lAzK6kw8sefh
	0CSHMAfgeZQoS0c9zEpM9Q7v8wIuTyioIPsIvXmITAxDtIi78jU9vDxGU51TDDrxHYB90SkesQl
	oeZ+PPy6JSUQbq62K+E7s3NkkxnZ0E7N8sn9B5Rw4EuZiz3SVX8WKh77KnEIkQUkVfena0LoPT/
	r3XwR7Ud8N4E4XHhV96NFgRLAqz/0sx2UHJiZ35+eMRtpPF3niVjr5ywjsT3jMVu7bdjjaWfIO1
	gcAdgQJSuRTNoXG+hSqz0pYhFUw/VFzC0EqM9gyKicSbHlCUdSvg93gpnEjGGt8jkXmXt+3M5I3
	BXjx1YAo6Ky+q2aB6J3aHKoN1kkqfkyIaiUL37gj+Qv73FFbOeSaGVVXIpIBdjl/o6LzNyBm4Hp
	OofHCAFOQArDcq83zPZddCjUTqifvkW43/2Qv6jNnCMgGlgoxHa2JoiPDTq6Q+VBJBKfIpVRcpt
	7eDOqObZ0hj9Nbfv/Ts7L9lVzwmAxTuP3gltxY=
X-Received: by 2002:a05:7300:8256:b0:360:d4c5:7243 with SMTP id 5a478bee46e88-361a146ee7fmr11262690eec.11.1792447332696;
        Mon, 19 Oct 2026 15:02:12 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:42e7:1057:ba3a:2c19])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-360813b684dsm34798959eec.10.2026.10.19.15.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 15:02:10 -0700 (PDT)
Date: Mon, 19 Oct 2026 15:02:08 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 03/13] iio: Discard pm_runtime_put_autosuspend() return
 values
Message-ID: <ataTYER7XM_MEYKL@google.com>
References: <20261006231900.3230373-1-briannorris@chromium.org>
 <20261006161337.3.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
 <20261018211807.66bfea0d@jic23-hlaptop>
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
In-Reply-To: <20261018211807.66bfea0d@jic23-hlaptop>

Hi Jonathan,

On Sun, Oct 18, 2026 at 09:18:07PM +0100, Jonathan Cameron wrote:
> On Tue,  6 Oct 2026 16:13:31 -0700
> Brian Norris <briannorris@chromium.org> wrote:
> 
> > Multiple IIO drivers inspect or propagate the return value of
> > pm_runtime_put_autosuspend(), which is not particularly useful.
> > 
> > Returning an error code from pm_runtime_put_autosuspend() merely means
> > that it has not queued up a timer or work item to check whether or not
> > the device can be suspended and there are many perfectly valid
> > situations in which that can happen, like after writing "on" to the
> > device's runtime PM "control" attribute in sysfs for one example.
> > 
> > For this reason, modify these drivers to simply discard the
> > pm_runtime_put_autosuspend() return value, and change the return types
> > of fxls8962af_power_off() and fxas21002c_pm_put() to void.
> > 
> > This will facilitate a planned change of the
> > pm_runtime_put_autosuspend() return type to void in the future, similar
> > to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> > type to void").
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > This patch is independent of the rest of the series, except for the end
> > (changing the return type). I expect it can be applied by individual
> > maintainers, and we pick up the end once the dust is settled.
> > 
> > I couldn't decide if I should split this up by individual driver, or
> > just 1 for the whole drivers/iio/ subsystem. Many of these drivers have
> > borrowed the same patterns, so I chose to just send 1. Let me know if I
> > should split it up.
> 
> Hi Brian,
> 
> Great that you are doing this, but sadly it opens the can of worms that
> are the helpers a lot of these drivers have.  They just about made
> sense before various recent runtime_pm useability improvements.
> Now they make very little sense at all. Dropping the return value
> here also removes the reason for a bunch of odd defensive ifdefs.
> 
> As such, I'm requesting some slightly more involved changes. Some of
> them I think are coupled tightly to what you are doing here so should
> be in this series, others can be left for later.

Thanks for the notes. I'll handle the ones that are at least
approximately related to the code I'm touching. I think there are a few
bugs that get resolved along the way too.

I may not get the more tangential ones though.

Also, unless you'd prefer otherwise, I plan to wait a bit more to send
v2, since the merge window only just opened, and some of this series
will just be a RESEND. I'd prefer maximizing the chance that the
recipients will actually notice the patches, by submitting outside that
window.

(OTOH, the bulk of these changes are in IIO, so I can just make IIO its
own series if that helps things along.)

I'll leave a few comments below.

> With that in mind, I think the changes will become a little more
> complex and so we probably end up with one patch per driver.
> 
> Jonathan
> 
> p.s. I'm feeling a bit mean asking for so many additional changes,
> so if you don't have time say that and I'll see if I can find some
> time (or someone else!) to do the extra work.
> 
> > 
> >  drivers/iio/accel/bmc150-accel-core.c         | 14 +++++-----
> >  drivers/iio/accel/fxls8962af-core.c           | 11 +++-----
> >  drivers/iio/accel/kxcjk-1013.c                | 15 ++++++-----
> >  drivers/iio/accel/mma8452.c                   | 15 +++++------
> >  drivers/iio/accel/mma9551_core.c              | 15 +++++------
> >  drivers/iio/adc/rcar-gyroadc.c                |  4 +--
> >  drivers/iio/adc/ti-ads1015.c                  |  8 +++---
> >  drivers/iio/chemical/atlas-sensor.c           |  4 +--
> >  .../common/hid-sensors/hid-sensor-trigger.c   | 14 ++++------
> >  drivers/iio/gyro/bmg160_core.c                | 17 +++++-------
> >  drivers/iio/gyro/fxas21002c_core.c            | 12 +++------
> >  drivers/iio/imu/kmx61.c                       | 17 ++++++------
> >  drivers/iio/light/apds9960.c                  |  2 +-
> >  drivers/iio/light/isl29028.c                  | 15 +++--------
> >  drivers/iio/light/pa12203001.c                |  3 ++-
> >  drivers/iio/light/rpr0521.c                   | 15 +++++------
> >  drivers/iio/light/tsl2583.c                   | 27 +++----------------
> >  drivers/iio/light/us5182d.c                   |  3 ++-
> >  18 files changed, 80 insertions(+), 131 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> > index 46bb36d9366e..2f7fe28e3e0b 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -332,14 +332,14 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
> >  	struct device *dev = regmap_get_device(data->regmap);
> This driver could do with modernizing to use the stuff that
> lets the compiler drop unused pm functions.  That is a bit
> of a bigger change though so entirely optional wrt to this set.
> 
> >  	int ret;
> >  
> > -	if (on)
> > +	if (on) {
> >  		ret = pm_runtime_resume_and_get(dev);
> > -	else
> > -		ret = pm_runtime_put_autosuspend(dev);
> > -	if (ret < 0) {
> > -		dev_err(dev,
> > -			"Failed: %s for %d\n", __func__, on);
> > -		return ret;
> > +		if (ret < 0) {
> > +			dev_err(dev, "%s: failed to resume: %d\n", __func__, ret);
> > +			return ret;
> > +		}
> > +	} else {
> > +		pm_runtime_put_autosuspend(dev);
> >  	}
> >  
> >  	return 0;
> > diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> > index 18d7b09bddd2..3a2c4ce0557c 100644
> > --- a/drivers/iio/accel/fxls8962af-core.c
> > +++ b/drivers/iio/accel/fxls8962af-core.c
> > @@ -216,16 +216,11 @@ static int fxls8962af_power_on(struct fxls8962af_data *data)
> >  	return ret;
> >  }
> >  
> > -static int fxls8962af_power_off(struct fxls8962af_data *data)
> > +static void fxls8962af_power_off(struct fxls8962af_data *data)
> 
> This helper is completely pointless after you cleanup. Please drop
> it.  The _on() one just exists to print an error. So ideally drop
> that one as well.

Ack.

> >  {
> >  	struct device *dev = regmap_get_device(data->regmap);
> > -	int ret;
> > -
> > -	ret = pm_runtime_put_autosuspend(dev);
> > -	if (ret)
> > -		dev_err(dev, "failed to power off\n");
> >  
> > -	return ret;
> > +	pm_runtime_put_autosuspend(dev);
> >  }
> >  
> >  static int fxls8962af_standby(struct fxls8962af_data *data)
> > @@ -692,7 +687,7 @@ fxls8962af_write_event_config(struct iio_dev *indio_dev,
> >  			return -EBUSY;
> >  
> >  		/* Not in buffered mode so disable power */
> > -		ret = fxls8962af_power_off(data);
> > +		fxls8962af_power_off(data);
> >  
> >  		iio_device_release_direct(indio_dev);
> >  	}
> > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> > index 166fb786425f..f068753469a8 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -633,14 +633,15 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
> 
> Same as the one below. 

Ack.

> >  #ifdef CONFIG_PM
> >  	int ret;
> >  
> > -	if (on)
> > +	if (on) {
> >  		ret = pm_runtime_resume_and_get(&data->client->dev);
> > -	else
> > -		ret = pm_runtime_put_autosuspend(&data->client->dev);
> > -	if (ret < 0) {
> > -		dev_err(&data->client->dev,
> > -			"Failed: %s for %d\n", __func__, on);
> > -		return ret;
> > +		if (ret < 0) {
> > +			dev_err(&data->client->dev,
> > +				"%s: failed to resume: %d\n", __func__, ret);
> > +			return ret;
> > +		}
> > +	} else {
> > +		pm_runtime_put_autosuspend(&data->client->dev);
> >  	}
> >  #endif
> >  
> > diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> > index 7d683686dd9d..711689db8694 100644
> > --- a/drivers/iio/accel/mma8452.c
> > +++ b/drivers/iio/accel/mma8452.c
> > @@ -224,15 +224,14 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
> 
> As with so many of the others. This is now a pointless function.
> The reason for the ifdef is gone I believe after this patch so dropping
> that would be minimum. Better would be to get rid of the helper
> and just make the runtime pm calls directly wherever this
> was called.

Ack.

> >  #ifdef CONFIG_PM
> >  	int ret;
> >  
> > -	if (on)
> > +	if (on) {
> >  		ret = pm_runtime_resume_and_get(&client->dev);
> > -	else
> > -		ret = pm_runtime_put_autosuspend(&client->dev);
> > -	if (ret < 0) {
> > -		dev_err(&client->dev,
> > -			"failed to change power state to %d\n", on);
> > -
> > -		return ret;
> > +		if (ret < 0) {
> > +			dev_err(&client->dev, "failed to resume: %d\n", ret);
> > +			return ret;
> > +		}
> > +	} else {
> > +		pm_runtime_put_autosuspend(&client->dev);
> >  	}
> >  #endif
> >  
> > diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> > index 2ccb1fb19b96..d8aa0a062779 100644
> > --- a/drivers/iio/accel/mma9551_core.c
> > +++ b/drivers/iio/accel/mma9551_core.c
> > @@ -669,15 +669,14 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
> >  #ifdef CONFIG_PM
> >  	int ret;
> 
> Another one where I think the ifdef was for the return value of stubbed
> pm_runtime_put_autosuspend.  So we can drop that.
> Also the function no longer has any real purpose - so if you don't
> mind going a little further, dropping this helper and calling
> the pm_runtime functions inline would be much nicer.

Ack.

> >  
> > -	if (on)
> > +	if (on) {
> >  		ret = pm_runtime_resume_and_get(&client->dev);
> > -	else
> > -		ret = pm_runtime_put_autosuspend(&client->dev);
> > -	if (ret < 0) {
> > -		dev_err(&client->dev,
> > -			"failed to change power state to %d\n", on);
> > -
> > -		return ret;
> > +		if (ret < 0) {
> > +			dev_err(&client->dev, "failed to resume: %d\n", ret);
> > +			return ret;
> > +		}
> > +	} else {
> > +		pm_runtime_put_autosuspend(&client->dev);
> >  	}
> >  #endif
> >  
> 
> > diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> > index 0fbfa4e499aa..817ec1c73df4 100644
> > --- a/drivers/iio/adc/ti-ads1015.c
> > +++ b/drivers/iio/adc/ti-ads1015.c
> > @@ -370,15 +370,13 @@ static const struct iio_chan_spec tla2024_channels[] = {
> >  #ifdef CONFIG_PM
> >  static int ads1015_set_power_state(struct ads1015_data *data, bool on)
> >  {
> > -	int ret;
> >  	struct device *dev = regmap_get_device(data->regmap);
> >  
> >  	if (on)
> > -		ret = pm_runtime_resume_and_get(dev);
> > -	else
> > -		ret = pm_runtime_put_autosuspend(dev);
> > +		return pm_runtime_resume_and_get(dev);
> >  
> > -	return ret < 0 ? ret : 0;
> > +	pm_runtime_put_autosuspend(dev);
> > +	return 0;
> >  }
> >  
> >  #else /* !CONFIG_PM */
> 
> I think the ifdef stuff here was to paper over the return value
> you are removing.  Should be able to drop it now.
> 
> 
> > diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> > index d611341a0e2a..e8e511daa7c4 100644
> > --- a/drivers/iio/gyro/bmg160_core.c
> > +++ b/drivers/iio/gyro/bmg160_core.c
> > @@ -319,18 +319,15 @@ static int bmg160_set_power_state(struct bmg160_data *data, bool on)
> >  	struct device *dev = regmap_get_device(data->regmap);
> >  	int ret;
> >  
> > -	if (on)
> > +	if (on) {
> >  		ret = pm_runtime_get_sync(dev);
> 
> gah.  Please just change this to use pm_runtime_resume_and_get() whilst you
> are here.
> 
> Ideally squash the helper in favour of direct calls to the runtime
> pm.  Yet another pace that the recent improvements in runtime pm useability
> have made what was of minor benefit entirely pointless.
> 
> The ifdef can go away as well as I think the only thing that helped with
> was the return value of the put you are removing.

One thing I found while looking through this driver:

bmg160_write_event_config() and bmg160_data_rdy_trigger_set_state() do
some ghastly things w.r.t. runtime PM. In particular, they seem to
perform put_autosuspend() *before* they're done touching the hardware,
and then rely on the (very large) autosuspend delay to defer the
runtime_suspend() operation. It even has a bunch of comments about the
incorrect ordering.

That's one giant race condition. And the autosuspend delay is
configurable via user space, so it's extra dangerous.

Anyway, that's to say: I plan to refactor/reorder the put_autosuspend()
ordering there while I'm at it.

(There's also some strange error handling that potentially leads to
runtime PM underflow. I'll fix that one while I'm here.)

I think this one is imitated in another few drivers as well.

> > -	else
> > -		ret = pm_runtime_put_autosuspend(dev);
> > -
> > -	if (ret < 0) {
> > -		dev_err(dev, "Failed: bmg160_set_power_state for %d\n", on);
> > -
> > -		if (on)
> > +		if (ret < 0) {
> > +			dev_err(dev, "%s: failed to resume: %d\n", __func__, ret);
> >  			pm_runtime_put_noidle(dev);
> > -
> > -		return ret;
> > +			return ret;
> > +		}
> > +	} else {
> > +		pm_runtime_put_autosuspend(dev);
> >  	}
> >  #endif
> >  
> > diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> > index a88670207cec..408f88f12fe7 100644
> > --- a/drivers/iio/gyro/fxas21002c_core.c
> > +++ b/drivers/iio/gyro/fxas21002c_core.c
> > @@ -369,11 +369,11 @@ static int  fxas21002c_pm_get(struct fxas21002c_data *data)
> >  	return pm_runtime_resume_and_get(regmap_get_device(data->regmap));
> >  }
> >  
> > -static int  fxas21002c_pm_put(struct fxas21002c_data *data)
> > +static void fxas21002c_pm_put(struct fxas21002c_data *data)
> The two runtime pm helpers in here have evolved to become a terrible
> idea.
> 
> Can we just drop them as part of your change and make the
> runtime pm calls directly instead?  The dev is always available
> at the call sites so this should be trivial.

Ack.

> >  {
> >  	struct device *dev = regmap_get_device(data->regmap);
> >  
> > -	return pm_runtime_put_autosuspend(dev);
> > +	pm_runtime_put_autosuspend(dev);
> >  }
> >  
> >  static int fxas21002c_temp_get(struct fxas21002c_data *data, int *val)
> > @@ -396,9 +396,7 @@ static int fxas21002c_temp_get(struct fxas21002c_data *data, int *val)
> >  
> >  	*val = sign_extend32(temp, 7);
> >  
> > -	ret = fxas21002c_pm_put(data);
> > -	if (ret < 0)
> > -		goto data_unlock;
> > +	fxas21002c_pm_put(data);
> >  
> >  	ret = IIO_VAL_INT;
> >  
> > @@ -430,9 +428,7 @@ static int fxas21002c_axis_get(struct fxas21002c_data *data,
> >  
> >  	*val = sign_extend32(be16_to_cpu(axis_be), 15);
> >  
> > -	ret = fxas21002c_pm_put(data);
> > -	if (ret < 0)
> > -		goto data_unlock;
> > +	fxas21002c_pm_put(data);
> >  
> >  	ret = IIO_VAL_INT;
> >  
> 
> > diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> > index afe520de60e2..611e59d6b027 100644
> > --- a/drivers/iio/light/apds9960.c
> > +++ b/drivers/iio/light/apds9960.c
> 
> Not needed for this series but...
> 
> Another one that has become rather pointless and should just be split
> into separate functions for enable and disable (where disable one
> is just pm_runtime_put_autosuspend)
> 
> > @@ -495,7 +495,7 @@ static int apds9960_set_power_state(struct apds9960_data *data, bool on)
> >  			usleep_range(data->als_adc_int_us,
> >  				     APDS9960_MAX_INT_TIME_IN_US);
> >  	} else {
> > -		ret = pm_runtime_put_autosuspend(dev);
> > +		pm_runtime_put_autosuspend(dev);
> >  	}
> >  
> >  	mutex_unlock(&data->lock);
> > diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> > index 33deb1726689..190ce67d2efe 100644
> > --- a/drivers/iio/light/isl29028.c
> > +++ b/drivers/iio/light/isl29028.c
> > @@ -395,9 +395,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	ret = pm_runtime_put_autosuspend(dev);
> > -	if (ret < 0)
> > -		return ret;
> > +	pm_runtime_put_autosuspend(dev);
> >  
> >  	return 0;
> >  }
> > @@ -408,7 +406,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
> >  {
> >  	struct isl29028_chip *chip = iio_priv(indio_dev);
> >  	struct device *dev = regmap_get_device(chip->regmap);
> > -	int ret, pm_ret;
> > +	int ret;
> 
> Not one for this series (the patch for this LGTM),
> but if anyone is reading and bored, cleanup.h magic would simplify
> this code nicely.
> 
> 
> >  
> >  	ret = pm_runtime_resume_and_get(dev);
> >  	if (ret < 0)
> > @@ -464,14 +462,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	/**
> > -	 * Preserve the ret variable if the call to
> > -	 * pm_runtime_put_autosuspend() is successful so the reading
> > -	 * (if applicable) is returned to user space.
> > -	 */
> > -	pm_ret = pm_runtime_put_autosuspend(dev);
> > -	if (pm_ret < 0)
> > -		return pm_ret;
> > +	pm_runtime_put_autosuspend(dev);
> >  
> >  	return ret;
> >  }
> > diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
> > index c0f4db8d95f7..d4e197e05d26 100644
> > --- a/drivers/iio/light/pa12203001.c
> > +++ b/drivers/iio/light/pa12203001.c
> > @@ -188,7 +188,8 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
> >  	if (on)
> >  		return pm_runtime_resume_and_get(&data->client->dev);
> >  
> > -	return pm_runtime_put_autosuspend(&data->client->dev);
> > +	pm_runtime_put_autosuspend(&data->client->dev);
> > +	return 0;
> 
> This function has evolved to the point of silliness.
> Given how minor your change is, feel free to ignore the following however!
> 
> There is zero shared code in here between the on and off paths so
> rename the function pa12203001_runtime_enable() and cover only the
> 'on' case.  Then just put the pm_runtime_put_autosuspend() in wherever
> on was previously false.

Ack. But because "runtime_enable()" has a specific runtime PM meaning
that is very different than the usage here, I've chosen the name
"pa12203001_runtime_resume_and_get()" instead, which I think makes for
more API symmetry.

> Given that presumably one of the things is being turned on whenever
> we enable it, also pull the mutex out of the if blocks and use
> guard() to simplify that.

guard() is tricky, since it produces a deadlock if you hold the lock
across pm_runtime_resume_and_get(). So I'll skip that part and leave it
to someone (or no one) who is more particularly interested in this
driver.

> >  
> >  err:
> >  	mutex_unlock(&data->lock);
> > diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> > index 7d82efc31f3a..60c5e85bac2c 100644
> > --- a/drivers/iio/light/rpr0521.c
> > +++ b/drivers/iio/light/rpr0521.c
> > @@ -357,15 +357,14 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
> >  	 * Note: If either measurement is re-enabled before _suspend(),
> >  	 * both stay enabled until _suspend().
> 
> Not asking for it in your series as beyond the scope, but
> this function should just be split in two.  Almost no code is shared
> between the get and put paths.
> 
> However...
> 
> >  	 */
> > -	if (on)
> > +	if (on) {
> >  		ret = pm_runtime_resume_and_get(&data->client->dev);
> > -	else
> > -		ret = pm_runtime_put_autosuspend(&data->client->dev);
> > -	if (ret < 0) {
> > -		dev_err(&data->client->dev,
> > -			"Failed: rpr0521_set_power_state for %d, ret %d\n",
> > -			on, ret);
> > -		return ret;
> > +		if (ret < 0) {
> > +			dev_err(&data->client->dev, "Failed to resume: %d\n", ret);
> > +			return ret;
> > +		}
> > +	} else {
> > +		pm_runtime_put_autosuspend(&data->client->dev);
> >  	}
> >  
> >  	if (on) {
> 
> This no longer makes any sense so maybe it is better to just split the
> code as part of your change set or at minimum change to
> 
> 	if (!on) {
> 		pm_runtime_put_autosuspend(&data->client->dev);
> 
> 		return 0;
> 	}
> 
> 	ret = pm_runtime_resume_and_get(&data->client->dev);
> 	if (ret < 0) {
> 		dev_err(&data->client->dev, "Failed to resume: %d\n", ret);
> 		return ret;
> 	}
> 
> 	/* If _resume() was not called, enable measurement now. */
> 	if (data->als_ps_need_en) {
> 		ret = rpr0521_als_enable(data, RPR0521_MODE_ALS_ENABLE);
> 		if (ret)
> 			return ret;
> 		data->als_ps_need_en = false;
> 	}
> 
> 	if (data->pxs_ps_need_en) {
> 		ret = rpr0521_pxs_enable(data, RPR0521_MODE_PXS_ENABLE);
> 		if (ret)
> 			return ret;
> 		data->pxs_ps_need_en = false;
> 	}
> #endif //mess that makes sense with more context!
> 	return 0;
> }

Ack.

> > diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> > index 53fd423aa7ae..deaa71485468 100644
> > --- a/drivers/iio/light/tsl2583.c
> > +++ b/drivers/iio/light/tsl2583.c
> > @@ -640,7 +640,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
> >  			    int *val, int *val2, long mask)
> >  {
> >  	struct tsl2583_chip *chip = iio_priv(indio_dev);
> > -	int ret, pm_ret;
> > +	int ret;
> >  
> >  	ret = pm_runtime_resume_and_get(&chip->client->dev);
> >  	if (ret < 0)
> > @@ -709,19 +709,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
> >  read_done:
> >  	mutex_unlock(&chip->als_mutex);
> >  
> > -	if (ret < 0) {
> > -		pm_runtime_put_autosuspend(&chip->client->dev);
> > -		return ret;
> > -	}
> > -
> > -	/*
> > -	 * Preserve the ret variable if the call to
> > -	 * pm_runtime_put_autosuspend() is successful so the reading
> > -	 * (if applicable) is returned to user space.
> > -	 */
> > -	pm_ret = pm_runtime_put_autosuspend(&chip->client->dev);
> > -	if (pm_ret < 0)
> > -		return pm_ret;
> > +	pm_runtime_put_autosuspend(&chip->client->dev);
> >  
> >  	return ret;
> >  }
> > @@ -773,16 +761,9 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
> >  
> >  	mutex_unlock(&chip->als_mutex);
> >  
> > -	if (ret < 0) {
> > -		pm_runtime_put_autosuspend(&chip->client->dev);
> > -		return ret;
> > -	}
> > +	pm_runtime_put_autosuspend(&chip->client->dev);
> >  
> > -	ret = pm_runtime_put_autosuspend(&chip->client->dev);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	return 0;
> > +	return ret;
> Yuck this was indeed a mess, so great to clean that up!
> 
> Not asking for it in this series, but this is a great place to use
> some cleanup.h magic for the mutex and the runtime pm.
> 
> 
> >  }
> >  
> >  static const struct iio_info tsl2583_info = {
> > diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> > index ab518311fd79..e76c40b422f4 100644
> > --- a/drivers/iio/light/us5182d.c
> > +++ b/drivers/iio/light/us5182d.c
> > @@ -366,7 +366,8 @@ static int us5182d_set_power_state(struct us5182d_data *data, bool on)
> >  	if (on)
> >  		return pm_runtime_resume_and_get(&data->client->dev);
> >  
> > -	return pm_runtime_put_autosuspend(&data->client->dev);
> > +	pm_runtime_put_autosuspend(&data->client->dev);
> 
> Prefer a blank line here.  Always nice before a simple return like this.

Ack.

Brian

> > +	return 0;
> >  }
> >  
> >  static int us5182d_read_value(struct us5182d_data *data,
> 
