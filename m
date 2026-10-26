Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792985158;
	b=XKxH87Q4bT1X09wu8UHq7XlreMIeY/o+TPVBUtF8aopoJC/oDv47ic9Ex0EgZjIdLopE
	 9oz5zEm+a19SqJLRytd2XE3PDMtMxoNcAWO7Yap7264zFxVIAag7257e4A6LrybeUOfDq
	 Mf4+Y8r6rUVzVTR2aaYSb04fW976SnJB+DVeP7YBc8if4oZ4qL8cXdhYHHan7+PjcRNZb
	 xNi8ytgRvUhAPa/tDa0iBlrGh+1ZVNnYIarhIi0RCjvJ5VEyKineHD6hVNzWVsIV0IEVK
	 LM/R0KsInIOLYTvn5lpbF5SSq4iNFZc2Waz8aBTrCaTSKrzJexb2b3cBBcCicDHwkMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792985158;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=r7ezphrj+oGFDlyJzh0KgsQtGnCebZng7eNFUrW44ts=;
	b=Kr34c5rs7Bhg1qxFfxn5Y5PVxfoGr9VHWPLB4o5Ww9uJF1rSpYKBNq1X7mbqTU+DFejg
	 o1wZStB/nRbpHmYAYgI6t7s03xtUc76roodE9u+tA//q8M5Dv8O6DqoWiYvmF9DSN2gtt
	 8XF16yFl86wDAIROmvxXGEEDF+auka+AMTSkliZg28RDZVVGufIYkggpoV+2hmb1sQ+dv
	 vrKb8Ufq18xR5GqjZRww8ZATTTy00jJTm13pYUdtzmM/RiigQi6Hib0ystCncoQsEGbuI
	 RXa2ghyGAv3RttxHMbbnWIdv77RpbKheRbkx3VFSxi3i+rB9faiT1SwGbMJVsZ0H1vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJbor1ZF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66646606A31B;
	Mon, 26 Oct 2026 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJbor1ZF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BB41F01825;
	Mon, 26 Oct 2026 03:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792985158;
	bh=r7ezphrj+oGFDlyJzh0KgsQtGnCebZng7eNFUrW44ts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iJbor1ZF6TAy1nxpgPmlEV3U2iTl4M1wdl+VcMJ2pE2JDoI2fQfESg9a5P5yNEF6/
	 9d8F6waUwgqFW8BupkLm2PXDnn6lATlwpKVNc9i4etUIDAKe+K29b0Wh6ISwpDhMuL
	 dl5apYZ14qKbxvzsXDMZ5vRkzf3jm/p7Nu4//ms2QrIw2Wo2ZpGB27KgnxcdCKLMNY
	 qcaRb4AzjbXELgY14p60jozchxVwoO8OVlS/dIyboC70DrozygyEb5Ue0YGUpYvn2b
	 rWzNxu0B3DOZrlafHeswD2onVwZGcZx+ZStSTlDeohADnsYfuurkww+HfSYDALXVEY
	 bnWmjIl96w8QQ==
Date: Mon, 26 Oct 2026 03:25:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/17] iio: chemical: atlas-sensor: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261026032550.0451be50@jic23-hlaptop>
In-Reply-To: <20261021165858.v2.8.I55d76837b3feb481080e43d358375445ca0993c6@changeid>
References: <20261021235818.3059519-1-briannorris@chromium.org>
	<20261021165858.v2.8.I55d76837b3feb481080e43d358375445ca0993c6@changeid>
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

On Wed, 21 Oct 2026 16:57:09 -0700
Brian Norris <briannorris@chromium.org> wrote:

> The atlas-sensor driver propagates the return value of
> pm_runtime_put_autosuspend(), which is not particularly useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> For this reason, modify this driver to simply discard the
> pm_runtime_put_autosuspend() return value.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Applied.

> ---
> 
> Changes in v2:
>  * Split iio patch into per-driver patches
> 
>  drivers/iio/chemical/atlas-sensor.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 1d4a9919df1a..48598475512f 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -426,9 +426,7 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> -	ret = pm_runtime_put_autosuspend(&data->client->dev);
> -	if (ret)
> -		return ret;
> +	pm_runtime_put_autosuspend(&data->client->dev);
>  
>  	return 0;
>  }

