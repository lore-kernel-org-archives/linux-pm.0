From: Dawei Chien <dawei.chien@mediatek.com>
Subject: Re: [PATCH v2 3/3] arm: dts: thermal: add thermal/auxadc node.
Date: Tue, 6 Sep 2016 11:28:30 +0800
Message-ID: <1473132510.15922.13.camel@mtksdaap41>
References: <1471492253-7185-1-git-send-email-dawei.chien@mediatek.com>
         <1471492253-7185-4-git-send-email-dawei.chien@mediatek.com>
         <1473121447.2201.20.camel@intel.com> <1473121807.2201.23.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:21129 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753534AbcIFD2h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Sep 2016 23:28:37 -0400
In-Reply-To: <1473121807.2201.23.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Fan Chen <fan.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Erin Lo <erin.lo@mediatek.com>

Dear Rui,

On Tue, 2016-09-06 at 08:30 +0800, Zhang Rui wrote:
> On 二, 2016-09-06 at 08:24 +0800, Zhang Rui wrote:
> > On 四, 2016-08-18 at 11:50 +0800, Dawei Chien wrote:
> > > 
> > > This adds the thermal controller and auxadc nodes
> > > to the Mediatek MT2701 dtsi file.
> > > 
> > > Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> > > ---
> > > This patch depned on:
> > > https://patchwork.kernel.org/patch/9249589/
> > > https://patchwork.kernel.org/patch/9249589/
> > Hmm, does this mean that I should take all these three patches and
> > hold
> > the patches in next merge window until the above patch has been
> > merged?
> > 
Yes, this patch is base on auxadc patchset.

> Patch 3/3 can not be applied on top of upstream kernel, so I guess it
> still has some other dependencies.
> I think I can apply patch 1, 2 first. And patch 3/3 should be handled
> in the dt tree.

Sorry, this patch is also need Mediatek's clock patchset what I miss to
add in dependency list, I would resend this dt tree once clock patch
merge, or resend this for right dependency on next version, thank you.

> thanks,
> rui
> > thanks,
> > rui 
> > > 
> > > ---
> > >  arch/arm/boot/dts/mt2701.dtsi |   44
> > > +++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/mt2701.dtsi
> > > b/arch/arm/boot/dts/mt2701.dtsi
> > > index e9150a4..cee4724 100644
> > > --- a/arch/arm/boot/dts/mt2701.dtsi
> > > +++ b/arch/arm/boot/dts/mt2701.dtsi
> > > @@ -87,6 +87,36 @@
> > >  		clock-output-names = "rtc32k";
> > >  	};
> > >  
> > > +	thermal-zones {
> > > +		cpu_thermal: cpu_thermal {
> > > +			polling-delay-passive = <1000>; /*
> > > milliseconds */
> > > +			polling-delay = <1000>; /* milliseconds */
> > > +
> > > +			thermal-sensors = <&thermal 0>;
> > > +			sustainable-power = <1000>;
> > > +
> > > +			trips {
> > > +				threshold: trip-point@0 {
> > > +					temperature = <68000>;
> > > +					hysteresis = <2000>;
> > > +					type = "passive";
> > > +				};
> > > +
> > > +				target: trip-point@1 {
> > > +					temperature = <85000>;
> > > +					hysteresis = <2000>;
> > > +					type = "passive";
> > > +				};
> > > +
> > > +				cpu_crit: cpu_crit@0 {
> > > +					temperature = <115000>;
> > > +					hysteresis = <2000>;
> > > +					type = "critical";
> > > +				};
> > > +			};
> > > +		};
> > > +	};
> > > +
> > >  	timer {
> > >  		compatible = "arm,armv7-timer";
> > >  		interrupt-parent = <&gic>;
> > > @@ -222,4 +252,18 @@
> > >  		clock-names = "baud", "bus";
> > >  		status = "disabled";
> > >  	};
> > > +
> > > +	thermal: thermal@1100b000 {
> > > +		#thermal-sensor-cells = <0>;
> > > +		compatible = "mediatek,mt2701-thermal";
> > > +		reg = <0 0x1100b000 0 0x1000>;
> > > +		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
> > > +		clocks = <&pericfg CLK_PERI_THERM>, <&pericfg
> > > CLK_PERI_AUXADC>;
> > > +		clock-names = "therm", "auxadc";
> > > +		resets = <&pericfg 0x10>;
> > > +		reset-names = "therm";
> > > +		mediatek,auxadc = <&auxadc>;
> > > +		mediatek,apmixedsys = <&apmixedsys>;
> > > +	};
> > > +
> > >  };
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm"
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


