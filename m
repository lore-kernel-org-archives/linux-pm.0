Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68753EE1FE;
	Tue, 25 Aug 2026 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654461; cv=none; b=FCuG0zzC4HHqOtlRdKN0WZt+2UBECkisOf6f+FE0E/Pqbd7yV+CoT/klTjk7n8wiXWOSyP1Wd6JxhsZtMFZHQRBj8TRpt0IOmG0NtQ8BTzUvuWDLAyqwSacL8BL52Ij4gzXS9LvFYnttnDNMSuBtR65J9Ei8l0V3KtAQ9ZwWXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654461; c=relaxed/simple;
	bh=p/iEIQEg4Od/2AF7sVyqR9bpzrPa8MAAbs3IWmNJYTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUR89s3H/2J+cI1LOO8SopcKWOgX1rZ23E+3TTe5LY0wJklggNYcnQaDM4D6lQ7QNBt8W/G6mcTUTv+7gtpZXpWbJNd4yCS6HeQy2JQRk9XFgpPz5GMJ0j7FLu85fP0YLRIWj2Ws90k7y0fdxBAH810XiQ22YkiggNceMvjjCh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RlAWPpGH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RlAWPpGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1787654451;
	bh=p/iEIQEg4Od/2AF7sVyqR9bpzrPa8MAAbs3IWmNJYTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlAWPpGHELfKthiO4SSUhTXgEPOwpnn6XbodC1sStpcZMDgy10/Al8CO2h8BGmbYi
	 YAZwe0PfgifmPFsTURI+WWnzlJnU4LQ4T1Rg4qA8qupIeyFIFsS+NBL2ax/sEa9SQJ
	 bpe1LAvY3BFH1x0fiAJCeOyjbDUOxLc59zUJCdOI=
Date: Tue, 25 Aug 2026 12:40:50 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Matt DeVillier <matt.devillier@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, 
	"open list:CHROMEOS EC SUBDRIVERS" <chrome-platform@lists.linux.dev>, 
	"open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: cros_charge-control: adopt EC charge
 state on probe
Message-ID: <8ea6fdfc-5965-4754-9633-2a10cba32cbe@t-8ch.de>
References: <20260824155736.1186510-1-matt.devillier@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260824155736.1186510-1-matt.devillier@gmail.com>

On 2026-08-24 10:57:18-0500, Matt DeVillier wrote:
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
> pairs are remapped the same way with a warning.
> 
> If GET fails, fall back to the previous defaults and SET them on the
> EC. Command version 1 still cannot report state and keeps forcing a
> well-known configuration.
> 
> Signed-off-by: Matt DeVillier <matt.devillier@gmail.com>
> ---
>  drivers/power/supply/cros_charge-control.c | 159 ++++++++++++++++++---
>  1 file changed, 142 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
> index e0f168624807..fd620317cfba 100644
> --- a/drivers/power/supply/cros_charge-control.c
> +++ b/drivers/power/supply/cros_charge-control.c
> @@ -21,12 +21,22 @@
>  
>  /*
>   * Semantics of data *returned* from the EC API and Linux sysfs differ
> - * slightly, also the v1 API can not return any data.
> - * To match the expected sysfs API, data is never read back from the EC but
> - * cached in the driver.
> + * slightly:
> + *  - EC sustainer off is lower=upper=-1
> + *  - Linux "no limit" is start=0, end=100
> + * Also the v1 API can not return any data.
>   *
> - * Changes to the EC bypassing the driver will not be reflected in sysfs.
> - * Any change to "charge_behaviour" will synchronize the EC with the driver state.
> + * While the sustainer is active the EC may report IDLE or DISCHARGE as the
> + * current charge-control mode; that is an internal hold/discharge step, not a
> + * Linux inhibit-charge / force-discharge request. Valid sustainer limits are
> + * therefore adopted as AUTO with the reported thresholds.
> + *
> + * Sysfs reads come from a driver-side cache. On probe, command versions that
> + * support GET (v2+) are initialized from the EC so firmware or firmware-setup
> + * programmed limits and modes are preserved (unlike earlier behaviour that
> + * always forced AUTO with no limits). v1 still forces a well-known EC state.
> + * Subsequent sysfs writes keep the cache and EC in sync; changes that bypass
> + * the driver are not reflected until the next probe.
>   */
>  
>  struct cros_chctl_priv {
> @@ -44,18 +54,20 @@ struct cros_chctl_priv {
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

This function is not guaranteed to write all bytes of the response
structure. This forces callers to pass in a pre-initialized structure.
I'd prefer this function to guarantee a fully initialized response.
Either by unconditionally zeroing out the resp parameter before calling
cros_ec_cmd() or only zeroing the trailing fields, using the return
value of cros_ec_cmd().

> +	int ret;

>  
>  	ret = cros_ec_cmd(cros_ec, cmd_version, EC_CMD_CHARGE_CONTROL, req,
> -			  outsizes[cmd_version], NULL, 0);
> -
> +			  outsizes[cmd_version], resp, insize);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -94,7 +106,126 @@ static int cros_chctl_configure_ec(struct cros_chctl_priv *priv)
>  		req.sustain_soc.upper = -1;
>  	}
>  
> -	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_version, &req);
> +	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_version,
> +						  &req, NULL);

