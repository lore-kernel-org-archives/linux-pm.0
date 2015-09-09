From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 9 Sep 2015 14:00:31 +0530
Message-ID: <20150909083031.GB5266@linux>
References: <20150811120124.GH5509@linux>
 <20150811132756.GG18282@x1>
 <20150811142812.GJ5509@linux>
 <20150811151736.GO18282@x1>
 <20150812110841.GC20238@linux>
 <20150826120628.GZ19409@x1>
 <20150902080639.GA26744@linux>
 <CAL_JsqKMGp+3Z+oO6E0YYzjTCb=-R_QM=YF=B33NWayWmV057A@mail.gmail.com>
 <20150909062722.GA5266@linux>
 <20150909075930.GB3260@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150909075930.GB3260@x1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ajit Pal Singh <ajitpal.singh-qxv4g6HH51o@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 09-09-15, 08:59, Lee Jones wrote:
> Thanks for doing this Viresh.  I appreciate your efforts.

I wanted to get this sorted out, before we meet face to face :)

> > -------------------------8<-------------------------
> > From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Date: Wed, 9 Sep 2015 11:47:37 +0530
> > Subject: [PATCH] PM / OPP: Add "opp-cuts" and "opp-supply-version" bindings
> > 
> > For many platforms it is unknown until runtime, about which OPPs should
> > be used or if used what should be voltage range for the supplies for a
> > particular frequency. And this mostly depends on the version of the
> > device or hardware, for which the OPPs are getting used.
> > 
> > This patch adds two new OPP bindings to get this solved.
> > 
> > 1. "opp-cuts": The purpose of this binding is to allow the platform to
> >    identify the valid OPPs based on the different levels of versions
> >    with which the hardware is identified.
> 
> "cuts" is a very specific name for such a generic property.

I agree... I wasn't concerned much about naming on the first try and
so just wrote it quickly enough to get an overall idea ..

> You are using the format I suggested weeks ago, which I like.

