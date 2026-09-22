Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705E83932D9
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062628; cv=none; b=VJmqVqTMRnLQlgK+MDL2INth8CyA86ZKuwocYKyQDCIBqmdCqAKmfdyc4OSl0hiPHznup6nOtCiIEe7P9lIvpjLP7RTBD6xTckfNhSIBtheHDTmLoInA0Mwzyuxo+GY8JZmkV5kXFM5NEc6+Tpczj6Lg/rd2qXBGfX0uHDGZo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062628; c=relaxed/simple;
	bh=RCOAyYyJ+8UWrD8BLeNfubU6J7FHGPqwqVtqxhezK28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNGaVnZmzJIFJM6dQ+kRuJD1YR7AEyhFhNQhIQlBy7HtEVWr8/ZGp7/2QszbWqfCwqtdDyi0vdc4vgL1Ope/rFN77WBRVDhcaA4z9uyZcYlPyuFlFjLVhrrk+cal76Ts/0DlTEs6DB7MDAlURVzwnTtqTWHHlShzVcl5HTMpNBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sM8MH6pE; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sM8MH6pE"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a354118856so29448861fa.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 00:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790062624; x=1790667424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jdAazOvNHDsZEwumcDHnCWyoCBwbu0/+HO8q4JOpYAE=;
        b=sM8MH6pEfZNPYQOJAamMGfAEeO2gRFOInm8WUPkjab702L9lT/yWbtJddgeSgsLW14
         DqYhDehfr0ZSzwJ12YTmWnbmRFSOacBrHbGqWN35L+XW13j+1ZhldLyULDdO9m7oyR3F
         dbl8mEdpSebfgCaX6cmNsci/6v1xbUgOnWBtKGo1ICRYskUBuiP1ZuOIJrhz1h05fwE3
         FAtNdZAhGy3OmLg5WVWsaun0d/Fdgx9VVPfl6LhGzX8wf9lISiS+5p6HeEXeBkxvzEnE
         St14o90yH/vmoUUqXT9PdDOmzbrfG5i7IkaSF4g8+Ibjvao/+Ri5CYSpj1+VB/C1J9tj
         Nchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790062624; x=1790667424;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jdAazOvNHDsZEwumcDHnCWyoCBwbu0/+HO8q4JOpYAE=;
        b=s1pU5gUZ0NJc4f2cbF2mSysKNQLmX4SnkcNMnS7MCVWPcHyKsoJdMkxcPx6dPpWnJA
         5Hdxr3sHiaAZMnqP2bsaDMsi59j7kk5qGWdisQbySKVxFvvFgvGr/Qs6a19RhXVfT8/z
         FgL3DfVj2PGqDp10LDbPdIPMe7SaNTT95A6x+pZZO5zG6Gui31HmJulA8QhQaKmQ3MLj
         bvdc+qNo0e4kqe6YOs61Ak7EQbly9ypgO+HDJZltjcyttzzxncGAahiIWqpIdRA8kUU4
         cZzAYsrBo3zFEcxR1aUEFbItK68Myw++mgwBiG9KrH+puA/xzRrA2kLEDxPhfGVuK1kv
         20BA==
X-Forwarded-Encrypted: i=1; AKwUvBxn721TeRnKGxUAZnHCi+1Qiz2YHM3cQBmOoYtNG8d6Bc+qRTjGVUS9F5tHaV6GDzdlSDVbGYWlcA==@vger.kernel.org
X-Gm-Message-State: AFuF++noC21CfI0phdPo953lo+zSWfOHt8m4ynE9DaVDJqOlnY1532TW
	CRb6kbrw0dP6/dq4LVG1PMpZsi70BNbpcqWTrps2PzeBIEqqkgdwwbBS
