From: =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski@samsung.com>
Subject: Re: [PATCH 01/10] power: charger-manager: Use thermal subsystem
 interface only to get temperature.
Date: Thu, 30 Oct 2014 14:11:35 +0100
Message-ID: <54523907.4030609@samsung.com>
References: <1414672996-28355-1-git-send-email-jonghwa3.lee@samsung.com>
 <1414672996-28355-2-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:30297 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759020AbaJ3NLk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Oct 2014 09:11:40 -0400
In-reply-to: <1414672996-28355-2-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>, linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, pavel@ucw.cz, myungjoo.ham@samsung.com, cw00.choi@samsung.com

On 30.10.2014 13:43, Jonghwa Lee wrote:
> It drops the way of using power_supply interface to reference battery's
> temperature. Then it tries to use thermal subsystem's only. This makes driver
> more simple and also can remove ifdeferies.
> 
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> ---
>  drivers/power/Kconfig                 |    1 +
>  drivers/power/charger-manager.c       |  113 ++++++++-------------------------
>  include/linux/power/charger-manager.h |    3 +-
>  3 files changed, 28 insertions(+), 89 deletions(-)
> 
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 8ff2511..115d153 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -317,6 +317,7 @@ config CHARGER_MANAGER
>  	bool "Battery charger manager for multiple chargers"
>  	depends on REGULATOR
>  	select EXTCON
> +	select THERMAL

I think both of "select" here could be dangerous. Select should rather
be used for non-visible errors. Just use "depends on".

>  	help
>            Say Y to enable charger-manager support, which allows multiple
>            chargers attached to a battery and multiple batteries attached to a
> diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
> index 22246b9..b4b101c 100644
> --- a/drivers/power/charger-manager.c
> +++ b/drivers/power/charger-manager.c
> @@ -28,13 +28,6 @@
>  #include <linux/of.h>
>  #include <linux/thermal.h>
>  
> -/*
> - * Default termperature threshold for charging.
> - * Every temperature units are in tenth of centigrade.
> - */
> -#define CM_DEFAULT_RECHARGE_TEMP_DIFF	50
> -#define CM_DEFAULT_CHARGE_TEMP_MAX	500
> -
>  static const char * const default_event_names[] = {
>  	[CM_EVENT_UNKNOWN] = "Unknown",
>  	[CM_EVENT_BATT_FULL] = "Battery Full",
> @@ -572,40 +565,18 @@ static int check_charging_duration(struct charger_manager *cm)
>  	return ret;
>  }
>  
> -static int cm_get_battery_temperature_by_psy(struct charger_manager *cm,
> -					int *temp)
> -{
> -	struct power_supply *fuel_gauge;
> -
> -	fuel_gauge = power_supply_get_by_name(cm->desc->psy_fuel_gauge);
> -	if (!fuel_gauge)
> -		return -ENODEV;
> -
> -	return fuel_gauge->get_property(fuel_gauge,
> -				POWER_SUPPLY_PROP_TEMP,
> -				(union power_supply_propval *)temp);
> -}
> -
>  static int cm_get_battery_temperature(struct charger_manager *cm,
>  					int *temp)
>  {
>  	int ret;
>  
> -	if (!cm->desc->measure_battery_temp)
> +	if (!cm->tzd_batt)
>  		return -ENODEV;
>  
> -#ifdef CONFIG_THERMAL
> -	if (cm->tzd_batt) {
> -		ret = thermal_zone_get_temp(cm->tzd_batt, (unsigned long *)temp);
> -		if (!ret)
> -			/* Calibrate temperature unit */
> -			*temp /= 100;
> -	} else
> -#endif
> -	{
> -		/* if-else continued from CONFIG_THERMAL */
> -		ret = cm_get_battery_temperature_by_psy(cm, temp);
> -	}
> +	ret = thermal_zone_get_temp(cm->tzd_batt, (unsigned long *)temp);
> +	if (!ret)
> +		/* Calibrate temperature unit */
> +		*temp /= 100;
>  
>  	return ret;
>  }
> @@ -623,7 +594,7 @@ static int cm_check_thermal_status(struct charger_manager *cm)
>  		 * occur hazadous result. We have to handle it
>  		 * depending on battery type.
>  		 */
> -		dev_err(cm->dev, "Failed to get battery temperature\n");
> +		dev_dbg(cm->dev, "Failed to get battery temperature\n");

A valuable change but not strictly related to the commit. Additionally
that is a user-visible change. Could you split it to separate patch?

Best regards,
Krzysztof

