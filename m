From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v8 2/6] clk: samsung: add cpu clock configuration data
 and instantiate cpu clock
Date: Tue, 29 Jul 2014 14:04:27 +0200
Message-ID: <53D78DCB.8080607@gmail.com>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com>	<1406611711-25112-3-git-send-email-thomas.ab@samsung.com>	<53D773DA.6050003@gmail.com> <CAJuA9ahuch8c9CzVwO7pf8Chf0G3coNH4KLOF29Sj7dQ9gqO_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJuA9ahuch8c9CzVwO7pf8Chf0G3coNH4KLOF29Sj7dQ9gqO_Q@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 29.07.2014 13:46, Thomas Abraham wrote:
> Hi Tomasz,
> 
> On Tue, Jul 29, 2014 at 3:43 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> Hi Thomas,
>>
>> Just few minor comments for things I probably missed before.
>>
>> On 29.07.2014 07:28, Thomas Abraham wrote:
>>
>> [snip]
>>
>>> @@ -1356,6 +1357,16 @@ static struct samsung_pll_clock exynos4x12_plls[nr_plls] __initdata = {
>>>                       VPLL_LOCK, VPLL_CON0, NULL),
>>>  };
>>>
>>> +static const struct exynos_cpuclk_cfg_data e4210_armclk_d[] __initconst = {
>>> +     { 1200000, E4210_CPU_DIV0(7, 1, 4, 3, 7, 3), E4210_CPU_DIV1(0, 5), },
>>> +     { 1000000, E4210_CPU_DIV0(7, 1, 4, 3, 7, 3), E4210_CPU_DIV1(0, 4), },
>>> +     {  800000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
>>> +     {  500000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
>>> +     {  400000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
>>
>> I have noticed that the old driver does not have this operating point.
>> While it is probably OK to add this one and even few more for all
>> possible APLL settings, I am interested in how you obtained the values
>> for DIV0 and DIV1 registers for this configuration.
> 
> I found these values from an old internal repo. So far no trouble seen
> with these values in all the testing.

OK.

> 
>>
>>> +     {  200000, E4210_CPU_DIV0(0, 1, 1, 1, 3, 1), E4210_CPU_DIV1(0, 3), },
>>> +     {  0 },
>>> +};
>>
>> [snip]
>>
>>> diff --git a/include/dt-bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
>>> index 4273891..855d809 100644
>>> --- a/include/dt-bindings/clock/exynos5250.h
>>> +++ b/include/dt-bindings/clock/exynos5250.h
>>> @@ -21,6 +21,7 @@
>>>  #define CLK_FOUT_CPLL                6
>>>  #define CLK_FOUT_EPLL                7
>>>  #define CLK_FOUT_VPLL                8
>>> +#define CLK_ARM_CLK          12
>>
>> Why 12 not 9?
> 
> Exynos4 uses 12 and so just wanted to keep it same for Exynos5250 as well.

There is no need to align those numbers between different bindings,
because preprocessor macros are used anyway and leaving holes between
clocks only makes the namespace harder to maintain.

Best regards,
Tomasz
