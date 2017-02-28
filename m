From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 1/7] PM / Domains: Introduce "performance-states"
 binding
Date: Tue, 28 Feb 2017 11:06:23 +0530
Message-ID: <20170228053623.GC19417@vireshk-i7>
References: <cover.1487926924.git.viresh.kumar@linaro.org>
 <132e9200102bf2f1175567f0862596d098363d9e.1487926924.git.viresh.kumar@linaro.org>
 <20170228003108.2jcclpkawi3o74c2@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170228003108.2jcclpkawi3o74c2@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 27-02-17, 18:31, Rob Herring wrote:
> On Fri, Feb 24, 2017 at 02:36:33PM +0530, Viresh Kumar wrote:
> > Some platforms have the capability to configure the performance state of
> > their power domains. The process of configuring the performance state is
> > pretty much platform dependent and we may need to work with a wide range
> > of configurables. For some platforms, like Qcom, it can be a positive
> > integer value alone, while in other cases it can be voltage levels, etc.
> > 
> > The power-domain framework until now was only designed for the idle
> > state management of the device and this needs to change in order to
> > reuse the power-domain framework for active state management of the
> > devices.
> > 
> > This patch adds DT bindings to describe the performance states of a
> > power domain. The power domain node needs to contain a
> > "performance-states" node, which itself is an array of per-state nodes.
> > Each per-state node represents individual performance state of a device.
> > Individual nodes are identified by their (mandatory) "reg" field. These
> > nodes can also contain an optional "domain-microvolt" property. More
> > properties can be added later on once we have more platforms using it.
> > 
> > If the consumers don't need the capability of switching to different
> > domain performance states at runtime, then they can simply define their
> > required domain performance state in their node directly using the
> > "domain-performance-state" property. Otherwise the consumers can define
> > their requirements with help of other infrastructure, for example the
> > OPP table (added in a later commit).
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Tested-by: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > ---
> >  .../devicetree/bindings/power/power_domain.txt     | 67 ++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> > index 723e1ad937da..9be09e576f68 100644
> > --- a/Documentation/devicetree/bindings/power/power_domain.txt
> > +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> > @@ -38,6 +38,33 @@ phandle arguments (so called PM domain specifiers) of length specified by the
> >    domain's idle states. In the absence of this property, the domain would be
> >    considered as capable of being powered-on or powered-off.
> >  
> > +- performance-states : This describes the performance states of a PM domain.
> > +  The performance-states node reflects the performance states of this PM domain
> > +  and not the performance states of the devices or sub-domains in the PM domain.
> > +  Sub domains can have their own performance states. Sub domains without their
> > +  own performance states are governed by the performance states of the parent
> > +  domain and the "domain-performance-state" properties of their consumers refer
> > +  to the "reg" properties of the nodes in the parent domain.
> > +
> > +  Required properties of the performance-states node:
> > +  - compatible: Allow performance states to express their compatibility. It
> > +    should be: "domain-performance-state".
> > +
> > +  - nodes: The performance-states node should contain one or
> > +    more nodes, each representing a supported performance state.
> > +
> > +    Required properties of the performance state nodes:
> > +    - reg: A positive integer value representing the performance level
> > +      associated with a performance state. The integer value '0' represents the
> > +      lowest performance level and the highest value represents the highest
> > +      performance level. The exact meaning and performance implications of
> > +      individual values is left to be defined by the user platform.
> > +
> > +    Optional properties of performance state nodes:
> > +    - domain-microvolt: voltage in micro Volts. A single regulator's voltage is
> > +      specified with an array of size one or three.  Single entry is for target
> > +      voltage and three entries are for <target min max> voltages.
> > +
> >  Example:
> >  
> >  	power: power-controller@12340000 {
> > @@ -118,4 +145,44 @@ The node above defines a typical PM domain consumer device, which is located
> >  inside a PM domain with index 0 of a power controller represented by a node
> >  with the label "power".
> >  
> > +Optional properties:
> > +- domain-performance-state: A positive integer value representing the minimum
> > +  performance level (of the parent domain) required by the consumer for its
> > +  working. The integer value '0' represents the lowest performance level and the
> > +  highest value represents the highest performance level. The value of
> > +  domain-performance-state field should match one of the "reg" fields in the
> > +  "performance-states" table of the parent power domain.
> > +
> > +
> > +Example:
> > +
> > +	parent: power-controller@12340000 {
> > +		compatible = "foo,power-controller";
> > +		reg = <0x12340000 0x1000>;
> > +		#power-domain-cells = <0>;
> > +
> > +		performance-states {
> > +			compatible = "domain-performance-state";
> > +			pstate@1 {
> > +				reg = <1>;
> > +				domain-microvolt = <970000 975000 985000>;
> 
> This doesn't look like "<target> <min> <max>".

Wow, even the examples in the OPP document have these screwed up :(

> With that fixed,
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
