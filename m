From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC 3/6] power: supply: Ettus Research E31x charger driver
Date: Mon, 25 Feb 2019 17:38:27 -0600
Message-ID: <20190225233827.GA29092@bogus>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
 <20190212010143.3729-4-virendra.kakade@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212010143.3729-4-virendra.kakade@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Virendra Kakade <virendra.kakade@ni.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lee.jones@linaro.org, mark.rutland@arm.com, sre@kernel.org, moritz.fischer@ettus.com
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 11, 2019 at 07:01:40PM -0600, Virendra Kakade wrote:
> Document bindings for the E31x devices charger.

Fix your subject. It is the same as patch 4.

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
> +
>  Example:
>  
>  pmu {
>  	compatible = "ni,e31x-pmu";
>  	regmap = <&devctrl>;

regmap is a linux thing. How is the h/w addressed?

>  	status = "okay";
> +	charger: charger@0{

unit-address without 

> +		compatible = "ni,e31x-charger";

No other properties or DT resources? Then you don't need a child node in 
DT. The driver for the parent node can instantiate child devices like a 
charger.

> +	};
>  };
>  
