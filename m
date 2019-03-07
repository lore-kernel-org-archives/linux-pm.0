From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4 4/8] drivers: devfreq: add DMC driver for Exynos5422
Date: Thu, 7 Mar 2019 10:10:15 +0900
Message-ID: <4bbc0f61-952e-bcdb-4645-2644a122ac99@samsung.com>
References: <CGME20190201164720eucas1p13aac6550399d240b261a2cbe489d3dfc@eucas1p1.samsung.com>
        <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
        <1549039612-28905-5-git-send-email-l.luba@partner.samsung.com>
        <CAGTfZH0o6dHQj00vHwZBn05AT-Z_oAWHfBX0eATQ12NPmfw4fg@mail.gmail.com>
        <94e169cf-4dc2-82ec-1385-852bc7853931@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <94e169cf-4dc2-82ec-1385-852bc7853931@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, cwchoi00@gmail.com, Lukasz Luba <l.luba@partner.samsung.com>
Cc: devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Sylwester,

On 19. 3. 6. 오후 10:44, Sylwester Nawrocki wrote:
> Hi,
> 
> On 2/3/19 13:23, Chanwoo Choi wrote:
> 
>> 2019년 2월 2일 (토) 오전 2:42, Lukasz Luba <l.luba@partner.samsung.com>님이 작성:
> 
>>> +/**
>>> + * exynos5_dmc_pause_on_switching() - Controls a pause feature in DMC
>>> + * @dmc:       device which is used for changing this feature
>>> + * @set:       a boolean state passing enable/disable request
>>> + *
>>> + * There is a need of pausing DREX DMC when divider or MUX in clock tree
>>> + * changes its configuration. In such situation access to the memory is blocked
>>> + * in DMC automatically. This feature is used when clock frequency change
>>> + * request appears and touches clock tree.
>>> + */
>>> +static int exynos5_dmc_pause_on_switching(struct exynos5_dmc *dmc, bool set)
>>
>> Don't need to make it as the separate function. It is only used on
>> probe() function.
> 
> It seems fine to me to have this functionality in a separate function, 
> it's self-contained and it's now pretty well documented.
> 
>>> +{
>>> +       unsigned int val;
>>> +
>>> +       val = readl(dmc->base_clk + DMC_PAUSE_CTRL);
>>> +       if (set)
>>> +               val |= DMC_PAUSE_ENABLE;
>>> +       else
>>> +               val &= ~DMC_PAUSE_ENABLE;
>>> +       writel(val, dmc->base_clk + DMC_PAUSE_CTRL);
>>
>> The dt-binding file doesn't explain the 'reg' property for 'base_clk'.
>> You are missing.
>> When I tried to find what are the base address, it is the register map
>> of clock-controller.
>> This driver accesed the register of clock controller without any
>> functions of CCF
>> (common clock framework). It is wrong.
>>
>> If you need to get the some information of clock, must have to use the CCF.
> We talked a little about this issue with Lukasz in person and it looks
> like there are some DMC related registers in the clock controller register 
> region, I'd say those registers are better handled by the DMC driver rather
> than the clocks controller driver. Moreover, we should avoid abusing clk API
> for not strictly clocks related functionality as it appears to be above.
> It might be more appropriate to add in the dmc DT node a phandle to a regmap
> exposed by the clock-controller node. It seems there will be even no single
> register that would be shared between the DMC and the clock controller.
> 

I agree to share the regmap instance of clock controller
with syscon_regmap_lookup_by_phandle() and then add the detailed
description about this to dt-binding documentation.


And,
This patch has the another quetion about the clocks in
exynos5_dmc_init_clks(). This functions used 'clk_set_parent'
to make the hierarchy between clocks. I think it is possible to make
the relation of clocks in DT by using the 'assigned-clocks'.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
