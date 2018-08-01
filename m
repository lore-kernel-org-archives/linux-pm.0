From: skannan@codeaurora.org
Subject: Re: [PATCH v7 8/8] interconnect: Allow endpoints translation via DT
Date: Wed, 01 Aug 2018 15:57:52 -0700
Message-ID: <804925d5927ccb6927b16f7e9a4aa05c@codeaurora.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-9-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731161340.13000-9-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2018-07-31 09:13, Georgi Djakov wrote:
> Currently we support only platform data for specifying the interconnect
> endpoints. As now the endpoints are hard-coded into the consumer driver
> this may lead to complications when a single driver is used by multiple
> SoCs, which may have different interconnect topology.
> To avoid cluttering the consumer drivers, introduce a translation 
> function
> to help us get the board specific interconnect data from device-tree.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c  | 62 ++++++++++++++++++++++++++++++++++++
>  include/linux/interconnect.h |  7 ++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 9fef180cf77e..d1b6adff0a3d 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  #include <linux/overflow.h>
>  #include <linux/uaccess.h>
> 
> @@ -251,6 +252,67 @@ static int apply_constraints(struct icc_path 
> *path)
>  	return ret;
>  }
> 
> +struct icc_path *of_icc_get(struct device *dev, const char *name)
> +{
> +	struct device_node *np = NULL;
> +	struct of_phandle_args src_args, dst_args;
> +	u32 src_id, dst_id;
> +	int idx = 0;
> +	int ret;
> +
> +	if (!dev || !dev->of_node)
> +		return ERR_PTR(-ENODEV);
> +
> +	np = dev->of_node;
> +
> +	/*
> +	 * When the consumer DT node do not have "interconnects" property
> +	 * return a NULL path to skip setting constraints.
> +	 */
> +	if (!of_find_property(np, "interconnects", NULL))
> +		return NULL;
> +
> +	/*
> +	 * We use a combination of phandle and specifier for endpoint. For 
> now
> +	 * lets support only global ids and extend this is the future if 
> needed
> +	 * without breaking DT compatibility.
> +	 */
> +	if (name) {
> +		idx = of_property_match_string(np, "interconnect-names", name);
> +		if (idx < 0)
> +			return ERR_PTR(idx);
> +	}
> +
> +	ret = of_parse_phandle_with_args(np, "interconnects",
> +					 "#interconnect-cells", idx * 2,
> +					 &src_args);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	of_node_put(src_args.np);
> +
> +	if (!src_args.args_count || src_args.args_count > 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	src_id = src_args.args[0];
> +
> +	ret = of_parse_phandle_with_args(np, "interconnects",
> +					 "#interconnect-cells", idx * 2 + 1,
> +					 &dst_args);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	of_node_put(dst_args.np);
> +
> +	if (!dst_args.args_count || dst_args.args_count > 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	dst_id = dst_args.args[0];
> +
> +	return icc_get(dev, src_id, dst_id);
> +}
> +EXPORT_SYMBOL_GPL(of_icc_get);
> +
>  /**
>   * icc_set() - set constraints on an interconnect path between two 
> endpoints
>   * @path: reference to the path returned by icc_get()
> diff --git a/include/linux/interconnect.h 
> b/include/linux/interconnect.h
> index 593215371fd6..ae6744da9bc2 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -17,6 +17,7 @@ struct device;
> 
>  struct icc_path *icc_get(struct device *dev, const int src_id,
>  			 const int dst_id);
> +struct icc_path *of_icc_get(struct device *dev, const char *name);
>  void icc_put(struct icc_path *path);
>  int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
> 
> @@ -28,6 +29,12 @@ static inline struct icc_path *icc_get(struct
> device *dev, const int src_id,
>  	return NULL;
>  }
> 
> +static inline struct icc_path *of_icc_get(struct device *dev,
> +					  const char *name)
> +{
> +	return NULL;
> +}
> +

Might want to return PTR(-ENODEV) or some error code so that client 
doesn't have to do NULL check AND an error check?

-Saravana
