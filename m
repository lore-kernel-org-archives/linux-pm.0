From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for Maxim PMIC-s on Samsung boards
Date: Fri, 16 Jan 2015 20:51:13 +0900
Message-ID: <54B8FB31.5090105@samsung.com>
References: <1421407190-6771-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1421407190-6771-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Alessandro Zummo <a.zummo@towertech.it>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 01/16/2015 08:19 PM, Krzysztof Kozlowski wrote:
> Add myself as supporter for Maxim 77686 PMIC and Maxim 14577/77693 MUIC
> drivers:
>  - mfd (all of them),
>  - extcon (extcon-max14577, extcon-max77693)
>  - power (max14577_charger.c, 77693 on LKML [1]),
>  - regulator (all of them),
>  - clock (clk-max77686.c)
>  - RTC (rtc-max77686.c).
> 
> Lately I am the author of major contributors to them. These
> drivers are used on Exynos-based boards (Trats 2, Gear 1 and Gear 2).
> 
> [1] https://lkml.org/lkml/2015/1/5/139
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> ---
>  MAINTAINERS | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f017a30eb280..b033fb499186 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6143,6 +6143,21 @@ F:	Documentation/devicetree/bindings/i2c/max6697.txt
>  F:	drivers/hwmon/max6697.c
>  F:	include/linux/platform_data/max6697.h
>  
> +MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BOARDS
> +M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Supported
> +F:	drivers/*/*max14577*.c
> +F:	drivers/*/*max77686*.c
> +F:	drivers/*/*max77693*.c

I knew that you did implement max14577 series because I did cowork to implement it with you.

But,
The drivers/extcon/extcon-max77693.c was implemented by me
and extcon-max14577.c was implemented by me and you.

The initial version of drivers/mfd/max77876.c, drivers/regulator/max77686.c
was implemented by Jonghwa Lee(jonghwa3.lee@samsung.com).

The initial version of drivers/mfd/max77693.c was implmented by me
and drivers/mfd/max77693.c by Jonghwa Lee.

Best Regards,
Chanwoo Choi
