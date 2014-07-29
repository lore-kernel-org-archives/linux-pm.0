From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v7 1/6] clk: samsung: add infrastructure to register cpu
 clocks
Date: Tue, 29 Jul 2014 11:57:24 +0200
Message-ID: <53D77004.9010701@gmail.com>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>	<1405345118-4269-2-git-send-email-thomas.ab@samsung.com>	<53CA6AC7.9020205@gmail.com> <CAJuA9ahMTE0K2E0jr1R4pv121VZv7Bkhxf8_ke4PcAUY5QiHuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJuA9ahMTE0K2E0jr1R4pv121VZv7Bkhxf8_ke4PcAUY5QiHuQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 29.07.2014 07:35, Thomas Abraham wrote:
> Hi Tomasz,
> 
> Thanks for your review comments. I have made most of the changes you
> have suggested. The suggested modifications which I did not include is
> marked below.
> 
> On Sat, Jul 19, 2014 at 6:25 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>
>>
>> Hi Thomas,
>>
>> Please see my comments inline.
>>
>> On 14.07.2014 15:38, Thomas Abraham wrote:
>>
>> [snip]
>>
>>> diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
>>> new file mode 100644
>>> index 0000000..0d62968
>>> --- /dev/null
>>> +++ b/drivers/clk/samsung/clk-cpu.c
>>> @@ -0,0 +1,576 @@
>>> +/*
>>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>>> + * Author: Thomas Abraham <thomas.ab@samsung.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * This file contains the utility functions to register the CPU clocks
>>> + * for Samsung platforms.
>>
>> I'd expect few words here or in separate comment on how the code works,
>> i.e. assumptions made, most important procedures, etc. This is a complex
>> piece of code for quite complex hardware, so proper documentation is
>> essential.
>>
>>> +*/
>>> +
>>> +#include <linux/errno.h>
>>> +#include "clk.h"
>>> +
>>> +#define E4210_SRC_CPU                0x0
>>> +#define E4210_STAT_CPU               0x200
>>> +#define E4210_DIV_CPU0               0x300
>>> +#define E4210_DIV_CPU1               0x304
>>> +#define E4210_DIV_STAT_CPU0  0x400
>>> +#define E4210_DIV_STAT_CPU1  0x404
>>> +
>>> +#define MAX_DIV                      8
>>> +#define DIV_MASK             7
>>> +#define DIV_MASK_ALL         0xffffffff
>>> +#define MUX_MASK             7
>>> +
>>> +#define E4210_DIV0_RATIO0_MASK       0x7
>>> +#define E4210_DIV1_HPM_MASK  ((0x7 << 4) | (0x7 << 0))
>>
>> This mask contains two fields, doesn't it? I'd say it would be better
>> for readability if you split it.
>>
>>> +#define E4210_MUX_HPM_MASK   (1 << 20)
>>> +#define E4210_DIV0_ATB_SHIFT 16
>>> +#define E4210_DIV0_ATB_MASK  (DIV_MASK << E4210_DIV0_ATB_SHIFT)
>>> +
>>> +#define E4210_CPU_DIV0(apll, pclk_dbg, atb, periph, corem1, corem0)  \
>>> +             (((apll) << 24) | ((pclk_dbg) << 20) | ((atb) << 16) |  \
>>> +             ((periph) << 12) | ((corem1) << 8) | ((corem0) <<  4))
>>> +#define E4210_CPU_DIV1(hpm, copy)                                    \
>>> +             (((hpm) << 4) | ((copy) << 0))
>>> +
>>> +#define E5250_CPU_DIV0(apll, pclk_dbg, atb, periph, acp, cpud)               \
>>> +             (((apll << 24) | (pclk_dbg << 20) | (atb << 16) |       \
>>> +              (periph << 12) | (acp << 8) | (cpud << 4)))
>>> +#define E5250_CPU_DIV1(hpm, copy)                                    \
>>> +             (((hpm) << 4) | (copy))
>>> +
>>> +#define E5420_EGL_DIV0(apll, pclk_dbg, atb, cpud)                    \
>>> +             (((apll << 24) | (pclk_dbg << 20) | (atb << 16) |       \
>>> +              (cpud << 4)))
>>> +#define E5420_KFC_DIV(kpll, pclk, aclk)                                      \
>>> +             (((kpll << 24) | (pclk << 20) | (aclk << 4)))
>>
>> Again, used macro arguments should always be surrounded with parentheses.
>>
>>> +
>>> +enum cpuclk_type {
>>> +     EXYNOS4210,
>>> +     EXYNOS5250,
>>> +     EXYNOS5420,
>>> +};
>>> +
>>> +/**
>>> + * struct exynos4210_cpuclk_data: config data to setup cpu clocks.
>>
>> It seems like this could be used for all Exynos SoCs, so probably should
>> be called exynos_cpuclk_data.
>>
>>> + * @prate: frequency of the primary parent clock (in KHz).
>>> + * @div0: value to be programmed in the div_cpu0 register.
>>> + * @div1: value to be programmed in the div_cpu1 register.
>>> + *
>>> + * This structure holds the divider configuration data for dividers in the CPU
>>> + * clock domain. The parent frequency at which these divider values are valid is
>>> + * specified in @prate. The @prate is the frequency of the primary parent clock.
>>> + * For CPU clock domains that do not have a DIV1 register, the @div1 member
>>> + * is optional.
>>> + */
>>> +struct exynos4210_cpuclk_data {
>>> +     unsigned long   prate;
>>> +     unsigned int    div0;
>>> +     unsigned int    div1;
>>> +};
>>> +
>>> +/**
>>> + * struct exynos_cpuclk: information about clock supplied to a CPU core.
>>> + * @hw:      handle between CCF and CPU clock.
>>> + * @alt_parent: alternate parent clock to use when switching the speed
>>> + *   of the primary parent clock.
>>> + * @ctrl_base:       base address of the clock controller.
>>> + * @offset: offset from the ctrl_base address where the CPU clock div/mux
>>> + *   registers can be accessed.
>>> + * @lock: cpu clock domain register access lock.
>>> + * @type: type of the CPU clock.
>>> + * @data: optional data which the actual instantiation of this clock
>>> + *   can use.
>>> + * @clk_nb: clock notifier registered for changes in clock speed of the
>>> + *   primary parent clock.
>>> + * @pre_rate_cb: callback function to handle PRE_RATE_CHANGE notification
>>> + *   of the primary parent clock.
>>> + * @post_rate_cb: callback function to handle POST_RATE_CHANGE notification
>>> + *   of the primary parent clock.
>>> + *
>>> + * This structure holds information required for programming the cpu clock for
>>> + * various clock speeds.
>>
>> nit: s/cpu/CPU/
>>
>>> + */
>>> +struct exynos_cpuclk {
>>> +     struct clk_hw           hw;
>>> +     struct clk              *alt_parent;
>>> +     void __iomem            *ctrl_base;
>>> +     unsigned long           offset;
>>> +     spinlock_t              *lock;
>>> +     enum cpuclk_type        type;
>>> +     const void              *data;
>>
>> The code always expects this to be const struct exynos4210_cpuclk_data.
>> Why not make this field so?
>>
>> Also this is not some plain data, but an array of operating points, so
>> probably a name like "rates" would be better.
>>
>>> +     struct notifier_block   clk_nb;
>>> +     int                     (*pre_rate_cb)(struct clk_notifier_data *,
>>> +                                     struct exynos_cpuclk *,
>>> +                                     void __iomem *base);
>>> +     int                     (*post_rate_cb)(struct clk_notifier_data *,
>>> +                                     struct exynos_cpuclk *,
>>> +                                     void __iomem *base);
>>
>> All the Exynos SoCs supported by this patch seem to be using exactly the
>> same notifiers. We don't know what changes in further SoCs, so there is
>> no guarantee that having these as pointer here will give us any
>> benefits. I'd recommend just getting rid of this indirection for now. If
>> it turns out to be needed, it will be trivial to add it back.
>>
>>> +};
>>> +
>>> +#define to_exynos_cpuclk_hw(hw) container_of(hw, struct exynos_cpuclk, hw)
>>> +#define to_exynos_cpuclk_nb(nb) container_of(nb, struct exynos_cpuclk, clk_nb)
>>
>> Please make these static inlines for type safety.
>>
>>> +
>>> +/**
>>> + * struct exynos_cpuclk_soc_data: soc specific data for cpu clocks.
>>> + * @ops: clock operations to be used for this clock.
>>> + * @offset: optional offset from base of clock controller register base, to
>>> + *   be used when accessing clock controller registers related to the
>>> + *   CPU clock.
>>> + * @data: SoC specific data for cpuclk configuration (optional).
>>
>> How is this optional? Can this code work without a list of operating points?
>>
>>> + * @data_size: size of the data contained in @data member.
>>
>> Both fields could be probably named "rates" and "num_rates", with the
>> meaning of the latter changed to mean the number of entries, not size in
>> bytes.
>>
>>> + * @type: type of the CPU clock.
>>> + * @pre_rate_cb: callback function to handle PRE_RATE_CHANGE notification
>>> + *   of the primary parent clock.
>>> + * @post_rate_cb: callback function to handle POST_RATE_CHANGE notification
>>> + *   of the primary parent clock.
>>> + *
>>> + * This structure provides SoC specific data for CPU clocks. Based on
>>> + * the compatible value of the clock controller node, the value of the
>>> + * fields in this structure can be populated.
>>> + */
>>> +struct exynos_cpuclk_soc_data {
>>> +     const struct clk_ops    *ops;
>>> +     unsigned int            offset;
>>> +     const void              *data;
>>
>> Same comments as for the data field above.
>>
>>> +     const unsigned int      data_size;
>>
>> If the same struct is always used it would be clearer to
>>
>>> +     enum cpuclk_type        type;
>>> +     int                     (*pre_rate_cb)(struct clk_notifier_data *,
>>> +                                     struct exynos_cpuclk *,
>>> +                                     void __iomem *base);
>>> +     int                     (*post_rate_cb)(struct clk_notifier_data *,
>>> +                                     struct exynos_cpuclk *,
>>> +                                     void __iomem *base);
>>
>> Same comment as above.
>>
>>> +};
>>
>> It looks like instead of duplicating most of the fields of this struct
>> in exynos_cpuclk struct the latter could simply have a pointer to an
>> instance of the former.
>>
>>> +
>>> +/*
>>> + * Helper function to wait until divider(s) have stabilized after the divider
>>> + * value has changed.
>>> + */
>>
>> How about a kernel doc like comments for functions as well? (same
>> comment for remaining functions)
> 
> Since most of these functions are static and very simple, I have not
> added kernel-doc like comments.

What I mean is that you already added comments for those functions, so
why they couldn't be in kerneldoc format as in other drivers?

Anyway, this doesn't have any functional meaning, so it might be changed
in further patch, since you already posted next version.

Best regards,
Tomasz
