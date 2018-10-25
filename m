From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 01/10] PM / Domains: Rename genpd virtual devices as virt_dev
Date: Thu, 25 Oct 2018 12:54:32 +0200
Message-ID: <CAPDyKFqb0kuZdpBeV2Uktd0gDXAg+v2p=a1vuRowj7f2zk1NOA@mail.gmail.com>
References: <cover.1540446493.git.viresh.kumar@linaro.org> <d5f993001c97895d82bb68e246f6eaafce6dc795.1540446493.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d5f993001c97895d82bb68e246f6eaafce6dc795.1540446493.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, Niklas Cassel <niklas.cassel@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 25 October 2018 at 07:52, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> There are several struct device instances that genpd core handles. The
> most common one is the consumer device structure, which is named
> (correctly) as "dev" within genpd core. The second one is the genpd's
> device structure, referenced as genpd->dev. The third one is the virtual
> device structures created by the genpd core to represent the consumer
> device for multiple power domain case, currently named as genpd_dev. The
> naming of these virtual devices isn't very clear or readable and it
> looks more like the genpd->dev.
>
> Rename the virtual device instances within the genpd core as "virt_dev".
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks, this make the code more clear!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 7f38a92b444a..fe9b0527b161 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2338,7 +2338,7 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>                                          unsigned int index)
>  {
> -       struct device *genpd_dev;
> +       struct device *virt_dev;
>         int num_domains;
>         int ret;
>
> @@ -2352,31 +2352,31 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>                 return NULL;
>
>         /* Allocate and register device on the genpd bus. */
> -       genpd_dev = kzalloc(sizeof(*genpd_dev), GFP_KERNEL);
> -       if (!genpd_dev)
> +       virt_dev = kzalloc(sizeof(*virt_dev), GFP_KERNEL);
> +       if (!virt_dev)
>                 return ERR_PTR(-ENOMEM);
>
> -       dev_set_name(genpd_dev, "genpd:%u:%s", index, dev_name(dev));
> -       genpd_dev->bus = &genpd_bus_type;
> -       genpd_dev->release = genpd_release_dev;
> +       dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
> +       virt_dev->bus = &genpd_bus_type;
> +       virt_dev->release = genpd_release_dev;
>
> -       ret = device_register(genpd_dev);
> +       ret = device_register(virt_dev);
>         if (ret) {
> -               kfree(genpd_dev);
> +               kfree(virt_dev);
>                 return ERR_PTR(ret);
>         }
>
>         /* Try to attach the device to the PM domain at the specified index. */
> -       ret = __genpd_dev_pm_attach(genpd_dev, dev->of_node, index, false);
> +       ret = __genpd_dev_pm_attach(virt_dev, dev->of_node, index, false);
>         if (ret < 1) {
> -               device_unregister(genpd_dev);
> +               device_unregister(virt_dev);
>                 return ret ? ERR_PTR(ret) : NULL;
>         }
>
> -       pm_runtime_enable(genpd_dev);
> -       genpd_queue_power_off_work(dev_to_genpd(genpd_dev));
> +       pm_runtime_enable(virt_dev);
> +       genpd_queue_power_off_work(dev_to_genpd(virt_dev));
>
> -       return genpd_dev;
> +       return virt_dev;
>  }
>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
>
> --
> 2.19.1.568.g152ad8e3369a
>
