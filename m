From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v2 1/4] cpufreq: mediatek: add mt8183 cpufreq support
Date: Sat, 30 Mar 2019 17:06:58 -0700
Message-ID: <CANMq1KBX1NTfv1OYV3aq4B8hfrOnSEJRX1g6JOYzMws1ZNQgjg@mail.gmail.com>
References: <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com> <1553841972-19737-2-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553841972-19737-2-git-send-email-andrew-sh.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Fan Chen <fan.chen@mediatek.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 28, 2019 at 11:46 PM Andrew-sh.Cheng
<andrew-sh.cheng@mediatek.com> wrote:
>
> For new mediatek chip mt8183,
> cci and little cluster share the same buck,
> so need to modify the attribute of regulator from exclusive to optional
>
> Intermediate clock is not always enabled by ccf in different projects,
> so cpufreq should always enable it by itself.

One comment, otherwise the changes look good. However, I feel that
this patch should be split in 3:
 1. Change to regulator_get_optional
 2. Enable inter_clk
 3. Add support for 8183

> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>  drivers/cpufreq/mediatek-cpufreq.c   | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 47729a2..53ea52b 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -117,6 +117,7 @@
>         { .compatible = "mediatek,mt817x", },
>         { .compatible = "mediatek,mt8173", },
>         { .compatible = "mediatek,mt8176", },
> +       { .compatible = "mediatek,mt8183", },
>
>         { .compatible = "nvidia,tegra124", },
>         { .compatible = "nvidia,tegra210", },
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 48e9829..7cd01d3 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -346,7 +346,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>                 goto out_free_resources;
>         }
>
> -       proc_reg = regulator_get_exclusive(cpu_dev, "proc");
> +       proc_reg = regulator_get_optional(cpu_dev, "proc");
>         if (IS_ERR(proc_reg)) {
>                 if (PTR_ERR(proc_reg) == -EPROBE_DEFER)
>                         pr_warn("proc regulator for cpu%d not ready, retry.\n",
> @@ -376,13 +376,17 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>                 goto out_free_resources;
>         }
>
> +       ret = clk_prepare_enable(inter_clk);

Should you disable the clock in mtk_cpu_dvfs_info_release?

> +       if (ret)
> +               goto out_free_opp_table;
> +
>         /* Search a safe voltage for intermediate frequency. */
>         rate = clk_get_rate(inter_clk);
>         opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
>         if (IS_ERR(opp)) {
>                 pr_err("failed to get intermediate opp for cpu%d\n", cpu);
>                 ret = PTR_ERR(opp);
> -               goto out_free_opp_table;
> +               goto out_disable_clock;
>         }
>         info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
>         dev_pm_opp_put(opp);
> @@ -401,6 +405,9 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>
>         return 0;
>
> +out_disable_clock:
> +       clk_disable_unprepare(inter_clk);
> +
>  out_free_opp_table:
>         dev_pm_opp_of_cpumask_remove_table(&info->cpus);
>
> @@ -543,6 +550,7 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
>         { .compatible = "mediatek,mt817x", },
>         { .compatible = "mediatek,mt8173", },
>         { .compatible = "mediatek,mt8176", },
> +       { .compatible = "mediatek,mt8183", },
>
>         { }
>  };
> --
> 1.8.1.1.dirty
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
