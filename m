From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/4] power: supply: core: Introduce properties to
 present the battery OCV capacity table
Date: Fri, 12 Oct 2018 09:35:30 -0500
Message-ID: <20181012143530.GA28145@bogus>
References: <2787f18a0366576959557d05112a069dca982269.1538033078.git.baolin.wang@linaro.org>
 <7dccec1694a05a524710e59a63859974b4cdae89.1538033078.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7dccec1694a05a524710e59a63859974b4cdae89.1538033078.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: sre@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, broonie@kernel.org, ctatlor97@gmail.com, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 27, 2018 at 03:26:55PM +0800, Baolin Wang wrote:
> Some battery driver will use the open circuit voltage (OCV) value to look
> up the corresponding battery capacity percent in one certain degree Celsius.
> Thus this patch provides some battery properties to present the OCV table
> temperatures and OCV capacity table values. Moreover it also provides some
> helper functions to use the OCV capacity table for users.
> 
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes from v2:
>  - Use type __be32 to calculate the table length.
>  - Update error messages.
>  - Add some helper functions.
> 
> Changes from v1:
>  - New patch in v2.
> ---
>  .../devicetree/bindings/power/supply/battery.txt   |   14 +++

Please split binding patches.

>  drivers/power/supply/power_supply_core.c           |  125 +++++++++++++++++++-
>  include/linux/power_supply.h                       |   19 +++
>  3 files changed, 157 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> index 938d027..cad38df 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -23,6 +23,16 @@ Optional Properties:
>   - constant-charge-current-max-microamp: maximum constant input current
>   - constant-charge-voltage-max-microvolt: maximum constant input voltage
>   - factory-internal-resistance-micro-ohms: battery factory internal resistance
> + - ocv-capacity-table-0: An array providing the battery capacity percent
> +   with corresponding open circuit voltage (OCV) of the battery, which
> +   is used to look up battery capacity according to current OCV value.
> + - ocv-capacity-table-1: Same as ocv-capacity-table-0
> + ......
> + - ocv-capacity-table-n: Same as ocv-capacity-table-0

So it is tubles of (percent, voltage)? What's the units for voltage?

What determines the # of entries for each table? Do all tables have the 
same number of entries?

> + - ocv-capacity-table-temperatures: An array containing the temperature
> +   in degree Celsius, for each of the battery capacity lookup table.
> +   The first temperature value specifies the OCV table 0, and the second
> +   temperature value specifies the OCV table 1, and so on.

This should have unit suffix. Perhaps just "ocv-capacity-celsius" to 
avoid being too long.

>  Battery properties are named, where possible, for the corresponding
>  elements in enum power_supply_property, defined in
> @@ -44,6 +54,10 @@ Example:
>  		constant-charge-current-max-microamp = <900000>;
>  		constant-charge-voltage-max-microvolt = <4200000>;
>  		factory-internal-resistance-micro-ohms = <250000>;
> +		ocv-capacity-table-temperatures = <(-10) 0 10>;
> +		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
> +		ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
> +		ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
>  	};
>  
>  	charger: charger@11 {
