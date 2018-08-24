From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2] of: thermal: Allow multiple devices to share cooling
 map
Date: Fri, 24 Aug 2018 16:14:19 -0700
Message-ID: <20180824231417.GB25163@localhost.localdomain>
References: <b5555967e713fd601bc74de0cab8ab45608399c4.1531824436.git.viresh.kumar@linaro.org>
 <438c3792a41b31629fb702c919ad244db97c0283.1533711976.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <438c3792a41b31629fb702c919ad244db97c0283.1533711976.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 08, 2018 at 12:38:14PM +0530, Viresh Kumar wrote:
> A cooling map entry may now contain a list of phandles and their
> arguments representing multiple devices which share the trip point.
> 
> This patch updates the thermal OF core to parse them properly. The trip
> point and contribution value is shared by multiple cooling devices now
> and so a new structure is created, struct __thermal_cooling_bind_param,
> which represents a cooling device and its min/max states and the
> existing struct __thermal_bind_params now contains an array of this new
> cooling device structure.
> 
> Tested on Hikey960.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - Updated commit log to include new structures information
> - Updated two error messages to give better error log
> 
>  drivers/thermal/of-thermal.c | 142 +++++++++++++++++++++++++----------
>  1 file changed, 103 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 977a8307fbb1..16b890a4fb50 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -19,22 +19,33 @@
>  /***   Private data structures to represent thermal device tree data ***/
>  
>  /**
> - * struct __thermal_bind_param - a match between trip and cooling device
> + * struct __thermal_cooling_bind_param - a cooling device for a trip point
>   * @cooling_device: a pointer to identify the referred cooling device
> - * @trip_id: the trip point index
> - * @usage: the percentage (from 0 to 100) of cooling contribution
>   * @min: minimum cooling state used at this trip point
>   * @max: maximum cooling state used at this trip point
>   */
>  
> -struct __thermal_bind_params {
> +struct __thermal_cooling_bind_param {
>  	struct device_node *cooling_device;
> -	unsigned int trip_id;
> -	unsigned int usage;
>  	unsigned long min;
>  	unsigned long max;
>  };
>  
> +/**
> + * struct __thermal_bind_param - a match between trip and cooling device
> + * @tcbp: a pointer to an array of cooling devices
> + * @count: number of elements in array
> + * @trip_id: the trip point index
> + * @usage: the percentage (from 0 to 100) of cooling contribution
> + */
> +
> +struct __thermal_bind_params {
> +	struct __thermal_cooling_bind_param *tcbp;
> +	unsigned int count;
> +	unsigned int trip_id;
> +	unsigned int usage;
> +};
> +
>  /**
>   * struct __thermal_zone - internal representation of a thermal zone
>   * @mode: current thermal zone device mode (enabled/disabled)
> @@ -192,25 +203,31 @@ static int of_thermal_bind(struct thermal_zone_device *thermal,
>  			   struct thermal_cooling_device *cdev)
>  {
>  	struct __thermal_zone *data = thermal->devdata;
> -	int i;
> +	struct __thermal_bind_params *tbp;
> +	struct __thermal_cooling_bind_param *tcbp;
> +	int i, j;
>  
>  	if (!data || IS_ERR(data))
>  		return -ENODEV;
>  
>  	/* find where to bind */
>  	for (i = 0; i < data->num_tbps; i++) {
> -		struct __thermal_bind_params *tbp = data->tbps + i;
> +		tbp = data->tbps + i;
>  
> -		if (tbp->cooling_device == cdev->np) {
> -			int ret;
> +		for (j = 0; j < tbp->count; j++) {
> +			tcbp = tbp->tcbp + j;
>  
> -			ret = thermal_zone_bind_cooling_device(thermal,
> +			if (tcbp->cooling_device == cdev->np) {
> +				int ret;
> +
> +				ret = thermal_zone_bind_cooling_device(thermal,
>  						tbp->trip_id, cdev,
> -						tbp->max,
> -						tbp->min,
> +						tcbp->max,
> +						tcbp->min,
>  						tbp->usage);
> -			if (ret)
> -				return ret;
> +				if (ret)
> +					return ret;
> +			}
>  		}
>  	}
>  
> @@ -221,22 +238,28 @@ static int of_thermal_unbind(struct thermal_zone_device *thermal,
>  			     struct thermal_cooling_device *cdev)
>  {
>  	struct __thermal_zone *data = thermal->devdata;
> -	int i;
> +	struct __thermal_bind_params *tbp;
> +	struct __thermal_cooling_bind_param *tcbp;
> +	int i, j;
>  
>  	if (!data || IS_ERR(data))
>  		return -ENODEV;
>  
>  	/* find where to unbind */
>  	for (i = 0; i < data->num_tbps; i++) {
> -		struct __thermal_bind_params *tbp = data->tbps + i;
> +		tbp = data->tbps + i;
> +
> +		for (j = 0; j < tbp->count; j++) {
> +			tcbp = tbp->tcbp + j;
>  
> -		if (tbp->cooling_device == cdev->np) {
> -			int ret;
> +			if (tcbp->cooling_device == cdev->np) {
> +				int ret;
>  
> -			ret = thermal_zone_unbind_cooling_device(thermal,
> -						tbp->trip_id, cdev);
> -			if (ret)
> -				return ret;
> +				ret = thermal_zone_unbind_cooling_device(thermal,
> +							tbp->trip_id, cdev);
> +				if (ret)
> +					return ret;
> +			}
>  		}
>  	}
>  
> @@ -652,8 +675,9 @@ static int thermal_of_populate_bind_params(struct device_node *np,
>  					   int ntrips)
>  {
>  	struct of_phandle_args cooling_spec;
> +	struct __thermal_cooling_bind_param *__tcbp;
>  	struct device_node *trip;
> -	int ret, i;
> +	int ret, i, count;
>  	u32 prop;
>  
>  	/* Default weight. Usage is optional */
> @@ -680,20 +704,44 @@ static int thermal_of_populate_bind_params(struct device_node *np,
>  		goto end;
>  	}
>  
> -	ret = of_parse_phandle_with_args(np, "cooling-device", "#cooling-cells",
> -					 0, &cooling_spec);
> -	if (ret < 0) {
> -		pr_err("missing cooling_device property\n");
> +	count = of_count_phandle_with_args(np, "cooling-device",
> +					   "#cooling-cells");
> +	if (!count) {
> +		pr_err("Add a cooling_device property with at least one device\n");
>  		goto end;
>  	}
> -	__tbp->cooling_device = cooling_spec.np;
> -	if (cooling_spec.args_count >= 2) { /* at least min and max */
> -		__tbp->min = cooling_spec.args[0];
> -		__tbp->max = cooling_spec.args[1];
> -	} else {
> -		pr_err("wrong reference to cooling device, missing limits\n");
> +
> +	__tcbp = kcalloc(count, sizeof(*__tcbp), GFP_KERNEL);
> +	if (!__tcbp)
> +		goto end;
> +
> +	for (i = 0; i < count; i++) {
> +		ret = of_parse_phandle_with_args(np, "cooling-device",
> +				"#cooling-cells", i, &cooling_spec);
> +		if (ret < 0) {
> +			pr_err("Invalid cooling-device entry\n");
> +			goto free_tcbp;
> +		}
> +
> +		__tcbp[i].cooling_device = cooling_spec.np;
> +
> +		if (cooling_spec.args_count >= 2) { /* at least min and max */
> +			__tcbp[i].min = cooling_spec.args[0];
> +			__tcbp[i].max = cooling_spec.args[1];
> +		} else {
> +			pr_err("wrong reference to cooling device, missing limits\n");
> +		}
>  	}
>  
> +	__tbp->tcbp= __tcbp;

Applying but manually fixing the above style issue.

> +	__tbp->count = count;
> +
> +	goto end;
> +
> +free_tcbp:
> +	for (i = i - 1; i >= 0; i--)
> +		of_node_put(__tcbp[i].cooling_device);
> +	kfree(__tcbp);
>  end:
>  	of_node_put(trip);
>  
> @@ -900,8 +948,16 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
>  	return tz;
>  
>  free_tbps:
> -	for (i = i - 1; i >= 0; i--)
> -		of_node_put(tz->tbps[i].cooling_device);
> +	for (i = i - 1; i >= 0; i--) {
> +		struct __thermal_bind_params *tbp = tz->tbps + i;
> +		int j;
> +
> +		for (j = 0; j < tbp->count; j++)
> +			of_node_put(tbp->tcbp[j].cooling_device);
> +
> +		kfree(tbp->tcbp);
> +	}
> +
>  	kfree(tz->tbps);
>  free_trips:
>  	for (i = 0; i < tz->ntrips; i++)
> @@ -917,10 +973,18 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
>  
>  static inline void of_thermal_free_zone(struct __thermal_zone *tz)
>  {
> -	int i;
> +	struct __thermal_bind_params *tbp;
> +	int i, j;
> +
> +	for (i = 0; i < tz->num_tbps; i++) {
> +		tbp = tz->tbps + i;
> +
> +		for (j = 0; j < tbp->count; j++)
> +			of_node_put(tbp->tcbp[j].cooling_device);
> +
> +		kfree(tbp->tcbp);
> +	}
>  
> -	for (i = 0; i < tz->num_tbps; i++)
> -		of_node_put(tz->tbps[i].cooling_device);
>  	kfree(tz->tbps);
>  	for (i = 0; i < tz->ntrips; i++)
>  		of_node_put(tz->trips[i].np);
> -- 
> 2.18.0.rc1.242.g61856ae69a2c
> 
