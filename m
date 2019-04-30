From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 1/3] thermal: rockchip: fix up the tsadc pinctrl
 setting error
Date: Tue, 30 Apr 2019 11:44:49 +0200
Message-ID: <70cc3a91-8f5d-da48-a815-eaf2670f9a93@linaro.org>
References: <1556187154-22632-1-git-send-email-zhangqing@rock-chips.com>
 <1556187154-22632-2-git-send-email-zhangqing@rock-chips.com>
 <be0170d7-64dc-896d-b847-5be192304791@linaro.org>
 <8d41ea98-e0e8-60c8-3237-ade5d0d169bf@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8d41ea98-e0e8-60c8-3237-ade5d0d169bf@rock-chips.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "elaine.zhang" <zhangqing@rock-chips.com>, heiko@sntech.de
Cc: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com
List-Id: linux-pm@vger.kernel.org

On 29/04/2019 11:51, elaine.zhang wrote:

[ ... ]

> pinctrl select to gpio mode when tsadc suspend and shutdown.
> 
> When suspend, tsadc is disabled, the otp_pin should revert to the
> default gpio state.
> 
>>
>>>         return 0;
>>>   }
>>> @@ -1383,7 +1413,8 @@ static int __maybe_unused
>>> rockchip_thermal_resume(struct device *dev)
>>>       for (i = 0; i < thermal->chip->chn_num; i++)
>>>           rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
>>>   -    pinctrl_pm_select_default_state(dev);
>>> +    if (thermal->tshut_mode == TSHUT_MODE_GPIO)
>>> +        pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
>> And then
>>     pinctrl_select_state(thermal->pinctrl, thermal->pinctrl_state);
> 
> pinctrl select to otp mode when tsadc resume.

Ok, thanks for clarifying.

  -- Daniel



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
