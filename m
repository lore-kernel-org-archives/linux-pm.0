From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v8 3/5] clk: samsung: exynos5433: Add support for
 runtime PM
Date: Fri, 11 Aug 2017 08:34:35 +0200
Message-ID: <42f58f9d-9408-c648-6333-09e8cc7709f9@samsung.com>
References: <1502274907-11931-1-git-send-email-m.szyprowski@samsung.com>
        <CGME20170809103514eucas1p1d09fbd4d6b9954b24fb6280c7d9eaa02@eucas1p1.samsung.com>
        <1502274907-11931-4-git-send-email-m.szyprowski@samsung.com>
        <150239077548.5192.17536583927926528432@resonance>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34483 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdHKGem (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2017 02:34:42 -0400
In-reply-to: <150239077548.5192.17536583927926528432@resonance>
Content-language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Michael,

On 2017-08-10 20:46, Michael Turquette wrote:
> Quoting Marek Szyprowski (2017-08-09 03:35:05)
>> Add runtime pm support for all clock controller units (CMU), which belong
>> to power domains and require special handling during on/off operations.
>> Typically special values has to be written to MUX registers to change
>> internal clocks parents to OSC clock before turning power off. During such
>> operation all clocks, which enter CMU has to be enabled to let MUX to
>> stabilize. Also for each CMU there is one special parent clock, which has
>> to be enabled all the time when any access to CMU registers is being done.
>>
>> This patch solves most of the mysterious external abort and freeze issues
>> caused by a lack of proper parent CMU clock enabled or incorrect turn off
>> procedure.
> I would have preferred two patches here. First to platform_driver-ify
> the samsung clk driver and the second to add the pm_runtime bits.
>
>> +static int exynos5433_cmu_suspend(struct device *dev)
>> +{
>> +       struct exynos5433_cmu_data *data = dev_get_drvdata(dev);
>> +       int i;
>> +
>> +       samsung_clk_save(data->ctx.reg_base, data->clk_save,
>> +                        data->nr_clk_save);
>> +
>> +       for (i = 0; i < data->nr_pclks; i++)
>> +               clk_prepare_enable(data->pclks[i]);
>> +
>> +       /* for suspend some registers have to be set to certain values */
>> +       samsung_clk_restore(data->ctx.reg_base, data->clk_suspend,
>> +                           data->nr_clk_suspend);
>> +
>> +       for (i = 0; i < data->nr_pclks; i++)
>> +               clk_disable_unprepare(data->pclks[i]);
>> +
>> +       clk_disable_unprepare(data->clk);
>> +
>> +       return 0;
>> +}
>> +
>> +static int exynos5433_cmu_resume(struct device *dev)
>> +{
>> +       struct exynos5433_cmu_data *data = dev_get_drvdata(dev);
>> +       int i;
>> +
>> +       clk_prepare_enable(data->clk);
>> +
>> +       for (i = 0; i < data->nr_pclks; i++)
>> +               clk_prepare_enable(data->pclks[i]);
>> +
>> +       samsung_clk_restore(data->ctx.reg_base, data->clk_save,
>> +                           data->nr_clk_save);
> Will the restored clk hardware always match the software bookkeeping in
> the clk framework?

Yes, that's why we store all registers in suspend.

> Is it necessary to do a tree walk and recalc rates after restoring these
> registers?

Nope, no recalc is needed. During suspend, the software logical state in clk
framework might not match the hardware in a few places: some provider's
internal muxes are reconfigured to lowest possible source (external
oscillator), because otherwise the hardware will lock the turning power
domain off. It is also a bit hard to say about provider's state when the
power domain is off, because the registers cannot be accessed at all (any
access will result external abort exception). However after resume, all
the mentioned muxes are restored to the values they had before the suspend,
so the hw state matches again the state in clock framework.

>> +
>> +       for (i = 0; i < data->nr_pclks; i++)
>> +               clk_disable_unprepare(data->pclks[i]);
>> +
>> +       return 0;
>> +}
>> +
>> +static int __init exynos5433_cmu_probe(struct platform_device *pdev)
>> +{
>> +       const struct samsung_cmu_info *info;
>> +       struct exynos5433_cmu_data *data;
>> +       struct samsung_clk_provider *ctx;
>> +       struct device *dev = &pdev->dev;
>> +       struct resource *res;
>> +       void __iomem *reg_base;
>> +       int i;
>> +
>> +       info = of_device_get_match_data(dev);
>> +
>> +       data = devm_kzalloc(dev, sizeof(*data) +
>> +                           sizeof(*data->ctx.clk_data.hws) * info->nr_clk_ids,
>> +                           GFP_KERNEL);
>> +       if (!data)
>> +               return -ENOMEM;
>> +       ctx = &data->ctx;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       reg_base = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(reg_base)) {
>> +               dev_err(dev, "failed to map registers\n");
>> +               return PTR_ERR(reg_base);
>> +       }
>> +
>> +       for (i = 0; i < info->nr_clk_ids; ++i)
>> +               ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
>> +
>> +       ctx->clk_data.num = info->nr_clk_ids;
>> +       ctx->reg_base = reg_base;
>> +       ctx->dev = dev;
>> +       spin_lock_init(&ctx->lock);
>> +
>> +       data->clk_save = samsung_clk_alloc_reg_dump(info->clk_regs,
>> +                                                   info->nr_clk_regs);
>> +       data->nr_clk_save = info->nr_clk_regs;
>> +       data->clk_suspend = info->suspend_regs;
>> +       data->nr_clk_suspend = info->nr_suspend_regs;
>> +       data->nr_pclks = of_count_phandle_with_args(dev->of_node, "clocks",
>> +                                                   "#clock-cells");
>> +       if (data->nr_pclks > 0) {
>> +               data->pclks = devm_kcalloc(dev, sizeof(struct clk *),
>> +                                          data->nr_pclks, GFP_KERNEL);
>> +
>> +               for (i = 0; i < data->nr_pclks; i++) {
>> +                       struct clk *clk = of_clk_get(dev->of_node, i);
>> +
>> +                       if (IS_ERR(clk))
>> +                               return PTR_ERR(clk);
>> +                       data->pclks[i] = clk;
>> +               }
>> +       }
>> +
>> +       if (info->clk_name)
>> +               data->clk = clk_get(dev, info->clk_name);
>> +       clk_prepare_enable(data->clk);
> What's going on here with this weird clk_prepare_enable? It looks like
> it is never balanced with a disable_unprepare?

Well, in theory that disable_unprepare() has to be done in provider's remove
callback. But there is no exynos5433_cmu_remove function, because this 
driver
is so critical in the system, that it is marked with 
.suppress_bind_attrs and
hotplug/unplug is forbidden.

CLK_OF_DECLARE() initialized clocks also doesn't have any remove method.

Keeping this special parent clock enabled all the time is needed to make any
access to the given clock provider as well as even putting it into suspend.
Currently those clocks are marked with IS_CRITICAL flag in the parent
provider, but those flags might be removed once this patch is applied.

>> +
>> +       platform_set_drvdata(pdev, data);
>> +
>> +       /*
>> +        * Enable runtime PM here to allow the clock core using runtime PM
>> +        * for the registered clocks. Additionally, we increase the runtime
>> +        * PM usage count before registering the clocks, to prevent the
>> +        * clock core from runtime suspending the device.
>> +        */
>> +       pm_runtime_get_noresume(dev);
>> +       pm_runtime_set_active(dev);
>> +       pm_runtime_enable(dev);
> Hmm, I do wonder if this sort of initialization can be made generic for
> all other clk drivers that will use this. Thanksfully it is very few
> functions to call.

IMHO this can be only judged after some time, when more drivers will use 
this
feature.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
