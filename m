From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 1/9] PM / OPP: Reword binding supporting multiple
 regulators per device
Date: Thu, 10 Nov 2016 14:51:26 -0800
Message-ID: <20161110225126.GK16026@codeaurora.org>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <28119b44689921f3c3cc00be49bff2bb99b32162.1477463128.git.viresh.kumar@linaro.org>
 <20161109145828.p6vvsd5bygkzjcmh@sirena.org.uk>
 <20161110040440.GA11670@vireshk-i7>
 <20161110163659.rk67qrmnrovq2ktf@sirena.org.uk>
 <20161110180940.GD11670@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35688 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753298AbcKJWv2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 17:51:28 -0500
Content-Disposition: inline
In-Reply-To: <20161110180940.GD11670@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, devicetree@vger.kernel.org

On 11/10, Viresh Kumar wrote:
> On 10-11-16, 16:36, Mark Brown wrote:
> > On Thu, Nov 10, 2016 at 09:34:40AM +0530, Viresh Kumar wrote:
> > > On 09-11-16, 14:58, Mark Brown wrote:
> > > > On Wed, Oct 26, 2016 at 12:02:56PM +0530, Viresh Kumar wrote:
> > 
> > > > > +  Entries for multiple regulators shall be provided in the same field separated
> > > > > +  by angular brackets <>. The OPP binding doesn't provide any provisions to
> > > > > +  relate the values to their power supplies or the order in which the supplies
> > > > > +  need to be configured.
> > 
> > > > I don't understand how this works.  If we have an unordered list of
> > > > values to set for regulators how will we make sense of them?
> > 
> > > The platform driver is responsible to identify the order and pass it on to the
> > > OPP core. And the platform driver needs to have that hard coded.
> > 
> > That *really* should be in the binding.
> 
> Okay, how do you suggest doing that? Will a property like supply-names
> in the OPP table be fine? Like this:
> 
> @@ -369,13 +378,16 @@ Example 4: Handling multiple regulators
>                         compatible = "arm,cortex-a7";
>                         ...
>  
> -                       cpu-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
> +                       vcc0-supply = <&cpu_supply0>;
> +                       vcc1-supply = <&cpu_supply1>;
> +                       vcc2-supply = <&cpu_supply2>;
>                         operating-points-v2 = <&cpu0_opp_table>;
>                 };
>         };
>  
>         cpu0_opp_table: opp_table0 {
>                 compatible = "operating-points-v2";
> +               supply-names = "vcc0", "vcc1", "vcc2";
>                 opp-shared;
> 

No. The supply names (and also clock names/index) should be left
up to the consumer of the OPP table. We don't want to encode any
sort of details like this between the OPP table and the consumer
of it in DT because then it seriously couples the OPP table to
the consumer device. "The binding" in this case that needs to be
updated is the consumer binding, to indicate that it correlated
foo-supply and bar-supply to index 0 and 1 of the OPP table
voltages.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
