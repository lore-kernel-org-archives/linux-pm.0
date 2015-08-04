From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH RESEND] power: bq24190_charger: Fix charge type sysfs
 property
Date: Tue, 4 Aug 2015 11:45:36 -0500
Message-ID: <55C0EC30.8000006@ti.com>
References: <1438706177-8115-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49057 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbbHDQp7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 4 Aug 2015 12:45:59 -0400
In-Reply-To: <1438706177-8115-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, Andrew Davis <afd@ti.com>

On 08/04/2015 11:36 AM, Andreas Dannenberg wrote:
> Access to the BQ24190's configurable charge type property (none, trickle,
> fast) is being masked by an incorrect power_supply_property entry. After
> applying this patch a new 'charge_type' property will appear in the
> bq24190-charger sysfs folder backed up by getters/setters already
> present in the driver.
>
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> ---
> This is a RESEND of yesterday's patch that for some reason did not seem to
> have gotten picked up correctly...
>
> The current driver incorrectly tries to declare the charge type property
> using POWER_SUPPLY_PROP_TYPE which is the wrong declaration for this
> (actually POWER_SUPPLY_PROP_TYPE itself has been superseeded by
> power_supply.type and isn't even used anymore as part of the power
> supply property declarations).
>
> After implementing the fix tested this aspect of the driver using an
> actual BQ24190 device and could witness the impact the change of charge
> type has on the battery (writing '1' to the new sysfs property means
> charging off, '2' will do trickle charging, and '3' will result in
> fast charging).
>
>
>  drivers/power/bq24190_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/bq24190_charger.c b/drivers/power/bq24190_charger.c
> index 052db78..40ae47c 100644
> --- a/drivers/power/bq24190_charger.c
> +++ b/drivers/power/bq24190_charger.c
> @@ -902,7 +902,7 @@ static int bq24190_charger_property_is_writeable(struct power_supply *psy,
>  }
>  
>  static enum power_supply_property bq24190_charger_properties[] = {
> -	POWER_SUPPLY_PROP_TYPE,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
>  	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,

Acked-by: Dan Murphy <dmurphy@ti.com>

-- 
------------------
Dan Murphy

