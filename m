From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 7/9] pinctrl: samsung: Add property to mark pad state as
 suitable for power down
Date: Sun, 25 Dec 2016 21:19:14 +0200
Message-ID: <20161225191914.5bzl6fso36ozuum6@kozik-lap>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122538epcas5p29515ceff21963ab035b3b32878830ce2@epcas5p2.samsung.com>
 <1482495889-6201-8-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1482495889-6201-8-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 23, 2016 at 01:24:47PM +0100, Marek Szyprowski wrote:
> Add support for special property "samsung,off-state", which indicates a special
> state suitable for device's "sleep" state. Its pin values/properties should
> match the configuration in power down mode. It indicates that pin controller
> can notify runtime power management subsystem, that it is ready for runtime
> suspend if its all pins are configured for such state. This in turn might
> allow to turn respective power domain off to reduce power consumption.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 8 ++++++++
>  drivers/pinctrl/samsung/pinctrl-samsung.c                     | 4 ++++
>  drivers/pinctrl/samsung/pinctrl-samsung.h                     | 1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> index b7bd2e12a269..354eea0e7798 100644
> --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> @@ -105,6 +105,7 @@ Required Properties:
>    - samsung,pin-drv: Drive strength configuration.
>    - samsung,pin-pud-pdn: Pull up/down configuration in power down mode.
>    - samsung,pin-drv-pdn: Drive strength configuration in power down mode.
> +  - samsung,off-state: Mark this configuration as suitable for bank power off.
>  
>    The values specified by these config properties should be derived from the
>    hardware manual and these values are programmed as-is into the pin
> @@ -113,6 +114,13 @@ Required Properties:
>    Note: A child should include atleast a pin function selection property or
>    pin configuration property (one or more) or both.
>  
> +  Note: Special property "samsung,off-state" indicates that this state can
> +  be used for device's "sleep" pins state. Its pin values/properties should
> +  match the configuration in power down mode.

Why power down values cannot be used for sleep state? Why you need
separate pin control state? If pins values should match power down
configuration, then they could just be added to default state, couldn't
they?

In the patch 2/9, existing configuration:
716         i2s0_bus: i2s0-bus {
(...)
719                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
720                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
721                 samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
722         };

additional configuration:
+       i2s0_bus_slp: i2s0-bus-slp {
+               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_INPUT>;
+               samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_NONE>;
+               samsung,off-state;
+       };

> It indicates that pin control
> +  can notify runtime power management subsystem, that it is ready for runtime
> +  suspend if its all pins are configured for such state. This in turn might
> +  allow to turn respective power domain off to reduce power consumption.

What do you mean by "notifying RPM subsystem"? Either this is
description of hardware in certain mode (sleep state) or this is not
device tree property.

Best regards,
Krzysztof

> +
>    The client nodes that require a particular pin function selection and/or
>    pin configuration should use the bindings listed in the "pinctrl-bindings.txt"
>    file.
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index a7b7d75373f2..301169d2b6e1 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -692,6 +692,10 @@ static int samsung_pinctrl_create_function(struct device *dev,
>  	}
>  
>  	func->name = func_np->full_name;
> +	if (of_property_read_bool(func_np, "samsung,off-state"))
> +		func->rpm_active = false;
> +	else
> +		func->rpm_active = true;
>  
>  	func->groups = devm_kzalloc(dev, npins * sizeof(char *), GFP_KERNEL);
>  	if (!func->groups)
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
> index 32b949e2a89b..edeafa00abd3 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.h
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
> @@ -280,6 +280,7 @@ struct samsung_pmx_func {
>  	const char		**groups;
>  	u8			num_groups;
>  	u32			val;
> +	bool			rpm_active;
>  };
>  
>  /* list of all exported SoC specific data */
> -- 
> 1.9.1
> 
