From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] soc: imx: gpc: Disable 6sl display power gating
 for ERR006287
Date: Tue, 10 Jul 2018 00:33:21 +0200
Message-ID: <CAPDyKFoELWSiZ4cfOByziPQzqW7Tx3m29qKu9uCKPHO1gXO4YA@mail.gmail.com>
References: <cover.1531138446.git.leonard.crestez@nxp.com> <a00303c5672b332d1d363b78926903187169b8cc.1531138446.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a00303c5672b332d1d363b78926903187169b8cc.1531138446.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Linux PM <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

On 9 July 2018 at 14:23, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> The imx6sl chip errata document describes ERR006287 like this:
>
> """
> Upon resuming from power gating, the modules in the display power domain
> (eLCDIF, EPDC, PXP and SPDC) might fail to perform register reads
> correctly.
>
> When the modules listed above are used, do not use power gating on the
> display power domain.
> """
>
> Link: https://www.nxp.com/docs/en/errata/IMX6SLCE.pdf#page=62
>
> Handle this in linux in the same way as imx6qp ERR009619: make the DISP
> domain return -EBUSY on power_off.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/soc/imx/gpc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index 526f2d02dc78..6b726dada560 100644
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
> +       /* Disable DISP power down in normal operation if ERR006287 is present */
> +       if (of_id_data->err006287_present)
> +               imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].flags |=
> +                               PGC_DOMAIN_FLAG_NO_PD;
> +

This looks like a use-case for an always powered on PM domain?

If that's the case, GENPD_FLAG_ALWAYS_ON does the trick, but more
efficient as it enables genpd to take a few shortcuts when trying to
power of a PM domain.

>         if (!pgc_node) {
>                 ret = imx_gpc_old_dt_init(&pdev->dev, regmap,
>                                           of_id_data->num_domains);
>                 if (ret)
>                         return ret;
> --
> 2.17.1
>

Kind regards
Uffe
