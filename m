From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v7 01/13] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Date: Tue, 7 May 2019 18:17:45 +0900
Message-ID: <e808eb3a-9fbe-897d-ce25-cab732581391@samsung.com>
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151210eucas1p13c2a4b86a6f987ff34fbe1e2d705fbbf@eucas1p1.samsung.com>
        <1557155521-30949-2-git-send-email-l.luba@partner.samsung.com>
        <8b063f30-1a4d-3292-2e57-6e33e94d57ae@samsung.com>
        <55e89fc7-6f22-b384-adbf-40c68618bdac@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55e89fc7-6f22-b384-adbf-40c68618bdac@partner.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com, jroedel@suse.de, treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

On 19. 5. 7. 오후 5:51, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 5/7/19 9:33 AM, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> On 19. 5. 7. 오전 12:11, Lukasz Luba wrote:
>>> Define new IDs for clocks used by Dynamic Memory Controller in
>>> Exynos5422 SoC.
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>> ---
>>>   include/dt-bindings/clock/exynos5420.h | 28 ++++++++++++++++++++++------
>>>   1 file changed, 22 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
>>> index 355f469..bf50d8a 100644
>>> --- a/include/dt-bindings/clock/exynos5420.h
>>> +++ b/include/dt-bindings/clock/exynos5420.h
>>> @@ -60,6 +60,7 @@
>>>   #define CLK_MAU_EPLL		159
>>>   #define CLK_SCLK_HSIC_12M	160
>>>   #define CLK_SCLK_MPHY_IXTAL24	161
>>> +#define CLK_SCLK_BPLL		162
>>>   
>>>   /* gate clocks */
>>>   #define CLK_UART0		257
>>> @@ -195,6 +196,16 @@
>>>   #define CLK_ACLK432_CAM		518
>>>   #define CLK_ACLK_FL1550_CAM	519
>>>   #define CLK_ACLK550_CAM		520
>>> +#define CLK_CLKM_PHY0		521
>>> +#define CLK_CLKM_PHY1		522
>>> +#define CLK_ACLK_PPMU_DREX0_0	523
>>> +#define CLK_ACLK_PPMU_DREX0_1	524
>>> +#define CLK_ACLK_PPMU_DREX1_0	525
>>> +#define CLK_ACLK_PPMU_DREX1_1	526
>>> +#define CLK_PCLK_PPMU_DREX0_0	527
>>> +#define CLK_PCLK_PPMU_DREX0_1	528
>>> +#define CLK_PCLK_PPMU_DREX1_0	529
>>> +#define CLK_PCLK_PPMU_DREX1_1	530
>>>   
>>>   /* mux clocks */
>>>   #define CLK_MOUT_HDMI		640
>>> @@ -217,6 +228,8 @@
>>>   #define CLK_MOUT_EPLL		657
>>>   #define CLK_MOUT_MAU_EPLL	658
>>>   #define CLK_MOUT_USER_MAU_EPLL	659
>>> +#define CLK_MOUT_SCLK_SPLL	660
>>> +#define CLK_MOUT_MX_MSPLL_CCORE_PHY	661
>>>   
>>>   /* divider clocks */
>>>   #define CLK_DOUT_PIXEL		768
>>> @@ -243,13 +256,16 @@
>>>   #define CLK_DOUT_ACLK300_GSCL	789
>>>   #define CLK_DOUT_ACLK400_DISP1	790
>>>   #define CLK_DOUT_PCLK_CDREX	791
>>> -#define CLK_DOUT_SCLK_CDREX	792
>>> -#define CLK_DOUT_ACLK_CDREX1	793
>>> -#define CLK_DOUT_CCLK_DREX0	794
>>> -#define CLK_DOUT_CLK2X_PHY0	795
>>> -#define CLK_DOUT_PCLK_CORE_MEM	796
>>
>> The your previous patch didn't change the id number
>> of already exiting clocks. It cause the fault.
>> In order to keep the compatibility, you keep
>> the original id number without modification.
> True, the previous patch didn't change these IDs.
> I have not seen any faults during builds and stress tests, though.

If you use the built dtb file before modification, it cause the fault.
It is advantage of device-tree style to split out
the dependency between kernel image and dtb.

>>
>> Please don't change the id number of the existing clocks
>> and then just add the new clocks.
> OK, I will add CLK_DOUT_PCLK_DREX0	and CLK_DOUT_PCLK_DREX1
> at the end:
> ------------------>8--------------------------
> @@ -248,8 +261,11 @@
>   #define CLK_DOUT_CCLK_DREX0    794
>   #define CLK_DOUT_CLK2X_PHY0    795
>   #define CLK_DOUT_PCLK_CORE_MEM 796
> +#define CLK_FF_DOUT_SPLL2      797
> +#define CLK_DOUT_PCLK_DREX0    798
> +#define CLK_DOUT_PCLK_DREX1    799
> 
>   /* must be greater than maximal clock id */
> -#define CLK_NR_CLKS            797
> +#define CLK_NR_CLKS            800
> -----------------8<---------------------------
> 
> Can I add your ack in the modified version?

I agree.

> 
> Regards,
> Lukasz
>>
>>
>>> +#define CLK_DOUT_PCLK_DREX0	792
>>> +#define CLK_DOUT_PCLK_DREX1	793
>>> +#define CLK_DOUT_SCLK_CDREX	794
>>> +#define CLK_DOUT_ACLK_CDREX1	795
>>> +#define CLK_DOUT_CCLK_DREX0	796
>>> +#define CLK_DOUT_CLK2X_PHY0	797
>>> +#define CLK_DOUT_PCLK_CORE_MEM	798
>>> +#define CLK_FF_DOUT_SPLL2	799
>>>   
>>>   /* must be greater than maximal clock id */
>>> -#define CLK_NR_CLKS		797
>>> +#define CLK_NR_CLKS		800
>>>   
>>>   #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
>>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
