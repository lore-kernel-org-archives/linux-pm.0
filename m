From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] opp: no need to check return value of debugfs_create functions
Date: Tue, 22 Jan 2019 18:48:07 +0100
Message-ID: <CAJZ5v0i5=r78AHmXRLgu8GwjCVgHjsNRhNWHxx-H5auD8AFAng@mail.gmail.com>
References: <20190122152151.16139-18-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122152151.16139-18-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 22, 2019 at 4:28 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Viresh, would you take this one, please?

> ---
>  drivers/opp/core.c    |  10 +---
>  drivers/opp/debugfs.c | 109 +++++++++++-------------------------------
>  drivers/opp/opp.h     |  15 +++---
>  3 files changed, 37 insertions(+), 97 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 18f1639dbc4a..00b6b436a199 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -805,10 +805,7 @@ static struct opp_device *_add_opp_dev_unlocked(const struct device *dev,
>         list_add(&opp_dev->node, &opp_table->dev_list);
>
>         /* Create debugfs entries for the opp_table */
> -       ret = opp_debug_register(opp_dev, opp_table);
> -       if (ret)
> -               dev_err(dev, "%s: Failed to register opp debugfs (%d)\n",
> -                       __func__, ret);
> +       opp_debug_register(opp_dev, opp_table);
>
>         return opp_dev;
>  }
> @@ -1229,10 +1226,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
>         new_opp->opp_table = opp_table;
>         kref_init(&new_opp->kref);
>
> -       ret = opp_debug_create_one(new_opp, opp_table);
> -       if (ret)
> -               dev_err(dev, "%s: Failed to register opp to debugfs (%d)\n",
> -                       __func__, ret);
> +       opp_debug_create_one(new_opp, opp_table);
>
>         if (!_opp_supported_by_regulators(new_opp, opp_table)) {
>                 new_opp->available = false;
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index e6828e5f81b0..baac1ae33c55 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -35,7 +35,7 @@ void opp_debug_remove_one(struct dev_pm_opp *opp)
>         debugfs_remove_recursive(opp->dentry);
>  }
>
> -static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
> +static void opp_debug_create_supplies(struct dev_pm_opp *opp,
>                                       struct opp_table *opp_table,
>                                       struct dentry *pdentry)
>  {
> @@ -50,30 +50,21 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
>                 /* Create per-opp directory */
>                 d = debugfs_create_dir(name, pdentry);
>
> -               if (!d)
> -                       return false;
> +               debugfs_create_ulong("u_volt_target", S_IRUGO, d,
> +                                    &opp->supplies[i].u_volt);
>
> -               if (!debugfs_create_ulong("u_volt_target", S_IRUGO, d,
> -                                         &opp->supplies[i].u_volt))
> -                       return false;
> +               debugfs_create_ulong("u_volt_min", S_IRUGO, d,
> +                                    &opp->supplies[i].u_volt_min);
>
> -               if (!debugfs_create_ulong("u_volt_min", S_IRUGO, d,
> -                                         &opp->supplies[i].u_volt_min))
> -                       return false;
> +               debugfs_create_ulong("u_volt_max", S_IRUGO, d,
> +                                    &opp->supplies[i].u_volt_max);
>
> -               if (!debugfs_create_ulong("u_volt_max", S_IRUGO, d,
> -                                         &opp->supplies[i].u_volt_max))
> -                       return false;
> -
> -               if (!debugfs_create_ulong("u_amp", S_IRUGO, d,
> -                                         &opp->supplies[i].u_amp))
> -                       return false;
> +               debugfs_create_ulong("u_amp", S_IRUGO, d,
> +                                    &opp->supplies[i].u_amp);
>         }
> -
> -       return true;
>  }
>
> -int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
> +void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
>  {
>         struct dentry *pdentry = opp_table->dentry;
>         struct dentry *d;
> @@ -95,40 +86,22 @@ int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
>
>         /* Create per-opp directory */
>         d = debugfs_create_dir(name, pdentry);
> -       if (!d)
> -               return -ENOMEM;
> -
> -       if (!debugfs_create_bool("available", S_IRUGO, d, &opp->available))
> -               return -ENOMEM;
> -
> -       if (!debugfs_create_bool("dynamic", S_IRUGO, d, &opp->dynamic))
> -               return -ENOMEM;
> -
> -       if (!debugfs_create_bool("turbo", S_IRUGO, d, &opp->turbo))
> -               return -ENOMEM;
> -
> -       if (!debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend))
> -               return -ENOMEM;
> -
> -       if (!debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate))
> -               return -ENOMEM;
>
> -       if (!debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate))
> -               return -ENOMEM;
> +       debugfs_create_bool("available", S_IRUGO, d, &opp->available);
> +       debugfs_create_bool("dynamic", S_IRUGO, d, &opp->dynamic);
> +       debugfs_create_bool("turbo", S_IRUGO, d, &opp->turbo);
> +       debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend);
> +       debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate);
> +       debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate);
> +       debugfs_create_ulong("clock_latency_ns", S_IRUGO, d, &opp->clock_latency_ns);
>
> -       if (!opp_debug_create_supplies(opp, opp_table, d))
> -               return -ENOMEM;
> -
> -       if (!debugfs_create_ulong("clock_latency_ns", S_IRUGO, d,
> -                                 &opp->clock_latency_ns))
> -               return -ENOMEM;
> +       opp_debug_create_supplies(opp, opp_table, d);
>
>         opp->dentry = d;
> -       return 0;
>  }
>
> -static int opp_list_debug_create_dir(struct opp_device *opp_dev,
> -                                    struct opp_table *opp_table)
> +static void opp_list_debug_create_dir(struct opp_device *opp_dev,
> +                                     struct opp_table *opp_table)
>  {
>         const struct device *dev = opp_dev->dev;
>         struct dentry *d;
> @@ -137,36 +110,21 @@ static int opp_list_debug_create_dir(struct opp_device *opp_dev,
>
>         /* Create device specific directory */
>         d = debugfs_create_dir(opp_table->dentry_name, rootdir);
> -       if (!d) {
> -               dev_err(dev, "%s: Failed to create debugfs dir\n", __func__);
> -               return -ENOMEM;
> -       }
>
>         opp_dev->dentry = d;
>         opp_table->dentry = d;
> -
> -       return 0;
>  }
>
> -static int opp_list_debug_create_link(struct opp_device *opp_dev,
> -                                     struct opp_table *opp_table)
> +static void opp_list_debug_create_link(struct opp_device *opp_dev,
> +                                      struct opp_table *opp_table)
>  {
> -       const struct device *dev = opp_dev->dev;
>         char name[NAME_MAX];
> -       struct dentry *d;
>
>         opp_set_dev_name(opp_dev->dev, name);
>
>         /* Create device specific directory link */
> -       d = debugfs_create_symlink(name, rootdir, opp_table->dentry_name);
> -       if (!d) {
> -               dev_err(dev, "%s: Failed to create link\n", __func__);
> -               return -ENOMEM;
> -       }
> -
> -       opp_dev->dentry = d;
> -
> -       return 0;
> +       opp_dev->dentry = debugfs_create_symlink(name, rootdir,
> +                                                opp_table->dentry_name);
>  }
>
>  /**
> @@ -177,20 +135,13 @@ static int opp_list_debug_create_link(struct opp_device *opp_dev,
>   * Dynamically adds device specific directory in debugfs 'opp' directory. If the
>   * device-opp is shared with other devices, then links will be created for all
>   * devices except the first.
> - *
> - * Return: 0 on success, otherwise negative error.
>   */
> -int opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table)
> +void opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table)
>  {
> -       if (!rootdir) {
> -               pr_debug("%s: Uninitialized rootdir\n", __func__);
> -               return -EINVAL;
> -       }
> -
>         if (opp_table->dentry)
> -               return opp_list_debug_create_link(opp_dev, opp_table);
> -
> -       return opp_list_debug_create_dir(opp_dev, opp_table);
> +               opp_list_debug_create_link(opp_dev, opp_table);
> +       else
> +               opp_list_debug_create_dir(opp_dev, opp_table);
>  }
>
>  static void opp_migrate_dentry(struct opp_device *opp_dev,
> @@ -252,10 +203,6 @@ static int __init opp_debug_init(void)
>  {
>         /* Create /sys/kernel/debug/opp directory */
>         rootdir = debugfs_create_dir("opp", NULL);
> -       if (!rootdir) {
> -               pr_err("%s: Failed to create root directory\n", __func__);
> -               return -ENOMEM;
> -       }
>
>         return 0;
>  }
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index e24d81497375..810a85b9a66d 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -236,18 +236,17 @@ static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
>
>  #ifdef CONFIG_DEBUG_FS
>  void opp_debug_remove_one(struct dev_pm_opp *opp);
> -int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table);
> -int opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table);
> +void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table);
> +void opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table);
>  void opp_debug_unregister(struct opp_device *opp_dev, struct opp_table *opp_table);
>  #else
>  static inline void opp_debug_remove_one(struct dev_pm_opp *opp) {}
>
> -static inline int opp_debug_create_one(struct dev_pm_opp *opp,
> -                                      struct opp_table *opp_table)
> -{ return 0; }
> -static inline int opp_debug_register(struct opp_device *opp_dev,
> -                                    struct opp_table *opp_table)
> -{ return 0; }
> +static inline void opp_debug_create_one(struct dev_pm_opp *opp,
> +                                       struct opp_table *opp_table) { }
> +
> +static inline void opp_debug_register(struct opp_device *opp_dev,
> +                                     struct opp_table *opp_table) { }
>
>  static inline void opp_debug_unregister(struct opp_device *opp_dev,
>                                         struct opp_table *opp_table)
> --
> 2.20.1
>
