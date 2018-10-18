From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 3/6] dt-bindings: power: Introduce properties to
 present the battery OCV capacity table
Date: Thu, 18 Oct 2018 11:51:01 -0500
Message-ID: <20181018165101.GA11562@bogus>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
 <eb56baf2e2d127067e459b6014516071ba9005c0.1539587217.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <eb56baf2e2d127067e459b6014516071ba9005c0.1539587217.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: sre@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, broonie@kernel.org, ctatlor97@gmail.com, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 15, 2018 at 04:09:22PM +0800, Baolin Wang wrote:
> Some battery driver will use the open circuit voltage (OCV) value to look
> up the corresponding battery capacity percent in one certain degree Celsius.
> Thus this patch provides some battery properties to present the OCV table
> temperatures and OCV capacity table values.
> 
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes from v3:
>  - Split binding into one separate patch.
>  - Rename ocv-capacity-table-temperatures to ocv-capacity-celsius.
>  - Add some words to specify the OCV's unit.
> 
> Changes from v2:
>  - Use type __be32 to calculate the table length.
>  - Update error messages.
>  - Add some helper functions.
> 
> Changes from v1:
>  - New patch in v2.
> ---
>  .../devicetree/bindings/power/supply/battery.txt   |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> index 938d027..1f70e5d 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -23,6 +23,17 @@ Optional Properties:
>   - constant-charge-current-max-microamp: maximum constant input current
>   - constant-charge-voltage-max-microvolt: maximum constant input voltage
>   - factory-internal-resistance-micro-ohms: battery factory internal resistance
> + - ocv-capacity-table-0: An array providing the battery capacity percent
> +   with corresponding open circuit voltage (OCV) of the battery, which
> +   is used to look up battery capacity according to current OCV value.
> +   And the open circuit voltage unit is microvolt.

The order percent and voltage is still not clear. I'd guess one way 
based on the text here, but the example is the opposite. The description 
here must stand on its own.

> + - ocv-capacity-table-1: Same as ocv-capacity-table-0
> + ......
> + - ocv-capacity-table-n: Same as ocv-capacity-table-0
> + - ocv-capacity-celsius: An array containing the temperature in degree Celsius,
> +   for each of the battery capacity lookup table. The first temperature value
> +   specifies the OCV table 0, and the second temperature value specifies the
> +   OCV table 1, and so on.
>  
>  Battery properties are named, where possible, for the corresponding
>  elements in enum power_supply_property, defined in
> @@ -44,6 +55,10 @@ Example:
>  		constant-charge-current-max-microamp = <900000>;
>  		constant-charge-voltage-max-microvolt = <4200000>;
>  		factory-internal-resistance-micro-ohms = <250000>;
> +		ocv-capacity-celsius = <(-10) 0 10>;
> +		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
> +		ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
> +		ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
>  	};
>  
>  	charger: charger@11 {
> -- 
> 1.7.9.5
> 
