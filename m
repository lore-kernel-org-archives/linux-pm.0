Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855109;
	b=yu6cOl1IQqh++pR2myuj/1odjmML7+xt06uVRTJNJok2fOjKhGlSuXUXeoPaKJCrUiLK
	 JxdmiopAz6I72sfcd8IMne7A0zaNlZ7D+PE4kb1jmDx/+Uwp7xanM6wO0okRM9lJatK6t
	 gs3bqrRWT5pb8Z0/UdIfUXgr+eq8qj+WfZece+ZKVI65komt6glduYQDg6RD+k8vuWFNs
	 j70Bc27z7efEoe5EftwKVvRFw+rzDhxcDhLoQHRaeZNYQ38Ztcn/J812D2P4PttSmLWzO
	 RS2fwfz/tYbwVHxyWvYmsjvyoTmaXUgfBC4gMOricnIkXNY9jE9yHmSZncCgX/BUPyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855109;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xMf0EawBmw76DM3vHihCHtrd9empoxXzcPgjEXDY21g=;
	b=eURRCyui+9m5h4VEWnFvD2gVsB4TP00QY674J7/fJ7mXLDERinbrFh8iwZxcQ3zw8AOW
	 8NlIlJSPkUBZGDpOKV+7k/fQoVUtGNSuWMVnoDvqLjoENSrDTiG2cEOM63u/DmB6WHy64
	 1VclqE7DvDn1Hml34OcbwpJ6V8XIGsJBwiDEgsFPRP3d0i3ELWfggB4NC+2jsmiMHa8RT
	 IiGaVI8PZfztKd0sNOKaJeoBI2/Msvv1HT++AOYGShX2xkEPhfm5v5tQRZ7lJPZVXBimd
	 RvRH0GmWo1JwJ4wP5EKh3bB+9m7ywN+N6Gh/NtPu1Lpaq13OMjh8Butq+hsRze+4wGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJfybVnY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9F606A31C;
	Mon, 16 Nov 2026 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJfybVnY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40411F000C4;
	Mon, 16 Nov 2026 18:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855109;
	bh=xMf0EawBmw76DM3vHihCHtrd9empoxXzcPgjEXDY21g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UJfybVnYHKUzMRG+PJkxU6Fj7gexeWmiPkwwqtum/qybsRRlbuP2Wf8HLrNzXWb9a
	 OoqoFkeajBumWDDcn1NSaq0w2G9AitqId6jO3jmPLq5MNcpK1/UqjaHIe+mB8VtywX
	 +bjAJvVHy8hUHXE0bcT8uzsnDRaaSq9LD6lWcwmzJE1wLjfkfNmVdsXHcJ6RxGdd0u
	 tbr5gkYtaBo65Skbo/ybm2v6P7qBLwS2WoEL+Ban4bK9QDp1E4ko75ey/mA2EkpuSw
	 6HcI0zYRLyYzhGxmdVs/Lb2ahODjN3tNLUEUd3nRkE3dHwibsbDtkfQxvEyOxXz8W+
	 3sXZmAcHzBkNA==
Date: Mon, 16 Nov 2026 11:51:44 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Xu Rao <raoxu@uniontech.com>,
	linux-pm@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: gpio-charger: mark
 gpio_charger_properties as __maybe_unused
Message-ID: <20261116185144.GA1036192@ax162>
References: <20261116124117.2922333-1-sashal@kernel.org>
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
In-Reply-To: <20261116124117.2922333-1-sashal@kernel.org>

On Mon, Nov 16, 2026 at 07:41:17AM -0500, Sasha Levin wrote:
> Commit fad4655224f60 ("power: supply: gpio-charger: Keep properties per
> device") keeps gpio_charger_properties[] only to size the per-device array
> with ARRAY_SIZE(). clang sees that the array itself is never emitted and
> warns, which fails the build with CONFIG_WERROR:
> 
>   drivers/power/supply/gpio-charger.c:26:35: error: variable 'gpio_charger_properties' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> 
> Mark the array __maybe_unused.
> 
> Fixes: fad4655224f60 ("power: supply: gpio-charger: Keep properties per device")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> fad4655224f60 is the tip of power-supply's for-next.

Since the Fixes has 'Cc: stable', this one should too (unless this is
just going to be squashed in).

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

>  drivers/power/supply/gpio-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
> index c90c824382c62..647f5bde38c7c 100644
> --- a/drivers/power/supply/gpio-charger.c
> +++ b/drivers/power/supply/gpio-charger.c
> @@ -23,7 +23,7 @@ struct gpio_mapping {
>  } __packed;
>  
>  /* This list ensures, that the array is big enough for all optional features. */
> -static enum power_supply_property gpio_charger_properties[] = {
> +static enum power_supply_property gpio_charger_properties[] __maybe_unused = {
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> 
> base-commit: fad4655224f60328cc9bcf4399eda8f6d7a587a6
> -- 
> 2.53.0
> 

-- 
Cheers,
Nathan
