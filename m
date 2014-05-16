From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Implement free_opp_table function
Date: Fri, 16 May 2014 15:36:36 +0530
Message-ID: <CAKohponY6Nn5kYGyps2SLm5uBbH1JWuJBpzzVD=QOc=oM7crAg@mail.gmail.com>
References: <1400231366-1221-1-git-send-email-inderpal.s@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400231366-1221-1-git-send-email-inderpal.s@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Inderpal Singh <inderpal.s@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 16 May 2014 14:39, Inderpal Singh <inderpal.s@samsung.com> wrote:
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> +void dev_pm_opp_free_opp_table(struct device *dev)
> +{
> +       struct device_opp *dev_opp = NULL;
> +       struct dev_pm_opp *opp;
> +
> +       /* Hold our list modification lock here */
> +       mutex_lock(&dev_opp_list_lock);
> +
> +       /* Check for existing list for 'dev' */
> +       dev_opp = find_device_opp(dev);
> +       if (IS_ERR(dev_opp)) {
> +               mutex_unlock(&dev_opp_list_lock);
> +               return;
> +       }
> +
> +       while (!list_empty(&dev_opp->opp_list)) {
> +               opp = list_entry_rcu(dev_opp->opp_list.next,
> +                                       struct dev_pm_opp, node);

list_for_each_entry_rcu ?

> +               list_del_rcu(&opp->node);
> +               kfree_rcu(opp, head);
> +       }
> +
> +       list_del_rcu(&dev_opp->node);
> +       mutex_unlock(&dev_opp_list_lock);
> +       synchronize_rcu();
> +       kfree(dev_opp);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_free_opp_table);
>  #endif
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 0330217..3c29620 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -50,6 +50,8 @@ int dev_pm_opp_enable(struct device *dev, unsigned long freq);
>  int dev_pm_opp_disable(struct device *dev, unsigned long freq);
>
>  struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev);
> +
> +void dev_pm_opp_free_opp_table(struct device *dev);
>  #else
>  static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
>  {
> @@ -105,6 +107,10 @@ static inline struct srcu_notifier_head *dev_pm_opp_get_notifier(
>  {
>         return ERR_PTR(-EINVAL);
>  }
> +
> +void dev_pm_opp_free_opp_table(struct device *dev)
> +{
> +}
>  #endif         /* CONFIG_PM_OPP */
>
>  #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)

Otherwise looks fine.
