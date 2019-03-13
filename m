From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/1] PM / Domains: Avoid a potential deadlock
Date: Wed, 13 Mar 2019 15:45:03 +0100
Message-ID: <CAMuHMdUEnzgwAqBC=vTYWnrzC5HrqC5f5gDLWJFSJRYAu+DD1g@mail.gmail.com>
References: <20190312065128.24994-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312065128.24994-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg KH <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Jiada,

CC Marek, Jon, Mike, Stephen, linux-clk, linux-renesas-soc

On Tue, Mar 12, 2019 at 7:51 AM Jiada Wang <jiada_wang@mentor.com> wrote:
> Lockdep warns that prepare_lock and genpd->mlock can cause a deadlock
> the deadlock scenario is like following:
> First thread is probing cs2000
> cs2000_probe()
>   clk_register()
>     __clk_core_init()
>       clk_prepare_lock()                            ----> acquires prepare_lock
>         cs2000_recalc_rate()
>           i2c_smbus_read_byte_data()
>             rcar_i2c_master_xfer()
>               dma_request_chan()
>                 rcar_dmac_of_xlate()
>                   rcar_dmac_alloc_chan_resources()
>                     pm_runtime_get_sync()
>                       __pm_runtime_resume()
>                         rpm_resume()
>                           rpm_callback()
>                             genpd_runtime_resume()   ----> acquires genpd->mlock
>
> Second thread is attaching any device to the same PM domain
> genpd_add_device()
>   genpd_lock()                                       ----> acquires genpd->mlock
>     cpg_mssr_attach_dev()
>       of_clk_get_from_provider()
>         __of_clk_get_from_provider()
>           __clk_create_clk()
>             clk_prepare_lock()                       ----> acquires prepare_lock
>
> Since currently no PM provider access genpd's critical section
> in .attach_dev, and .detach_dev callbacks, so there is no need to protect
> these two callbacks with genpd->mlock.
> This patch avoids a potential deadlock by moving out .attach_dev and .detach_dev
> from genpd->mlock, so that genpd->mlock won't be held when prepare_lock is acquired
> in .attach_dev and .detach_dev
>
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Thanks a lot for your perseverance!
I had tried putting each PM Domain in its own lockdep class, but that
didn't help.

Your patch fixes the lockdep warnings on my Salvator-X(S) boards.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Your solution makes sense, as the .{at,de}tach_dev() callbacks are
owned by the individual PM Domain drivers, and not by the genpd core.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

One thing I'm still wondering about: genpd_add_device() is always called
with gpd_list_lock held.
However, the same cannot be said about genpd_remove_device():
  - pm_genpd_remove_device() does not take gpd_list_lock, unlike
    pm_genpd_add_device(),
  - genpd_dev_pm_detach() does not take gpd_list_lock, while
    __genpd_dev_pm_attach() does take the lock for adding,
    but not for removing (in the error patch)?

> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1467,12 +1467,12 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>         if (IS_ERR(gpd_data))
>                 return PTR_ERR(gpd_data);
>
> -       genpd_lock(genpd);
> -
>         ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
>         if (ret)
>                 goto out;
>
> +       genpd_lock(genpd);
> +
>         dev_pm_domain_set(dev, &genpd->domain);
>
>         genpd->device_count++;
> @@ -1480,9 +1480,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>
>         list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
>
> - out:
>         genpd_unlock(genpd);
> -
> + out:
>         if (ret)
>                 genpd_free_dev_data(dev, gpd_data);
>         else
> @@ -1531,15 +1530,15 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>         genpd->device_count--;
>         genpd->max_off_time_changed = true;
>
> -       if (genpd->detach_dev)
> -               genpd->detach_dev(genpd, dev);
> -
>         dev_pm_domain_set(dev, NULL);
>
>         list_del_init(&pdd->list_node);
>
>         genpd_unlock(genpd);
>
> +       if (genpd->detach_dev)
> +               genpd->detach_dev(genpd, dev);
> +
>         genpd_free_dev_data(dev, gpd_data);
>
>         return 0;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