X-Gm-Gg: AYBFou3Xc24eTO+VRW3FvVt9Bu2vfAPJSlRDye7hANXGcqHr3HfuvIpsbEy0eRQ3wz5
	pr/PDjx3frS9PrQItDHmkS9DFe6DnSw7ILOsZ+ymlbqouDtgY01N8BUKFeZ+9jU2Wm4MU8XmPCU
	Fj1dfIxJVZ+c+2+rrkkZFXk6dzkAdzdiEQZsQ7hVj4W1qQLDhqDSM+EwjJmAppb5K5ZEQeIss32
	KXOs9HYGgrWeIaWzmmRwkDWZiZcuedWZhvY0KqvZbgOOn93mBBCiCnU0782NlqUKA0y9oGO7HId
	SZhcKeKdIXvDJx4ULOs5lwFl3q392fWKcHQfft887Ke6dtxTKKmPH2cnQgW6hABRj+BRA/DF9H5
	EsRnuPYm4FCcdElB4wFGh5Jq2LZiEHQ8juoVjhVVFgUW/S46G1t0TStVnEEvLzM1Xu/Y9blJXaT
	GakBzTCyk0vxiClSmKe0m/C7d5VJtxLf9VP6l4H6M98ciIiSoqXFH0xLu4CezhBXaubYZTY/E1q
	naYArDdNxshC3mAmb0Puk5/xcS+9YjSL/qxDZOOEUJNE+akzK8rEHs=
X-Received: by 2002:a05:651c:19a8:b0:3a3:74b7:fc07 with SMTP id 38308e7fff4ca-3a5fbfd7ab8mr30363061fa.19.1790062623831;
        Tue, 22 Sep 2026 00:37:03 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a627d28468sm3244951fa.9.2026.09.22.00.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 00:37:03 -0700 (PDT)
Message-ID: <f4d2e209-1c89-447a-a5d1-92696b51b614@gmail.com>
Date: Tue, 22 Sep 2026 10:37:00 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/6] reboot: add parsable tokens for power state
 change reasons
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
 avaneesh.dwivedi@oss.qualcomm.com,
 Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20260921-pscrr-framework-v14-0-a16290003b7c@oss.qualcomm.com>
 <20260921-pscrr-framework-v14-3-a16290003b7c@oss.qualcomm.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260921-pscrr-framework-v14-3-a16290003b7c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 20:44, Faruque Ansari wrote:
