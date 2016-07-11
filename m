From: dawei chien <dawei.chien@mediatek.com>
Subject: Re: [PATCH 3/3] arm: dts: thermal: add thermal/auxadc node.
Date: Mon, 11 Jul 2016 16:56:55 +0800
Message-ID: <1468227415.15776.34.camel@mtksdaap41>
References: <1467882386-40544-1-git-send-email-dawei.chien@mediatek.com>
	 <1467882386-40544-4-git-send-email-dawei.chien@mediatek.com>
	 <577E465D.8070004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <577E465D.8070004@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Fan Chen <fan.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Erin Lo <erin.lo@mediatek.com>
List-Id: linux-pm@vger.kernel.org

Dear Keerthy,

On Thu, 2016-07-07 at 17:39 +0530, Keerthy wrote:
> 
> On Thursday 07 July 2016 02:36 PM, Dawei Chien wrote:
> > This adds the thermal controller and auxadc nodes
> > to the Mediatek MT2701 dtsi file.
> >
> > Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> > ---
> > This patch depned on:
> > https://patchwork.kernel.org/patch/9213545/
> > ---
> >   arch/arm/boot/dts/mt2701.dtsi |   43 +++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 43 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> > index 2ac8b50..0834a23 100644
> > --- a/arch/arm/boot/dts/mt2701.dtsi
> > +++ b/arch/arm/boot/dts/mt2701.dtsi
> > @@ -77,6 +77,36 @@
> >   		#clock-cells = <0>;
> >   	};
> >
> > +	thermal-zones {
> > +		cpu_thermal: cpu_thermal {
> > +			polling-delay-passive = <1000>; /* milliseconds */
> > +			polling-delay = <1000>; /* milliseconds */
> > +
> > +			thermal-sensors = <&thermal 0>;
> > +			sustainable-power = <1000>;
> > +
> > +			trips {
> > +				threshold: trip-point@0 {
> > +					temperature = <68000>;
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> > +
> > +				target: trip-point@1 {
> > +					temperature = <85000>;
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> > +
> > +				cpu_crit: cpu_crit@0 {
> > +					temperature = <115000>;
> > +					hysteresis = <2000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> 
> are there any corresponding cooling-maps?

Since MT2701 does not register CPUFREQ cooling device and its' own
device node, I could not add cooling-maps so far.
Could we add cooling map after CPUFREQ ready, thank you.

> 
> >   	timer {
> >   		compatible = "arm,armv7-timer";
> >   		interrupt-parent = <&gic>;
> > @@ -183,4 +213,17 @@
> >   		clocks = <&uart_clk>;
> >   		status = "disabled";
> >   	};
> > +
> > +	thermal: thermal@1100b000 {
> > +		#thermal-sensor-cells = <0>;
> > +		compatible = "mediatek,mt2701-thermal";
> > +		reg = <0 0x1100b000 0 0x1000>;
> > +		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
> > +		clock-names = "therm", "auxadc";
> > +		resets = <&pericfg 0x10>;
> > +		reset-names = "therm";
> > +		mediatek,auxadc = <&auxadc>;
> > +		mediatek,apmixedsys = <&apmixedsys>;
> > +	};
> >   };
> >
