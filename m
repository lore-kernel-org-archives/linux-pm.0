Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A647F766;
	Tue, 25 Aug 2026 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676718; cv=none; b=Zb1uICVRLAvVvIV9iJfwDnRgRIa2I1ZDzLjfxWHmZ99fs6v0pOedHwSKjVYHLhQLs3ie0vFyQ9EQle9YSPCm0VDYTueCnxeNfyMBI4PSqxZIyOUd4hZ32Hu9tc61CUtLVGIppDYaanrQOPBjnCqVzubarPtlbFXzj14khDUCCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676718; c=relaxed/simple;
	bh=kwNPdpVBs+eBnXtqBwqlGpl0BNKWOhPNcLWXN+DhtPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WC8xPOw7xHaaF3g4gzCLpYBgYu7Vd+Gokon/3sJ5ce3O297erMBhaHzgGj6FVdxKwSJW7KU0dJmTnBvZtj1QuNhSgBqote7H3ymjrZ+LjqJQzIhVFtA+FhoEqaqNlt+rNCOUM7So2RuKcLSq00sHLHehlBmt26zOXzsN9JWdzgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pXg/4/lH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pXg/4/lH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1787676714;
	bh=kwNPdpVBs+eBnXtqBwqlGpl0BNKWOhPNcLWXN+DhtPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pXg/4/lHWiYV7PklUVzgw5QqOabDBEfalC9RcOmEwV0+0wh4UOakwpxGPllhFl3sW
	 8WoS+3ZLp+7i9aLjGKX+BZwdEeWHazQrz/K/BJI9RgbfWrzCC5O8V7dfpWV6h6UU23
	 9jQvLXz09B5bCmwlaTD9YPSBprkRRz+QVcqI5gdQ=
Date: Tue, 25 Aug 2026 18:51:52 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Matt DeVillier <matt.devillier@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: cros_charge-control: adopt EC charge
 state on probe
Message-ID: <93b00121-77ad-4dd0-8c58-e00d1f33b405@t-8ch.de>
References: <20260824155736.1186510-1-matt.devillier@gmail.com>
 <20260825120929.13168-1-matt.devillier@gmail.com>
 <20260825120929.13168-2-matt.devillier@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260825120929.13168-2-matt.devillier@gmail.com>

On 2026-08-25 07:09:00-0500, Matt DeVillier wrote:
> The driver previously always forced AUTO with no charge limits at
> probe, which discarded sustainer thresholds and modes set by firmware
> or firmware setup before the kernel loaded.
> 
> For command versions that support GET (v2+), read the EC state into
> the driver cache instead. Valid sustainer limits are adopted as AUTO
> with those thresholds: while the sustainer is active the EC may report
> IDLE or DISCHARGE as a transient hold/discharge step, which must not
> be exposed as inhibit-charge or force-discharge. Sustainer off
> (-1/-1) still maps to Linux "no limit" (0/100); other invalid limit
> pairs are remapped the same way with a warning and pushed back to
> the EC so the cache stays in sync.
> 
> If GET fails, fall back to the previous defaults and SET them on the
> EC. Command version 1 still cannot report state and keeps forcing a
> well-known configuration.
> 
> Signed-off-by: Matt DeVillier <matt.devillier@gmail.com>

Something seems to have gone wrong when sending the v2.
Two mails are sent, the first has the old patch and the changelog,
the second one has no changelog but the correct v2.

I have a few small nitpicks left, but in any case:

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  drivers/power/supply/cros_charge-control.c | 157 ++++++++++++++++++---
>  1 file changed, 139 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
> index e0f168624807..07bcc6a9aeef 100644
> --- a/drivers/power/supply/cros_charge-control.c
> +++ b/drivers/power/supply/cros_charge-control.c
> @@ -21,12 +21,22 @@

(...)
  
>  struct cros_chctl_priv {
> @@ -44,18 +54,23 @@ struct cros_chctl_priv {
>  };
>  
>  static int cros_chctl_send_charge_control_cmd(struct cros_ec_device *cros_ec,
> -					      u8 cmd_version, struct ec_params_charge_control *req)
> +					      u8 cmd_version,
> +					      struct ec_params_charge_control *req,
> +					      struct ec_response_charge_control *resp)
>  {
> -	int ret;
>  	static const u8 outsizes[] = {
>  		[1] = offsetof(struct ec_params_charge_control, cmd),
>  		[2] = sizeof(struct ec_params_charge_control),
>  		[3] = sizeof(struct ec_params_charge_control),
>  	};
> +	size_t insize = resp ? sizeof(*resp) : 0;
> +	int ret;
>  
> -	ret = cros_ec_cmd(cros_ec, cmd_version, EC_CMD_CHARGE_CONTROL, req,
> -			  outsizes[cmd_version], NULL, 0);
> +	if (resp)
> +		*resp = (struct ec_response_charge_control){};
>  
> +	ret = cros_ec_cmd(cros_ec, cmd_version, EC_CMD_CHARGE_CONTROL, req,
> +			  outsizes[cmd_version], resp, insize);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -94,7 +109,120 @@ static int cros_chctl_configure_ec(struct cros_chctl_priv *priv)
>  		req.sustain_soc.upper = -1;
>  	}
>  
> -	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_version, &req);
> +	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_version,
> +						  &req, NULL);

This can also go on a single line.

> +}
> +
> +static int cros_chctl_get_ec_status(struct cros_chctl_priv *priv,
> +				    struct ec_response_charge_control *resp)
> +{
> +	struct ec_params_charge_control req = {
> +		.cmd = EC_CHARGE_CONTROL_CMD_GET,
> +	};
> +
> +	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_version,
> +						  &req, resp);

Ditto.

> +}
> +
> +static void cros_chctl_set_default_state(struct cros_chctl_priv *priv)
> +{
> +	lockdep_assert_held(&priv->lock);
> +
> +	priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +	priv->current_start_threshold = 0;
> +	priv->current_end_threshold = 100;
> +}
> +
> +static bool cros_chctl_sustainer_limits_valid(s8 lower, s8 upper)
> +{
> +	return lower >= 0 && upper >= 0 && lower <= 100 && upper <= 100 && lower <= upper;
> +}
> +
> +static int cros_chctl_adopt_ec_mode(struct cros_chctl_priv *priv, u32 mode)
> +{
> +	lockdep_assert_held(&priv->lock);
> +
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

The error number is never used. The function could return a bool instead.

> +	}
> +}
> +
> +static int cros_chctl_init_state(struct cros_chctl_priv *priv)
> +{

(...)

> +defaults:
> +	cros_chctl_set_default_state(priv);
> +	return cros_chctl_configure_ec(priv);

This might as well be inline instead of an extra label.

>  }
>  
>  static int cros_chctl_psy_ext_get_prop(struct power_supply *psy,
> @@ -152,7 +280,6 @@ static int cros_chctl_psy_ext_set_threshold(struct cros_chctl_priv *priv,
>  	return 0;
>  }

(...)
