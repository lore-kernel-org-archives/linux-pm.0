From: Henry Chen <henryc.chen@mediatek.com>
Subject: Re: [RFC RESEND PATCH 3/7] soc: mediatek: add support for the
 performance state
Date: Mon, 7 Jan 2019 19:06:34 +0800
Message-ID: <1546859194.6818.129.camel@mtksdaap41>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
         <1546438198-1677-4-git-send-email-henryc.chen@mediatek.com>
         <154655622671.15366.9695869469694306752@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154655622671.15366.9695869469694306752@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Fan Chen <fan.chen@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>, James Liao <jamesjj.liao@mediatek.com>, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2019-01-03 at 14:57 -0800, Stephen Boyd wrote:
> Quoting Henry Chen (2019-01-02 06:09:54)
> > @@ -187,6 +190,18 @@ struct scp_soc_data {
> >         bool bus_prot_reg_update;
> >  };
> >  
> > +BLOCKING_NOTIFIER_HEAD(scpsys_notifier_list);
> 
> static?
OK
> 
> > +
> > +int register_scpsys_notifier(struct notifier_block *nb)
> > +{
> > +       return blocking_notifier_chain_register(&scpsys_notifier_list, nb);
> > +}
> > +
> > +int unregister_scpsys_notifier(struct notifier_block *nb)
> > +{
> > +       return blocking_notifier_chain_unregister(&scpsys_notifier_list, nb);
> > +}
> 
> What is the notifier for?
It used to notifier the DVFSRC driver that performance stat was changed.
> 
> > +
> >  static int scpsys_domain_is_on(struct scp_domain *scpd)
> >  {
> >         struct scp *scp = scpd->scp;
> > @@ -536,6 +551,48 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
> >                 clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
> >  }
> >  
> > +static int mtk_pd_set_performance(struct generic_pm_domain *genpd,
> > +                                 unsigned int state)
> > +{
> > +       int i;
> > +       struct scp_domain *scpd =
> > +               container_of(genpd, struct scp_domain, genpd);
> > +       struct scp_event_data scpe;
> > +       struct scp *scp = scpd->scp;
> > +       struct genpd_onecell_data *pd_data = &scp->pd_data;
> > +
> > +       for (i = 0; i < pd_data->num_domains; i++) {
> > +               if (genpd == pd_data->domains[i]) {
> > +                       dev_dbg(scp->dev, "%d. %s = %d\n",
> > +                               i, genpd->name, state);
> > +                       break;
> > +               }
> > +       }
> > +
> > +       scpe.event_type = MTK_SCPSYS_PSTATE;
> > +       scpe.genpd = genpd;
> > +       scpe.domain_id = i;
> > +       blocking_notifier_call_chain(&scpsys_notifier_list, state, &scpe);
> > +
> > +       return 0;
> > +}
> > +
> > +static unsigned int mtk_pd_get_performance(struct generic_pm_domain *genpd,
> > +                                          struct dev_pm_opp *opp)
> > +{
> > +       struct device_node *np;
> > +       unsigned int state;
> > +
> > +       np = dev_pm_opp_get_of_node(opp);
> > +
> > +       if (of_property_read_u32(np, "mtk,level", &state))
> > +               return 0;
> > +
> > +       of_node_put(np);
> 
> The generic API that Rajendra is adding I guess will become even more
> generic by assuming some sort of property like 'opp-level' or
> 'performance-state' that is just some raw number.
ok, I will follow the new property from Rajendra.

> > +
> > +       return state;
> > +}
> > +
> >  static struct scp *init_scp(struct platform_device *pdev,
> >                         const struct scp_domain_data *scp_domain_data, int num,
> >                         const struct scp_ctrl_reg *scp_ctrl_reg,
