From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5 04/11] thermal: core: export apis to get slope and
 offset
Date: Wed, 27 Apr 2016 17:08:14 -0700
Message-ID: <20160428000813.GA17932@localhost.localdomain>
References: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org>
 <1460626319-14516-5-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460626319-14516-5-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 14, 2016 at 03:01:52PM +0530, Rajendra Nayak wrote:
> Add apis for platform thermal drivers to query for slope and offset
> attributes, which might be needed for temperature calculations.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/thermal/thermal_core.c | 16 ++++++++++++++++
>  include/linux/thermal.h        |  8 ++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d4b5465..7d72aad 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -2065,6 +2065,22 @@ exit:
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
>  
> +int thermal_zone_get_slope(struct thermal_zone_device *tz)
> +{
> +	if (tz && tz->tzp)
> +		return tz->tzp->slope;
> +	return 1;
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_get_slope);
> +
> +int thermal_zone_get_offset(struct thermal_zone_device *tz)
> +{
> +	if (tz && tz->tzp)
> +		return tz->tzp->offset;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_get_offset);


Please include kernel doc entries for the exported functions. Updating
sysfs-api.txt would be also appreciated.

Thanks for adding this.

> +
>  #ifdef CONFIG_NET
>  static const struct genl_multicast_group thermal_event_mcgrps[] = {
>  	{ .name = THERMAL_GENL_MCAST_GROUP_NAME, },
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index a55d052..84be6a9 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -432,6 +432,8 @@ thermal_of_cooling_device_register(struct device_node *np, char *, void *,
>  void thermal_cooling_device_unregister(struct thermal_cooling_device *);
>  struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
>  int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
> +int thermal_zone_get_slope(struct thermal_zone_device *tz);
> +int thermal_zone_get_offset(struct thermal_zone_device *tz);
>  
>  int get_tz_trend(struct thermal_zone_device *, int);
>  struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
> @@ -489,6 +491,12 @@ static inline struct thermal_zone_device *thermal_zone_get_zone_by_name(
>  static inline int thermal_zone_get_temp(
>  		struct thermal_zone_device *tz, int *temp)
>  { return -ENODEV; }
> +static inline int thermal_zone_get_slope(
> +		struct thermal_zone_device *tz)
> +{ return -ENODEV; }
> +static inline int thermal_zone_get_offset(
> +		struct thermal_zone_device *tz)
> +{ return -ENODEV; }
>  static inline int get_tz_trend(struct thermal_zone_device *tz, int trip)
>  { return -ENODEV; }
>  static inline struct thermal_instance *
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