I must have missed that :(

> 
> So how about:
> 
> opp-hw-version:
> 	User defined array containing a hierarchy of version numbers.
> 
> E.g: Taking kernel version v2.6.19 for instance:
> 	<2, 6, 19>;
> 
> E.g: Representing Major 2 Minor 0, Cuts ALL and Substrate 5:
> 	<2, 0, 0xffffffff, 5>;

At least what I suggested in my attempt here is a bit different than
what you might be thinking. For example, consider a case with single
level of hierarchy, say cuts. And that the SoC has got 10 different
cuts, and we name them 0-9. So, the values I was looking to fill to
the opp-hw-version field is like: (1 << version_num). So, if an OPP
supports version 2, 5 and 7, the value will be 0x000000A4. i.e. with
the respective bit positions set. And by this way only 0xffffffff can
mean all versions ..

> > 2. "opp-supply-name": The purpose of this binding is to allow the
> >    platform to select the voltage range of the power supplies, for a
> >    valid OPP.
> 
> Did you mean 'opp-supply-version', like in the example below?

Urg. Yeah.

> I suggest '-name' would be better than '-version'.

So, its not name of the supply really, but a virtual name given to the
voltage-range which we need to pick based on the hardware version.

> I guess this is a Qcom specific feature.  I'll let Stephen comment.

No. So, my plan was to use this instead of the st,avs & pcode thing
you have got in your bindings. So, instead of 'slow' and 'fast' from
my example, it will have the corresponding strings for pcode numbers.
And at runtime the platform will pass a string to the OPP library, to
activate/add OPPs only for a specific opp-supply-version.

Maybe we can name it 'opp-supply-range-name'..

> > Both of these can be used together, as well as independently.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/opp/opp.txt | 90 +++++++++++++++++++++++++++
> >  1 file changed, 90 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > index c56a6b1a44ef..def75f7a3614 100644
> > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -98,6 +98,13 @@ This describes the OPPs belonging to a device. This node can have following
> >    information. But for multiple power-supplies, this must be set to pass
> >    triplet style values.
> >  
> > +- opp-supply-version: One or more strings describing version of the supplies on
> 
> What kind of supplies?  Supplies to me means regulator supplies, which
> I fear would be too easily confused with the regulator '*-supply'
> property.

Yeah, its more like opp-supply-range-names ..

> > +  the platform. This is useful for the cases, where the platform wants to select
> > +  the voltage range for supplies at runtime, based on the specific version of
> > +  the hardware. There should be one entry in opp-microvolt array, for each
> > +  string present here. OPPs for the device must be configured, only for a single
> > +  version of the supplies.
> > +
> >  - status: Marks the OPP table enabled/disabled.
> >  
> >  
> > @@ -144,6 +151,16 @@ properties.
> >  - opp-suspend: Marks the OPP to be used during device suspend. Only one OPP in
> >    the table should have this.
> >  
> > +- opp-cuts: Variable length field that contains versions/cuts/substrate of the
> 
> I'd remove any mention of cuts and substrate versions here.

I agree, but probably keep the same in example code to make it simple
to understand.

> > +  hardware for which the OPP is supported. Should contain entry per level of
> > +  version type. For example: a platform with three levels of versions (cuts
> > +  substrate pcode), this field should be like <X Y Z>, where X corresponds to
> > +  different cuts, Y corresponds to different substrates and Z corresponds to
> > +  different pcodes the OPP supports. Each bit of the value corresponds to a
> 
> s/bit/cell/

No. Its like each bit of the 32 bit cell corresponds ... 

> > +  particular version of the level, and so we can have maximum 32 different
> > +  values of any level. A value of 0xFFFFFFFF means that all the versions of the
> > +  level are supported.

> > +	opp_table {
> > +		compatible = "operating-points-v2";
> > +		status = "okay";
> > +		opp-shared;
> > +
> > +		opp00 {
> > +			/*
> > +			 * Supports all substrate and pcode versions for 0xf
> > +			 * cuts, i.e. only first four cuts.
> > +			 */
> > +			opp-cuts = <0xf 0xffffffff 0xffffffff>
> 
> This does not avoid our issue, as it insists we have an OPP node per
> permutation.  That's (pcodes * cuts * substrate) nodes, which if we
> support 16 pcodes, 4 cuts and 5 substrates is </me takes shoes and
> socks off to count> 320 nodes.  This IMHO is too many to write/
> maintain and is the nucleus of our issue.

Not with the bitwise logic I just tried to explain. Obviously we are
doing all this to avoid writing so many nodes.

> If we could index into opp-microvolt however (please see below), this
> would reduce down to (cuts * substrates) nodes, which if taking the
> example above would only result in a more manageable 20 nodes.

I don't want 20 nodes but only ONE. And in your case, you may only
want to use pcode in the opp-supply-range-name property. But its fine
if you want to enable/disable some OPPs based on that as well :)

> > +			opp-hz = /bits/ 64 <600000000>;
> > +			...
> 
> It's still worth putting the opp-microvolt property in these nodes.

Okay, but I didn't wanted to confuse in the sense that opp-cuts
doesn't have anything to do with opp-microvolt..

> > +		};
> > +
> > +		opp01 {
> > +			/*
> > +			 * Supports all substrate and pcode versions for 0x20
> > +			 * cuts, i.e. only the 6th cut.
> > +			 */
> 
> Not sure what you mean by 6th cut?

Bit number 6th, i.e. 0x20.

> > +			opp-cuts = <0x20 0xffffffff 0xffffffff>
> > +			opp-hz = /bits/ 64 <800000000>;
> > +			...
> > +		};
> > +	};
> > +};
> > +
> > +Example 7: Multiple voltage-ranges (opp-supply-version) per supply
> > +(example: device with 2 supplies: vcc0 and vcc1, with two possible ranges of
> > +voltages: slow and fast)
> > +
> > +/ {
> > +	cpus {
> > +		cpu@0 {
> > +			compatible = "arm,cortex-a7";
> > +			...
> > +
> > +			vcc0-supply = <&cpu_supply0>;
> > +			vcc1-supply = <&cpu_supply1>;
> > +			operating-points-v2 = <&cpu0_opp_table>;
> > +		};
> > +	};
> > +
> > +	cpu0_opp_table: opp_table0 {
> > +		compatible = "operating-points-v2";
> > +		supply-names = "vcc0", "vcc1";
> > +		opp-supply-version = "slow", "fast";
> 
> You've broken your own convention.  In the explanation above you say,
> "There should be one entry in opp-microvolt array, for each string
> present here."  However, you seem to have 4 arrays of values in
> opp-microvolt below.  I guess (supply-names * opp-supply-version)
> gives you the 4 in your example, but the docs bear no mention of
> this.
> 
> Then each of those 4 entries are actually arrays?  What are they?  Are
> they user defined?  If so, then that's great.  In our driver we can
> choose to index by 'pcode', then our node count gets reduced
> dramatically and our problems are solved. \o/

Not really. So this is the logic (I perhaps need to write the
paragraph in the bindings in a better way):
1. A regulator's voltage can be supplied as <target> or <target min max> now.
2. For each regulator we need to have an array of size mentioned above.

Now this is what I call as ONE entry.

For each opp-supply-range-name string, we need a copy of this..

> > +		opp-shared;
> > +
> > +		opp00 {
> > +			opp-hz = /bits/ 64 <1000000000>;
> > +			opp-microvolt = <900000 915000 925000>, /* Supply vcc0: slow */
> > +					<910000 925000 935000>, /* Supply vcc1: slow */

So this is one entry for two regulators in the form <target min max>, and it
belongs to the opp-supply-range-name 'slow'.

> > +					<970000 975000 985000>, /* Supply vcc0: fast */
> > +					<960000 965000 975000>; /* Supply vcc1: fast */

And this one is for 'fast'.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
