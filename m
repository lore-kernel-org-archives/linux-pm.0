From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/3] devicetree: bindings: Add optional
 dynamic-power-coefficient property
Date: Mon, 9 Nov 2015 11:45:42 -0600
Message-ID: <20151109174542.GA19016@rob-hp-laptop>
References: <1447090163-13700-1-git-send-email-punit.agrawal@arm.com>
 <1447090163-13700-2-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447090163-13700-2-git-send-email-punit.agrawal@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: devicetree@vger.kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, edubezval@gmail.com, dawei.chien@mediatek.com, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 09, 2015 at 05:29:21PM +0000, Punit Agrawal wrote:
> The dynamic power consumption of a device is proportional to the
> square of voltage (V) and the clock frequency (f). It can be expressed as
> 
> Pdyn = dynamic-power-coefficient * V^2 * f.
> 
> The coefficient represents the running time dynamic power consumption in
> units of mw/MHz/uVolt^2 and can be used in the above formula to
> calculate the dynamic power in mW.

I have no issue with the binding, but I wonder if a single value is 
really sufficient to model this. Don't you also need a static component? 

Rob

> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 91e6e5c..c33362d 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -240,6 +240,23 @@ nodes to be present and contain the properties described below.
>  		Definition: Specifies the syscon node controlling the cpu core
>  			    power domains.
>  
> +	- dynamic-power-coefficient
> +		Usage: optional
> +		Value type: <prop-encoded-array>
> +		Definition: A u32 value that represents the running time dynamic
> +			    power coefficient in units of mW/MHz/uVolt^2. The
> +			    coefficient can either be calculated from power
> +			    measurements or derived by analysis.
> +
> +			    The dynamic power consumption of the CPU  is
> +			    proportional to the square of the Voltage (V) and
> +			    the clock frequency (f). The coefficient is used to
> +			    calculate the dynamic power as below -
> +
> +			    Pdyn = dynamic-power-coefficient * V^2 * f
> +
> +			    where voltage is in uV, frequency is in MHz.
> +
>  Example 1 (dual-cluster big.LITTLE system 32-bit):
>  
>  	cpus {
> -- 
> 2.5.3
> 
