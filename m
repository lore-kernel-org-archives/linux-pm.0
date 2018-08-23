From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: RE: [PATCH 4/5] arm64: dts: add QorIQ LX2160A SoC support
Date: Thu, 23 Aug 2018 15:00:03 +0000
Message-ID: <AM6PR04MB47899CE5F871731749E59636F3370@AM6PR04MB4789.eurprd04.prod.outlook.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-5-git-send-email-vabhav.sharma@nxp.com>
 <20180821101652.GA18139@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180821101652.GA18139@e107155-lin>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>, Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>, "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, Sriram Dash <sriram.dash@nxp.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Udit Kumar <udit.kumar@nxp.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Varun
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Tuesday, August 21, 2018 3:47 PM
> To: Vabhav Sharma <vabhav.sharma@nxp.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> robh+dt@kernel.org; mark.rutland@arm.com; linuxppc-dev@lists.ozlabs.org;
> linux-arm-kernel@lists.infradead.org; mturquette@baylibre.com;
> sboyd@kernel.org; rjw@rjwysocki.net; viresh.kumar@linaro.org; linux-
> clk@vger.kernel.org; linux-pm@vger.kernel.org; linux-kernel-
> owner@vger.kernel.org; catalin.marinas@arm.com; will.deacon@arm.com;
> gregkh@linuxfoundation.org; arnd@arndb.de;
> kstewart@linuxfoundation.org; yamada.masahiro@socionext.com;
> linux@armlinux.org.uk; Varun Sethi <V.Sethi@nxp.com>; Udit Kumar
> <udit.kumar@nxp.com>; Ramneek Mehresh <ramneek.mehresh@nxp.com>;
> Ying Zhang <ying.zhang22455@nxp.com>; Nipun Gupta
> <nipun.gupta@nxp.com>; Priyanka Jain <priyanka.jain@nxp.com>; Yogesh
> Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Sriram Dash
> <sriram.dash@nxp.com>; Sudeep Holla <sudeep.holla@arm.com>
> Subject: Re: [PATCH 4/5] arm64: dts: add QorIQ LX2160A SoC support
> 
> On Mon, Aug 20, 2018 at 12:17:15PM +0530, Vabhav Sharma wrote:
> > LX2160A SoC is based on Layerscape Chassis Generation 3.2 Architecture.
> >
> > LX2160A features an advanced 16 64-bit ARM v8 CortexA72 processor
> > cores in 8 cluster, CCN508, GICv3,two 64-bit DDR4 memory controller, 8
> > I2C controllers, 3 dspi, 2 esdhc,2 USB 3.0, mmu 500, 3 SATA, 4 PL011
> > SBSA UARTs etc.
> >
> > Signed-off-by: Ramneek Mehresh <ramneek.mehresh@nxp.com>
> > Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 572
> > +++++++++++++++++++++++++
> >  1 file changed, 572 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > new file mode 100644
> > index 0000000..e35e494
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > @@ -0,0 +1,572 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT) // // Device Tree
> > +Include file for Layerscape-LX2160A family SoC.
> > +//
> > +// Copyright 2018 NXP
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/memreserve/ 0x80000000 0x00010000;
> > +
> > +/ {
> > +	compatible = "fsl,lx2160a";
> > +	interrupt-parent = <&gic>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		// 8 clusters having 2 Cortex-A72 cores each
> > +		cpu@0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a72";
> > +			reg = <0x0>;
> > +			clocks = <&clockgen 1 0>;
> > +			next-level-cache = <&cluster0_l2>;
> 
> If you expect to get cache properties in sysfs entries, you need to populate
> them here and for each L2 cache.
Rather sysfs, If Entry is not present then print  "cacheinfo: Unable to detect cache hierarchy for CPU 0" appears in boot log which is bad saying something is not present.
Either this print is require change to debug instead of warning.
> 
> [...]
> 
> > +
> > +	rstcr: syscon@1e60000 {
> > +		compatible = "syscon";
> > +		reg = <0x0 0x1e60000 0x0 0x4>;
> > +	};
> > +
> > +	reboot {
> > +		compatible ="syscon-reboot";
> > +		regmap = <&rstcr>;
> > +		offset = <0x0>;
> > +		mask = <0x2>;
> 
> Is this disabled in bootloader ? With PSCI, it's preferred to use
> SYSTEM_RESET/OFF. EL3 f/w may need to do some housekeeping on
> poweroff.
No, PSCIv0.2 is used and control passes to EL3 fw via smc call, psci node is present in the file.
This node is not required and keeping it in case PSCI is not used.
> 
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <1 13 4>, // Physical Secure PPI, active-low
> 
> The comment says active low but the value 4 indicates it's HIGH from
> "include/dt-bindings/interrupt-controller/irq.h"
Thanks, I will change the entries to existing definition IRQ_TYPE_LEVEL_LOW,GIC_PPI which is self-explanatory and not require comments
> 
> > +			     <1 14 4>, // Physical Non-Secure PPI, active-low
> > +			     <1 11 4>, // Virtual PPI, active-low
> > +			     <1 10 4>; // Hypervisor PPI, active-low
> > +	};
> > +
> > +	pmu {
> > +		compatible = "arm,armv8-pmuv3";
> 
> More specific compatible preferably "arm,cortex-a72-pmu" ?
Sure.
> 
> --
> Regards,
> Sudeep
