From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Thu, 15 Oct 2015 17:22:43 -0700
Message-ID: <20151016002243.GA23912@codeaurora.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
 <2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
 <55F72C97.2030306@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55F72C97.2030306@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On 09/14, Rob Herring wrote:
> On 09/11/2015 07:01 AM, Viresh Kumar wrote:
> > Regulators already have stable DT bindings, wherein the consumer (of
> > supplies) will have following for each regulator/supply.
> > 
> > <name>-supply: <phandle to the regulator node>;
> > 
> > Current OPP bindings extend above, by transforming it into a list of
> > phandles. But we missed the <name> string, which is used to identify the
> > regulator.
> > 
> > And looking from regulators perspective, having two different ways of
> > specifying regulators doesn't seem like a step forward, it also means we
> > have to update every single device binding. And things will become
> > complex.
> > 
> > Another way to support multiple regulators per device (in OPP V2
> > bindings) is to leave regulator consumer bindings as is, and create a
> > 'supply-names' property in the opp-table node, which will contain a list
> > of strings. The names in this list shall match 'name' from the
> > '<name>-supply' strings present in the device node.
> > 
> > The strings in this list also specify the order in which values must be
> > present in 'opp-microvolt' and 'opp-microamp' properties.
> > 
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/opp/opp.txt | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > index 0cb44dc21f97..8759bc4783ed 100644
> > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -69,6 +69,13 @@ This describes the OPPs belonging to a device. This node can have following
> >  - compatible: Allow OPPs to express their compatibility. It should be:
> >    "operating-points-v2".
> >  
> > +- supply-names: This is a required property, only if multiple supplies are
> > +  available for the device. Otherwise it is optional.
> > +
> > +  This list is used to pass names of all the device supplies. The order of names
> > +  present here is important, as that should match the order in which values are
> > +  present in 'opp-microvolt' and 'opp-microamp' properties.
> > +
> 
> What if we have a 2nd device and supply rail? For example, what if the
> L2$ has a separate rail from the cores but is linked to the OPPs.

I'm lost why we need this property at all. What happened to using

 opp-microvolt-0 = <1 2 3>;
 opp-microvolt-1 = <1>;
 opp-microvolt-2 = <3 4 5>;
 etc.

That seems to avoid any problem with 3 vs. 1 element properties
combined into one large array. Having supply-names seems too
brittle and would tie us to a particular OPP user's decision to
call supplies by some name.

Also, I've seen devices that are split across two power domains.
These devices aren't CPUs, but they are other devices including
L2 caches. So we're going to need either multiple regulator
support or multiple "power domain at a particular performance
levels" support somehow.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
