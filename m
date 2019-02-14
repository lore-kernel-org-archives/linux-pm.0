From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RFC 1/6] mfd: Support for Ettus Research E31x devices PMU
Date: Thu, 14 Feb 2019 09:23:10 +0000
Message-ID: <20190214092310.GE13737@dell>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
 <20190212010143.3729-2-virendra.kakade@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212010143.3729-2-virendra.kakade@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Virendra Kakade <virendra.kakade@ni.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, moritz.fischer@ettus.com
List-Id: linux-pm@vger.kernel.org

On Mon, 11 Feb 2019, Virendra Kakade wrote:

> Document bindings for E31x device PMU MFD driver.
> 
> Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
> ---
>  Documentation/devicetree/bindings/mfd/e31x-pmu.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> new file mode 100644
> index 000000000000..ebb5625f6c74
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> @@ -0,0 +1,14 @@
> +Ettus Research/National Instruments E31x PMU MFD driver

Please expand on what PMU is.

MFD is a Linuxisum and has no place in the description.

You can supplement it with "parent device" or some such.

> +Required properties:
> +- compatible : Must be "ni,e31x-pmu"
> +- regmap     : Must be <&regmapnode>
> +
> +Example:
> +
> +pmu {
> +	compatible = "ni,e31x-pmu";

No address?

> +	regmap = <&devctrl>;
> +	status = "okay";

Not required in DT documentation.

> +};
> +

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
