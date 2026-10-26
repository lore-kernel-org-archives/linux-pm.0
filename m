Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984904;
	b=LuJZV2z/0Ypt60QeUoAhAAwG6b+ARYP3T3SPMXHU9uu8yhfiJ6G8cgeTxO9r3JGGZKMQ
	 ka3H9QSIoC2XnIFJaFPUHLzELjlI1TNkpnH9gUOf7Q7cGLAUjKqVZFNB3DLdpMXv4OKwC
	 MOqIr/OvmiQYnry4m6xd42SYhMPT14a8vJXBBx5p7aB/D8puOkhkz8UFurH3wVyUcmDcs
	 ilZF9kuPdYSr2DCNo9bvNahhGwcuIh2M8AdHXt4RGc9jfQZFxTs6pBE3+1I2+CvV4j2nV
	 usdpvZfSTyOsvXVC0WMO4CusSqbSmY++mEQwP050Hx5rGK30/Me1Tq4YYHbpZZNGjMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984904;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hHE6IQcnuKMkcZmd8KP7GqMn/9CxW05x7kZYhg8S1Kg=;
	b=t5O3X5LXEtM15FmxdvnVOSPokIDa39fwD85cjdAakNKSZS4Xplxh//3LhQxEuaRZcZee
	 KD4Dc+gSKcH2fMPgAGzttSROBVX2S7xBve99wRJxmg+6C8Ow4gIpLsnJ1HuafvAYlPu6n
	 C7DeNmuVBfL2BdJXnoJuwoFjUBbAoqfsD8LXd3LPj7H2664P0j5NzGYNhXOEXPcwk1yMI
	 UWbQD2DGNqea52CYuwjVD7MnbAuySJtJ9Ha9DdxTo3GL+rDWjvX6VzH8UKdrqN9+befR6
	 3R4TMQLa3LWIkKqxH2H7AsLlLRQHJeNzu0dgrWrcudomUlzzuMR+FzyZ6zDRKk6rjLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BZk9ZC8/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE36606A31A;
	Mon, 26 Oct 2026 03:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZk9ZC8/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB391F01825;
	Mon, 26 Oct 2026 03:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792984904;
	bh=hHE6IQcnuKMkcZmd8KP7GqMn/9CxW05x7kZYhg8S1Kg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BZk9ZC8/5zmdEP8WmnXOP0XottU3T7Llp4+0ob8BSm+iA3Ts8VNRfRImgXEnpnM+1
	 i1ri3VNYuH8n3h5NFViMJuJp/miZHBDmmh/wwsvkH0yCITiRyy4sCSBAIsoOu13nIG
	 azSkncVIpBJO69uPMVPR4//81jk6ZtyQw3WYbPjXOz26/B0cyDn8SBjfwzmSEW9trl
	 UK3NfFC1tNsR+AKe0AQ2qLn+imR7oIaYusKzUr9fYnqCOZQuHatwX50otbk5NjyzbJ
	 3g6dyKmYSSM7kMVXdua2y4jgd953Jl00oUrYSIPiIkw2QaUuAPLDlMDdfsxmObWzCV
	 gvIOlN87kLSTg==
Date: Mon, 26 Oct 2026 03:21:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org, Rui Miguel Silva
 <rmfrfs@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/17] iio: gyro: fxas21002c: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261026032135.43938d1c@jic23-hlaptop>
In-Reply-To: <20261021165858.v2.11.I3517fbd2ba5f7d25ddcdf4abaec13f6ca301236d@changeid>
References: <20261021235818.3059519-1-briannorris@chromium.org>
	<20261021165858.v2.11.I3517fbd2ba5f7d25ddcdf4abaec13f6ca301236d@changeid>
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

On Wed, 21 Oct 2026 16:57:12 -0700
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
> pm_runtime_put_autosuspend() return value, and inline the helpers now
> that they're even more trivial.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

This one I think does deserve a tweak.
Whether to jump to guard() and ACQUIRE() for 2 out of the 3 cases
is a more complex decision - I messed with it and I think it
makes sense. I'll send out a suggested v3 in a sec with a follow up
doing broader conversion to guard.

> ---
> 
> Changes in v2:
>  * Split iio patch into per-driver patches
>  * Inlining
> 
>  drivers/iio/gyro/fxas21002c_core.c | 33 ++++++++----------------------
>  1 file changed, 9 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> index a88670207cec..1d891387b121 100644
> --- a/drivers/iio/gyro/fxas21002c_core.c
> +++ b/drivers/iio/gyro/fxas21002c_core.c

>  static int fxas21002c_temp_get(struct fxas21002c_data *data, int *val)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
> @@ -383,22 +371,20 @@ static int fxas21002c_temp_get(struct fxas21002c_data *data, int *val)
>  	int ret;
>  
>  	mutex_lock(&data->lock);
> -	ret = fxas21002c_pm_get(data);
> +	ret = pm_runtime_resume_and_get(dev);
>  	if (ret < 0)
>  		goto data_unlock;
>  
>  	ret = regmap_field_read(data->regmap_fields[F_TEMP], &temp);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to read temp: %d\n", ret);
> -		fxas21002c_pm_put(data);
> +		pm_runtime_put_autosuspend(dev);
>  		goto data_unlock;
>  	}
>  
>  	*val = sign_extend32(temp, 7);
>  
> -	ret = fxas21002c_pm_put(data);
> -	if (ret < 0)
> -		goto data_unlock;
> +	pm_runtime_put_autosuspend(dev);

Similar to below.

>  
>  	ret = IIO_VAL_INT;
>  
> @@ -416,7 +402,7 @@ static int fxas21002c_axis_get(struct fxas21002c_data *data,
>  	int ret;
>  
>  	mutex_lock(&data->lock);
> -	ret = fxas21002c_pm_get(data);
> +	ret = pm_runtime_resume_and_get(dev);
>  	if (ret < 0)
>  		goto data_unlock;
>  
> @@ -424,15 +410,13 @@ static int fxas21002c_axis_get(struct fxas21002c_data *data,
>  			       &axis_be, sizeof(axis_be));
>  	if (ret < 0) {
>  		dev_err(dev, "failed to read axis: %d: %d\n", index, ret);
> -		fxas21002c_pm_put(data);
> +		pm_runtime_put_autosuspend(dev);
See below - tiny tweak and this isn't needed.

>  		goto data_unlock;
>  	}
>  
>  	*val = sign_extend32(be16_to_cpu(axis_be), 15);
>  
> -	ret = fxas21002c_pm_put(data);
> -	if (ret < 0)
> -		goto data_unlock;
> +	pm_runtime_put_autosuspend(dev);
This wants pushing a few lines later as then it can be after
a new label just above data_unlock.  With that done we can drop the call of
the same above.

>  
>  	ret = IIO_VAL_INT;
>  

