From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/2] power: supply: max17042_battery: use VF SOC register
 for capacity property
Date: Mon, 26 Sep 2016 13:16:15 +0200
Message-ID: <20160926111615.GB8140@kozik-lap>
References: <1474837811-9413-1-git-send-email-wolfgit@wiedmeyer.de>
 <1474837811-9413-2-git-send-email-wolfgit@wiedmeyer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36467 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030403AbcIZLQT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2016 07:16:19 -0400
Content-Disposition: inline
In-Reply-To: <1474837811-9413-2-git-send-email-wolfgit@wiedmeyer.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Sep 25, 2016 at 11:10:10PM +0200, Wolfgang Wiedmeyer wrote:
> The capacity property uses the RepSOC register to report the current state
> of charge. This register did not provide a reliable SOC value during my
> testing with the max17047 variant on a Galaxy S3 (Trats2/GT-I9300). The
> reported value did not change or even stayed zero in some cases.
> However, the VF SOC register provided an accurate SOC value at all times.
> It uses the voltage fuel gauge to determine the SOC.
> 
> Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
> ---
>  drivers/power/max17042_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
> index da7a75f..20cb1fd 100644
> --- a/drivers/power/max17042_battery.c
> +++ b/drivers/power/max17042_battery.c
> @@ -246,7 +246,7 @@ static int max17042_get_property(struct power_supply *psy,
>  		val->intval = data * 625 / 8;
>  		break;
>  	case POWER_SUPPLY_PROP_CAPACITY:
> -		ret = regmap_read(map, MAX17042_RepSOC, &data);
> +		ret = regmap_read(map, MAX17042_VFSOC, &data);
>  		if (ret < 0)
>  			return ret;

The RepSOC is for ModelGauge m3 which requires current sense resistor. I
don't remember whether the resistor is present on Trats2. If not, then
m1 is used. However in both cases (m1 and m3) the battery
characteristics (cell information) should be loaded which in case of DT
driver is not supported.

Overall, I am not sure whether your change is correct. It might fix this
particular scenario because:
1. We are not providing the cell information,
2. We mre not providing the SNS resistor value so we are in m1 mode (if
there is no SNS resistor).  but it might break other applications where
SNS is present and cell configuration is provided. Unless you tested it
in such?

Probably this should be based on Device Tree property describing what is
configured (e.g. missing model data). Maybe existing maxim,rsns-microohm
could be used - in case of lack of it, fall back to reading VFSOC?

Best regards,
Krzysztof

