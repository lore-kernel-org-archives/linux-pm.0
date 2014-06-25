From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 8/8] arm64: boot: dts: update rtsm aemv8 dts with PSCI
 and idle states
Date: Wed, 25 Jun 2014 18:47:52 +0100
Message-ID: <20140625174751.GD15050@e102568-lin.cambridge.arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-9-git-send-email-lorenzo.pieralisi@arm.com>
 <20140625142714.GB15240@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:45211 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757578AbaFYRr5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jun 2014 13:47:57 -0400
In-Reply-To: <20140625142714.GB15240@leverpostej>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel>

On Wed, Jun 25, 2014 at 03:27:14PM +0100, Mark Rutland wrote:
> Hi Lorenzo,
> 
> On Wed, Jun 25, 2014 at 03:10:21PM +0100, Lorenzo Pieralisi wrote:
> > This patch updates the RTSM dts file with PSCI bindings and nodes
> > describing the AEMv8 model idle states parameters.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  arch/arm64/boot/dts/rtsm_ve-aemv8a.dts | 44 +++++++++++++++++++++++++++-------
> >  1 file changed, 36 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> > index d79de9c..4051ffb 100644
> > --- a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> > +++ b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> > @@ -27,37 +27,65 @@
> >  		serial3 = &v2m_serial3;
> >  	};
> >  
> > +	psci {
> > +		compatible = "arm,psci-0.2";
> 
> Where can I find a PSCI 0.2 implementation for the RTSM VE model? I
> couldn't find a link in the cover.
> 
> The upstream bootwrapper is not PSCI 0.2 compliant and it does not
> implement CPU_SUSPEND.

This patch was not meant to be merged, it was for DT bindings demonstration
purposes, you are definitely right. I will patch the FVP model dts and
add a link to trusted firmware that supports the FVP models power
controller.

> > +		method = "smc";
> > +		cpu_suspend = <0xc4000001>;
> > +		cpu_off = <0x84000002>;
> > +		cpu_on = <0xc4000003>;
> 
> Without "arm,psci" in the compatible list, these three properties are
> meaningless.

Right, my bad.

> > +	};
> > +
> >  	cpus {
> >  		#address-cells = <2>;
> >  		#size-cells = <0>;
> >  
> > +		idle-states {
> > +			entry-method = "arm,psci";
> > +
> > +			CPU_SLEEP_0: cpu-sleep-0 {
> > +				compatible = "arm,idle-state";
> > +				entry-method-param = <0x0010000>;
> > +				entry-latency-us = <40>;
> > +				exit-latency-us = <100>;
> > +				min-residency-us = <150>;
> > +			};
> > +
> > +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> > +				compatible = "arm,idle-state";
> > +				entry-method-param = <0x1010000>;
> > +				entry-latency-us = <500>;
> > +				exit-latency-us = <1000>;
> > +				min-residency-us = <2500>;
> > +			};
> > +		};
> > +
> 
> If this is going to live in the /cpus node, could it please be placed
> after the cpu nodes?

Ok.

> >  		cpu@0 {
> >  			device_type = "cpu";
> >  			compatible = "arm,armv8";
> >  			reg = <0x0 0x0>;
> > -			enable-method = "spin-table";
> > -			cpu-release-addr = <0x0 0x8000fff8>;
> > +			enable-method = "psci";
> 
> Changing the enable-method will break boot on a model when using a
> bootwrapper without PSCI support. Really we should leave it up to the
> bootwrapper to inject the enable method...

See above, you are right, I should have made it clear that this patch
was not meant for merging or testing and it was to provide a sample dts, will
fix it for v6.

Thanks,
Lorenzo

