From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 7/9] pinctrl: samsung: Add property to mark pad state as
 suitable for power down
Date: Mon, 26 Dec 2016 15:02:11 +0900
Message-ID: <CA+Ln22Fk+OPDbnLc1K+-kmFnmLJSs=Had5Uf5g6RYXCaM-1m-A@mail.gmail.com>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122538epcas5p29515ceff21963ab035b3b32878830ce2@epcas5p2.samsung.com>
 <1482495889-6201-8-git-send-email-m.szyprowski@samsung.com> <20161225191914.5bzl6fso36ozuum6@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20161225191914.5bzl6fso36ozuum6@kozik-lap>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

2016-12-26 4:19 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> On Fri, Dec 23, 2016 at 01:24:47PM +0100, Marek Szyprowski wrote:
>> Add support for special property "samsung,off-state", which indicates a special
>> state suitable for device's "sleep" state. Its pin values/properties should
>> match the configuration in power down mode. It indicates that pin controller
>> can notify runtime power management subsystem, that it is ready for runtime
>> suspend if its all pins are configured for such state. This in turn might
>> allow to turn respective power domain off to reduce power consumption.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 8 ++++++++
>>  drivers/pinctrl/samsung/pinctrl-samsung.c                     | 4 ++++
>>  drivers/pinctrl/samsung/pinctrl-samsung.h                     | 1 +
>>  3 files changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>> index b7bd2e12a269..354eea0e7798 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>> @@ -105,6 +105,7 @@ Required Properties:
>>    - samsung,pin-drv: Drive strength configuration.
>>    - samsung,pin-pud-pdn: Pull up/down configuration in power down mode.
>>    - samsung,pin-drv-pdn: Drive strength configuration in power down mode.
>> +  - samsung,off-state: Mark this configuration as suitable for bank power off.
>>
>>    The values specified by these config properties should be derived from the
>>    hardware manual and these values are programmed as-is into the pin
>> @@ -113,6 +114,13 @@ Required Properties:
>>    Note: A child should include atleast a pin function selection property or
>>    pin configuration property (one or more) or both.
>>
>> +  Note: Special property "samsung,off-state" indicates that this state can
>> +  be used for device's "sleep" pins state. Its pin values/properties should
>> +  match the configuration in power down mode.
>
> Why power down values cannot be used for sleep state? Why you need
> separate pin control state? If pins values should match power down
> configuration, then they could just be added to default state, couldn't
> they?
>
> In the patch 2/9, existing configuration:
> 716         i2s0_bus: i2s0-bus {
> (...)
> 719                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> 720                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> 721                 samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> 722         };
>
> additional configuration:
> +       i2s0_bus_slp: i2s0-bus-slp {
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_INPUT>;
> +               samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,off-state;
> +       };

+1

If I'm not missing something, it should be reasonably easy to
determine if a state is suitable for power off by its configuration,
by comparing pin-function and pin-pud with pin-con-pdn and
pin-pud-pdn.

Best regards,
Tomasz
