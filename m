From: andrew-sh.cheng <andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/3] cpufreq: mediatek: add mt8183 cpufreq support
Date: Mon, 11 Feb 2019 21:19:29 +0800
Message-ID: <1549891169.12454.2.camel@mtksdaap41>
References: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1548743704-16821-2-git-send-email-andrew-sh.cheng@mediatek.com>
 <20190129101348.7oxqerszhcopanzr@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190129101348.7oxqerszhcopanzr@vireshk-i7>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, fan.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2019-01-29 at 15:43 +0530, Viresh Kumar wrote:
> On 29-01-19, 14:35, Andrew-sh Cheng wrote:
> > From: "Andrew-sh.Cheng" <andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > 
> > For new mediatek chip mt8183,
> > cci and little cluster share the same buck,
> > so need to modify the attribute of regulator from exclusive to optional
> > 
> > Intermediate clock is not always enabled by ccf in different projects,
> > so cpufreq should always enable it by itself.
> > 
> > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> >  drivers/cpufreq/mediatek-cpufreq.c   | 7 ++++++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index b1c5468..5a1c588 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -117,6 +117,7 @@
> >  	{ .compatible = "mediatek,mt817x", },
> >  	{ .compatible = "mediatek,mt8173", },
> >  	{ .compatible = "mediatek,mt8176", },
> > +	{ .compatible = "mediatek,mt8183", },
> >  
> >  	{ .compatible = "nvidia,tegra124", },
> >  
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> > index eb8920d..e956248 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -355,7 +355,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
> >  		goto out_free_resources;
> >  	}
> >  
> > -	proc_reg = regulator_get_exclusive(cpu_dev, "proc");
> > +	proc_reg = regulator_get_optional(cpu_dev, "proc");
> >  	if (IS_ERR(proc_reg)) {
> >  		if (PTR_ERR(proc_reg) == -EPROBE_DEFER)
> >  			pr_warn("proc regulator for cpu%d not ready, retry.\n",
> > @@ -385,6 +385,9 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
> >  		goto out_free_resources;
> >  	}
> >  
> > +	ret = clk_prepare_enable(inter_clk);
> > +	if (ret)
> > +		goto out_free_resources;
> 
> Add a blank line here please.
> 
> Also out_free_resources isn't enough here and you need to free OPP table as
> well.
I will modify these in next patch.
> 
> 
> >  	/* Search a safe voltage for intermediate frequency. */
> >  	rate = clk_get_rate(inter_clk);
> >  	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
> > @@ -412,6 +415,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
> >  
> >  out_free_opp_table:
> >  	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
> > +	clk_disable_unprepare(inter_clk);
> 
> Clock was enabled after adding the table, and so it must be disabled before
> removing the table. Just the opposite sequence.
I will modify this in next patch.
> 
> >  
> >  out_free_resources:
> >  	if (!IS_ERR(proc_reg))
> > @@ -551,6 +555,7 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
> >  	{ .compatible = "mediatek,mt817x", },
> >  	{ .compatible = "mediatek,mt8173", },
> >  	{ .compatible = "mediatek,mt8176", },
> > +	{ .compatible = "mediatek,mt8183", },
> >  
> >  	{ }
> >  };
> > -- 
> > 1.8.1.1.dirty
> 
