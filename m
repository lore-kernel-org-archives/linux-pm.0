From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 03/13] power: max17047_battery: The temp alert values are
 8-bit 2's complement
Date: Fri, 14 Apr 2017 17:09:27 +0200
Message-ID: <20170414150927.eo5n2derv26dskcd@kozik-lap>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35427 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdDNPJc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 11:09:32 -0400
Received: by mail-wr0-f194.google.com with SMTP id l44so12760588wrc.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 08:09:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414125919.25771-3-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 02:59:09PM +0200, Hans de Goede wrote:
> The temp alert values are 8-bit 2's complement, so sign-extend them
> before reporting them back to the caller.

Are you sure that these are reported with sign bit? I couldn't find
confirmation of this in datasheet.

Best regards,
Krzysztof

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/max17042_battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index 790dfa9..a51b296 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -270,14 +270,14 @@ static int max17042_get_property(struct power_supply *psy,
>  		if (ret < 0)
>  			return ret;
>  		/* LSB is Alert Minimum. In deci-centigrade */
> -		val->intval = (data & 0xff) * 10;
> +		val->intval = sign_extend32(data & 0xff, 7) * 10;
>  		break;
>  	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
>  		ret = regmap_read(map, MAX17042_TALRT_Th, &data);
>  		if (ret < 0)
>  			return ret;
>  		/* MSB is Alert Maximum. In deci-centigrade */
> -		val->intval = (data >> 8) * 10;
> +		val->intval = sign_extend32(data >> 8, 7) * 10;
>  		break;
>  	case POWER_SUPPLY_PROP_TEMP_MIN:
>  		val->intval = chip->pdata->temp_min;
> -- 
> 2.9.3
> 
