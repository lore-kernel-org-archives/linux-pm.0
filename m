From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: remove define_genpd_open_function() and define_genpd_debugfs_fops()
Date: Mon, 3 Dec 2018 10:12:29 +0100
Message-ID: <CAJZ5v0g6R40D-OrQeZ=wAj+epPaYacLTnCVLLHfzUrpNKUv2_w@mail.gmail.com>
References: <20181201015154.4718-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181201015154.4718-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiny.windzz@gmail.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Mark Brown <broonie@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 1, 2018 at 2:51 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> We already have the DEFINE_SHOW_ATTRIBUTE,There is no need to define such
> a macro,so remove define_genpd_open_function and define_genpd_debugfs_fops.
> Also use DEFINE_SHOW_ATTRIBUTE to simplify somecode.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

It would be good at least to split the genpd changes off into a separate patch.

The regmap and comonent changes appear to be independent of each other
too, so I would put them into separate patches either for easier
handling.

> ---
>  drivers/base/component.c              | 12 +----
>  drivers/base/power/domain.c           | 71 +++++++++------------------
>  drivers/base/regmap/regcache-rbtree.c | 12 +----
>  drivers/base/regmap/regmap-debugfs.c  | 12 +----
>  4 files changed, 27 insertions(+), 80 deletions(-)
>
> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index e8d676fad0c9..ddcea8739c12 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -85,17 +85,7 @@ static int component_devices_show(struct seq_file *s, void *data)
>         return 0;
>  }
>
> -static int component_devices_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, component_devices_show, inode->i_private);
> -}
> -
> -static const struct file_operations component_devices_fops = {
> -       .open = component_devices_open,
> -       .read = seq_read,
> -       .llseek = seq_lseek,
> -       .release = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(component_devices);
>
>  static int __init component_debug_init(void)
>  {
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 7f38a92b444a..10a61d6147d0 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2671,7 +2671,7 @@ static int genpd_summary_one(struct seq_file *s,
>         return 0;
>  }
>
> -static int genpd_summary_show(struct seq_file *s, void *data)
> +static int summary_show(struct seq_file *s, void *data)
>  {
>         struct generic_pm_domain *genpd;
>         int ret = 0;
> @@ -2694,7 +2694,7 @@ static int genpd_summary_show(struct seq_file *s, void *data)
>         return ret;
>  }
>
> -static int genpd_status_show(struct seq_file *s, void *data)
> +static int status_show(struct seq_file *s, void *data)
>  {
>         static const char * const status_lookup[] = {
>                 [GPD_STATE_ACTIVE] = "on",
> @@ -2721,7 +2721,7 @@ static int genpd_status_show(struct seq_file *s, void *data)
>         return ret;
>  }
>
> -static int genpd_sub_domains_show(struct seq_file *s, void *data)
> +static int sub_domains_show(struct seq_file *s, void *data)
>  {
>         struct generic_pm_domain *genpd = s->private;
>         struct gpd_link *link;
> @@ -2738,7 +2738,7 @@ static int genpd_sub_domains_show(struct seq_file *s, void *data)
>         return ret;
>  }
>
> -static int genpd_idle_states_show(struct seq_file *s, void *data)
> +static int idle_states_show(struct seq_file *s, void *data)
>  {
>         struct generic_pm_domain *genpd = s->private;
>         unsigned int i;
> @@ -2767,7 +2767,7 @@ static int genpd_idle_states_show(struct seq_file *s, void *data)
>         return ret;
>  }
>
> -static int genpd_active_time_show(struct seq_file *s, void *data)
> +static int active_time_show(struct seq_file *s, void *data)
>  {
>         struct generic_pm_domain *genpd = s->private;
>         ktime_t delta = 0;
> @@ -2787,7 +2787,7 @@ static int genpd_active_time_show(struct seq_file *s, void *data)
>         return ret;
>  }
>
> -static int genpd_total_idle_time_show(struct seq_file *s, void *data)
> +static int total_idle_time_show(struct seq_file *s, void *data)
>  {
>         struct generic_pm_domain *genpd = s->private;
>         ktime_t delta = 0, total = 0;
> @@ -2815,7 +2815,7 @@ static int genpd_total_idle_time_show(struct seq_file *s, void *data)
>  }
>
>
> -static int genpd_devices_show(struct seq_file *s, void *data)
> +static int devices_show(struct seq_file *s, void *data)
>  {
>         struct generic_pm_domain *genpd = s->private;
>         struct pm_domain_data *pm_data;
> @@ -2841,7 +2841,7 @@ static int genpd_devices_show(struct seq_file *s, void *data)
>         return ret;
>  }
>
> -static int genpd_perf_state_show(struct seq_file *s, void *data)
> +static int perf_state_show(struct seq_file *s, void *data)
>  {
>         struct generic_pm_domain *genpd = s->private;
>
> @@ -2854,37 +2854,14 @@ static int genpd_perf_state_show(struct seq_file *s, void *data)
>         return 0;
>  }
>
> -#define define_genpd_open_function(name) \
> -static int genpd_##name##_open(struct inode *inode, struct file *file) \
> -{ \
> -       return single_open(file, genpd_##name##_show, inode->i_private); \
> -}
> -
> -define_genpd_open_function(summary);
> -define_genpd_open_function(status);
> -define_genpd_open_function(sub_domains);
> -define_genpd_open_function(idle_states);
> -define_genpd_open_function(active_time);
> -define_genpd_open_function(total_idle_time);
> -define_genpd_open_function(devices);
> -define_genpd_open_function(perf_state);
> -
> -#define define_genpd_debugfs_fops(name) \
> -static const struct file_operations genpd_##name##_fops = { \
> -       .open = genpd_##name##_open, \
> -       .read = seq_read, \
> -       .llseek = seq_lseek, \
> -       .release = single_release, \
> -}
> -
> -define_genpd_debugfs_fops(summary);
> -define_genpd_debugfs_fops(status);
> -define_genpd_debugfs_fops(sub_domains);
> -define_genpd_debugfs_fops(idle_states);
> -define_genpd_debugfs_fops(active_time);
> -define_genpd_debugfs_fops(total_idle_time);
> -define_genpd_debugfs_fops(devices);
> -define_genpd_debugfs_fops(perf_state);
> +DEFINE_SHOW_ATTRIBUTE(summary);
> +DEFINE_SHOW_ATTRIBUTE(status);
> +DEFINE_SHOW_ATTRIBUTE(sub_domains);
> +DEFINE_SHOW_ATTRIBUTE(idle_states);
> +DEFINE_SHOW_ATTRIBUTE(active_time);
> +DEFINE_SHOW_ATTRIBUTE(total_idle_time);
> +DEFINE_SHOW_ATTRIBUTE(devices);
> +DEFINE_SHOW_ATTRIBUTE(perf_state);
>
>  static int __init genpd_debug_init(void)
>  {
> @@ -2897,7 +2874,7 @@ static int __init genpd_debug_init(void)
>                 return -ENOMEM;
>
>         d = debugfs_create_file("pm_genpd_summary", S_IRUGO,
> -                       genpd_debugfs_dir, NULL, &genpd_summary_fops);
> +                       genpd_debugfs_dir, NULL, &summary_fops);
>         if (!d)
>                 return -ENOMEM;
>
> @@ -2907,20 +2884,20 @@ static int __init genpd_debug_init(void)
>                         return -ENOMEM;
>
>                 debugfs_create_file("current_state", 0444,
> -                               d, genpd, &genpd_status_fops);
> +                               d, genpd, &status_fops);
>                 debugfs_create_file("sub_domains", 0444,
> -                               d, genpd, &genpd_sub_domains_fops);
> +                               d, genpd, &sub_domains_fops);
>                 debugfs_create_file("idle_states", 0444,
> -                               d, genpd, &genpd_idle_states_fops);
> +                               d, genpd, &idle_states_fops);
>                 debugfs_create_file("active_time", 0444,
> -                               d, genpd, &genpd_active_time_fops);
> +                               d, genpd, &active_time_fops);
>                 debugfs_create_file("total_idle_time", 0444,
> -                               d, genpd, &genpd_total_idle_time_fops);
> +                               d, genpd, &total_idle_time_fops);
>                 debugfs_create_file("devices", 0444,
> -                               d, genpd, &genpd_devices_fops);
> +                               d, genpd, &devices_fops);
>                 if (genpd->set_performance_state)
>                         debugfs_create_file("perf_state", 0444,
> -                                           d, genpd, &genpd_perf_state_fops);
> +                                           d, genpd, &perf_state_fops);
>         }
>
>         return 0;
> diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
> index b1e9aae9a5d0..2e8f0144f9ab 100644
> --- a/drivers/base/regmap/regcache-rbtree.c
> +++ b/drivers/base/regmap/regcache-rbtree.c
> @@ -177,17 +177,7 @@ static int rbtree_show(struct seq_file *s, void *ignored)
>         return 0;
>  }
>
> -static int rbtree_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, rbtree_show, inode->i_private);
> -}
> -
> -static const struct file_operations rbtree_fops = {
> -       .open           = rbtree_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(rbtree);
>
>  static void rbtree_debugfs_init(struct regmap *map)
>  {
> diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
> index 87b562e49a43..19eb454f26c3 100644
> --- a/drivers/base/regmap/regmap-debugfs.c
> +++ b/drivers/base/regmap/regmap-debugfs.c
> @@ -435,17 +435,7 @@ static int regmap_access_show(struct seq_file *s, void *ignored)
>         return 0;
>  }
>
> -static int access_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, regmap_access_show, inode->i_private);
> -}
> -
> -static const struct file_operations regmap_access_fops = {
> -       .open           = access_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(regmap_access);
>
>  static ssize_t regmap_cache_only_write_file(struct file *file,
>                                             const char __user *user_buf,
> --
> 2.17.0
>