> psc_reason_to_str() returns human-readable labels that contain spaces
> (e.g. "over temperature"). Those are fine for logs but unusable as
> values in a space-separated sysfs list or as a write target.
> 
> Extend the single reason descriptor table with a stable, space-free
> token next to the existing label, and add psc_reason_to_token() and
> psc_reason_from_token() so consumers can emit and parse reasons without
> inventing their own string table.
> 
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> 
> changes v12:
> - new patch
> ---
>   include/linux/reboot.h |  2 ++
>   kernel/reboot.c        | 77 +++++++++++++++++++++++++++++++++++++++-----------
>   2 files changed, 63 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index 08a7549bbc40..4c5327dd7645 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -244,6 +244,8 @@ enum psc_reason {
>   #define PSCR_MAX_REASON	(PSCR_REASON_COUNT - 1)
>   
>   const char *psc_reason_to_str(enum psc_reason reason);
> +const char *psc_reason_to_token(enum psc_reason reason);
> +int psc_reason_from_token(const char *token, enum psc_reason *reason);
>   
>   /**
>    * enum hw_protection_action - Hardware protection action
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index d5a45db82c3d..e53fb31bad06 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -1084,34 +1084,79 @@ void set_psc_reason(enum psc_reason reason)
>   }
>   EXPORT_SYMBOL_GPL(set_psc_reason);
>   
> -static const char * const pscr_reason_strs[] = {
> -	[PSCR_UNKNOWN]            = POWER_ON_REASON_UNKNOWN,
> -	[PSCR_UNDER_VOLTAGE]      = POWER_ON_REASON_BROWN_OUT,
> -	[PSCR_OVER_CURRENT]       = POWER_ON_REASON_OVER_CURRENT,
> -	[PSCR_REGULATOR_FAILURE]  = POWER_ON_REASON_REGULATOR_FAILURE,
> -	[PSCR_OVER_TEMPERATURE]   = POWER_ON_REASON_OVER_TEMPERATURE,
> -	[PSCR_EC_PANIC]           = POWER_ON_REASON_EC_PANIC,
> +/**
> + * struct psc_reason_desc - Descriptor for a power state change reason.
> + * @token: Stable, parsable identifier without spaces (e.g. "over-temperature").
> + *	   Suitable for use in sysfs values and as a user/kernel contract.
> + * @label: Human-readable description (e.g. "over temperature"), for logs.
> + */
> +struct psc_reason_desc {
> +	const char *token;
> +	const char *label;
> +};
> +
> +static const struct psc_reason_desc psc_reason_descs[] = {
> +	[PSCR_UNKNOWN]		 = { "unknown",		  POWER_ON_REASON_UNKNOWN },
> +	[PSCR_UNDER_VOLTAGE]	 = { "under-voltage",	  POWER_ON_REASON_BROWN_OUT },
> +	[PSCR_OVER_CURRENT]	 = { "over-current",	  POWER_ON_REASON_OVER_CURRENT },
> +	[PSCR_REGULATOR_FAILURE] = { "regulator-failure", POWER_ON_REASON_REGULATOR_FAILURE },
> +	[PSCR_OVER_TEMPERATURE]	 = { "over-temperature",  POWER_ON_REASON_OVER_TEMPERATURE },
> +	[PSCR_EC_PANIC]		 = { "ec-panic",	  POWER_ON_REASON_EC_PANIC },
>   };

nit:
Is there a reason for having the label as a define while token is a 
plain string? It may be just me, but I would have expected the userland 
contract to be defined in a header. (It may be just my false expectation 
though!).

>   
>   /**
> - * psc_reason_to_str - Converts a power state change reason enum to a string.
> - * @reason: The `psc_reason` enum value to be converted.
> - *
> - * This function provides a human-readable string representation of the power
> - * state change reason, making it easier to interpret logs and debug messages.
> + * psc_reason_to_str - Human-readable label for a power state change reason.
> + * @reason: The `psc_reason` value to convert.
>    *
> - * Return:
> - * - A string corresponding to the given `psc_reason` value.
> - * - `"Invalid"` if the value is not recognized.
> + * Return: The label string, or "Invalid" if @reason is out of range. For a
> + * stable, parsable form use psc_reason_to_token() instead.
>    */
>   const char *psc_reason_to_str(enum psc_reason reason)
>   {
>   	if (reason < 0 || reason >= PSCR_REASON_COUNT)
>   		return "Invalid";
> -	return pscr_reason_strs[reason];
> +	return psc_reason_descs[reason].label;

nit:
I would feel a tad safer if the psc_reason_descs[] was always guaranteed 
to be initialized up-to PSCR_REASON_COUNT. Having the enum and 
PSCR_REASON_COUNT defined in one place, and psc_reason_descs[] 
initialized here, adds a window for: "I added new enum value, forgot to 
update the psc_reason_descs[]". Can we add a NULL check or are we on a 
very performance critical path here?

>   }
>   EXPORT_SYMBOL_GPL(psc_reason_to_str);
>   
> +/**
> + * psc_reason_to_token - Stable, parsable token for a power state change reason.
> + * @reason: The `psc_reason` value to convert.
> + *
> + * Return: The token string (no spaces), or "invalid" if @reason is out of
> + * range. Round-trips with psc_reason_from_token().
> + */
> +const char *psc_reason_to_token(enum psc_reason reason)
> +{
> +	if (reason < 0 || reason >= PSCR_REASON_COUNT)
> +		return "invalid";
> +	return psc_reason_descs[reason].token;

Please, see my comment above.

> +}
> +EXPORT_SYMBOL_GPL(psc_reason_to_token);
> +
> +/**
> + * psc_reason_from_token - Parse a reason token into a `psc_reason` value.
> + * @token: A token as returned by psc_reason_to_token(). A trailing newline is
> + *	   tolerated.
> + * @reason: Output; set on success.
> + *
> + * Return: 0 on success or -EINVAL if @token matches no known reason.
> + */
> +int psc_reason_from_token(const char *token, enum psc_reason *reason)
> +{
> +	int i;
> +
> +	for (i = 0; i < PSCR_REASON_COUNT; i++) {
> +		if (sysfs_streq(token, psc_reason_descs[i].token)) {

I suppose my comment applies here as well.

> +			*reason = i;
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(psc_reason_from_token);
> +
>   /**
>    * __hw_protection_trigger - Trigger an emergency system shutdown or reboot
>    *

After all these years in the business - it's hard to be as confident as 
I used to. ;) So, I won't say [aloud] that my preferred way is the only 
correct way. Please weigh my comments and decide as you see best, this 
is "good enough" for me if you don't agree with my suggestions.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
   -- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
