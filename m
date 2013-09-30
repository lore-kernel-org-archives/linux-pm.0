From: amit daniel kachhap <amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/6] thermal: exynos: Replace SOC_ARCH_EXYNOS with SOC_ARCH_EXYNOS5250
Date: Mon, 30 Sep 2013 17:32:50 +0530
Message-ID: <CADGdYn7DMAWxrEYfkkAMSJZGRhGr6gBrypx_bmGPW9LKrLxvVw@mail.gmail.com>
References: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
	<1380010102-25817-5-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380010102-25817-5-git-send-email-l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonghwa Lee <jonghwa3.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lukasz Majewski <l.majewski-AM3owJQeAb5mR6Xm/wNWPw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Myungjoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 24, 2013 at 1:38 PM, Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> The TMU data definition is now separated to Exynos4412 and Exynos5250.
>
> Now SOC_ARCH_EXYNOS only refers to Exynos5250. Hence the name
> SOC_ARCH_EXYNOS has been changed to SOC_ARCH_EXYNOS5250.
>
> Signed-off-by: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Changes looks fine.
Reviewed-by: Amit Daniel Kachhap<amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Thanks,
Amit
> ---
>  drivers/thermal/samsung/exynos_tmu.c      |    4 ++--
>  drivers/thermal/samsung/exynos_tmu.h      |    2 +-
>  drivers/thermal/samsung/exynos_tmu_data.c |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 21b89e4..037cd46 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -632,9 +632,9 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> -       if (pdata->type == SOC_ARCH_EXYNOS ||
> -           pdata->type == SOC_ARCH_EXYNOS4210 ||
> +       if (pdata->type == SOC_ARCH_EXYNOS4210 ||
>             pdata->type == SOC_ARCH_EXYNOS4412 ||
> +           pdata->type == SOC_ARCH_EXYNOS5250 ||
>             pdata->type == SOC_ARCH_EXYNOS5440)
>                 data->soc = pdata->type;
>         else {
> diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
> index db37df0..b42ece4 100644
> --- a/drivers/thermal/samsung/exynos_tmu.h
> +++ b/drivers/thermal/samsung/exynos_tmu.h
> @@ -42,7 +42,7 @@ enum calibration_mode {
>  enum soc_type {
>         SOC_ARCH_EXYNOS4210 = 1,
>         SOC_ARCH_EXYNOS4412,
> -       SOC_ARCH_EXYNOS,
> +       SOC_ARCH_EXYNOS5250,
>         SOC_ARCH_EXYNOS5440,
>  };
>
> diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
> index bd08093..188223f 100644
> --- a/drivers/thermal/samsung/exynos_tmu_data.c
> +++ b/drivers/thermal/samsung/exynos_tmu_data.c
> @@ -183,7 +183,7 @@ struct exynos_tmu_init_data const exynos4412_default_tmu_data = {
>  struct exynos_tmu_init_data const exynos5250_default_tmu_data = {
>         .tmu_data = {
>                 { EXYNOS4412_TMU_DATA,
> -               .type = SOC_ARCH_EXYNOS,
> +               .type = SOC_ARCH_EXYNOS5250,
>                 },
>         },
>         .tmu_count = 1,
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
