From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/2] power: supply: max17042_battery: add technology
 property support
Date: Mon, 26 Sep 2016 12:55:10 +0200
Message-ID: <20160926105510.GA8140@kozik-lap>
References: <1474837811-9413-1-git-send-email-wolfgit@wiedmeyer.de>
 <1474837811-9413-3-git-send-email-wolfgit@wiedmeyer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36784 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755033AbcIZKzP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2016 06:55:15 -0400
Content-Disposition: inline
In-Reply-To: <1474837811-9413-3-git-send-email-wolfgit@wiedmeyer.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Sep 25, 2016 at 11:10:11PM +0200, Wolfgang Wiedmeyer wrote:
> This patch reports the battery technology as Li-ion.
> 
> Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
> ---
>  drivers/power/max17042_battery.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
> index 20cb1fd..43cb5df 100644
> --- a/drivers/power/max17042_battery.c
> +++ b/drivers/power/max17042_battery.c
> @@ -92,6 +92,7 @@ static enum power_supply_property max17042_battery_props[] = {
>  	POWER_SUPPLY_PROP_TEMP_MIN,
>  	POWER_SUPPLY_PROP_TEMP_MAX,
>  	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
>  	POWER_SUPPLY_PROP_CURRENT_AVG,
>  };
> @@ -296,6 +297,9 @@ static int max17042_get_property(struct power_supply *psy,
>  		if (ret < 0)
>  			return ret;
>  		break;
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;

How can you be sure it is always Li-Ion? For wearables and mobiles, rather yes, but
the driver is also used in other devices. Technically, specs are saying
it might be used also with Li-Poly applications.

Best regards,
Krzysztof

