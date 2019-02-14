From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RFC 3/6] power: supply: Ettus Research E31x charger driver
Date: Thu, 14 Feb 2019 09:38:19 +0000
Message-ID: <20190214093819.GG13737@dell>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
 <20190212010143.3729-4-virendra.kakade@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212010143.3729-4-virendra.kakade@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Virendra Kakade <virendra.kakade@ni.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, moritz.fischer@ettus.com
List-Id: linux-pm@vger.kernel.org

On Mon, 11 Feb 2019, Virendra Kakade wrote:

> Document bindings for the E31x devices charger.
> 
> Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
> ---
>  Documentation/devicetree/bindings/mfd/e31x-pmu.txt |  8 ++++++++
>  .../bindings/power/supply/e31x-charger.txt         | 14 ++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/e31x-charger.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> index ebb5625f6c74..3798886578ba 100644
> --- a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> +++ b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> @@ -4,11 +4,19 @@ Required properties:
>  - compatible : Must be "ni,e31x-pmu"
>  - regmap     : Must be <&regmapnode>
>  
> +e31x-pmu has a sub-device called e31x-charger.
> +
> +For the e31x-charger properties please refer to:
> +Documentation/device-tree/bindings/power/supply/e31x-charger.txt

Use relative path, so:

  ../power/supply/e31x-charger.txt

>  Example:
>  
>  pmu {
>  	compatible = "ni,e31x-pmu";
>  	regmap = <&devctrl>;
>  	status = "okay";

'\n' here.

> +	charger: charger@0{
> +		compatible = "ni,e31x-charger";
> +	};
>  };
>  
> diff --git a/Documentation/devicetree/bindings/power/supply/e31x-charger.txt b/Documentation/devicetree/bindings/power/supply/e31x-charger.txt
> new file mode 100644
> index 000000000000..ae9fedcbf1b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/e31x-charger.txt
> @@ -0,0 +1,14 @@
> +Ettus Research/National Instruments  E31x Devices Charger

Too many spaces.

> +All E31x devices have to be connected to an external power supply
> +charger to charge the in-built battery or supply power.
> +Some capability is provided to monitor this charger.

Why the linefeed here?  Take "Some" up to the previous line.

> +Required properties:
> +- compatible: Must be "ni,e31x-charger"
> +
> +Example:
> +
> +charger: charger@0{
> +	compatible = "ni,e31x-charger";
> +};

Not sure this really requires documentation.  Seems kinda simple.

I'll leave that up to Rob et al.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
