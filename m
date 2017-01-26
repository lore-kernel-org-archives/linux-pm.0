From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 01/13] soc: samsung: pmu: Provide global function to get
 PMU regmap
Date: Thu, 26 Jan 2017 11:22:08 +0100
Message-ID: <3ba1504d-5874-b09b-1ad8-6cda4851f113@samsung.com>
References: <CGME20170119134904eucas1p153a1d5b2ff9826c88293b6a8fe5140bc@eucas1p1.samsung.com>
 <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <1484833733-16082-2-git-send-email-m.szyprowski@samsung.com>
 <CACRpkdYyOgpAhAY=7QrXiEB2oDgs0azt_Tb80iO4vjzk1obemQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:27231 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbdAZKWW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2017 05:22:22 -0500
In-reply-to: <CACRpkdYyOgpAhAY=7QrXiEB2oDgs0azt_Tb80iO4vjzk1obemQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Linus,

On 2017-01-26 10:43, Linus Walleij wrote:
> On Thu, Jan 19, 2017 at 2:48 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>
>> PMU is something like a SoC wide service, so add a helper function to get
>> PMU regmap. This will be used by other Exynos device drivers. This way it
>> can be avoided to model this dependency in device tree (as phandles to PMU
>> node) for almost every device in the SoC.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
> But why? I could understand it as a local header in
> drivers/soc/samsung/*.h for those files.
>
> For the global kernel scope we usually look up the syscon
> regmap we need using a phandle, DT node or even
> compatible string directly from the device tree.
>
> Just
> #include <linux/mfd/syscon.h>
>
> syscon_node_to_regmap()
> syscon_regmap_lookup_by_compatible()
> syscon_regmap_lookup_by_pdevname()
> syscon_regmap_lookup_by_phandle()
>
> what is wrong with just using one of these?
>
> Introducing a special header just creates compile time problems
> with global interfaces when merging code and just litter the kernel
> for no good reason.
>
> Can you explain why this necessarily different approach is
> needed?

syscon_regmap_lookup_by_phandle() requires to have a phandle in the client
node. This has been used in v0 of this patchset and rejected as breaking
the old DT "compatibility".

syscon_regmap_lookup_by_compatible() requires to have a compatible string
hardcoded in the client driver. This might be used, but will require to have
(and maintain) a duplicated list of PMU compatibles in pin control driver.
There is a little problem with exynos4212 and exynos4412, which have same
pinctrl compatible (samsung,exynos4x12-pinctrl), but separate PMU 
compatibles
(samsung,exynos4212-pmu and samsung,exynos4412-pmu). Luckily support for
Exynos4212 has been scheduled for removal, so we can ignore this issue for
now. The problem with maintaining a duplicated list of compatibles remains.

syscon_regmap_lookup_by_pdevname() requires the provider to register regmap
first, then to hardcode the provider name in all client drivers. A bit 
similar
approach was used in v1, but the drawback was runtime probe order dependency
between PMU driver and pin control driver. I was requested to move the code
for acquiring PMU regmap to PMU driver, what in turn ended in the solution
presented in v2/v3 of this patchset, which requires least code for handling,
has no maintenance overhead, and doesn't cause any probe dependency issues.
It can be also later used for almost every driver found on the newer Exynos
SoCs, because for most of them there is a need to poke some registers in
the PMU not handled separately by any of the existing frameworks.

Various other drivers in the drivers/soc/ provide EXPORT_SYMBOL() based API,
so I don't think that this is a totally wrong approach.

> I guess I should have said this earlier, mea culpa.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

