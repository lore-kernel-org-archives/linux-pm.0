From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v7 1/6] clk: samsung: add infrastructure to register cpu clocks
Date: Tue, 29 Jul 2014 11:05:32 +0530
Message-ID: <CAJuA9ahMTE0K2E0jr1R4pv121VZv7Bkhxf8_ke4PcAUY5QiHuQ@mail.gmail.com>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>
	<1405345118-4269-2-git-send-email-thomas.ab@samsung.com>
	<53CA6AC7.9020205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:63774 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbaG2Ffe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jul 2014 01:35:34 -0400
In-Reply-To: <53CA6AC7.9020205@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Tomasz,

Thanks for your review comments. I have made most of the changes you
have suggested. The suggested modifications which I did not include is
marked below.

On Sat, Jul 19, 2014 at 6:25 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>
>
> Hi Thomas,
>
> Please see my comments inline.
>
> On 14.07.2014 15:38, Thomas Abraham wrote:
>
> [snip]
>
>> diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
>> new file mode 100644
>> index 0000000..0d62968
>> --- /dev/null
>> +++ b/drivers/clk/samsung/clk-cpu.c
>> @@ -0,0 +1,576 @@
>> +/*
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + * Author: Thomas Abraham <thomas.ab@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This file contains the utility functions to register the CPU clocks
>> + * for Samsung platforms.
>
> I'd expect few words here or in separate comment on how the code works,
> i.e. assumptions made, most important procedures, etc. This is a complex
> piece of code for quite complex hardware, so proper documentation is
> essential.
>
>> +*/
>> +
>> +#include <linux/errno.h>
>> +#include "clk.h"
>> +
>> +#define E4210_SRC_CPU                0x0
>> +#define E4210_STAT_CPU               0x200
>> +#define E4210_DIV_CPU0               0x300
>> +#define E4210_DIV_CPU1               0x304
>> +#define E4210_DIV_STAT_CPU0  0x400
>> +#define E4210_DIV_STAT_CPU1  0x404
>> +
>> +#define MAX_DIV                      8
>> +#define DIV_MASK             7
>> +#define DIV_MASK_ALL         0xffffffff
>> +#define MUX_MASK             7
>> +
>> +#define E4210_DIV0_RATIO0_MASK       0x7
>> +#define E4210_DIV1_HPM_MASK  ((0x7 << 4) | (0x7 << 0))
>
> This mask contains two fields, doesn't it? I'd say it would be better
> for readability if you split it.
>
>> +#define E4210_MUX_HPM_MASK   (1 << 20)
>> +#define E4210_DIV0_ATB_SHIFT 16
>> +#define E4210_DIV0_ATB_MASK  (DIV_MASK << E4210_DIV0_ATB_SHIFT)
>> +
>> +#define E4210_CPU_DIV0(apll, pclk_dbg, atb, periph, corem1, corem0)  \
>> +             (((apll) << 24) | ((pclk_dbg) << 20) | ((atb) << 16) |  \
>> +             ((periph) << 12) | ((corem1) << 8) | ((corem0) <<  4))
>> +#define E4210_CPU_DIV1(hpm, copy)                                    \
>> +             (((hpm) << 4) | ((copy) << 0))
>> +
>> +#define E5250_CPU_DIV0(apll, pclk_dbg, atb, periph, acp, cpud)               \
>> +             (((apll << 24) | (pclk_dbg << 20) | (atb << 16) |       \
>> +              (periph << 12) | (acp << 8) | (cpud << 4)))
>> +#define E5250_CPU_DIV1(hpm, copy)                                    \
>> +             (((hpm) << 4) | (copy))
>> +
>> +#define E5420_EGL_DIV0(apll, pclk_dbg, atb, cpud)                    \
>> +             (((apll << 24) | (pclk_dbg << 20) | (atb << 16) |       \
>> +              (cpud << 4)))
>> +#define E5420_KFC_DIV(kpll, pclk, aclk)                                      \
>> +             (((kpll << 24) | (pclk << 20) | (aclk << 4)))
>
> Again, used macro arguments should always be surrounded with parentheses.
>
>> +
>> +enum cpuclk_type {
>> +     EXYNOS4210,
>> +     EXYNOS5250,
>> +     EXYNOS5420,
>> +};
>> +
>> +/**
>> + * struct exynos4210_cpuclk_data: config data to setup cpu clocks.
>
> It seems like this could be used for all Exynos SoCs, so probably should
> be called exynos_cpuclk_data.
>
>> + * @prate: frequency of the primary parent clock (in KHz).
>> + * @div0: value to be programmed in the div_cpu0 register.
>> + * @div1: value to be programmed in the div_cpu1 register.
>> + *
>> + * This structure holds the divider configuration data for dividers in the CPU
>> + * clock domain. The parent frequency at which these divider values are valid is
>> + * specified in @prate. The @prate is the frequency of the primary parent clock.
>> + * For CPU clock domains that do not have a DIV1 register, the @div1 member
>> + * is optional.
>> + */
>> +struct exynos4210_cpuclk_data {
>> +     unsigned long   prate;
>> +     unsigned int    div0;
>> +     unsigned int    div1;
>> +};
>> +
>> +/**
>> + * struct exynos_cpuclk: information about clock supplied to a CPU core.
>> + * @hw:      handle between CCF and CPU clock.
>> + * @alt_parent: alternate parent clock to use when switching the speed
>> + *   of the primary parent clock.
>> + * @ctrl_base:       base address of the clock controller.
>> + * @offset: offset from the ctrl_base address where the CPU clock div/mux
>> + *   registers can be accessed.
>> + * @lock: cpu clock domain register access lock.
>> + * @type: type of the CPU clock.
>> + * @data: optional data which the actual instantiation of this clock
>> + *   can use.
>> + * @clk_nb: clock notifier registered for changes in clock speed of the
>> + *   primary parent clock.
>> + * @pre_rate_cb: callback function to handle PRE_RATE_CHANGE notification
>> + *   of the primary parent clock.
>> + * @post_rate_cb: callback function to handle POST_RATE_CHANGE notification
>> + *   of the primary parent clock.
>> + *
>> + * This structure holds information required for programming the cpu clock for
>> + * various clock speeds.
>
> nit: s/cpu/CPU/
>
>> + */
>> +struct exynos_cpuclk {
>> +     struct clk_hw           hw;
>> +     struct clk              *alt_parent;
>> +     void __iomem            *ctrl_base;
>> +     unsigned long           offset;
>> +     spinlock_t              *lock;
>> +     enum cpuclk_type        type;
>> +     const void              *data;
>
> The code always expects this to be const struct exynos4210_cpuclk_data.
> Why not make this field so?
>
> Also this is not some plain data, but an array of operating points, so
> probably a name like "rates" would be better.
>
>> +     struct notifier_block   clk_nb;
>> +     int                     (*pre_rate_cb)(struct clk_notifier_data *,
>> +                                     struct exynos_cpuclk *,
>> +                                     void __iomem *base);
>> +     int                     (*post_rate_cb)(struct clk_notifier_data *,
>> +                                     struct exynos_cpuclk *,
>> +                                     void __iomem *base);
>
> All the Exynos SoCs supported by this patch seem to be using exactly the
> same notifiers. We don't know what changes in further SoCs, so there is
> no guarantee that having these as pointer here will give us any
> benefits. I'd recommend just getting rid of this indirection for now. If
> it turns out to be needed, it will be trivial to add it back.
>
>> +};
>> +
>> +#define to_exynos_cpuclk_hw(hw) container_of(hw, struct exynos_cpuclk, hw)
>> +#define to_exynos_cpuclk_nb(nb) container_of(nb, struct exynos_cpuclk, clk_nb)
>
> Please make these static inlines for type safety.
>
>> +
>> +/**
>> + * struct exynos_cpuclk_soc_data: soc specific data for cpu clocks.
>> + * @ops: clock operations to be used for this clock.
>> + * @offset: optional offset from base of clock controller register base, to
>> + *   be used when accessing clock controller registers related to the
>> + *   CPU clock.
>> + * @data: SoC specific data for cpuclk configuration (optional).
>
> How is this optional? Can this code work without a list of operating points?
>
>> + * @data_size: size of the data contained in @data member.
>
> Both fields could be probably named "rates" and "num_rates", with the
> meaning of the latter changed to mean the number of entries, not size in
> bytes.
>
>> + * @type: type of the CPU clock.
>> + * @pre_rate_cb: callback function to handle PRE_RATE_CHANGE notification
>> + *   of the primary parent clock.
>> + * @post_rate_cb: callback function to handle POST_RATE_CHANGE notification
>> + *   of the primary parent clock.
>> + *
>> + * This structure provides SoC specific data for CPU clocks. Based on
>> + * the compatible value of the clock controller node, the value of the
>> + * fields in this structure can be populated.
>> + */
>> +struct exynos_cpuclk_soc_data {
>> +     const struct clk_ops    *ops;
>> +     unsigned int            offset;
>> +     const void              *data;
>
> Same comments as for the data field above.
>
>> +     const unsigned int      data_size;
>
> If the same struct is always used it would be clearer to
>
>> +     enum cpuclk_type        type;
>> +     int                     (*pre_rate_cb)(struct clk_notifier_data *,
>> +                                     struct exynos_cpuclk *,
>> +                                     void __iomem *base);
>> +     int                     (*post_rate_cb)(struct clk_notifier_data *,
>> +                                     struct exynos_cpuclk *,
>> +                                     void __iomem *base);
>
> Same comment as above.
>
>> +};
>
> It looks like instead of duplicating most of the fields of this struct
> in exynos_cpuclk struct the latter could simply have a pointer to an
> instance of the former.
>
>> +
>> +/*
>> + * Helper function to wait until divider(s) have stabilized after the divider
>> + * value has changed.
>> + */
>
> How about a kernel doc like comments for functions as well? (same
> comment for remaining functions)

