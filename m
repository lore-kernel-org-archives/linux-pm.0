From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 3/3] arm64: dts: register Hi6220's thermal zone for power
 allocator
Date: Thu, 25 Feb 2016 10:41:52 +0800
Message-ID: <20160225024152.GA20591@leoy-linaro>
References: <1455983529-9559-1-git-send-email-leo.yan@linaro.org>
 <1455983529-9559-4-git-send-email-leo.yan@linaro.org>
 <20160224182856.GD3006@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35888 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757458AbcBYCmN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2016 21:42:13 -0500
Received: by mail-pa0-f47.google.com with SMTP id yy13so23426218pab.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2016 18:42:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160224182856.GD3006@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, kongxinwei <kong.kongxinwei@hisilicon.com>, Punit Agrawal <Punit.Agrawal@arm.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi Javi,

Thanks for review.

On Wed, Feb 24, 2016 at 06:28:57PM +0000, Javi Merino wrote:
> On Sat, Feb 20, 2016 at 11:52:09PM +0800, Leo Yan wrote:
> > With profiling Hi6220's power modeling so get dynamic coefficient and
> > sustainable power. So pass these parameters from DT.
> > 
> > Now enable power allocator wit only one actor for CPU part, so directly
> > use cluster0's thermal sensor for monitoring temperature.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 36 +++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > index 50ba1b0..3608a3e 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > @@ -6,6 +6,7 @@
> >  
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/clock/hi6220-clock.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >  
> >  / {
> >  	compatible = "hisilicon,hi6220";
> > @@ -87,6 +88,7 @@
> >  			cooling-max-level = <0>;
> >  			#cooling-cells = <2>; /* min followed by max */
> >  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> > +			dynamic-power-coefficient = <311>;
> >  		};
> >  
> >  		cpu1: cpu@1 {
> > @@ -322,5 +324,39 @@
> >  			clock-names = "thermal_clk";
> >  			#thermal-sensor-cells = <1>;
> >  		};
> > +
> > +		thermal-zones {
> > +
> > +			cls0: cls0 {
> > +				polling-delay = <1000>;
> > +				polling-delay-passive = <100>;
> > +				sustainable-power = <3326>;
> > +
> > +				/* sensor ID */
> > +				thermal-sensors = <&tsensor 2>;
> > +
> > +				trips {
> > +					threshold: trip-point@0 {
> > +						temperature = <65000>;
> > +						hysteresis = <1000>;
> 
> As far as I know, hysteresis is ignored in the thermal subsystem right
> now, so you could remove it from both trip points.

Will remove it.

> > +						type = "passive";
> > +					};
> > +
> > +					target: trip-point@1 {
> > +						temperature = <75000>;
> > +						hysteresis = <1000>;
> > +						type = "passive";
> > +					};
> > +				};
> > +
> > +				cooling-maps {
> > +					map0 {
> > +						trip = <&target>;
> > +						contribution = <1024>;
> 
> As Hikey has only one voltage domain, you only have one cpu cooling
> device.  "contribution" is only useful when you have more than one
> cooling device, as it's relative to the other cooling device's
> contribution.  You can remove contribution from here.
> 
> Other than this minor stuff, it looks good to me. FWIW,
> 
> Reviewed-by: Javi Merino <javi.merino@arm.com>

Thanks for review. Will sent out new version.

Thanks,
Leo Yan

> > +						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +					};
> > +				};
> > +			};
> > +		};
> >  	};
> >  };
