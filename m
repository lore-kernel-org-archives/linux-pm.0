From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V2 1/2] ARM: imx: add vddsoc/pu setpoint info into dts
Date: Wed, 18 Dec 2013 16:24:48 +0800
Message-ID: <20131218082445.GJ6691@S2101-09.ap.freescale.net>
References: <1387318102-11070-1-git-send-email-b20788@freescale.com>
 <20131218070538.GE6691@S2101-09.ap.freescale.net>
 <20131218201742.GB20579@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:53172
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751196Ab3LRIXo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 03:23:44 -0500
Content-Disposition: inline
In-Reply-To: <20131218201742.GB20579@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Wed, Dec 18, 2013 at 03:17:42PM -0500, Anson Huang wrote:
> > > +		operating-points = <
> > > +			/* kHz    uV */
> > > +			1200000 1275000
> > > +			996000  1250000
> > > +			792000  1150000
> > > +			396000  975000
> > > +		>;
> > > +		fsl,soc-operating-points = <
> > > +			/* ARM kHz  SOC-PU uV */
> > > +			1200000 1275000
> > > +			996000	1250000
> > > +			792000	1175000
> > > +			396000	1175000
> > > +		>;
> > > +		clock-latency = <61036>; /* two CLK32 periods */
> > > +		clocks = <&clks 104>, <&clks 6>, <&clks 16>,
> > > +			 <&clks 17>, <&clks 170>;
> > > +		clock-names = "arm", "pll2_pfd2_396m", "step",
> > > +			      "pll1_sw", "pll1_sys";
> > > +		arm-supply = <&reg_arm>;
> > > +		pu-supply = <&reg_pu>;
> > > +		soc-supply = <&reg_soc>;
> > 
> > Any properties in the example that are required for a successful driver
> > probe should be documented in 'Required properties', and others are in
> > 'Optional properties'.
> 
> I will not list so many properties as example as long as I describe this
> preoperties should be included in cpu@0's node?

The example is good.  But you also need to document properties clocks,
clock-names, arm-supply etc.

Shawn

