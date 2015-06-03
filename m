From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V6 1/3] OPP: Add new bindings to address shortcomings of
 existing bindings
Date: Wed, 3 Jun 2015 10:10:06 +0530
Message-ID: <20150603044006.GB4527@linux>
References: <cover.1432797343.git.viresh.kumar@linaro.org>
 <96d49e7e6747c1a65c5f285d70600795126641cc.1432797343.git.viresh.kumar@linaro.org>
 <20150602183120.GB24349@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36187 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbbFCEkL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 00:40:11 -0400
Received: by pdjm12 with SMTP id m12so65137104pdj.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2015 21:40:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150602183120.GB24349@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mike.turquette@linaro.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 02-06-15, 11:31, Stephen Boyd wrote:
> Also, is there already code written to handle these new
> bindings in the OPP library? If not, it would be good to write
> some to flush out any problems that may be lurking in actual
> implementation.

I had written code earlier for V2 or something, but then we went back
to the improvements in bindings and I stopped writing code for it.

http://marc.info/?i=cover.1423642246.git.viresh.kumar%40linaro.org

But that just requires to be updated a bit now. Will do that once I am
sure the bindings are all good now, with all Acks and RBYs.

> > +
> > +Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
> > +
> > +/ {
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu@0 {
> > +			compatible = "arm,cortex-a9";
> > +			reg = <0>;
> > +			next-level-cache = <&L2>;
> > +			clocks = <&clk_controller 0>;
> > +			clock-names = "cpu";
> > +			opp-supply = <&cpu_supply0>;
> 
> opp-supply isn't mentioned anywhere. Is that intentional? Is it

This should have been 'cpu-supply' instead.

> supposed to be cpu-supply still?

Yes.

> It isn't clear to me from the
> previous discussion where this all ended up, but I'm not sure how
> the in-kernel API is going to match up regulators with OPPs. I
> mean, how are we going to ask the OPP library what the
> min/max/target voltage is at a particular frequency when we have
> multiple regulators? Is that some string based interface? 
> 
> 	dev_pm_opp_get_voltage(name, &target, &min, &max);
> 
> Or a regulator pointer interface?
> 
> 	dev_pm_opp_get_voltage(regulator, &target, &min, &max);

Probably this.

> Or something else? Does this mean the OPP library is going to get
> the CPU device to request the opp-supply from the CPU node?

Maybe yes. That will clarify more with more code in place.

> Furthermore, why don't we care about opp-clocks? Are clocks
> somehow special?

There shouldn't be opp-supply in the first place and so no need of
opp-clocks as well.

-- 
viresh
