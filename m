From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 7/9] pinctrl: samsung: Add property to mark pad state as
 suitable for power down
Date: Fri, 30 Dec 2016 12:55:27 +0100
Message-ID: <bad5ef6a-6132-2029-8581-2e8b27f7a2bd@samsung.com>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122538epcas5p29515ceff21963ab035b3b32878830ce2@epcas5p2.samsung.com>
 <1482495889-6201-8-git-send-email-m.szyprowski@samsung.com>
 <20161225191914.5bzl6fso36ozuum6@kozik-lap>
 <bd48fe32-5296-fc23-dbb8-d212292d76cd@samsung.com>
 <20161227153331.jbh7ei6oh3obmnri@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20161227153331.jbh7ei6oh3obmnri@kozik-lap>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 2016-12-27 16:33, Krzysztof Kozlowski wrote:
> On Tue, Dec 27, 2016 at 11:30:57AM +0100, Marek Szyprowski wrote:
>> On 2016-12-25 20:19, Krzysztof Kozlowski wrote:
>>> On Fri, Dec 23, 2016 at 01:24:47PM +0100, Marek Szyprowski wrote:
>>>> Add support for special property "samsung,off-state", which indicates a special
>>>> state suitable for device's "sleep" state. Its pin values/properties should
>>>> match the configuration in power down mode. It indicates that pin controller
>>>> can notify runtime power management subsystem, that it is ready for runtime
>>>> suspend if its all pins are configured for such state. This in turn might
>>>> allow to turn respective power domain off to reduce power consumption.
>>>>
>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 8 ++++++++
>>>>    drivers/pinctrl/samsung/pinctrl-samsung.c                     | 4 ++++
>>>>    drivers/pinctrl/samsung/pinctrl-samsung.h                     | 1 +
>>>>    3 files changed, 13 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>>>> index b7bd2e12a269..354eea0e7798 100644
>>>> --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>>>> +++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>>>> @@ -105,6 +105,7 @@ Required Properties:
>>>>      - samsung,pin-drv: Drive strength configuration.
>>>>      - samsung,pin-pud-pdn: Pull up/down configuration in power down mode.
>>>>      - samsung,pin-drv-pdn: Drive strength configuration in power down mode.
>>>> +  - samsung,off-state: Mark this configuration as suitable for bank power off.
>>>>      The values specified by these config properties should be derived from the
>>>>      hardware manual and these values are programmed as-is into the pin
>>>> @@ -113,6 +114,13 @@ Required Properties:
>>>>      Note: A child should include atleast a pin function selection property or
>>>>      pin configuration property (one or more) or both.
>>>> +  Note: Special property "samsung,off-state" indicates that this state can
>>>> +  be used for device's "sleep" pins state. Its pin values/properties should
>>>> +  match the configuration in power down mode.
>>> Why power down values cannot be used for sleep state? Why you need
>>> separate pin control state? If pins values should match power down
>>> configuration, then they could just be added to default state, couldn't
>>> they?
>> Separate sleep state is needed because of the pin control bindings and
>> design.
>>
>> A separate sleep state is required to let pin control client driver (in this
>> case
>> Exynos I2S driver) let to choose when it is okay to switch pads into sleep
>> state and I see no other way to achieve this.
> Maybe the pinctrl API should be extended for this? Doing this in DTS
> just for purpose of passing information between drivers (consumer and
> provider) looks odd.

Well, I don't know if it is odd or not, but that's how it is used now 
and I see
no reason to reinvent wheel. Please check it yourself:
$ git grep \"sleep\" arch/arm/boot/dts | wc -l
101

> Anyway, you are proposing a new binding so please Cc devicetree mailing
> list and device tree maintainers.

I'm just using the generic pinctrl bindings, but it might make some sense to
add a note to Exynos i2s driver that a sleep pin control state is needed if
one wants to get power domain to be turned off.

>>> In the patch 2/9, existing configuration:
>>> 716         i2s0_bus: i2s0-bus {
>>> (...)
>>> 719                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>>> 720                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>>> 721                 samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
>>> 722         };
>>>
>>> additional configuration:
>>> +       i2s0_bus_slp: i2s0-bus-slp {
>>> +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
>>> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>>> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
>>> +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_INPUT>;
>>> +               samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_NONE>;
>>> +               samsung,off-state;
>>> +       };
>> I agree that it would be possible to get rid of "samsung,off-state" property
>> and
>> just detect off state when func/pud pair matches power down func/pud.
>>
>>>> It indicates that pin control
>>>> +  can notify runtime power management subsystem, that it is ready for runtime
>>>> +  suspend if its all pins are configured for such state. This in turn might
>>>> +  allow to turn respective power domain off to reduce power consumption.
>>> What do you mean by "notifying RPM subsystem"? Either this is
>>> description of hardware in certain mode (sleep state) or this is not
>>> device tree property.
>> Maybe I wrote the description with a view too limited to the kernel
>> operation
>> perspective, but if we remove the need to mark state as off, the above
>> description
>> will not be needed.
> But still it wouldn't be describing any hardware property, would it?

Well, it somehow describes the hardware, because the pin state when it 
is allowed
to turn off the power domain is board specific. I should move that part 
to the
Odroid dts, because there might be a board which require other pin 
values in power
down mode.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
