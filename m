From: Jonghwan Choi <jhbird.choi@samsung.com>
Subject: Re: [PATCH v9 1/6] clk: samsung: add infrastructure to register cpu
 clocksClick to teach Gmail this conversation is important.
Date: Wed, 20 Aug 2014 16:07:57 +0900
Message-ID: <000001cfbc45$7851dd30$68f59790$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:10518 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbaHTHIB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Aug 2014 03:08:01 -0400
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Thomas Abraham' <thomas.ab@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com

Hi ~

On Wed, Jul 30, 2014 at 5:07 PM, Thomas Abraham <thomas.ab@samsung.com> wrote:
> +
> +/* handler for post-rate change notification from parent clock */
> +static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
> +                       struct exynos_cpuclk *cpuclk, void __iomem *base)
> +{
> +       const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
> +       unsigned long div = 0, div_mask = DIV_MASK;
> +       unsigned long mux_reg;
> +
> +       spin_lock(cpuclk->lock);
> +
> +       /* select mout_apll as the alternate parent */
> +       mux_reg = readl(base + E4210_SRC_CPU);
> +       writel(mux_reg & ~(1 << 16), base + E4210_SRC_CPU);
> +       wait_until_mux_stable(base + E4210_STAT_CPU, 16, 1);
> +
> +       if (test_bit(CLK_CPU_NEEDS_DEBUG_ALT_DIV, &cpuclk->flags)) {
> +               /* find out the divider values to use for clock data */
> +               while ((cfg_data->prate * 1000) != ndata->new_rate) {
> +                       if (cfg_data->prate == 0)

                   missing spin_unlock(cpuclk->lock);? 
                I think that spin_unlock should be added in here..   
> +                               return -EINVAL;            
> +                       cfg_data++;
> +               }
> +
> +               div |= (cfg_data->div0 & E4210_DIV0_ATB_MASK);
> +               div_mask |= E4210_DIV0_ATB_MASK;
> +       }
> +
> +       exynos_set_safe_div(base, div, div_mask);
> +       spin_unlock(cpuclk->lock);
> +       return 0;
> +}
> +
>

Best regards,

