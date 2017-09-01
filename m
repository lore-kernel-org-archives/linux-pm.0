From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: PM / OPP: add clocks per OPP node
 support
Date: Fri, 1 Sep 2017 21:01:32 +0800
Message-ID: <20170901130132.GA22788@b29396-OptiPlex-7040>
References: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
 <1503504610-12880-3-git-send-email-aisheng.dong@nxp.com>
 <20170831173920.4emtr5vkgvjcx6ac@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170831173920.4emtr5vkgvjcx6ac@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org, vireshk@kernel.org, nm@ti.com, rjw@rjwysocki.net, shawnguo@kernel.org, Anson.Huang@nxp.com, ping.bai@nxp.com, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 31, 2017 at 12:39:20PM -0500, Rob Herring wrote:
> On Thu, Aug 24, 2017 at 12:10:05AM +0800, Dong Aisheng wrote:
> > It's used for platforms where different OPPs may use different clocks.
> > With this extended binding, user could specify the correct clock for each
> > OPP node.
> > 
> > Cc: Viresh Kumar <vireshk@kernel.org>
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/opp/opp.txt | 52 +++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > index e36d261..40a4340 100644
> > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -152,6 +152,11 @@ Optional properties:
> >    hierarchy can be contained in multiple 32 bit values. i.e. <X Y Z1 Z2> in the
> >    above example, Z1 & Z2 refer to the version hierarchy Z.
> >  
> > +- clocks: Clock phandle and specifier used for this opp.
> > +
> > +- clock-names: clock names for this opp. The valid clock names are platform
> > +	       specific.
> 
> You don't need -names if there's only 1 clock.

Got it, will remove -name.

> But then how long until 
> we have a list of any random clocks some how associated with an OPP.
> 

Not sure whether it will really happen in the future. Even it happens,
as we usually only need the device parent clock, then probably better to
handle the left complicated things in clock driver or OPP device driver.

> I think this should really be solved within the clock framework. What 
> you really need is "set my parent clock to the source that can provide X 
> Hz". Could the assigned-clocks property work here (in the OPP nodes 
> rather than the cpu nodes)?
> 

I'm not quite sure i got your point. assigned-clocks seems a bit like function
the same as clocks property here, both are used to specifying the device
parent clock which provide X hz.

Or are you suggesting using assigned-clocks/assigned-clocks-rates instread
of clocks/opp-hz? Would you please clarify a bit more?

> > +
> >  - status: Marks the node enabled/disabled.
> >  
> >  Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
> > @@ -528,3 +533,50 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
> >  		};
> >  	};
> >  };
> > +
> > +Example 7: Single core ARM cortex A7, switch separate clocks for each OPP:
> 
> Can't you add this to an existing example? We don't need to enumerate 
> every possible option.

Okay, Will merge it.

Thanks

Regards
Dong Aisheng

> 
> Rob
