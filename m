Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792976928;
	b=0HOdFPHn5oIuyhtgk5TPvTuldxVoZ8ipS5biGzW98UbPJdIakMI9Nh8Bcut15ZgY7VUT
	 p2ApcZrtRVNJwVQKjnYCkhqk2yJVzEZNLgKx8GbQDnvkaCiBNhg3509FYH0ry+dgEl3LW
	 oUs2IjY3rT4W/I2ZuKjtC6Coc3ZaDtoVuTA/YXeU22qvEoTSsUHd9kmglV6hMQePV9PQf
	 ZiheB4Wz4/ay1hhjPU1Sn5G01fAwykfM/8qAxMiRrf2w/w8vUI4SlULpXtaao4JF8fEZW
	 Kimjtkmll6GFRNf3jEWmJUTbfpwha3ftpqDGxaca6V2Y//HDsnCKyqKGDB2EUdwxkvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792976928;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1hgj4CnUvO7cv9RW3JdCHadNJGjXOR2CZY0go+pT5j4=;
	b=XvnoVFnXwkiChSnmI0Pb/BIRsAD145GZvT8lzEz2i8QvxDn/4tNHd5KLnTqKRln0pmGA
	 NkSOz56/ILjk03QkEbiAkw4POkqEoddkXi9Z03aFRgwvJ2DpTP1GVr0aeUHfA+Sg2O0F5
	 WPy58a7y9ROrmVXPfu7UzKNLDQLC7II/pHMBItowTWUg0Zt3WQy1WRytNvafWIbKEusi6
	 RaR9XO9fcVzhgdKXfUKtCm1uiHYC/t5Qot2Dhw2Xhh/ZQFA2NIqNlTTjGJOHSdPkOaiMt
	 pCiudRHjCee4YXPq5en/hTUCz/DXd9TKMMc0P9cbI1qkv9xLCt+cvnldpSTxwR/ZSlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzcDPFMI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43573606A31A;
	Mon, 26 Oct 2026 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzcDPFMI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F5B1F01825;
	Mon, 26 Oct 2026 01:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792976927;
	bh=1hgj4CnUvO7cv9RW3JdCHadNJGjXOR2CZY0go+pT5j4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jzcDPFMI5NRTbN2SiUrfcNys6dJN7uvDqDJhMHI8PWx1bs3Sh2JSbCXqHGiX6gsTT
	 I8DbnzHNKn5pcV5LttMGJECOrH+690iUfeF490rBCiiHkjSbqT4cOlcT0A2NkIC68h
	 bCs09p04jrXk0fY98HOfFwTQzOANKnsizeu16O8kzL04vWq1YnRH4pgUCv2T9/D/Ey
	 7KVAh3fRx+H98Se6MofFG7g+6aGrzxM8SQMwUUPTloYTTv15Pa3eo0K5+188qtNdIh
	 irGoMyKG+dtb/P5bUvBrF4heDfpMs1sTNV8XjQIBm9XJ/Z47dRV3lt/6NJii/Y8uhl
	 BVshkI0T9R7ew==
Date: Mon, 26 Oct 2026 01:08:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/17] iio: light: pa12203001: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261026010840.57583c86@jic23-hlaptop>
In-Reply-To: <20261021165858.v2.14.I501510b542691f595de1e110cfe35632a5fa7768@changeid>
References: <20261021235818.3059519-1-briannorris@chromium.org>
	<20261021165858.v2.14.I501510b542691f595de1e110cfe35632a5fa7768@changeid>
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

On Wed, 21 Oct 2026 16:57:15 -0700
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
> pm_runtime_put_autosuspend() return value, and inline some of the
> runtime PM helper function, now that it behaves the same with and
> without CONFIG_PM.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
Applied. Note I sent a follow up just now to use guard() on
the code that is visible in context here.

Thanks,

Jonathan

> ---
> 
> Changes in v2:
>  * Split iio patch into per-driver patches
>  * Inlining
> 
>  drivers/iio/light/pa12203001.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
> index c0f4db8d95f7..0a0502a60a06 100644
> --- a/drivers/iio/light/pa12203001.c
> +++ b/drivers/iio/light/pa12203001.c
> @@ -154,13 +154,12 @@ static inline int pa12203001_px_enable(struct pa12203001_data *data, u8 enable)
>  	return 0;
>  }
>  
> -static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
> -				      u8 mask)
> +static int pa12203001_runtime_resume_and_get(struct pa12203001_data *data, u8 mask)
>  {
>  #ifdef CONFIG_PM
>  	int ret;
>  
> -	if (on && (mask & PA12203001_ALS_EN_MASK)) {
> +	if (mask & PA12203001_ALS_EN_MASK) {
>  		mutex_lock(&data->lock);
>  		if (data->px_enabled) {
>  			ret = pa12203001_als_enable(data,
> @@ -173,7 +172,7 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
>  		mutex_unlock(&data->lock);
>  	}
>  
> -	if (on && (mask & PA12203001_PX_EN_MASK)) {
> +	if (mask & PA12203001_PX_EN_MASK) {
>  		mutex_lock(&data->lock);
>  		if (data->als_enabled) {
>  			ret = pa12203001_px_enable(data, PA12203001_PX_EN_MASK);
> @@ -185,10 +184,7 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
>  		mutex_unlock(&data->lock);
>  	}
>  
> -	if (on)
> -		return pm_runtime_resume_and_get(&data->client->dev);
> -
> -	return pm_runtime_put_autosuspend(&data->client->dev);
> +	return pm_runtime_resume_and_get(&data->client->dev);
>  
>  err:
>  	mutex_unlock(&data->lock);
> @@ -213,7 +209,7 @@ static int pa12203001_read_raw(struct iio_dev *indio_dev,
>  		switch (chan->type) {
>  		case IIO_LIGHT:
>  			dev_mask = PA12203001_ALS_EN_MASK;
> -			ret = pa12203001_set_power_state(data, true, dev_mask);
> +			ret = pa12203001_runtime_resume_and_get(data, dev_mask);
>  			if (ret < 0)
>  				return ret;
>  			/*
> @@ -226,13 +222,11 @@ static int pa12203001_read_raw(struct iio_dev *indio_dev,
>  				goto reg_err;
>  
>  			*val = le16_to_cpu(reg_word);
> -			ret = pa12203001_set_power_state(data, false, dev_mask);
> -			if (ret < 0)
> -				return ret;
> +			pm_runtime_put_autosuspend(&data->client->dev);
>  			break;
>  		case IIO_PROXIMITY:
>  			dev_mask = PA12203001_PX_EN_MASK;
> -			ret = pa12203001_set_power_state(data, true, dev_mask);
> +			ret = pa12203001_runtime_resume_and_get(data, dev_mask);
>  			if (ret < 0)
>  				return ret;
>  			ret = regmap_read(data->map, PA12203001_REG_PDH,
> @@ -241,9 +235,7 @@ static int pa12203001_read_raw(struct iio_dev *indio_dev,
>  				goto reg_err;
>  
>  			*val = reg_byte;
> -			ret = pa12203001_set_power_state(data, false, dev_mask);
> -			if (ret < 0)
> -				return ret;
> +			pm_runtime_put_autosuspend(&data->client->dev);
>  			break;
>  		default:
>  			return -EINVAL;
> @@ -262,7 +254,7 @@ static int pa12203001_read_raw(struct iio_dev *indio_dev,
>  	}
>  
>  reg_err:
> -	pa12203001_set_power_state(data, false, dev_mask);
> +	pm_runtime_put_autosuspend(&data->client->dev);
>  	return ret;
>  }
>  

