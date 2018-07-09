From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 6/6] PM / Domains: Stop deferring probe at the end of initcall
Date: Tue, 10 Jul 2018 00:49:03 +0200
Message-ID: <CAPDyKFoN1=16dGKmkFp6Khgs5zx+BguOs3qOcm+rAZw=b38JVg@mail.gmail.com>
References: <20180709154153.15742-1-robh@kernel.org> <20180709154153.15742-7-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709154153.15742-7-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexander Graf <agraf@suse.de>, Bjorn Andersson <bjorn.andersson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, boot-architecture@lists.linaro.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 9 July 2018 at 17:41, Rob Herring <robh@kernel.org> wrote:
> All PM domain drivers must be built-in (at least those using DT), so
> there is no point deferring probe after initcalls are done. Continuing
> to defer probe may prevent booting successfully even if managing PM
> domains is not required. This can happen if the user failed to enable
> the driver or if power-domains are added to a platform's DT, but there
> is not yet a driver (e.g. a new DTB with an old kernel).
>
> Call the driver core function driver_deferred_probe_check_init_done()
> instead of just returning -EPROBE_DEFER to stop deferring probe when
> initcalls are done.
>
> Acked-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v4:
>  - Add Rafael's ack
>
> v3:
>   - Update to new function name
>
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 4925af5c4cf0..8c12213875c6 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2253,7 +2253,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
>                 mutex_unlock(&gpd_list_lock);
>                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>                         __func__, PTR_ERR(pd));
> -               return -EPROBE_DEFER;
> +               return driver_deferred_probe_check_state(dev);
>         }

This isn't the only error path where -EPROBE_DEFER may be returned
during attach in genpd.

Have a look at the callers of __genpd_dev_pm_attach() and also have a
second look inside __genpd_dev_pm_attach() itself. And in Rafael's
tree.

>
>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> --
> 2.17.1

Besides the above, I am fine with the approach as such.

Kind regards
Uffe
