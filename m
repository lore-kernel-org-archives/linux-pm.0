From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH 06/15] thermal: inline only once used function
Date: Wed, 20 May 2015 10:28:01 +0300
Message-ID: <555C3781.6090005@kapsi.fi>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de> <1431507163-19933-7-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431507163-19933-7-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 05/13/15 11:52, Sascha Hauer wrote:
> Inline update_temperature into its only caller to make the code
> more readable.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>   drivers/thermal/thermal_core.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index e204deb..19da022 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -450,9 +450,12 @@ exit:
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
>
> -static void update_temperature(struct thermal_zone_device *tz)
> +void thermal_zone_device_update(struct thermal_zone_device *tz)
>   {
> -	int temp, ret;
> +	int temp, ret, count;
> +
> +	if (!tz->ops->get_temp)
> +		return;
>
>   	ret = thermal_zone_get_temp(tz, &temp);
>   	if (ret) {
> @@ -471,16 +474,6 @@ static void update_temperature(struct thermal_zone_device *tz)
>   	trace_thermal_temperature(tz);
>   	dev_dbg(&tz->device, "last_temperature=%d, current_temperature=%d\n",
>   				tz->last_temperature, tz->temperature);
> -}
> -
> -void thermal_zone_device_update(struct thermal_zone_device *tz)
> -{
> -	int count;
> -
> -	if (!tz->ops->get_temp)
> -		return;
> -
> -	update_temperature(tz);
>
>   	for (count = 0; count < tz->trips; count++)
>   		handle_thermal_trip(tz, count);
>

This is a slight change in that if get_temp fails, governors were 
updated before but aren't now. But I don't know why that would matter.

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
