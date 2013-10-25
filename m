From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 2/3] charger-manager : Add default battery temperature
 checking funtion.
Date: Fri, 25 Oct 2013 16:44:37 -0700
Message-ID: <20131025234436.GC13859@teo>
References: <1382669253-23629-1-git-send-email-jonghwa3.lee@samsung.com>
 <1382669253-23629-3-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:34142 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab3JYXok (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2013 19:44:40 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so4744679pbc.30
        for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2013 16:44:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1382669253-23629-3-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-pm@vger.kernel.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com

On Fri, Oct 25, 2013 at 11:47:32AM +0900, Jonghwa Lee wrote:
> During the charger manager driver's probing time, it can't succeed
> if there's no pre-defined .temperature_out_of_range callback function.
> But if fuel gauge supports battery temperature measurement, we
> can use it directly. That's what cm_default_get_temp() function does.
> 
> With flag measure_batter_temp ON, we normally use cm_default_get_temp()
> for .temperature_out_of_range callback funtion.
> The TEMP_AMBIENT property is only used for pre-defined one.
> 
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
> ---
...
> +static int cm_default_get_temp(struct charger_manager *cm)
> +{
> +	struct charger_desc *desc = cm->desc;
> +	union power_supply_propval val;
> +	static int temp_alert_min = 0;

No. Never.

> +	static int temp_alert_max = 0;
> +	static int temp_alert_diff = 0;
> +	static int last_temp_status = 0;
> +	int ret;
> +
> +	if (!temp_alert_min && !temp_alert_max) {
> +		/* Initialize minimum temperature for alert */
> +		ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
> +					POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
> +					&val);
> +		temp_alert_min = ret ? desc->temp_alert_min :
> +					min(desc->temp_alert_min, val.intval);

Is it a minimum temperature of a bettery below which we should alert?
Should it be max() then?

> +		if (!temp_alert_min)
> +			temp_alert_min = CM_DEFAULT_TEMP_ALERT_MIN;

The whole function is ugly as hell.  Please tidy it up, split it into two,
three or whatever amount needed to make it readable and comprehendable.
Use temporary variables for things like
cm->fuel_gauge->get_property(cm->fuel_gauge, ....).

> +
> +		/* Initialize maximum temperature for alert */
> +		ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
> +					POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
> +					&val);
> +		temp_alert_max = ret ? desc->temp_alert_max :
> +					min(desc->temp_alert_max, val.intval);

Thanks,

Anton
