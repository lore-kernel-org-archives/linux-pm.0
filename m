From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 6/9] OPP: Add dev_pm_opp_{set|put}_genpd_device() helper
Date: Fri, 12 Oct 2018 16:46:33 +0200
Message-ID: <CAPDyKFojOdmGbAzDMrO8EVJYrEYwYi6PT8YG55J9svGT61a1Cg@mail.gmail.com>
References: <cover.1539341929.git.viresh.kumar@linaro.org> <110c9e13d8d44dfb59577256b1309dddf2ceda12.1539341929.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <110c9e13d8d44dfb59577256b1309dddf2ceda12.1539341929.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Niklas Cassel <niklas.cassel@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12 October 2018 at 13:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Multiple generic power domains for a consumer device are supported with
> the help of virtual devices, which are created for each consumer device
> - genpd pair. These are the device structures which are attached to the
> power domain and are required by the OPP core to set the performance
> state of the genpd.
>
> The helpers added by this commit are required to be called once for each
> of these virtual devices. These are required only if multiple domains
> are available for a device, otherwise the actual device structure will
> be used instead by the OPP core.
>
> The new helpers also support the complex cases where the consumer device
> wouldn't always require all the domains. For example, a camera may
> require only one power domain during normal operations but two during
> high resolution operations. The consumer driver can call
> dev_pm_opp_put_genpd_device(high_resolution_genpd_dev) if it is
> currently operating in the normal mode and doesn't have any performance
> requirements from the genpd which manages high resolution power
> requirements. The consumer driver can later call
> dev_pm_opp_set_genpd_device(high_resolution_genpd_dev) once it switches
> back to the high resolution mode.
>
> The new helpers differ from other OPP set/put helpers as the new ones
> can be called with OPPs initialized for the table as we may need to call
> them on the fly because of the complex case explained above. For this
> reason it is possible that the genpd_device structure may be used in

This is a bit unclear. What is really the genpd_device structure?
Could you please clarify that here?

> parallel while the new helpers are running and a new mutex is added to
> protect against that. We didn't use the existing opp_table->lock mutex
> as that is widely used in the OPP core and we will need a lock in the
> hotpath now, i.e.  while changing OPP and we need to make sure there is
> not much contention while doing that.

I not sure this needs to be considered as hotpath. I would be
surprised if changing genpd virtual devices for OPP, is something that
is going to be done frequently. Rather, this is more depending on the
use case, like the camera case you describe above.

In other words, do you really need a new lock?

Other than that, this looks good to me.

Kind regards
Uffe

