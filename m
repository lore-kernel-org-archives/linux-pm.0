From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC RESEND PATCH 3/7] soc: mediatek: add support for the performance state
Date: Thu, 03 Jan 2019 14:57:06 -0800
Message-ID: <154655622671.15366.9695869469694306752@swboyd.mtv.corp.google.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com> <1546438198-1677-4-git-send-email-henryc.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546438198-1677-4-git-send-email-henryc.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <vireshk@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Fan Chen <fan.chen@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>, James Liao <jamesjj.liao@mediatek.com>, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Henry Chen <henryc.chen@mediatek.com>
List-Id: linux-pm@vger.kernel.org

Quoting Henry Chen (2019-01-02 06:09:54)
> @@ -187,6 +190,18 @@ struct scp_soc_data {
>         bool bus_prot_reg_update;
>  };
> =20
> +BLOCKING_NOTIFIER_HEAD(scpsys_notifier_list);

static?

> +
> +int register_scpsys_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_register(&scpsys_notifier_list, nb=
);
> +}
> +
> +int unregister_scpsys_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_unregister(&scpsys_notifier_list, =
nb);
> +}

What is the notifier for?

> +
>  static int scpsys_domain_is_on(struct scp_domain *scpd)
>  {
>         struct scp *scp =3D scpd->scp;
> @@ -536,6 +551,48 @@ static void init_clks(struct platform_device *pdev, =
struct clk **clk)
>                 clk[i] =3D devm_clk_get(&pdev->dev, clk_names[i]);
>  }
> =20
> +static int mtk_pd_set_performance(struct generic_pm_domain *genpd,
> +                                 unsigned int state)
> +{
> +       int i;
> +       struct scp_domain *scpd =3D
> +               container_of(genpd, struct scp_domain, genpd);
> +       struct scp_event_data scpe;
> +       struct scp *scp =3D scpd->scp;
> +       struct genpd_onecell_data *pd_data =3D &scp->pd_data;
> +
> +       for (i =3D 0; i < pd_data->num_domains; i++) {
> +               if (genpd =3D=3D pd_data->domains[i]) {
> +                       dev_dbg(scp->dev, "%d. %s =3D %d\n",
> +                               i, genpd->name, state);
> +                       break;
> +               }
> +       }
> +
> +       scpe.event_type =3D MTK_SCPSYS_PSTATE;
> +       scpe.genpd =3D genpd;
> +       scpe.domain_id =3D i;
> +       blocking_notifier_call_chain(&scpsys_notifier_list, state, &scpe);
> +
> +       return 0;
> +}
> +
> +static unsigned int mtk_pd_get_performance(struct generic_pm_domain *gen=
pd,
> +                                          struct dev_pm_opp *opp)
> +{
> +       struct device_node *np;
> +       unsigned int state;
> +
> +       np =3D dev_pm_opp_get_of_node(opp);
> +
> +       if (of_property_read_u32(np, "mtk,level", &state))
> +               return 0;
> +
> +       of_node_put(np);

The generic API that Rajendra is adding I guess will become even more
generic by assuming some sort of property like 'opp-level' or
'performance-state' that is just some raw number.

> +
> +       return state;
> +}
> +
>  static struct scp *init_scp(struct platform_device *pdev,
>                         const struct scp_domain_data *scp_domain_data, in=
t num,
>                         const struct scp_ctrl_reg *scp_ctrl_reg,
