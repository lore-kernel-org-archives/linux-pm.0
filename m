From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 2/2] soc: imx: gpc: Use GENPD_FLAG_RPM_ALWAYS_ON for
 ERR009619
Date: Thu, 2 May 2019 11:20:14 +0200
Message-ID: <CAPDyKFpx8wXS4Fn8HcfZE6RvE5vOvsrp=utKvOmuaAxEWTVxXg@mail.gmail.com>
References: <cover.1556636234.git.leonard.crestez@nxp.com>
 <8f53bef00e72aa35d146210bb71ca05b8a3af141.1556636234.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <8f53bef00e72aa35d146210bb71ca05b8a3af141.1556636234.git.leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tue, 30 Apr 2019 at 17:06, Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> This allows PU domain to be turned off in suspend and save power.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/soc/imx/gpc.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index a8f1e47ce698..d9231bd3c691 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -427,14 +427,23 @@ static int imx_gpc_probe(struct platform_device *pdev)
>                 dev_err(&pdev->dev, "failed to init regmap: %d\n",
>                         ret);
>                 return ret;
>         }
>
> -       /* Disable PU power down in normal operation if ERR009619 is present */
> +       /*
> +        * Disable PU power down by runtime PM if ERR009619 is present.
> +        *
> +        * The PRE clock will be paused for several cycles when turning on the
> +        * PU domain LDO from power down state. If PRE is in use at that time,
> +        * the IPU/PRG cannot get the correct display data from the PRE.
> +        *
> +        * This is not a concern when the whole system enters suspend state, so
> +        * it's safe to power down PU in this case.
> +        */
>         if (of_id_data->err009619_present)
>                 imx_gpc_domains[GPC_PGC_DOMAIN_PU].base.flags |=
> -                               GENPD_FLAG_ALWAYS_ON;
> +                               GENPD_FLAG_RPM_ALWAYS_ON;
>
>         /* Keep DISP always on if ERR006287 is present */
>         if (of_id_data->err006287_present)
>                 imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].base.flags |=
>                                 GENPD_FLAG_ALWAYS_ON;
> --
> 2.17.1
>
