From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1 1/3] thermal: rockchip: add pinctrl control
Date: Tue, 16 Apr 2019 12:12:05 +0200
Message-ID: <6267ffc8-6ca4-86ad-7f87-c669bc9f3454@linaro.org>
References: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com>
 <1554100985-11385-2-git-send-email-zhangqing@rock-chips.com>
 <30325add-d75a-6775-50c0-d2d2274ff81e@linaro.org>
 <db977a75-195f-4c98-ef84-aa186b484e0d@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <db977a75-195f-4c98-ef84-aa186b484e0d@rock-chips.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "elaine.zhang" <zhangqing@rock-chips.com>, heiko@sntech.de
Cc: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com
List-Id: linux-pm@vger.kernel.org


Hi Elaine,

On 11/04/2019 09:46, elaine.zhang wrote:
> hi,
> 
> 在 2019/4/4 上午11:03, Daniel Lezcano 写道:
>> On 01/04/2019 08:43, Elaine Zhang wrote:
>>> Based on the TSADC Tshut mode to select pinctrl,
>>> instead of setting pinctrl based on architecture
>>> (Not depends on pinctrl setting by "init" or "default").
>>> And it requires setting the tshut polarity before select pinctrl.
>> I'm not sure to fully read the description. Can you rephrase/elaborate
>> the changelog?
> Example:
>         tsadc: tsadc@ff250000 {
>                     compatible = "rockchip,rk3328-tsadc";
>                     .....
>                 pinctrl-names = "init", "default", "sleep";
>                     pinctrl-0 = <&otp_gpio>;
>                     pinctrl-1 = <&otp_out>;
>                     pinctrl-2 = <&otp_gpio>;
>                     status = "disabled";
>                 .....
>             };
>         &tsadc {
>                 rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
>                 status = "okay";
>         };
>     Application on the product, hope tsadc overtemperature reset cru to
> restart.
>     But when pinctrl is initialized, it will setting pinctrl by "init"
> and "default".
>     So the pinctrl will set iomux to "otp_out", which may be make system
> crash.

why?

>     tsadc gpio iomux:
>     "otp_gpio" : just normal gpio, keep default level.
>     "otp_out" : tsadc shut down io, when overtemperature,this io may be
> trigger high
>     level or low level(depend on the tsadc polarity).
> 
>     After correction:
>     if rockchip,hw-tshut-mode = <0>; (tsadc overtemperature reset cru to
> restart)
>     select pinctrl to otp_gpio
>     if rockchip,hw-tshut-mode = <1>;(tsadc overtemperature IO triggers
> output at high or low levels)
>     select pinctrl to otp_out.
>     Actively select iomux based on rockchip,hw-tshut-mode,
>     rather than relying on the pinctrl framework to select iomux.

Let me rephrase it and tell me if I understood correctly:

"When the temperature sensor mode is set to 0, it will automatically
reset the board via the Clock-Reset-Unit (CRU) if the over temperature
threshold is reached. However, when the pinctrl initializes, it does a
transition to "otp_out" which may lead the SoC to crash (why?)

Explicitly use the pinctrl to set/unset the right mode instead of
relying on the pinctrl init mode"

So this patch is a fix and it must contain the Fixes: ... tag.


