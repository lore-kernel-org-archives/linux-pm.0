From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 1/9] PM / OPP: Reword binding supporting multiple
 regulators per device
Date: Mon, 14 Nov 2016 18:13:02 -0800
Message-ID: <20161115021302.GR5177@codeaurora.org>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <28119b44689921f3c3cc00be49bff2bb99b32162.1477463128.git.viresh.kumar@linaro.org>
 <20161109145828.p6vvsd5bygkzjcmh@sirena.org.uk>
 <20161110040440.GA11670@vireshk-i7>
 <20161110163659.rk67qrmnrovq2ktf@sirena.org.uk>
 <20161110180940.GD11670@vireshk-i7>
 <20161110225126.GK16026@codeaurora.org>
 <20161111031120.GE11670@vireshk-i7>
 <20161115015952.steomn4azdl5iv6z@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57932 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964792AbcKOCNE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2016 21:13:04 -0500
Content-Disposition: inline
In-Reply-To: <20161115015952.steomn4azdl5iv6z@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mark Brown <broonie@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, d-gerlach@ti.com, devicetree@vger.kernel.org

On 11/14, Rob Herring wrote:
> On Fri, Nov 11, 2016 at 08:41:20AM +0530, Viresh Kumar wrote:
> > On 10-11-16, 14:51, Stephen Boyd wrote:
> > > 
> > > No. The supply names (and also clock names/index) should be left
> > > up to the consumer of the OPP table. We don't want to encode any
> > > sort of details like this between the OPP table and the consumer
> > > of it in DT because then it seriously couples the OPP table to
> > > the consumer device. "The binding" in this case that needs to be
> > > updated is the consumer binding, to indicate that it correlated
> > > foo-supply and bar-supply to index 0 and 1 of the OPP table
> > > voltages.
> > 
> > Are you saying that we shall have a property like this then?
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > index ee91cbdd95ee..733946df2fb8 100644
> > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -389,7 +389,10 @@ Example 4: Handling multiple regulators
> >                         compatible = "arm,cortex-a7";
> >                         ...
> >  
> > -                       cpu-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
> > +                       vcc0-supply = <&cpu_supply0>;
> > +                       vcc1-supply = <&cpu_supply1>;
> > +                       vcc2-supply = <&cpu_supply2>;
> > +                       opp-supply-names = "vcc0", "vcc1", "vcc2";
> 
> Uh, no. You already have the names in the *-supply properties. Yes, they 
> are a PIA to retrieve compared to a *-names property, but that is the 
> nature of this style of binding.
> 

I think the problem is that Viresh wants the binding to be "self
describing" so that the OPP can be used without a driver knowing
that a supply corresponds to a particular column in the voltage
table. I don't understand that though. Can't we set the supply
names from C code somewhere based on the consumer of the OPPs?
Similar to how we pick the different tables based on fuses?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
