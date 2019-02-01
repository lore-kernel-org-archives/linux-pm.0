From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v3 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Date: Fri, 1 Feb 2019 14:49:23 +0100
Message-ID: <66b886d3-37af-dc54-9dd8-c56977709e2a@partner.samsung.com>
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7@eucas1p2.samsung.com>
        <1548924594-19084-2-git-send-email-l.luba@partner.samsung.com>
        <d6124295-cb72-0d5f-f887-438698cf48e1@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d6124295-cb72-0d5f-f887-438698cf48e1@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 2/1/19 8:40 AM, Chanwoo Choi wrote:
> Hi,
> 
> On 19. 1. 31. 오후 5:49, Lukasz Luba wrote:
>> Define new IDs for clocks used by Dynamic Memory Controller in
>> Exynos5422 SoC.
>>
>> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> CC: Chanwoo Choi <cw00.choi@samsung.com>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Mark Rutland <mark.rutland@arm.com>
>> CC: Kukjin Kim <kgene@kernel.org>
>> CC: Krzysztof Kozlowski <krzk@kernel.org>
>> CC: linux-samsung-soc@vger.kernel.org
>> CC: devicetree@vger.kernel.org
>> CC: linux-arm-kernel@lists.infradead.org
>> CC: linux-kernel@vger.kernel.org
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
>> index 355f469..1827a64 100644
>> --- a/include/dt-bindings/clock/exynos5420.h
>> +++ b/include/dt-bindings/clock/exynos5420.h
>> @@ -60,6 +60,7 @@
>>   #define CLK_MAU_EPLL		159
>>   #define CLK_SCLK_HSIC_12M	160
>>   #define CLK_SCLK_MPHY_IXTAL24	161
>> +#define CLK_SCLK_BPLL		162
>>   
>>   /* gate clocks */
>>   #define CLK_UART0		257
>> @@ -195,6 +196,16 @@
>>   #define CLK_ACLK432_CAM		518
>>   #define CLK_ACLK_FL1550_CAM	519
>>   #define CLK_ACLK550_CAM		520
>> +#define CLK_CLKM_PHY0		521
>> +#define CLK_CLKM_PHY1		522
>> +#define CLK_ACLK_PPMU_DREX0_0	523
>> +#define CLK_ACLK_PPMU_DREX0_1	524
>> +#define CLK_ACLK_PPMU_DREX1_0	525
>> +#define CLK_ACLK_PPMU_DREX1_1	526
>> +#define CLK_PCLK_PPMU_DREX0_0	527
>> +#define CLK_PCLK_PPMU_DREX0_1	528
>> +#define CLK_PCLK_PPMU_DREX1_0	529
>> +#define CLK_PCLK_PPMU_DREX1_1	530
>>   
>>   /* mux clocks */
>>   #define CLK_MOUT_HDMI		640
>> @@ -217,6 +228,10 @@
>>   #define CLK_MOUT_EPLL		657
>>   #define CLK_MOUT_MAU_EPLL	658
>>   #define CLK_MOUT_USER_MAU_EPLL	659
>> +#define CLK_MOUT_DPLL		660
>> +#define CLK_MOUT_ACLK_G3D	661
> 
> The second patch don't implement some clocks
> for CLK_MOUT_DPLL, CLK_MOUT_ACLK_G3D.
> 
> Why do you define them?
You are right, it is a mistake.
I will remove it in v2.

Regards,
Lukasz
> 
> (snip)
> 
