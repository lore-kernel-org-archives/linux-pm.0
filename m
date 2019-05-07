From: Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v2 2/5] interconnect: Add of_icc_get_by_index() helper
 function
Date: Tue, 7 May 2019 17:29:40 +0530
Message-ID: <e6469e3b-3653-d20b-b27d-242547a777df@codeaurora.org>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190423132823.7915-3-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423132823.7915-3-georgi.djakov@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org, sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc: jcrouse@codeaurora.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hey Georgi,

On 4/23/19 6:58 PM, Georgi Djakov wrote:
> This is the same as the traditional of_icc_get() function, but the
> difference is that it takes index as an argument, instead of name.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>   drivers/interconnect/core.c  | 45 ++++++++++++++++++++++++++++--------
>   include/linux/interconnect.h |  6 +++++
>   2 files changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 871eb4bc4efc..a7c3c262c974 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -295,9 +295,9 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
>   }
>   
>   /**
> - * of_icc_get() - get a path handle from a DT node based on name
> + * of_icc_get_by_index() - get a path handle from a DT node based on index
>    * @dev: device pointer for the consumer device
> - * @name: interconnect path name
> + * @idx: interconnect path index
>    *
>    * This function will search for a path between two endpoints and return an
>    * icc_path handle on success. Use icc_put() to release constraints when they
> @@ -309,13 +309,12 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
>    * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
>    * when the API is disabled or the "interconnects" DT property is missing.
>    */
> -struct icc_path *of_icc_get(struct device *dev, const char *name)
> +struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
>   {
>   	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
>   	struct icc_node *src_node, *dst_node;
>   	struct device_node *np = NULL;
>   	struct of_phandle_args src_args, dst_args;
> -	int idx = 0;
>   	int ret;
>   
>   	if (!dev || !dev->of_node)
> @@ -335,12 +334,6 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>   	 * lets support only global ids and extend this in the future if needed
>   	 * without breaking DT compatibility.
>   	 */
> -	if (name) {
> -		idx = of_property_match_string(np, "interconnect-names", name);
> -		if (idx < 0)
> -			return ERR_PTR(idx);
> -	}
> -
>   	ret = of_parse_phandle_with_args(np, "interconnects",
>   					 "#interconnect-cells", idx * 2,
>   					 &src_args);
> @@ -383,6 +376,38 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>   
>   	return path;
>   }
> +
> +/**
> + * of_icc_get() - get a path handle from a DT node based on name
> + * @dev: device pointer for the consumer device
> + * @name: interconnect path name
> + *
> + * This function will search for a path between two endpoints and return an
> + * icc_path handle on success. Use icc_put() to release constraints when they
> + * are not needed anymore.
> + * If the interconnect API is disabled, NULL is returned and the consumer
> + * drivers will still build. Drivers are free to handle this specifically,
> + * but they don't have to.
> + *
> + * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
> + * when the API is disabled or the "interconnects" DT property is missing.
> + */
> +struct icc_path *of_icc_get(struct device *dev, const char *name)
> +{
> +	int idx = 0;
> +
> +	if (!dev || !dev->of_node)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (name) {
> +		idx = of_property_match_string(dev->of_node,
> +					       "interconnect-names", name);
> +		if (idx < 0)
> +			return ERR_PTR(idx);
> +	}
> +
> +	return of_icc_get_by_index(dev, idx);
> +}
>   EXPORT_SYMBOL_GPL(of_icc_get);
>   
>   /**
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index dc25864755ba..0e430b3b6519 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -28,6 +28,7 @@ struct device;
>   struct icc_path *icc_get(struct device *dev, const int src_id,
>   			 const int dst_id);
>   struct icc_path *of_icc_get(struct device *dev, const char *name);
> +struct icc_path *of_icc_get_by_index(struct device *dev, int idx);
>   void icc_put(struct icc_path *path);
>   int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>   
> @@ -45,6 +46,11 @@ static inline struct icc_path *of_icc_get(struct device *dev,
>   	return NULL;
>   }
>   
> +struct icc_path *of_icc_get_by_index(struct device *dev, int idx)

This should be static inline instead

> +{
> +	return NULL;
> +}
> +
>   static inline void icc_put(struct icc_path *path)
>   {
>   }
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
