From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v6 1/5] dt-bindings: thermal: qcom-spmi-temp-alarm: Fix
 documentation of 'reg'
Date: Fri, 24 Aug 2018 16:11:55 -0700
Message-ID: <20180824231154.GA25163@localhost.localdomain>
References: <20180731185917.176074-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180731185917.176074-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Douglas Anderson <dianders@chromium.org>, Stephen Boyd <sboyd@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hey

On Tue, Jul 31, 2018 at 11:59:13AM -0700, Matthias Kaehlcke wrote:
> The documentation claims that the 'reg' property consists of two values,
> the SPMI address and the length of the controller's registers. However
> the SPMI bus to which it is added specifies "#size-cells = <0>;". Remove
> the controller register length from the documentation of the field and the
> example.


queuing this for next merge window. Applied up to patch 3. both
dt changes go via your arch tree and you can add my ack on them.
Acked-by: Eduardo Valentin <edubezval@gmail.com>

> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v6:
> - patch added to the series
> ---
>  .../devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt     | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> index 290ec06fa33a..86fb41fe772f 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> @@ -6,8 +6,7 @@ interrupt signal and status register to identify high PMIC die temperature.
>  
>  Required properties:
>  - compatible:      Should contain "qcom,spmi-temp-alarm".
> -- reg:             Specifies the SPMI address and length of the controller's
> -                   registers.
> +- reg:             Specifies the SPMI address.
>  - interrupts:      PMIC temperature alarm interrupt.
>  - #thermal-sensor-cells: Should be 0. See thermal.txt for a description.
>  
> @@ -20,7 +19,7 @@ Example:
>  
>  	pm8941_temp: thermal-alarm@2400 {
>  		compatible = "qcom,spmi-temp-alarm";
> -		reg = <0x2400 0x100>;
> +		reg = <0x2400>;
>  		interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
>  		#thermal-sensor-cells = <0>;
>  
> -- 
> 2.18.0.345.g5c9ce644c3-goog
> 