>>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>>> ---
>>>   drivers/thermal/rockchip_thermal.c | 61
>>> +++++++++++++++++++++++++++++++-------
>>>   1 file changed, 50 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/thermal/rockchip_thermal.c
>>> b/drivers/thermal/rockchip_thermal.c
>>> index 9c7643d62ed7..faa6c7792155 100644
>>> --- a/drivers/thermal/rockchip_thermal.c
>>> +++ b/drivers/thermal/rockchip_thermal.c
>>> @@ -34,7 +34,7 @@
>>>    */
>>>   enum tshut_mode {
>>>       TSHUT_MODE_CRU = 0,
>>> -    TSHUT_MODE_GPIO,
>>> +    TSHUT_MODE_OTP,
>> Why do you change the enum name? The impact on the patch is much higher,
>> no ?
> 
> I just want to make it a little bit more intuitive to understand the
> definition of mode.
> 
> TSHUT_MODE_CRU: pinctrl select iomux to otp_gpio,the io is normal io.
> TSHUT_MODE_OTP: pinctrl select iomux to otp_out, the io is tsadc shut io.

I understand, but at the end the changes for this patch are counter
intuitive, so it is preferable to keep it as is so we can review the
important part.

[ ... ]

>>>   +static void thermal_pinctrl_select_otp(struct
>>> rockchip_thermal_data *thermal)
>>> +{
>>> +    if (!IS_ERR(thermal->pinctrl) &&
>>> !IS_ERR_OR_NULL(thermal->otp_state))
>>> +        pinctrl_select_state(thermal->pinctrl,
>>> +                     thermal->otp_state);
>>> +}
>>> +
>>> +static void thermal_pinctrl_select_gpio(struct rockchip_thermal_data
>>> *thermal)
>>> +{
>>> +    if (!IS_ERR(thermal->pinctrl) &&
>>> !IS_ERR_OR_NULL(thermal->gpio_state))
>>> +        pinctrl_select_state(thermal->pinctrl,
>>> +                     thermal->gpio_state);
>>> +}
>> You should not have to create a couple of specific functions just to
>> check the pinctrl pointers are set. The caller should do that.
> Because there are several places where the call is made,create a couple
> of specific functions reduce a lot of duplicated code.

No, that does not reduce a lot of duplicated code, it hides the fact
there is no control from the caller. See the comments below.

[ ... ]

>>>   static int rockchip_configure_from_dt(struct device *dev,
>>>                         struct device_node *np,
>>>                         struct rockchip_thermal_data *thermal)
>>> @@ -1103,7 +1120,7 @@ static int rockchip_configure_from_dt(struct
>>> device *dev,
>>>       if (of_property_read_u32(np, "rockchip,hw-tshut-mode",
>>> &tshut_mode)) {
>>>           dev_warn(dev,
>>>                "Missing tshut mode property, using default (%s)\n",
>>> -             thermal->chip->tshut_mode == TSHUT_MODE_GPIO ?
>>> +             thermal->chip->tshut_mode == TSHUT_MODE_OTP ?
>>>                   "gpio" : "cru");
>>>           thermal->tshut_mode = thermal->chip->tshut_mode;
>>>       } else {
>>> @@ -1242,6 +1259,8 @@ static int rockchip_thermal_probe(struct
>>> platform_device *pdev)
>>>           return error;
>>>       }
>>>   +    thermal->chip->control(thermal->regs, false);
>>> +
>>>       error = clk_prepare_enable(thermal->clk);
>>>       if (error) {
>>>           dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
>>> @@ -1267,6 +1286,24 @@ static int rockchip_thermal_probe(struct
>>> platform_device *pdev)
>>>       thermal->chip->initialize(thermal->grf, thermal->regs,
>>>                     thermal->tshut_polarity);
>>>   +    if (thermal->tshut_mode == TSHUT_MODE_OTP) {
>>> +        thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
>>> +        if (IS_ERR(thermal->pinctrl))
>>> +            dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
>>> +
>>> +        thermal->gpio_state = pinctrl_lookup_state(thermal->pinctrl,
>>> +                               "gpio");

panic if devm_pinctrl_get fails.

>>> +        if (IS_ERR_OR_NULL(thermal->gpio_state))
>>> +            dev_err(&pdev->dev, "failed to find thermal gpio state\n");
>>> +
>>> +        thermal->otp_state = pinctrl_lookup_state(thermal->pinctrl,
>>> +                              "otpout");
>>> +        if (IS_ERR_OR_NULL(thermal->otp_state))
>>> +            dev_err(&pdev->dev, "failed to find thermal otpout
>>> state\n");
>> What is the meaning for the rest of the code if the lookup fails for any
>> of those ?
> If the lookup fails for any of those， The pinctrl is no longer set and
> remains in its default state(otp_gpio normal io).
>>
>>> +        thermal_pinctrl_select_otp(thermal);
>>> +    }
>>> +

It is pointless to have a otp_state and a gpio_state field. Just use one
as the configuration tells you which lookup to do.

In case of error, just bail out. It is pointless to continue with a
broken configuration.

	thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
	if (IS_ERR(thermal->pinctrl)) {
		dev_err(&pdev->dev, "....");
		return PTR_ERR(thermal->pinctrl);
	}

	thermal->pinctrl_state =
		pinctrl_lookup_state(thermal->pinctrl,
			thermal->tshut_mode == TSHUT_MODE_OTP ?
			"otp" : "gpio");

	if (IS_ERR_OR_NULL(thermal->pinctrl_state)) {
		dev_err(&pdev->dev, "....");
		return -EINVAL;
	}


No need to use the thermal_pinctrl_select_otp/gpio wrappers, just
replace them with:

pinctrl_select_state(thermal->pinctrl, thermal->pinctrl_state);

and use it unconditionally.


>>>       for (i = 0; i < thermal->chip->chn_num; i++) {
>>>           error = rockchip_thermal_register_sensor(pdev, thermal,
>>>                           &thermal->sensors[i],
>>> @@ -1338,7 +1375,8 @@ static int __maybe_unused
>>> rockchip_thermal_suspend(struct device *dev)
>>>       clk_disable(thermal->pclk);
>>>       clk_disable(thermal->clk);
>>>   -    pinctrl_pm_select_sleep_state(dev);
>>> +    if (thermal->tshut_mode == TSHUT_MODE_OTP)
>>> +        thermal_pinctrl_select_gpio(thermal);
>>>         return 0;
>>>   }
>>> @@ -1383,7 +1421,8 @@ static int __maybe_unused
>>> rockchip_thermal_resume(struct device *dev)
>>>       for (i = 0; i < thermal->chip->chn_num; i++)
>>>           rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
>>>   -    pinctrl_pm_select_default_state(dev);
>>> +    if (thermal->tshut_mode == TSHUT_MODE_OTP)
>>> +        thermal_pinctrl_select_otp(thermal);
>>>         return 0;
>>>   }
>>>
>>
> 
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
