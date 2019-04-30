From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/4] Documentation: devicetree: add PPMU events
 description
Date: Tue, 30 Apr 2019 17:36:29 -0500
Message-ID: <20190430223629.GA22317@bogus>
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0@eucas1p2.samsung.com>
 <1555681688-19643-4-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555681688-19643-4-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com, krzk@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 19, 2019 at 03:48:07PM +0200, Lukasz Luba wrote:
> Extend the documenation by events description with new 'event-data-type'
> field. Add example how the event might be defined in DT.

Why do we need event types in DT? We don't do this for other h/w such as 
ARM PMU.

> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../devicetree/bindings/devfreq/event/exynos-ppmu.txt  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> index 3e36c1d..47feb5f 100644
> --- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> @@ -145,3 +145,21 @@ Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
>  			reg = <0x104d0000 0x2000>;
>  			status = "disabled";
>  		};
> +
> +The 'event' type specified in the PPMU node defines 'event-name'
> +which also contains 'id' number and optionally 'event-data-type'.
> +
> +Example:
> +
> +		events {
> +			ppmu_leftbus_0: ppmu-event0-leftbus {
> +				event-name = "ppmu-event0-leftbus";
> +				event-data-type = <PPMU_RO_DATA_CNT>;
> +			};
> +		};
> +
> +The 'event-data-type' defines the type of data which shell be counted
> +by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for
> +all possible type, i.e. count read requests, count write data in bytes,
> +etc. This field is optional and when it is missing, the driver code will
> +use default data type.
> -- 
> 2.7.4
> 
