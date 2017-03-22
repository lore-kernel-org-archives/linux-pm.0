From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v5 3/4] clk: samsung: exynos5433: Add runtime PM support
Date: Wed, 22 Mar 2017 09:26:09 +0100
Message-ID: <68edccfb-c86d-3412-82f4-2a5183f4a16c@samsung.com>
References: <CGME20170125115329eucas1p1f42bbb54d5973b6192e964dc8b3a8081@eucas1p1.samsung.com>
 <1485345194-3196-1-git-send-email-m.szyprowski@samsung.com>
 <1485345194-3196-4-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFotSo5qcJPt9w99Rf3i_kvQnBZE36iBbfDfuBkiKhsoTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <CAPDyKFotSo5qcJPt9w99Rf3i_kvQnBZE36iBbfDfuBkiKhsoTw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On 2017-03-13 14:31, Ulf Hansson wrote:
> On 25 January 2017 at 12:53, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> Add runtime pm support for all clock controller units (CMU), which belongs
>> to power domains and require special handling during on/off operations.
>> Typically special values has to be written to MUX registers to change
>> internal clocks parents to OSC clock before turning power off. During such
>> operation all clocks, which enters CMU has to be enabled to let MUX to
>> stabilize. Also for each CMU there is one special parent clock, which has
>> to be enabled all the time when any access to CMU registers is done.
>>
>> This patch solves most of the mysterious external abort and freeze issues
>> caused by a lack of proper parent CMU clock enabled or incorrect turn off
>> procedure.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---

Thanks for your review!

