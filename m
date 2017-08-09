From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v7 3/4] clk: samsung: exynos5433: Add runtime PM support
Date: Wed, 9 Aug 2017 10:50:11 +0200
Message-ID: <CAJKOXPdbo6jpf_s1=SN-0mMfPhsOwuTb=tKenwZ2FDwnoceTYA@mail.gmail.com>
References: <1501839294-478-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170804093516eucas1p2267f819dad7c2e84eeca81a81d2687f2@eucas1p2.samsung.com>
 <1501839294-478-4-git-send-email-m.szyprowski@samsung.com>
 <20170808161119.GC2646@kozik-book> <de027e15-0cac-c1b7-c98b-23369b9cec60@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <de027e15-0cac-c1b7-c98b-23369b9cec60@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 9, 2017 at 10:19 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi Krzysztof,
>
>
> On 2017-08-08 18:11, Krzysztof Kozlowski wrote:
>>
>> On Fri, Aug 04, 2017 at 11:34:53AM +0200, Marek Szyprowski wrote:
>>>
>>> Add runtime pm support for all clock controller units (CMU), which
>>> belongs
>>
>> s/belongs/belong/
>>
>>> to power domains and require special handling during on/off operations.
>>> Typically special values has to be written to MUX registers to change
>>> internal clocks parents to OSC clock before turning power off. During
>>> such
>>> operation all clocks, which enters CMU has to be enabled to let MUX to
>>
>> s/enters/enter/
>>
>> Beside that, how about unifying the title with previous mail ("Add
>> support for runtime PM")?
>>
>>> stabilize. Also for each CMU there is one special parent clock, which has
>>> to be enabled all the time when any access to CMU registers is done.
>>>
>>> This patch solves most of the mysterious external abort and freeze issues
>>> caused by a lack of proper parent CMU clock enabled or incorrect turn off
>>> procedure.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>   .../devicetree/bindings/clock/exynos5433-clock.txt |  16 +
>>>   drivers/clk/samsung/clk-exynos5433.c               | 409
>>> ++++++++++++++++-----
>>>   drivers/clk/samsung/clk.h                          |   6 +
>>>   3 files changed, 346 insertions(+), 85 deletions(-)
>>>
>> Looks okay for me, few minor nits below and:
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>>
>>> diff --git a/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
>>> b/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
>>> index 1dc80f8811fe..5c7dd12e667a 100644
>>> --- a/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
>>> +++ b/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
>>> @@ -168,6 +168,11 @@ Required Properties:
>>>                 - aclk_cam1_400
>>>                 - aclk_cam1_552
>>>   +Optional properties:
>>> +  - power-domains: a phandle to respective power domain node as
>>> described by
>>> +       generic PM domain bindings (see power/power_domain.txt for more
>>> +       information).
>>> +
>>>   Each clock is assigned an identifier and client nodes can use this
>>> identifier
>>>   to specify the clock which they consume.
>>>   @@ -270,6 +275,7 @@ Example 2: Examples of clock controller nodes are
>>> listed below.
>>>                 clocks = <&xxti>,
>>>                        <&cmu_top CLK_ACLK_G2D_266>,
>>>                        <&cmu_top CLK_ACLK_G2D_400>;
>>> +               power-domains = <&pd_g2d>;
>>>         };
>>>         cmu_disp: clock-controller@13b90000 {
>>> @@ -295,6 +301,7 @@ Example 2: Examples of clock controller nodes are
>>> listed below.
>>>                        <&cmu_mif CLK_SCLK_DECON_ECLK_DISP>,
>>>                        <&cmu_mif CLK_SCLK_DECON_TV_VCLK_DISP>,
>>>                        <&cmu_mif CLK_ACLK_DISP_333>;
>>> +               power-domains = <&pd_disp>;
>>>         };
>>>         cmu_aud: clock-controller@114c0000 {
>>> @@ -304,6 +311,7 @@ Example 2: Examples of clock controller nodes are
>>> listed below.
>>>                 clock-names = "oscclk", "fout_aud_pll";
>>>                 clocks = <&xxti>, <&cmu_top CLK_FOUT_AUD_PLL>;
>>> +               power-domains = <&pd_aud>;
>>>         };
>>>         cmu_bus0: clock-controller@13600000 {
>>> @@ -340,6 +348,7 @@ Example 2: Examples of clock controller nodes are
>>> listed below.
>>>                 clock-names = "oscclk", "aclk_g3d_400";
>>>                 clocks = <&xxti>, <&cmu_top CLK_ACLK_G3D_400>;
>>> +               power-domains = <&pd_g3d>;
>>>         };
>>>         cmu_gscl: clock-controller@13cf0000 {
>>> @@ -353,6 +362,7 @@ Example 2: Examples of clock controller nodes are
>>> listed below.
>>>                 clocks = <&xxti>,
>>>                         <&cmu_top CLK_ACLK_GSCL_111>,
>>>                         <&cmu_top CLK_ACLK_GSCL_333>;
>>> +               power-domains = <&pd_gscl>;
>>>         };
>>>         cmu_apollo: clock-controller@11900000 {
>>> @@ -384,6 +394,7 @@ Example 2: Examples of clock controller nodes are
>>> listed below.
>>>                 clocks = <&xxti>,
>>>                        <&cmu_top CLK_SCLK_JPEG_MSCL>,
>>>                        <&cmu_top CLK_ACLK_MSCL_400>;
>>> +               power-domains = <&pd_mscl>;
>>>         };
>>>         cmu_mfc: clock-controller@15280000 {
>>> @@ -393,6 +404,7 @@ Example 2: Examples of clock controller nodes are
>>> listed below.
>>>                 clock-names = "oscclk", "aclk_mfc_400";
>>>                 clocks = <&xxti>, <&cmu_top CLK_ACLK_MFC_400>;
>>> +               power-domains = <&pd_mfc>;
>>>         };
>>>         cmu_hevc: clock-controller@14f80000 {
>>> @@ -402,6 +414,7 @@ Example 2: Examples of clock controller nodes are
>>> listed below.
>>>                 clock-names = "oscclk", "aclk_hevc_400";
>>>                 clocks = <&xxti>, <&cmu_top CLK_ACLK_HEVC_400>;
>>> +               power-domains = <&pd_hevc>;
>>>         };
>>>         cmu_isp: clock-controller@146d0000 {
>>> @@ -415,6 +428,7 @@ Example 2: Examples of clock controller nodes are
>>> listed below.
>>>                 clocks = <&xxti>,
>>>                        <&cmu_top CLK_ACLK_ISP_DIS_400>,
>>>                        <&cmu_top CLK_ACLK_ISP_400>;
>>> +               power-domains = <&pd_isp>;
>>>         };
>>>         cmu_cam0: clock-controller@120d0000 {
>>> @@ -430,6 +444,7 @@ Example 2: Examples of clock controller nodes are
>>> listed below.
>>>                        <&cmu_top CLK_ACLK_CAM0_333>,
>>>                        <&cmu_top CLK_ACLK_CAM0_400>,
>>>                        <&cmu_top CLK_ACLK_CAM0_552>;
>>> +               power-domains = <&pd_cam0>;
>>>         };
>>>         cmu_cam1: clock-controller@145d0000 {
>>> @@ -451,6 +466,7 @@ Example 2: Examples of clock controller nodes are
>>> listed below.
>>>                        <&cmu_top CLK_ACLK_CAM1_333>,
>>>                        <&cmu_top CLK_ACLK_CAM1_400>,
>>>                        <&cmu_top CLK_ACLK_CAM1_552>;
>>> +               power-domains = <&pd_cam1>;
>>>         };
>>>     Example 3: UART controller node that consumes the clock generated by
>>> the clock
>>> diff --git a/drivers/clk/samsung/clk-exynos5433.c
>>> b/drivers/clk/samsung/clk-exynos5433.c
>>> index 11343a597093..7ae9bccb1192 100644
>>> --- a/drivers/clk/samsung/clk-exynos5433.c
>>> +++ b/drivers/clk/samsung/clk-exynos5433.c
>>> @@ -9,9 +9,14 @@
>>>    * Common Clock Framework support for Exynos5433 SoC.
>>>    */
>>>   +#include <linux/clk.h>
>>>   #include <linux/clk-provider.h>
>>>   #include <linux/of.h>
>>>   #include <linux/of_address.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/slab.h>
>>
>> Why you need slab.h?
>
>
> It was needed for kzalloc, which was later converted to devm_kzalloc. Maybe
> it would make sense to include "linux/device.h" then to avoid indirect
> inclusion.

platform_device.h pulls device.h so I think this could be removed.

(...)

>>> +
>>> info->nr_fixed_factor_clks);
>>> +
>>> +       samsung_clk_of_add_provider(dev->of_node, ctx);
>>> +       pm_runtime_put_sync(dev);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static const struct of_device_id exynos5433_cmu_of_match[] = {
>>
>> Since this is used only when matching devices maybe it can be also
>> marked as refdata?
>
>
> It is indirectly used by of_device_get_match_data() in probe(). I'm not sure
> if this would be fine for refdata.

Yes, right, it shouldn't be refdata then. Thanks for explanation.

Best regards,
Krzysztof
