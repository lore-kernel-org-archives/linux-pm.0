Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD8A3E49DB;
	Tue, 25 Aug 2026 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652268; cv=none; b=cHHq7hI/ow1JpB6B3kZ659g9RXyxOimndJJItPcdM1onh8YJmW9zHL/mp1aATSjTIin2gFgL10aSgwHDm2a8YQLpE9QndvmxA7frVQ/4YQc6Mqqn+LGl7ZoDxuknhIYPx82JPCd7kkBCSt4kX9ZVL75y6MCYQ7cPRwORkvB16ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652268; c=relaxed/simple;
	bh=zxdxEL1/1GW2gSGDxhWvhDOWljA3Efy5pzi2f/PmoaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTwxujihl5ResxnUNRXIQeRdfRyThNCxtu7NhdswWBiSWqcXIwpgu/UtKUpJWCHjsp6uu9pLwXMLV166C835DzzfbCYhNYOtS8LS9YyfDFPnF26DmauMw9EizkxS5tLKhSKQqebkOHJdl8C39+njGAq9Uci4aBukYu78FfnLfAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8ZbhQ4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8ZbhQ4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92A91F00A3A;
	Tue, 25 Aug 2026 10:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787652267;
	bh=IYnO9/VtZ8qNnbLCV3PdaSuhBK4W+VLVhLLZLYphll0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X8ZbhQ4E/0Jqfg017OBJ1Bn9JVrMpF3vFB53FkaDGBZjsZfa0IvEkF/HusGIv5yqE
	 utsLIrLcZqFtoyZ2oM26u8y/iTambbk+ZVUWfEOpMwmpYGhPL6XKoMXrqCXOGeQYHa
	 W4Q+uZ/WWkojIuVyGu07AIsj5gqbmpLxV5r5+sZ595xNQ/cF+Px1KOCvRT9FyG8U4o
	 QospAmcWE0ECsTWRf4NoxW8QZEbZBPN52QgvCPf7nmd8oTRL0Pw+tYM+crVqTQmzuJ
	 zMFOPc59f8FRSHZdo7kJYElMabqPLy4k+fRqhL5bpxN5mkmYmdgwBMK64wDn4hyM32
	 oIrKdwtxBR6zQ==
Date: Tue, 25 Aug 2026 10:04:23 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Matt DeVillier <matt.devillier@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	"open list:CHROMEOS EC SUBDRIVERS" <chrome-platform@lists.linux.dev>,
	"open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: cros_charge-control: adopt EC charge
 state on probe
Message-ID: <ao1op1gL2jWgxuER@google.com>
References: <20260824155736.1186510-1-matt.devillier@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824155736.1186510-1-matt.devillier@gmail.com>

On Mon, Aug 24, 2026 at 10:57:18AM -0500, Matt DeVillier wrote:
> +static int cros_chctl_get_ec_status(struct cros_chctl_priv *priv,
> +				    struct ec_response_charge_control *resp)
> +{
> +	struct ec_params_charge_control req = {
> +		.cmd = EC_CHARGE_CONTROL_CMD_GET,
> +	};
> +
> +	lockdep_assert_held(&priv->lock);
> +
> +	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_version,
> +						  &req, resp);
> +}

This lockdep_assert_held() is unnecessary.  While it might appear that the
lock is needed here to protect concurrent command transmissions through
the struct cros_ec_device, the underlying EC communication framework
already handles its own locking for that.

> +static void cros_chctl_set_default_state(struct cros_chctl_priv *priv)
> +{
> +	priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +	priv->current_start_threshold = 0;
> +	priv->current_end_threshold = 100;
> +}

Please add a lockdep_assert_held().  This function modifies the core driver
state fields that the lock is explicitly designed to protect.

> +static int cros_chctl_adopt_ec_mode(struct cros_chctl_priv *priv, u32 mode)
> +{
> +	switch (mode) {
> +	case CHARGE_CONTROL_NORMAL:
> +		priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +		return 0;
> +	case CHARGE_CONTROL_IDLE:
> +		priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> +		return 0;
> +	case CHARGE_CONTROL_DISCHARGE:
> +		priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
> +		return 0;
> +	default:
> +		dev_warn(priv->dev, "unknown charge control mode %u\n", mode);
> +		return -EINVAL;
> +	}
> +}

Same here, please add a lockdep_assert_held().

> +static int cros_chctl_init_state(struct cros_chctl_priv *priv)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&priv->lock);
> +
> +	cros_chctl_set_default_state(priv);
> +
> +	/* v1 cannot report current state; force a well-known EC configuration. */
> +	if (priv->cmd_version < 2)
> +		return cros_chctl_configure_ec(priv);
> +
> +	ret = cros_chctl_adopt_ec_state(priv);
> +	if (ret < 0) {
> +		dev_warn(priv->dev,
> +			 "failed to read EC charge state (%d), applying defaults\n",
> +			 ret);
> +		cros_chctl_set_default_state(priv);
> +		return cros_chctl_configure_ec(priv);
> +	}
> +
> +	return 0;
>  }

Instead of asserting the lock in the function, it would be cleaner to handle
the lock acquisition directly inside this function (e.g., by using guard()).

> @@ -305,13 +435,8 @@ static int cros_chctl_probe(struct platform_device *pdev)
>  	priv->battery_hook.add_battery = cros_chctl_add_battery;
>  	priv->battery_hook.remove_battery = cros_chctl_remove_battery;
>  
> -	priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> -	priv->current_start_threshold = 0;
> -	priv->current_end_threshold = 100;
> -
> -	/* Bring EC into well-known state */
>  	scoped_guard(mutex, &priv->lock)
> -		ret = cros_chctl_configure_ec(priv);
> +		ret = cros_chctl_init_state(priv);

Following the suggestion above, please move the guard() into
cros_chctl_init_state().