> [...]
>> --- a/drivers/clk/samsung/clk-exynos5433.c
>> +++ b/drivers/clk/samsung/clk-exynos5433.c
>> @@ -9,9 +9,14 @@
>>    * Common Clock Framework support for Exynos5443 SoC.
>>    */
>>
>> +#include <linux/clk.h>
>>   #include <linux/clk-provider.h>
>>   #include <linux/of.h>
>>   #include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/slab.h>
>>
>>   #include <dt-bindings/clock/exynos5433.h>
>>
> [...]
>
>> +struct exynos5433_cmu_data {
>> +       struct samsung_clk_provider ctx;
>> +
>> +       struct samsung_clk_reg_dump *clk_save;
>> +       unsigned int nr_clk_save;
>> +       const struct samsung_clk_reg_dump *clk_suspend;
>> +       unsigned int nr_clk_suspend;
>> +
>> +       struct clk *clk;
>> +       struct clk **pclks;
>> +       int nr_pclks;
>> +};
>> +
>> +static int exynos5433_cmu_suspend(struct device *dev)
>> +{
>> +       struct exynos5433_cmu_data *data = dev_get_drvdata(dev);
>> +       int i;
>> +
>> +       samsung_clk_save(data->ctx.reg_base, data->clk_save,
>> +                        data->nr_clk_save);
>> +
>> +       for (i = 0; i < data->nr_pclks; i++)
>> +               clk_enable(data->pclks[i]);
>> +
>> +       samsung_clk_restore(data->ctx.reg_base, data->clk_suspend,
>> +                           data->nr_clk_suspend);
>> +
>> +       for (i = 0; i < data->nr_pclks; i++)
>> +               clk_disable(data->pclks[i]);
>> +
>> +       clk_disable(data->clk);
>> +
>> +       return 0;
>> +}
>> +
>> +static int exynos5433_cmu_resume(struct device *dev)
>> +{
>> +       struct exynos5433_cmu_data *data = dev_get_drvdata(dev);
>> +       int i;
>> +
>> +       clk_enable(data->clk);
>> +
>> +       for (i = 0; i < data->nr_pclks; i++)
>> +               clk_enable(data->pclks[i]);
>> +
>> +       samsung_clk_restore(data->ctx.reg_base, data->clk_save,
>> +                           data->nr_clk_save);
>> +
>> +       for (i = 0; i < data->nr_pclks; i++)
>> +               clk_disable(data->pclks[i]);
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
>> +       struct clk **clk_table;
>> +       int i;
>> +
>> +       info = of_device_get_match_data(dev);
>> +
>> +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +       if (!data)
>> +               return -ENOMEM;
>> +       ctx = &data->ctx;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       reg_base = devm_ioremap_resource(dev, res);
>> +       if (!reg_base) {
>> +               dev_err(dev, "failed to map registers\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       clk_table = devm_kcalloc(dev, info->nr_clk_ids, sizeof(struct clk *),
>> +                                GFP_KERNEL);
>> +       if (!clk_table)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < info->nr_clk_ids; ++i)
>> +               clk_table[i] = ERR_PTR(-ENOENT);
>> +
>> +       ctx->clk_data.clks = clk_table;
>> +       ctx->clk_data.clk_num = info->nr_clk_ids;
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
>> +       /*
>> +        * Prepare all parent clocks here to avoid potential deadlock caused
>> +        * by global clock "prepare lock" grabbed by runtime pm callbacks
>> +        * from pm workers.
>> +        */
> I don't understand why this potentially could cause a deadlock. Can
> you please elaborate.

This deadlock was caused by using pm_runtime_put() in the clk core, but
after switching to pm_runtime_put_sync() it's gone. While tracking this
issue I also found another possible deadlock related to device_links.
I will send a separate patch for it.

> To me, I think you should be fine doing clk_prepare_enable() and
> clk_disable_unprepare() from exynos5433_cmu_suspend|resume(), but I
> may be missing something.
>
>> +       for (i = 0; i < data->nr_pclks; i++)
>> +               clk_prepare(data->pclks[i]);
>> +
>> +       if (info->clk_name)
>> +               data->clk = clk_get(dev, info->clk_name);
>> +       clk_prepare_enable(data->clk);
>> +
>> +       platform_set_drvdata(pdev, data);
>> +
>> +       /*
>> +        * Enable runtime pm here, so clock core with use runtime pm for all
>> +        * registered clocks. Additionally call pm_runtime_get_sync to ensure
>> +        * that clock core will not runtime suspend our clock controller in
>> +        * the middle of clock registration (clock core might call runtime pm
>> +        * on newly registered clocks, for example to recalculate clock rate).
>> +        */
> Instead of the rather confusing comment about the call to
> pm_runtime_get_sync(), let's instead state that we increase the
> runtime PM usage count during the clock registration, to avoid the
> clock core from runtime suspending the device.
>
> In other words, before calling pm_runtime_set_active(), add a call
> pm_runtime_get_noresume() and then remove the latter call to
> pm_runtime_get_sync().

Thanks for the hint!

>> +       pm_runtime_set_active(dev);
>> +       pm_runtime_enable(dev);
>> +       pm_runtime_get_sync(dev);
>> +
>> +       if (info->pll_clks)
>> +               samsung_clk_register_pll(ctx, info->pll_clks, info->nr_pll_clks,
>> +                                        reg_base);
>> +       if (info->mux_clks)
>> +               samsung_clk_register_mux(ctx, info->mux_clks,
>> +                                        info->nr_mux_clks);
>> +       if (info->div_clks)
>> +               samsung_clk_register_div(ctx, info->div_clks,
>> +                                        info->nr_div_clks);
>> +       if (info->gate_clks)
>> +               samsung_clk_register_gate(ctx, info->gate_clks,
>> +                                         info->nr_gate_clks);
>> +       if (info->fixed_clks)
>> +               samsung_clk_register_fixed_rate(ctx, info->fixed_clks,
>> +                                               info->nr_fixed_clks);
>> +       if (info->fixed_factor_clks)
>> +               samsung_clk_register_fixed_factor(ctx, info->fixed_factor_clks,
>> +                                                 info->nr_fixed_factor_clks);
>> +
>> +       samsung_clk_of_add_provider(dev->of_node, ctx);
>> +       pm_runtime_put(dev);
>> +
>> +       return 0;
>> +}
>>
> [...]
>
> Kind regards
> Uffe
>
>
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