>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c     | 88 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/opp/of.c       | 16 +++++++-
>  drivers/opp/opp.h      |  4 ++
>  include/linux/pm_opp.h |  8 ++++
>  4 files changed, 115 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 02a69a62dac8..8d7bf9d83752 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -823,6 +823,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
>                 return NULL;
>
>         mutex_init(&opp_table->lock);
> +       mutex_init(&opp_table->genpd_dev_lock);
>         INIT_LIST_HEAD(&opp_table->dev_list);
>
>         opp_dev = _add_opp_dev(dev, opp_table);
> @@ -920,6 +921,7 @@ static void _opp_table_kref_release(struct kref *kref)
>                 _remove_opp_dev(opp_dev, opp_table);
>         }
>
> +       mutex_destroy(&opp_table->genpd_dev_lock);
>         mutex_destroy(&opp_table->lock);
>         list_del(&opp_table->node);
>         kfree(opp_table);
> @@ -1602,6 +1604,92 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_set_opp_helper);
>
> +/**
> + * dev_pm_opp_set_genpd_device - Set virtual genpd device for an index
> + * @dev: Consumer device for which the genpd device is getting set.
> + * @genpd_dev: virtual genpd device.
> + * @index: index.
> + *
> + * Multiple generic power domains for a device are supported with the help of
> + * virtual genpd devices, which are created for each consumer device - genpd
> + * pair. These are the device structures which are attached to the power domain
> + * and are required by the OPP core to set the performance state of the genpd.
> + *
> + * This helper will normally be called by the consumer driver of the device
> + * "dev", as only that has details of the genpd devices.
> + *
> + * This helper needs to be called once for each of those virtual devices, but
> + * only if multiple domains are available for a device. Otherwise the original
> + * device structure will be used instead by the OPP core.
> + */
> +struct opp_table *dev_pm_opp_set_genpd_device(struct device *dev,
> +                                             struct device *genpd_device,
> +                                             int index)
> +{
> +       struct opp_table *opp_table;
> +
> +       opp_table = dev_pm_opp_get_opp_table(dev);
> +       if (!opp_table)
> +               return ERR_PTR(-ENOMEM);
> +
> +       mutex_lock(&opp_table->genpd_dev_lock);
> +
> +       if (unlikely(!opp_table->genpd_devices ||
> +                    index >= opp_table->required_opp_count ||
> +                    opp_table->genpd_devices[index])) {
> +
> +               dev_err(dev, "Invalid request to set required device\n");
> +               dev_pm_opp_put_opp_table(opp_table);
> +               mutex_unlock(&opp_table->genpd_dev_lock);
> +
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       opp_table->genpd_devices[index] = genpd_device;
> +       mutex_unlock(&opp_table->genpd_dev_lock);
> +
> +       return opp_table;
> +}
> +
> +/**
> + * dev_pm_opp_put_genpd_device() - Releases resources blocked for genpd device.
> + * @opp_table: OPP table returned by dev_pm_opp_set_genpd_device().
> + * @genpd_device: virtual genpd device.
> + *
> + * This releases the resource previously acquired with a call to
> + * dev_pm_opp_set_genpd_device(). The consumer driver shall call this helper if
> + * it doesn't want OPP core to update performance state of a power domain
> + * anymore.
> + */
> +void dev_pm_opp_put_genpd_device(struct opp_table *opp_table,
> +                                struct device *genpd_device)
> +{
> +       int i;
> +
> +       /*
> +        * Acquire genpd_dev_lock to make sure genpd_device isn't getting used
> +        * in parallel.
> +        */
> +       mutex_lock(&opp_table->genpd_dev_lock);
> +
> +       for (i = 0; i < opp_table->required_opp_count; i++) {
> +               if (opp_table->genpd_devices[i] != genpd_device)
> +                       continue;
> +
> +               opp_table->genpd_devices[i] = NULL;
> +               dev_pm_opp_put_opp_table(opp_table);
> +
> +               /* Drop the vote */
> +               dev_pm_genpd_set_performance_state(genpd_device, 0);
> +               break;
> +       }
> +
> +       mutex_unlock(&opp_table->genpd_dev_lock);
> +
> +       if (unlikely(i == opp_table->required_opp_count))
> +               dev_err(genpd_device, "Failed to find required device entry\n");
> +}
> +
>  /**
>   * dev_pm_opp_add()  - Add an OPP table from a table definitions
>   * @dev:       device for which we do this operation
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index ffaeefef98ce..fd67c9b55d7d 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -134,6 +134,7 @@ static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
>  static void _opp_table_free_required_tables(struct opp_table *opp_table)
>  {
>         struct opp_table **required_opp_tables = opp_table->required_opp_tables;
> +       struct device **genpd_devices = opp_table->genpd_devices;
>         int i;
>
>         if (!required_opp_tables)
> @@ -147,8 +148,10 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
>         }
>
>         kfree(required_opp_tables);
> +       kfree(genpd_devices);
>
>         opp_table->required_opp_count = 0;
> +       opp_table->genpd_devices = NULL;
>         opp_table->required_opp_tables = NULL;
>  }
>
> @@ -161,6 +164,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>                                              struct device_node *opp_np)
>  {
>         struct opp_table **required_opp_tables;
> +       struct device **genpd_devices = NULL;
>         struct device_node *required_np, *np;
>         int count, i;
>
> @@ -175,11 +179,21 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>         if (!count)
>                 goto put_np;
>
> +       if (count > 1) {
> +               genpd_devices = kcalloc(count, sizeof(*genpd_devices),
> +                                       GFP_KERNEL);
> +               if (!genpd_devices)
> +                       goto put_np;
> +       }
> +
>         required_opp_tables = kcalloc(count, sizeof(*required_opp_tables),
>                                       GFP_KERNEL);
> -       if (!required_opp_tables)
> +       if (!required_opp_tables) {
> +               kfree(genpd_devices);
>                 goto put_np;
> +       }
>
> +       opp_table->genpd_devices = genpd_devices;
>         opp_table->required_opp_tables = required_opp_tables;
>         opp_table->required_opp_count = count;
>
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 24b340ad18d1..aea69a24c26b 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -135,6 +135,8 @@ enum opp_table_access {
>   * @parsed_static_opps: True if OPPs are initialized from DT.
>   * @shared_opp: OPP is shared between multiple devices.
>   * @suspend_opp: Pointer to OPP to be used during device suspend.
> + * @genpd_dev_lock: Mutex protecting the genpd device pointers.
> + * @genpd_devices: List of virtual devices for multiple genpd support.
>   * @required_opp_tables: List of device OPP tables that are required by OPPs in
>   *             this table.
>   * @required_opp_count: Number of required devices.
> @@ -177,6 +179,8 @@ struct opp_table {
>         enum opp_table_access shared_opp;
>         struct dev_pm_opp *suspend_opp;
>
> +       struct mutex genpd_dev_lock;
> +       struct device **genpd_devices;
>         struct opp_table **required_opp_tables;
>         unsigned int required_opp_count;
>
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 5d399eeef172..b14600ce078f 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -126,6 +126,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
>  void dev_pm_opp_put_clkname(struct opp_table *opp_table);
>  struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
>  void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
> +struct opp_table *dev_pm_opp_set_genpd_device(struct device *dev, struct device *genpd_device, int index);
> +void dev_pm_opp_put_genpd_device(struct opp_table *opp_table, struct device *genpd_device);
>  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
>  int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
>  int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
> @@ -272,6 +274,12 @@ static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const
>
>  static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
>
> +static inline struct opp_table *dev_pm_opp_set_genpd_device(struct device *dev, struct device *genpd_device, int index)
> +{
> +       return ERR_PTR(-ENOTSUPP);
> +}
> +
> +static inline void dev_pm_opp_put_genpd_device(struct opp_table *opp_table, struct device *genpd_device) {}
>  static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  {
>         return -ENOTSUPP;
> --
> 2.18.0.rc1.242.g61856ae69a2c
>
