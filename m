From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/2] soc: imx: gpc: Disable 6sl display power gating
 for ERR006287
Date: Wed, 11 Jul 2018 14:19:48 +0200
Message-ID: <CAPDyKFp6MGXGsa1ToDm86mnxsj1nYqb0pA2ySN242YK3Epp5Fg@mail.gmail.com>
References: <cover.1531310547.git.leonard.crestez@nxp.com> <d694bc32feb1c9638485700ba53cd6e51bea495c.1531310547.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d694bc32feb1c9638485700ba53cd6e51bea495c.1531310547.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Linux PM <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

On 11 July 2018 at 14:11, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> The imx6sl chip errata document describes ERR006287 like this:
>
>> Upon resuming from power gating, the modules in the display power domain
> (eLCDIF, EPDC, PXP and SPDC) might fail to perform register reads
> correctly.
>
>> When the modules listed above are used, do not use power gating on the
> display power domain.
>
> Link: https://www.nxp.com/docs/en/errata/IMX6SLCE.pdf#page=62
>
> Handle this in the safest possible way by keeping the DISP domain
> always-on.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/soc/imx/gpc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index 526f2d02dc78..f7960f773019 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -339,30 +339,35 @@ static struct imx_pm_domain imx_gpc_domains[] = {
>  };
>
>  struct imx_gpc_dt_data {
>         int num_domains;
>         bool err009619_present;
> +       bool err006287_present;
>  };
>
>  static const struct imx_gpc_dt_data imx6q_dt_data = {
>         .num_domains = 2,
>         .err009619_present = false,
> +       .err006287_present = false,
>  };
>
>  static const struct imx_gpc_dt_data imx6qp_dt_data = {
>         .num_domains = 2,
>         .err009619_present = true,
> +       .err006287_present = false,
>  };
>
>  static const struct imx_gpc_dt_data imx6sl_dt_data = {
>         .num_domains = 3,
>         .err009619_present = false,
> +       .err006287_present = true,
>  };
>
>  static const struct imx_gpc_dt_data imx6sx_dt_data = {
>         .num_domains = 4,
>         .err009619_present = false,
> +       .err006287_present = false,
>  };
>
>  static const struct of_device_id imx_gpc_dt_ids[] = {
>         { .compatible = "fsl,imx6q-gpc", .data = &imx6q_dt_data },
>         { .compatible = "fsl,imx6qp-gpc", .data = &imx6qp_dt_data },
> @@ -467,10 +472,15 @@ static int imx_gpc_probe(struct platform_device *pdev)
>         /* Disable PU power down in normal operation if ERR009619 is present */
>         if (of_id_data->err009619_present)
>                 imx_gpc_domains[GPC_PGC_DOMAIN_PU].flags |=
>                                 PGC_DOMAIN_FLAG_NO_PD;
>
> +       /* Keep DISP always on if ERR006287 is present */
> +       if (of_id_data->err006287_present)
> +               imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].base.flags |=
> +                               GENPD_FLAG_ALWAYS_ON;
> +
>         if (!pgc_node) {
>                 ret = imx_gpc_old_dt_init(&pdev->dev, regmap,
>                                           of_id_data->num_domains);
>                 if (ret)
>                         return ret;
> --
> 2.17.1
>
