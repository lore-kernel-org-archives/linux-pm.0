From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 3/7] ARM: shmobile: R-Mobile: Enable module clocks if !CONFIG_PM_RUNTIME
Date: Thu, 4 Dec 2014 14:41:25 +0100
Message-ID: <CAPDyKFogROGA+MtQcGNfa052wPKxcs9cpT43NcpcyeGVFCwPoQ@mail.gmail.com>
References: <1417614107-5985-1-git-send-email-geert+renesas@glider.be>
	<1417614107-5985-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417614107-5985-4-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 3 December 2014 at 14:41, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org> wrote:
> If CONFIG_PM_RUNTIME is not set, the clocks must be enabled before the
> devices can be used.
>
> Currently these clocks are enabled by the !CONFIG_PM_RUNTIME version of
> pm_clk_notify, activated by the hack in drivers/sh/pm_runtime.c, but
> this will go away soon (at least for DT).
>
> On detach, disabling the clocks is already handled by pm_clk_destroy().
> On system suspend/resume, disabling/enabling clocks is already handled
> from the genpd->dev_ops.{start,stop}() callbacks.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
> v6:
>   - No changes,
> v5:
>   - No changes,
> v4:
>   - New.
> ---
>  arch/arm/mach-shmobile/pm-rmobile.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
> index 168046c355fc8368..6d912ce801aa88bd 100644
> --- a/arch/arm/mach-shmobile/pm-rmobile.c
> +++ b/arch/arm/mach-shmobile/pm-rmobile.c
> @@ -118,6 +118,14 @@ static int rmobile_pd_attach_dev(struct generic_pm_domain *domain,
>                 goto fail;
>         }
>
> +       if (!IS_ENABLED(CONFIG_PM_RUNTIME)) {

This will require a fixup later on, since using genpd will always be
done for CONFIG_PM_RUNTIME (or CONFIG_PM actually) ).

I guess you knew that already, but then you can't keep my response as
a reminder. :-)

Kind regards
Uffe

> +               error = pm_clk_resume(dev);
> +               if (error) {
> +                       dev_err(dev, "pm_clk_resume failed %d\n", error);
> +                       goto fail;
> +               }
> +       }
> +
>         return 0;
>
>  fail:
> --
> 1.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
