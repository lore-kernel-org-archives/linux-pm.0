From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [RFC PATCH 3/7] soc: mediatek: add support for the performance
 state
Date: Thu, 3 Jan 2019 09:48:27 +0800
Message-ID: <CANMq1KCNSRv36L7mFNDEwFEdHm+q8cYz7GmfQZJQSGboe36vKQ@mail.gmail.com>
References: <1546436644-19234-1-git-send-email-henryc.chen@mediatek.com>
 <1546436644-19234-4-git-send-email-henryc.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1546436644-19234-4-git-send-email-henryc.chen@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Henry Chen <henryc.chen@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>, Weiyi Lu <weiyi.lu@mediatek.com>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>, lkml <linux-kernel@vger.kernel.org>, Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 2, 2019 at 10:01 PM Henry Chen <henryc.chen@mediatek.com> wrote:
>
> Support power domain performance state, add header file for scp event.
>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 60 +++++++++++++++++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-scpsys.h | 22 ++++++++++++++
>  2 files changed, 82 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-scpsys.h
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 58d84fe..90102ae 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -11,7 +11,9 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/pm_opp.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
>  #include <linux/soc/mediatek/infracfg.h>
>  #include <linux/soc/mediatek/scpsys-ext.h>
>
> @@ -22,6 +24,7 @@
>  #include <dt-bindings/power/mt7623a-power.h>
>  #include <dt-bindings/power/mt8173-power.h>
>  #include <dt-bindings/power/mt8183-power.h>
> +#include "mtk-scpsys.h"
>
>  #define MTK_POLL_DELAY_US   10
>  #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> @@ -187,6 +190,18 @@ struct scp_soc_data {
>         bool bus_prot_reg_update;
>  };
>
> +BLOCKING_NOTIFIER_HEAD(scpsys_notifier_list);
> +
> +int register_scpsys_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_register(&scpsys_notifier_list, nb);
> +}
> +
> +int unregister_scpsys_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_unregister(&scpsys_notifier_list, nb);
> +}
> +
>  static int scpsys_domain_is_on(struct scp_domain *scpd)
>  {
>         struct scp *scp = scpd->scp;
> @@ -536,6 +551,48 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
>                 clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
>  }
>
> +static int mtk_pd_set_performance(struct generic_pm_domain *genpd,
> +                                 unsigned int state)
> +{
> +       int i;
> +       struct scp_domain *scpd =
> +               container_of(genpd, struct scp_domain, genpd);

nit: This (just) fits in 80 chars.

> +       struct scp_event_data scpe;
> +       struct scp *scp = scpd->scp;
> +       struct genpd_onecell_data *pd_data = &scp->pd_data;
> +
> +       for (i = 0; i < pd_data->num_domains; i++) {
> +               if (genpd == pd_data->domains[i]) {
> +                       dev_dbg(scp->dev, "%d. %s = %d\n",
> +                               i, genpd->name, state);
> +                       break;
> +               }
> +       }

Do we need a sanity check here, if i == pd_data->num_domains?

> +
> +       scpe.event_type = MTK_SCPSYS_PSTATE;
> +       scpe.genpd = genpd;
> +       scpe.domain_id = i;
> +       blocking_notifier_call_chain(&scpsys_notifier_list, state, &scpe);
> +
> +       return 0;
> +}
> +
> +static unsigned int mtk_pd_get_performance(struct generic_pm_domain *genpd,
> +                                          struct dev_pm_opp *opp)
> +{
> +       struct device_node *np;
> +       unsigned int state;
> +
> +       np = dev_pm_opp_get_of_node(opp);
> +
> +       if (of_property_read_u32(np, "mtk,level", &state))
> +               return 0;
> +
> +       of_node_put(np);
> +
> +       return state;
> +}
> +
>  static struct scp *init_scp(struct platform_device *pdev,
>                         const struct scp_domain_data *scp_domain_data, int num,
>                         const struct scp_ctrl_reg *scp_ctrl_reg,
> @@ -659,6 +716,9 @@ static struct scp *init_scp(struct platform_device *pdev,
>                 genpd->power_on = scpsys_power_on;
>                 if (MTK_SCPD_CAPS(scpd, MTK_SCPD_ACTIVE_WAKEUP))
>                         genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
> +
> +               genpd->set_performance_state = mtk_pd_set_performance;
> +               genpd->opp_to_performance_state = mtk_pd_get_performance;
>         }
>
>         return scp;
> diff --git a/drivers/soc/mediatek/mtk-scpsys.h b/drivers/soc/mediatek/mtk-scpsys.h
> new file mode 100644
> index 0000000..c1e8325
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-scpsys.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2018 MediaTek Inc.
> + */
> +
> +#ifndef __MTK_SCPSYS_H__
> +#define __MTK_SCPSYS_H__
> +
> +struct scp_event_data {
> +       int event_type;
> +       int domain_id;
> +       struct generic_pm_domain *genpd;
> +};
> +
> +enum scp_event_type {
> +       MTK_SCPSYS_PSTATE,
> +};
> +
> +int register_scpsys_notifier(struct notifier_block *nb);
> +int unregister_scpsys_notifier(struct notifier_block *nb);
> +
> +#endif /* __MTK_SCPSYS_H__ */
> --
> 1.9.1
>
