From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Thu, 13 Apr 2017 11:20:49 +0530
Message-ID: <20170413055049.GN5910@vireshk-i7>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <468e756b-7112-4006-b31d-9fcf1c32673d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33932 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbdDMFu6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2017 01:50:58 -0400
Received: by mail-pf0-f178.google.com with SMTP id c198so23883778pfc.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Apr 2017 22:50:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <468e756b-7112-4006-b31d-9fcf1c32673d@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, devicetree@vger.kernel.org

On 12-04-17, 18:05, Sudeep Holla wrote:
> 
> 
> On 20/03/17 09:32, Viresh Kumar wrote:
> [...]
> 
> > +
> > +Example 7: domain-Performance-state:
> > +(example: For 1GHz require domain state 1 and for 1.1 & 1.2 GHz require state 2)
> > +
> > +/ {
> > +	domain_opp_table: opp_table0 {
> > +		compatible = "operating-points-v2";
> > +
> > +		opp@1 {
> > +			domain-performance-state = <1>;
> > +			opp-microvolt = <975000 970000 985000>;
> > +		};
> > +		opp@2 {
> > +			domain-performance-state = <2>;
> > +			opp-microvolt = <1075000 1000000 1085000>;
> > +		};
> > +	};
> > +
> > +	foo_domain: power-controller@12340000 {
> > +		compatible = "foo,power-controller";
> > +		reg = <0x12340000 0x1000>;
> > +		#power-domain-cells = <0>;
> > +		operating-points-v2 = <&domain_opp_table>;
> > +	}
> > +
> > +	cpu0_opp_table: opp_table1 {
> > +		compatible = "operating-points-v2";
> > +		opp-shared;
> > +
> > +		opp@1000000000 {
> > +			opp-hz = /bits/ 64 <1000000000>;
> > +			domain-performance-state = <1>;
> > +		};
> > +		opp@1100000000 {
> > +			opp-hz = /bits/ 64 <1100000000>;
> > +			domain-performance-state = <2>;
> > +		};
> > +		opp@1200000000 {
> > +			opp-hz = /bits/ 64 <1200000000>;
> > +			domain-performance-state = <2>;
> > +		};
> > +	};
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu@0 {
> > +			compatible = "arm,cortex-a9";
> > +			reg = <0>;
> > +			clocks = <&clk_controller 0>;
> > +			clock-names = "cpu";
> > +			operating-points-v2 = <&cpu0_opp_table>;
> > +			power-domains = <&foo_domain>;
> > +		};
> > +	};
> > +};
> 
> 
> Thinking more about this above example, I think you need more
> explanation. So in the above case you have cpu with clock controller,
> power-domain and the OPP table info, I can think of few things that need
> to be explicit:
> 
> 1. How does the precedence look like ?

Just think of the power-domain as a regulator here. If we are
increasing frequency of the device, power-domain needs to be
programmed first followed by the clock.

> 2. Since power-domains with OPP table control the performance state, do

They control performance state of the domains, not the devices.

>    we ignore clock and operating-points-v2 in the above case completely?

No. They are separate.

> 
> 3. Will the power-domain drive the OPP ?

power-domain will driver its own state using its own OPP table.
Devices may fine tune within those states.

-- 
viresh