You could split the addition of the resp argument to cros_chctl_send_charge_control_cmd()
into its own patch.

> +}
> +
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
> +
> +static void cros_chctl_set_default_state(struct cros_chctl_priv *priv)
> +{
> +	priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +	priv->current_start_threshold = 0;
> +	priv->current_end_threshold = 100;
> +}
> +
> +static bool cros_chctl_sustainer_limits_valid(s8 lower, s8 upper)
> +{
> +	return lower >= 0 && upper >= 0 && lower <= 100 && upper <= 100 &&
> +	       lower <= upper;

No need to break so aggressively, you have 100 columns.

> +}
> +
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
> +
> +static int cros_chctl_adopt_ec_state(struct cros_chctl_priv *priv)
> +{
> +	struct ec_response_charge_control resp = {};

No need to initialize this with the changes requested above.

> +	s8 lower, upper;
> +	int ret;
> +
> +	lockdep_assert_held(&priv->lock);
> +
> +	ret = cros_chctl_get_ec_status(priv, &resp);
> +	if (ret < 0)
> +		return ret;
> +
> +	lower = resp.sustain_soc.lower;
> +	upper = resp.sustain_soc.upper;
> +
> +	/*
> +	 * Valid sustainer limits mean "auto with thresholds". The EC mode may
> +	 * be IDLE/DISCHARGE while the sustainer holds or bleeds SoC; do not
> +	 * expose that as inhibit-charge / force-discharge.
> +	 */
> +	if (cros_chctl_sustainer_limits_valid(lower, upper)) {
> +		priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +		priv->current_start_threshold = lower;
> +		priv->current_end_threshold = upper;
> +	} else {
> +		ret = cros_chctl_adopt_ec_mode(priv, resp.mode);
> +		if (ret < 0)
> +			return ret;
> +
> +		/*
> +		 * Sustainer off is lower=upper=-1 → Linux "no limit" (0/100).
> +		 * Any other non-valid pair is unexpected; remap and warn.
> +		 */
> +		if (!(lower == -1 && upper == -1))
> +			dev_warn(priv->dev,
> +				 "invalid EC sustainer limits (%d/%d), treating as no limit\n",
> +				 lower, upper);

Here the view between the EC and the driver goes out of sync.
I'd prefer to reconfigure the EC here, too.

> +
> +		priv->current_start_threshold = 0;
> +		priv->current_end_threshold = 100;
> +	}
> +
> +	dev_dbg(priv->dev,
> +		"adopted EC charge state: behaviour=%d start=%u end=%u (ec mode=%u)\n",
> +		priv->current_behaviour, priv->current_start_threshold,
> +		priv->current_end_threshold, resp.mode);
> +
> +	return 0;
> +}
> +
> +static int cros_chctl_init_state(struct cros_chctl_priv *priv)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&priv->lock);
> +
> +	cros_chctl_set_default_state(priv);

This can be under the 'cmd_version < 2' below.

> +
> +	/* v1 cannot report current state; force a well-known EC configuration. */
> +	if (priv->cmd_version < 2)
> +		return cros_chctl_configure_ec(priv);
> +
> +	ret = cros_chctl_adopt_ec_state(priv);

I have the feeling that the code would be easier to understand if
cros_chctl_adopt_ec_state() was inlined here.

> +	if (ret < 0) {
> +		dev_warn(priv->dev,
> +			 "failed to read EC charge state (%d), applying defaults\n",

Use %pe to log error numbers.

> +			 ret);
> +		cros_chctl_set_default_state(priv);
> +		return cros_chctl_configure_ec(priv);
> +	}
> +
> +	return 0;
>  }
>  
>  static int cros_chctl_psy_ext_get_prop(struct power_supply *psy,
> @@ -152,7 +283,6 @@ static int cros_chctl_psy_ext_set_threshold(struct cros_chctl_priv *priv,
>  	return 0;
>  }
>  
> -
>  static int cros_chctl_psy_ext_set_prop(struct power_supply *psy,
>  				       const struct power_supply_ext *ext,
>  				       void *data,
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
>  	if (ret < 0)
>  		return ret;
>  
> -- 
> 2.53.0
> 
