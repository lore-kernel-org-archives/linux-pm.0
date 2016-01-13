From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 2/2] power: add documentation for ACT8945A's charger DT
 bindings
Date: Wed, 13 Jan 2016 11:00:13 +0900
Message-ID: <5695AFAD.4030307@samsung.com>
References: <1452586185-818-1-git-send-email-wenyou.yang@atmel.com>
 <1452586185-818-3-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1452586185-818-3-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12.01.2016 17:09, Wenyou Yang wrote:
> This patch adds documentation for the DT bindings of the charger
> subdevice of ACT8945A MFD.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../devicetree/bindings/power/act8945a-charger.txt |   34 ++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/act8945a-charger.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/act8945a-charger.txt b/Documentation/devicetree/bindings/power/act8945a-charger.txt
> new file mode 100644
> index 0000000..868e0164
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/act8945a-charger.txt
> @@ -0,0 +1,34 @@
> +Device-Tree bindings for charger of Active-semi ACT8945A Multi-Function Device
> +
> +Required properties:
> + - compatible: "active-semi,act8945a-charger"
> + - active-semi,chglev-gpio = Specifies a gpio that uses to select
> +   the charge current level.

active-semi,chglev-gpios
See: Documentation/devicetree/bindings/gpio/gpio.txt

> +
> +Optional properties:
> + - active-semi,battery_temperature: Indicates if it is allowed to check
> +   the battery temperature. If it is missing, assume the battery temperature
> +   is not allowed to check.

Here and in rest of properties - no underscores but hyphens. The name
suggests that this is a value... but this is a boolean?

> + - active-semi,input_voltage_threshold: unit: mV;
> +   Specifies the charger's input over-voltage threshold value;
> +   The value can be: 6600, 7000, 7500, 8000; default: 6600

I think adding units suffix in binding is preferred. so "-microvolt"?

Best regards,
Krzysztof


> + - active-semi,precondition_timeout: unit: minutes;
> +   Specifies the charger's PRECONDITION safety timer setting value;
> +   The value can be: 40, 60, 80, 0; If 0, it means to disable this timer;
> +   default: 40.
> + - active-semi,total_timeout: unit: hours;
> +   Specifies the charger's total safety timer setting value;
> +   The value can be: 3, 4, 5, 0; If 0, it means to disable this timer;
> +   default: 3.
> +
> +Example:
> +
> +	charger {
> +		compatible = "active-semi,act8945a-charger";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_charger_chglev>;
> +		active-semi,chglev-gpio = <&pioA 12 GPIO_ACTIVE_HIGH>;
> +		active-semi,input_voltage_threshold = <6600>;
> +		active-semi,precondition_timeout = <40>;
> +		active-semi,total_timeout = <3>;
> +	};
> 
