Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793584380;
	b=BCrXY9EZjiYF/r+gaAbAs7El0GZOgmR3CO7SqeRzNOule3jZSzLVa4FVQv2n/R+BG9hp
	 4kgZiVtCRCAfDVtaYyT168iXPKuzoKah5WGLNGjaGYWI8yCmjNNYEHXpD0i9sSw1+XwXv
	 rnhlzHvOKRiFkvOjmFgPtTkUgVgMfv0ILOmljtvIhMGxGN+x16jZHazLSgpD1SuAF3YgV
	 S5AgSs8UxQ58hJJ2+Uc942xL1QEW8QjS30MG9FVuexuXcFvR9nv3plk8HyD2RvYcRPK6r
	 zO18DkwO42qcbvkEHHlWSdSorYmUTZLvaOO6tHKisKX/CvRnAeqW0CpSkM7NI7OqJxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793584380;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kxRe0LNqH2ViGLC0rMqrcgxwbomID3tdiZ3UJaftoIo=;
	b=jMvKDwKocpl6Am29biWem3eI671FH9xYsGrtCpOaQc7UvTBseCJl9RYytlH/ezHqkMjG
	 AfZVuYyb741nL7ylfRLImUgdtSkxubCMzvmTmBMV5pJUZGz45CXnEZ+LwZWkfX+6wKbTa
	 DaQ3Xzr/kAuaQCq4W7jk2BmEKEYGrcTtX11aOeZNLJBdKtsbrDUMbJqgdeIWd4thzEXk3
	 EeCYq4ObJ9Ic6Ir0VudZq4ShLu++Zj+0PqaAq+Dw+agQjnePw9qeNNfw0322yyr+/F0mn
	 U6GKx/YBJaWN4hy52pUa78zexBrve9UgaE9IEnOYdgHx7hIA9fjZzFkDNY15ob9p4TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxCLgzEX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78024606A326;
	Mon,  2 Nov 2026 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxCLgzEX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A33C1F00A02;
	Mon,  2 Nov 2026 01:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793584380;
	bh=kxRe0LNqH2ViGLC0rMqrcgxwbomID3tdiZ3UJaftoIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jxCLgzEXzdWwJl3rAiNwy6VOKjDMV/3CAm3UXQPYkJnJ7SxsuNk9eWk/9EC8Ju4wR
	 2GhdBEgJHd+qizJ/30Uwb8bmgr3sItK5LfFbArPxTgt2Uo3UIW55D64RmTnpjbBZGx
	 JKYbEdv2473yCxJRY+xKW7Z6ApkqOSf72hpN1vWYqmKApn+G1JEcM+61gjdglqAVEA
	 ohLN1VPWK0ygeJZhUJhEIhXgC3sde5c+5VtvsEfBBSiMGR2Dh6ts4UWfFJ22xYe4b4
	 QlSLw18uVwfu8nce4K3Ii36sOjFEXIvYaqjmVbqWrjc76gKHNfDCF+JBiz2IUiukaw
	 bLwXnT3sYQvSA==
Date: Mon, 2 Nov 2026 01:52:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>, linux-kernel@vger.kernel.org, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 09/17] iio: hid-sensors: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261102015255.487bd1bd@jic23-hlaptop>
In-Reply-To: <20261021165858.v2.9.Idbac8a0f9ecdd345191130e256e8d881d991bfc7@changeid>
References: <20261021235818.3059519-1-briannorris@chromium.org>
	<20261021165858.v2.9.Idbac8a0f9ecdd345191130e256e8d881d991bfc7@changeid>
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

On Wed, 21 Oct 2026 16:57:10 -0700
Brian Norris <briannorris@chromium.org> wrote:

> The hid-sensors driver propagates the return value of
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
+CC the various hid-sensors maintainers.

Anyone remember why this does
pm_runtime_use_autosuspend(&st->pdev->dev);
in this code?

That is unusual...  My immediate instinct is to
get rid of it, but maybe there is something subtle
going on.

> ---
> 
> Changes in v2:
>  * Split iio patch into per-driver patches
> 
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 60808e2430ca..d76a6d9f04f6 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -154,21 +154,17 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
>  {
>  
>  #ifdef CONFIG_PM
> -	int ret;
> -
>  	if (atomic_add_unless(&st->runtime_pm_enable, 1, 1))
>  		pm_runtime_enable(&st->pdev->dev);
>  
>  	if (state) {
>  		atomic_inc(&st->user_requested_state);
> -		ret = pm_runtime_resume_and_get(&st->pdev->dev);
> -	} else {
> -		atomic_dec(&st->user_requested_state);
> -		pm_runtime_use_autosuspend(&st->pdev->dev);
> -		ret = pm_runtime_put_autosuspend(&st->pdev->dev);
> +		return pm_runtime_resume_and_get(&st->pdev->dev);
>  	}
> -	if (ret < 0)
> -		return ret;
> +
> +	atomic_dec(&st->user_requested_state);
> +	pm_runtime_use_autosuspend(&st->pdev->dev);
This is odd enough to make me nervous even though the patch is
obviously a no-op change.


> +	pm_runtime_put_autosuspend(&st->pdev->dev);
>  
>  	return 0;
>  #else

