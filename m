Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121A28506F;
	Mon,  5 Oct 2026 04:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791174038; cv=none; b=YYUyvRmgZxnBInMnH+pvo1jO/k54qQnfV0rTfyeZH61kFwPygDxLkKA4wS0Db+T2wHDTgHW050vhLhusrfjMYEvFIJjG7VvkpWkg3/MZu3w25EQj9TaSbHass/zA2c8o5nQu54j5WJWqXiGjqUM5jti3uGKA/fS471Jzt/Xom0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791174038; c=relaxed/simple;
	bh=C4KXlAptsNQdq0fbn51EKUOZfzzXxMjfCvAyYbq3snI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bc+Il+1y6ANCN5A3G0XuU8MFchq/F2ikhpyd0KHBAPU9BlGqUcfzaqRGAlL+pIXwJNfFtuEMKJySfoLIaPps9rrqUJ40tZ0/DEZUeaR8C8bnBI+ZZDmPculoEKybYGMiQshb732718eMPkfI85/EDRrNz1WXv0I/2hYagN/UUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwUKFw5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwUKFw5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DE41F000FF;
	Mon,  5 Oct 2026 04:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791174037;
	bh=LlJToSInOmv/Ck2UQ7sw172NaSs/GRGFwHMPLupGo7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PwUKFw5/uepmjJ1ao+lEWhsCJyZ/RQ00mPx3lZ01M7iUJDPJACXaHmNnQOJB19aRF
	 aKSl/OLfcc03/ua5iBK5TVI/vTAz3o6Tc7FWFBYPz3gSmaXf26lKHQios829zS9ZS3
	 NT+GmJxijXiW+Dx0cok4tERamil1vvIETsc/o3w46azi2kPQW65UlaI8wsK4wzYxnz
	 vnHV8+OpfUa8zkeofq1dBfiri+0zBk0UX+lFGaLKqmb/NMHZvSThW/kFbP4ngoSN7/
	 myaaRkS0HW/wC/GHz5Olyzwg11Lf1zy7rGJ1YtGirVJEsoQ1ydQC2Eto5K4PDy5TOh
	 Y/sdRZtdzBazg==
Date: Mon, 5 Oct 2026 04:20:33 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Andrew Pam <andrew@fastmailteam.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sre@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Matt DeVillier <matt.devillier@gmail.com>,
	chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: cros_charge-control: restore EC state on
 resume
Message-ID: <asMlkcx5P3Qgolgh@google.com>
References: <20261004225606.30577-1-andrew@fastmailteam.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004225606.30577-1-andrew@fastmailteam.com>

On Mon, Oct 05, 2026 at 09:56:06AM +1100, Andrew Pam wrote:
> Nothing notices the reset. Commit 4fc88ba435da ("power: supply:
> cros_charge-control: adopt EC charge state on probe") made the driver

The commit 4fc88ba435da doesn't exist.

> initialise its cached state from the EC, but it does so only on probe,
                              ^^^^
To be precise, this should be "to".

> Note that re-reading the state from the EC on resume, by reusing
> cros_chctl_init_state() or otherwise, would be wrong even on the command

cros_chctl_init_state() doesn't exist.

>  #define EC_CHARGE_CONTROL_BEHAVIOURS	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)             | \
> @@ -420,6 +421,7 @@ static int cros_chctl_probe(struct platform_device *pdev)
>  
>  	priv->dev = dev;
>  	priv->cros_ec = cros_ec;
> +	platform_set_drvdata(pdev, priv);

Even though functionally identical, to be symmetric to cros_chctl_resume(),
maybe use:

    dev_set_drvdata(dev, priv)

> +static int cros_chctl_resume(struct device *dev)
> +{
> +	struct cros_chctl_priv *priv = dev_get_drvdata(dev);
> +
> +	/*
> +	 * The EC resets its charge control state when the AP powers off, so the
> +	 * configuration is lost across hibernation. As the driver never reads
> +	 * the state back from the EC, the values exposed to userspace would
> +	 * still describe the lost configuration. Reprogram the EC from the
> +	 * cached state to keep both in sync.
> +	 */
> +	guard(mutex)(&priv->lock);
> +	return cros_chctl_configure_ec(priv);

It may be worth adding a dev_err() or dev_warn() log if the configuration
fails.

> @@ -447,6 +466,7 @@ MODULE_DEVICE_TABLE(platform, cros_chctl_id);
>  
>  static struct platform_driver cros_chctl_driver = {
>  	.driver.name	= "cros-charge-control",
> +	.driver.pm	= pm_sleep_ptr(&cros_chctl_pm_ops),

To be neat,

    .driver = {
	.name = ...
	.pm = ...
    }
