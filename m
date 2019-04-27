From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1] thermal: Add some error messages
Date: Sat, 27 Apr 2019 17:32:05 +0200
Message-ID: <a7496561-cc51-a8bd-2266-d69efbce0981@linaro.org>
References: <cover.1556305991.git.amit.kucheria@linaro.org>
 <640cd0cd93e199459af6d6d04bad228e909faf54.1556305991.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <640cd0cd93e199459af6d6d04bad228e909faf54.1556305991.git.amit.kucheria@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi Amit,

On 26/04/2019 21:15, Amit Kucheria wrote:
> When registering a thermal zone device, we currently return -EINVAL in
> four cases. This is makes is a little hard to debug the real cause of
> the failure.
> 
> Print some error messages to make it easier for developer to figure out
> what happened.

Adding "Error" in the pr_err message is redundant. However I'm not sure
adding more traces is really important, that will add more RO data for a
function which is supposed to be called from wise code.

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 6590bb5cb688..51cb6d2bf7a2 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1189,17 +1189,26 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>  	int count;
>  	struct thermal_governor *governor;
>  
> -	if (!type || strlen(type) == 0)
> +	if (!type || strlen(type) == 0) {
> +		pr_err("Error: No thermal zone type defined");
>  		return ERR_PTR(-EINVAL);
> +	}
>  
> -	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> +	if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
> +		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars",
> +		       type, THERMAL_NAME_LENGTH);
>  		return ERR_PTR(-EINVAL);
> +	}

May be take the opportunity to remove the test 'type' is true because it
is always true after the previous test?

> -	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips)
> +	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
> +		pr_err("Error: Incorrect number of thermal trips");
>  		return ERR_PTR(-EINVAL);
> +	}
>  
> -	if (!ops)
> +	if (!ops) {
> +		pr_err("Error: Thermal zone device ops not defined");
>  		return ERR_PTR(-EINVAL);
> +	}
>  
>  	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp)>  		return ERR_PTR(-EINVAL);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
