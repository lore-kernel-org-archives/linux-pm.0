From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v10 3/7] interconnect: Allow endpoints translation via DT
Date: Fri, 30 Nov 2018 16:38:20 -0800
Message-ID: <CAE=gft5Z7-Ri07iZesq57bqLpsStvJF3y_TSm+Cz=h-pGqJzyw@mail.gmail.com>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <20181127180349.29997-4-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181127180349.29997-4-georgi.djakov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: georgi.djakov@linaro.org
Cc: mark.rutland@arm.com, sanjayc@nvidia.com, maxime.ripard@bootlin.com, Michael Turquette <mturquette@baylibre.com>, daidavid1@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Alexandre Bailon <abailon@baylibre.com>, lorenzo.pieralisi@arm.com, Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com, khilman@baylibre.com, ksitaraman@nvidia.com, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, robh+dt@kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, thierry.reding@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 27, 2018 at 10:04 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Currently we support only platform data for specifying the interconnect
> endpoints. As now the endpoints are hard-coded into the consumer driver
> this may lead to complications when a single driver is used by multiple
> SoCs, which may have different interconnect topology.
> To avoid cluttering the consumer drivers, introduce a translation function
> to help us get the board specific interconnect data from device-tree.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c           | 156 ++++++++++++++++++++++++++
>  include/linux/interconnect-provider.h |  17 +++
>  include/linux/interconnect.h          |   7 ++
>  3 files changed, 180 insertions(+)
>
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 3ae8e5a58969..ebc42ef9fa46 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  #include <linux/overflow.h>
>
>  static DEFINE_IDR(icc_idr);
> @@ -193,6 +194,159 @@ static int apply_constraints(struct icc_path *path)
>         return ret;
>  }
>
> +/* of_icc_xlate_onecell() - Xlate function using a single index.

It would be nice if translate were spelled out instead of xlate in the
description portion (throughout).

> + * @spec: OF phandle args to map into an interconnect node.
> + * @data: private data (pointer to struct icc_onecell_data)
> + *
> + * This is a generic xlate function that can be used to model simple
> + * interconnect providers that have one device tree node and provide
> + * multiple interconnect nodes. A single cell is used as an index into
> + * an array of icc nodes specified in the icc_onecell_data struct when
> + * registering the provider.
> + */
> +struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
> +                                     void *data)
> +{
> +       struct icc_onecell_data *icc_data = data;
> +       unsigned int idx = spec->args[0];
> +
> +       if (idx >= icc_data->num_nodes) {
> +               pr_err("%s: invalid index %u\n", __func__, idx);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return icc_data->nodes[idx];
> +}
> +EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
> +
> +/**
> + * of_icc_get_from_provider() - Look-up interconnect node
> + * @spec: OF phandle args to use for look-up
> + *
> + * Looks for interconnect provider under the node specified by @spec and if
> + * found, uses xlate function of the provider to map phandle args to node.
> + *
> + * Returns a valid pointer to struct icc_node on success or ERR_PTR()
> + * on failure.
> + */
> +static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
> +{
> +       struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
> +       struct icc_provider *provider;
> +
> +       if (!spec)
> +               return ERR_PTR(-EINVAL);
> +
> +       mutex_lock(&icc_lock);
> +       list_for_each_entry(provider, &icc_providers, provider_list) {
> +               if (provider->dev->of_node == spec->np)
> +                       node = provider->xlate(spec, provider->data);
> +               if (!IS_ERR(node))
> +                       break;
> +       }
> +       mutex_unlock(&icc_lock);
> +
> +       return node;
> +}
> +
> +/**
> + * of_icc_get() - get a path handle from a DT node based on name
> + * @dev: device pointer for the consumer device
> + * @name: interconnect path name
> + *
> + * This function will search for a path two endpoints and return an

path between two endpoints

> + * icc_path handle on success. Use icc_put() to release constraints when
> + * they are not needed anymore.
> + * If the interconnect API is disabled, NULL is returned and the consumer
> + * drivers will still build. Drivers are free to handle this specifically,
> + * but they don't have to. NULL is also returned when the "interconnects"

I'm not sure the sentence starting with "Drivers are free" adds much.
Also, you mention that null is returned when the interconnect API is
disabled both above and below. We probably only need it once.

> + * DT property is missing.
> + *
> + * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
> + * when the API is disabled or the "interconnects" DT property is missing.
> + */
> +struct icc_path *of_icc_get(struct device *dev, const char *name)
> +{
> +       struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
> +       struct icc_node *src_node, *dst_node;
> +       struct device_node *np = NULL;
> +       struct of_phandle_args src_args, dst_args;
> +       int idx = 0;
> +       int ret;
> +
> +       if (!dev || !dev->of_node)
> +               return ERR_PTR(-ENODEV);
> +
> +       np = dev->of_node;
> +
> +       /*
> +        * When the consumer DT node do not have "interconnects" property
> +        * return a NULL path to skip setting constraints.
> +        */
> +       if (!of_find_property(np, "interconnects", NULL))
> +               return NULL;
> +
> +       /*
> +        * We use a combination of phandle and specifier for endpoint. For now
> +        * lets support only global ids and extend this is the future if needed

s/is the future/in the future/

> +        * without breaking DT compatibility.
> +        */
> +       if (name) {
> +               idx = of_property_match_string(np, "interconnect-names", name);
> +               if (idx < 0)
> +                       return ERR_PTR(idx);
> +       }
> +
> +       ret = of_parse_phandle_with_args(np, "interconnects",
> +                                        "#interconnect-cells", idx * 2,
> +                                        &src_args);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       of_node_put(src_args.np);
> +
> +       if (!src_args.args_count || src_args.args_count > 1)

This could be src_args.argc_count != 1

> +               return ERR_PTR(-EINVAL);
> +
> +       ret = of_parse_phandle_with_args(np, "interconnects",
> +                                        "#interconnect-cells", idx * 2 + 1,
> +                                        &dst_args);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       of_node_put(dst_args.np);
> +
> +       if (!dst_args.args_count || dst_args.args_count > 1)

Similarly, this could be dst_args.args_count != 1

> +               return ERR_PTR(-EINVAL);
> +
> +       src_node = of_icc_get_from_provider(&src_args);
> +
> +       if (IS_ERR(src_node)) {
> +               if (PTR_ERR(src_node) != -EPROBE_DEFER)
> +                       dev_err(dev, "error finding src node: %ld\n",
> +                               PTR_ERR(src_node));
> +               return ERR_CAST(src_node);
> +       }
> +
> +       dst_node = of_icc_get_from_provider(&dst_args);
> +
> +       if (IS_ERR(dst_node)) {
> +               if (PTR_ERR(dst_node) != -EPROBE_DEFER)
> +                       dev_err(dev, "error finding dst node: %ld\n",
> +                               PTR_ERR(dst_node));
> +               return ERR_CAST(dst_node);
> +       }
> +
> +       mutex_lock(&icc_lock);
> +       path = path_find(dev, src_node, dst_node);
> +       if (IS_ERR(path))
> +               dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
> +       mutex_unlock(&icc_lock);
> +
> +       return path;
> +}
> +EXPORT_SYMBOL_GPL(of_icc_get);
> +
>  /**
>   * icc_set() - set constraints on an interconnect path between two endpoints
>   * @path: reference to the path returned by icc_get()
> @@ -521,6 +675,8 @@ int icc_provider_add(struct icc_provider *provider)
>  {
>         if (WARN_ON(!provider->set))
>                 return -EINVAL;
> +       if (WARN_ON(!provider->xlate))
> +               return -EINVAL;
>
>         mutex_lock(&icc_lock);
>
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> index 78208a754181..63caccadc2db 100644
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -12,6 +12,21 @@
>  #define icc_units_to_bps(bw)  ((bw) * 1000ULL)
>
>  struct icc_node;
> +struct of_phandle_args;
> +
> +/**
> + * struct icc_onecell_data - driver data for onecell interconnect providers
> + *
> + * @num_nodes: number of nodes in this device
> + * @nodes: array of pointers to the nodes in this device
> + */
> +struct icc_onecell_data {
> +       unsigned int num_nodes;
> +       struct icc_node *nodes[];
> +};
> +
> +struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
> +                                     void *data);
>
>  /**
>   * struct icc_provider - interconnect provider (controller) entity that might
> @@ -21,6 +36,7 @@ struct icc_node;
>   * @nodes: internal list of the interconnect provider nodes
>   * @set: pointer to device specific set operation function
>   * @aggregate: pointer to device specific aggregate operation function
> + * @xlate: provider-specific callback for mapping nodes from phandle arguments
>   * @dev: the device this interconnect provider belongs to
>   * @users: count of active users
>   * @data: pointer to private data
> @@ -31,6 +47,7 @@ struct icc_provider {
>         int (*set)(struct icc_node *src, struct icc_node *dst);
>         int (*aggregate)(struct icc_node *node, u32 avg_bw, u32 peak_bw,
>                          u32 *agg_avg, u32 *agg_peak);
> +       struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
>         struct device           *dev;
>         int                     users;
>         void                    *data;
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index 04b2966ded9f..41f7ecc2f20f 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -26,6 +26,7 @@ struct device;
>
>  struct icc_path *icc_get(struct device *dev, const int src_id,
>                          const int dst_id);
> +struct icc_path *of_icc_get(struct device *dev, const char *name);
>  void icc_put(struct icc_path *path);
>  int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>
> @@ -37,6 +38,12 @@ static inline struct icc_path *icc_get(struct device *dev, const int src_id,
>         return NULL;
>  }
>
> +static inline struct icc_path *of_icc_get(struct device *dev,
> +                                         const char *name)
> +{
> +       return NULL;
> +}
> +
>  static inline void icc_put(struct icc_path *path)
>  {
>  }

With these nits fixed:

Reviewed-by: Evan Green <evgreen@chromium.org>