Since most of these functions are static and very simple, I have not
added kernel-doc like comments.

>
>> +static void wait_until_divider_stable(void __iomem *div_reg, unsigned long mask)
>> +{
>> +     unsigned long timeout = jiffies + msecs_to_jiffies(10);
>> +
>> +     do {
>> +             if (!(readl(div_reg) & mask))
>> +                     return;
>> +     } while (time_before(jiffies, timeout));
>> +
>> +     pr_err("%s: timeout in divider stablization\n", __func__);
>> +}
>
> [snip]
>
>> +/* common recalc rate callback useable for all types of CPU clocks */
>> +static unsigned long exynos_cpuclk_recalc_rate(struct clk_hw *hw,
>> +                     unsigned long parent_rate)
>> +{
>
> This function is so trivial that it might be reasonable to explain why
> nothing else is needed, e.g.
>
>         /*
>          * The CPU clock output (armclk) rate is the same as its parent
>          * rate. Although there exist certain dividers inside the CPU
>          * clock block that could be used to divide the parent clock,
>          * the driver does not make use of them currently, except during
>          * frequency transitions.
>          */
>
>> +     return parent_rate;
>> +}
>> +
>> +static const struct clk_ops exynos_cpuclk_clk_ops = {
>> +     .recalc_rate = exynos_cpuclk_recalc_rate,
>> +     .round_rate = exynos_cpuclk_round_rate,
>> +};
>> +
>> +/*
>> + * Calculates the divider value to be set for deriving drate from prate.
>> + * Divider value is actual divider value - 1.
>> + */
>> +static unsigned long _calc_div(unsigned long prate, unsigned long drate)
>> +{
>> +     unsigned long div = DIV_ROUND_UP(prate, drate) - 1;
>> +
>> +     WARN_ON(div >= MAX_DIV);
>> +     return div;
>> +}
>
> This function seems to be used just once. Not even saying about its
> strange semantics - the name would suggest a real divider being
> returned, but it's not, it's divider minus one.
>
> So I'd suggest to completely remove this function and simply paste its
> contents instead, since it's only used once.
>
>> +
>
> [snip]
>
>> +/* helper function to register a cpu clock */
>> +static int __init exynos_cpuclk_register(struct samsung_clk_provider *ctx,
>> +             unsigned int lookup_id, const char *name, const char *parent,
>> +             const char *alt_parent, struct device_node *np,
>> +             const struct exynos_cpuclk_soc_data *soc_data)
>> +{
>> +     struct exynos_cpuclk *cpuclk;
>> +     struct clk_init_data init;
>> +     struct clk *clk;
>> +     void *data;
>> +     int ret = 0;
>> +
>> +     cpuclk = kzalloc(sizeof(*cpuclk), GFP_KERNEL);
>> +     if (!cpuclk)
>> +             return -ENOMEM;
>> +
>> +     data = kmalloc(soc_data->data_size, GFP_KERNEL);
>
> You could simply use kmemdup() here to duplicate the source array. Also
> the return value could be already saved in cpuclk->data without the need
> for a local variable.
>
>> +     if (!data) {
>> +             ret = -ENOMEM;
>> +             goto free_cpuclk;
>> +     }
>> +
>> +     init.name = name;
>> +     init.flags = CLK_SET_RATE_PARENT;
>> +     init.parent_names = &parent;
>> +     init.num_parents = 1;
>> +     init.ops = soc_data->ops;
>> +
>> +     cpuclk->hw.init = &init;
>> +     cpuclk->ctrl_base = ctx->reg_base;
>> +     cpuclk->lock = &ctx->lock;
>> +     cpuclk->offset = soc_data->offset;
>> +     cpuclk->type = soc_data->type;
>> +     cpuclk->pre_rate_cb = soc_data->pre_rate_cb;
>> +     cpuclk->post_rate_cb = soc_data->post_rate_cb;
>> +     memcpy(data, soc_data->data, soc_data->data_size);
>> +     cpuclk->data = data;
>> +
>> +     cpuclk->clk_nb.notifier_call = exynos_cpuclk_notifier_cb;
>> +     ret = clk_notifier_register(__clk_lookup(parent), &cpuclk->clk_nb);
>
> It would be a good idea to check if __clk_lookup() succeeded and error
> out otherwise.
>
>> +     if (ret) {
>> +             pr_err("%s: failed to register clock notifier for %s\n",
>> +                             __func__, name);
>> +             goto free_cpuclk_data;
>> +     }
>> +
>
> [snip]
>
>> +/*
>> + * Helper function to set the 'safe' dividers for the CPU clock. The parameters
>> + * div and mask contain the divider value and the register bit mask of the
>> + * dividers to be programmed.
>> + */
>> +static void exynos4210_set_safe_div(void __iomem *base, unsigned long div,
>> +                                     unsigned long mask)
>> +{
>> +     unsigned long div0;
>> +
>> +     div0 = readl(base + E4210_DIV_CPU0);
>> +     div0 = (div0 & ~mask) | div;
>
> There is nothing said in the comment above about the assumption that div
> has bits not indicated by mask cleared, so to be safe it might be a good
> idea to make this
>
>         div0 = (div0 & ~mask) | (div & mask);
>
> instead.
>
>> +     writel(div0, base + E4210_DIV_CPU0);
>> +     wait_until_divider_stable(base + E4210_DIV_STAT_CPU0, mask);
>> +}
>> +
>> +/* handler for pre-rate change notification from parent clock */
>> +static int exynos4210_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
>> +                     struct exynos_cpuclk *cpuclk, void __iomem *base)
>> +{
>> +     const struct exynos4210_cpuclk_data *cpuclk_data = cpuclk->data;
>> +     unsigned long alt_prate = clk_get_rate(cpuclk->alt_parent);
>> +     unsigned long alt_div = 0, alt_div_mask = DIV_MASK;
>> +     unsigned long div0, div1 = 0, mux_reg;
>> +
>> +     /* find out the divider values to use for clock data */
>> +     while ((cpuclk_data->prate * 1000) != ndata->new_rate) {
>> +             if (cpuclk_data->prate == 0)
>> +                     return -EINVAL;
>> +             cpuclk_data++;
>> +     }
>> +
>> +     /* For the selected PLL clock frequency, get the pre-defined divider
>> +      * values. If the clock for sclk_hpm is not sourced from apll, then
>> +      * the values for DIV_COPY and DIV_HPM dividers need not be set.
>> +      */
>> +     div0 = cpuclk_data->div0;
>> +     if (cpuclk->type != EXYNOS5420) {
>
> Rather than checking for Exynos5420 explicitly, it would be better to
> add a boolean "has_mux_hpm" flag to cpuclk.
>
>> +             div1 = cpuclk_data->div1;
>> +             if (readl(base + E4210_SRC_CPU) & E4210_MUX_HPM_MASK) {
>> +                     div1 = readl(base + E4210_DIV_CPU1) &
>> +                                     E4210_DIV1_HPM_MASK;
>> +                     div1 |= ((cpuclk_data->div1) & ~E4210_DIV1_HPM_MASK);
>> +             }
>> +     }
>> +
>> +     spin_lock(cpuclk->lock);
>> +
>> +     /*
>> +      * If the new and old parent clock speed is less than the clock speed
>> +      * of the alternate parent, then it should be ensured that at no point
>> +      * the armclk speed is more than the old_prate until the dividers are
>> +      * set.
>> +      */
>> +     if (alt_prate > ndata->old_rate) {
>> +             alt_div = _calc_div(alt_prate, ndata->old_rate);
>> +             if (cpuclk->type == EXYNOS4210) {
>
> Again, this could be handled by a boolean "needs_atb_alt_div" flag,
> instead of checking for Exynos4210 explicitly.
>
>> +                     /*
>> +                      * In Exynos4210, ATB clock parent is also mout_core. So
>> +                      * ATB clock also needs to be mantained at safe speed.
>> +                      */
>> +                     alt_div |= E4210_DIV0_ATB_MASK;
>> +                     alt_div_mask |= E4210_DIV0_ATB_MASK;
>> +             }
>> +             exynos4210_set_safe_div(base, alt_div, alt_div_mask);
>> +             div0 |= alt_div;
>> +     }
>> +
>> +     /* select sclk_mpll as the alternate parent */
>> +     mux_reg = readl(base + E4210_SRC_CPU);
>> +     writel(mux_reg | (1 << 16), base + E4210_SRC_CPU);
>> +     wait_until_mux_stable(base + E4210_STAT_CPU, 16, 2);
>> +
>> +     /* alternate parent is active now. set the dividers */
>> +     writel(div0, base + E4210_DIV_CPU0);
>> +     wait_until_divider_stable(base + E4210_DIV_STAT_CPU0, DIV_MASK_ALL);
>> +
>> +     if (cpuclk->type != EXYNOS5420) {
>
> This could be handled by "has_div_cpu1" boolean flag.
>
>> +             writel(div1, base + E4210_DIV_CPU1);
>> +             wait_until_divider_stable(base + E4210_DIV_STAT_CPU1,
>> +                             DIV_MASK_ALL);
>> +     }
>> +
>> +     spin_unlock(cpuclk->lock);
>> +     return 0;
>> +}
>> +
>> +/* handler for post-rate change notification from parent clock */
>> +static int exynos4210_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
>> +                     struct exynos_cpuclk *cpuclk, void __iomem *base)
>> +{
>> +     const struct exynos4210_cpuclk_data *cpuclk_data = cpuclk->data;
>> +     unsigned long div = 0, div_mask = DIV_MASK;
>> +     unsigned long mux_reg;
>> +
>> +     spin_lock(cpuclk->lock);
>> +
>> +     /* select mout_apll as the alternate parent */
>> +     mux_reg = readl(base + E4210_SRC_CPU);
>> +     writel(mux_reg & ~(1 << 16), base + E4210_SRC_CPU);
>> +     wait_until_mux_stable(base + E4210_STAT_CPU, 16, 1);
>> +
>> +     if (cpuclk->type == EXYNOS4210) {
>
> Here the "needs_atb_alt_div" flag could be used again.
>
>> +             /* find out the divider values to use for clock data */
>> +             while ((cpuclk_data->prate * 1000) != ndata->new_rate) {
>> +                     if (cpuclk_data->prate == 0)
>> +                             return -EINVAL;
>> +                     cpuclk_data++;
>> +             }
>> +
>> +             div |= (cpuclk_data->div0 & E4210_DIV0_ATB_MASK);
>> +             div_mask |= E4210_DIV0_ATB_MASK;
>> +     }
>> +
>> +     exynos4210_set_safe_div(base, div, div_mask);
>> +     spin_unlock(cpuclk->lock);
>> +     return 0;
>> +}
>> +
>> +static const struct exynos4210_cpuclk_data e4210_armclk_d[] __initconst = {
>> +     { 1200000, E4210_CPU_DIV0(7, 1, 4, 3, 7, 3), E4210_CPU_DIV1(0, 5), },
>> +     { 1000000, E4210_CPU_DIV0(7, 1, 4, 3, 7, 3), E4210_CPU_DIV1(0, 4), },
>> +     {  800000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
>> +     {  500000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
>> +     {  400000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
>> +     {  200000, E4210_CPU_DIV0(0, 1, 1, 1, 3, 1), E4210_CPU_DIV1(0, 3), },
>> +     {  0 },
>> +};
>
> [snip]
>
>> +static const struct exynos_cpuclk_soc_data e4210_clk_soc_data __initconst = {
>> +     .ops = &exynos_cpuclk_clk_ops,
>> +     .offset = 0x14200,
>> +     .data = e4210_armclk_d,
>> +     .data_size = sizeof(e4210_armclk_d),
>> +     .type = EXYNOS4210,
>> +     .pre_rate_cb = exynos4210_cpuclk_pre_rate_change,
>> +     .post_rate_cb = exynos4210_cpuclk_post_rate_change,
>> +};
>
> [snip]
>
>> +/**
>> + * exynos_register_cpu_clock: register cpu clock with ccf.
>> + * @ctx: driver context.
>> + * @cluster_id: cpu cluster number to which this clock is connected.
>> + * @lookup_id: cpuclk clock output id for the clock controller.
>> + * @name: the name of the cpu clock.
>> + * @parent: name of the parent clock for cpuclk.
>> + * @alt_parent: name of the alternate clock parent.
>> + * @np: device tree node pointer of the clock controller.
>> + */
>> +int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
>> +             unsigned int cluster_id, unsigned int lookup_id,
>> +             const char *name, const char *parent,
>> +             const char *alt_parent, struct device_node *np)
>> +{
>> +     const struct of_device_id *match;
>> +     const struct exynos_cpuclk_soc_data *data = NULL;
>> +
>> +     if (!np)
>> +             return -EINVAL;
>> +
>> +     match = of_match_node(exynos_cpuclk_ids, np);
>> +     if (!match)
>> +             return -EINVAL;
>> +
>> +     data = match->data;
>> +     data += cluster_id;
>> +     return exynos_cpuclk_register(ctx, lookup_id, name, parent,
>> +                     alt_parent, np, data);
>> +}
>
> We now have SoC-specific data hardcoded here, so (as opposed to my
> earlier comments when we did not have such) it's now reasonable to move
> such data to SoC-specific source files and then just call
> exynos_register_cpu_clock() with a pointer to such data. This would also
> eliminate the not so good idea of indexing internal data array with
> cluster_id passed as an argument from external code.
>
> Best regards,
> Tomasz


Thanks,
Thomas.


> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
