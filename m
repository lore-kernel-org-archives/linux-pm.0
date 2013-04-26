From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] thermal: Can't set policy
Date: Fri, 26 Apr 2013 22:33:22 +0200
Message-ID: <4217740.SfDcdCo8sm@vostro.rjw.lan>
References: <1366989432-4825-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:45499 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757120Ab3DZUZO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 26 Apr 2013 16:25:14 -0400
In-Reply-To: <1366989432-4825-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, rui.zhang@intel.com, Linux PM list <linux-pm@vger.kernel.org>

On Friday, April 26, 2013 08:17:12 AM Srinivas Pandruvada wrote:
> Setting policy results in invalid value error.
> 	>echo "step_wise" > policy
> 	>echo: write error: Invalid argument
> 
> Need clean up of the buffer which "echo" may add based on the
> arguments, before comparing aganist list of governor names.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This needs to go to linux-pm@vger.kernel.org, so that the people who work on
thermal have chance to comment.  Please resend.

Thanks,
Rafael


> ---
>  drivers/thermal/thermal_core.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 4cdc3e3..ed6904f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -696,16 +696,27 @@ static ssize_t
>  policy_store(struct device *dev, struct device_attribute *attr,
>  		    const char *buf, size_t count)
>  {
> -	int ret = -EINVAL;
> +	int ret;
>  	struct thermal_zone_device *tz = to_thermal_zone(dev);
>  	struct thermal_governor *gov;
> +	char str_gov[THERMAL_NAME_LENGTH];
> +	char format[6]; /* enough for 3 digit format width */
> +
> +	ret = snprintf(format, sizeof(format), "%%%ds",
> +					THERMAL_NAME_LENGTH - 1);
> +	if (ret < 0)
> +		return ret;
> +	ret = sscanf(buf, format, str_gov);
> +	if (ret <= 0)
> +		return -EINVAL;
>  
>  	mutex_lock(&thermal_governor_lock);
>  
> -	gov = __find_governor(buf);
> -	if (!gov)
> +	gov = __find_governor(str_gov);
> +	if (!gov) {
> +		ret = -EINVAL;
>  		goto exit;
> -
> +	}
>  	tz->governor = gov;
>  	ret = count;
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
