From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 9 Sep 2015 21:32:12 +0530
Message-ID: <20150909160212.GJ5266@linux>
References: <20150811142812.GJ5509@linux>
 <20150811151736.GO18282@x1>
 <20150812110841.GC20238@linux>
 <20150826120628.GZ19409@x1>
 <20150902080639.GA26744@linux>
 <CAL_JsqKMGp+3Z+oO6E0YYzjTCb=-R_QM=YF=B33NWayWmV057A@mail.gmail.com>
 <20150909062722.GA5266@linux>
 <20150909075930.GB3260@x1>
 <20150909083031.GB5266@linux>
 <20150909133930.GE3260@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36225 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbbIIQCR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 12:02:17 -0400
Received: by padhk3 with SMTP id hk3so14064814pad.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2015 09:02:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150909133930.GE3260@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 09-09-15, 14:39, Lee Jones wrote:
> Okay, I see what you mean.  Sound fine, although only allows up to 31
> versions.  Not an issue for us I don't think, but could be for other
> vendors.  Taking a recent example, the kernel recently went up to
> v2.6.39 and some of the stable releases have gone up to v3.4.108.
> Depends what you wish to support.

Oh, that is always expandable. No one is stopping a platform to have
hw-versions as: cuts_part1 cuts_part2 cuts_part3, and that will give
us 96 bits :)

> > So, its not name of the supply really, but a virtual name given to the
> > voltage-range which we need to pick based on the hardware version.
> 
> We usually call these 'names'; reg-names, clock-names, pinctrl-names,
> phy-names, dma-names, etc.

Probably (opp-)supply-range-name suits well.

> > > I guess this is a Qcom specific feature.  I'll let Stephen comment.
> > 
> > No. So, my plan was to use this instead of the st,avs & pcode thing
> > you have got in your bindings. So, instead of 'slow' and 'fast' from
> > my example, it will have the corresponding strings for pcode numbers.
> > And at runtime the platform will pass a string to the OPP library, to
> > activate/add OPPs only for a specific opp-supply-version.
> 
> So you're using it to index into a 2 dimensional array of opp-hz's.

s/opp-hz's/opp-microvolt

> 
> Eek!

:)

> > I don't want 20 nodes but only ONE. And in your case, you may only
> > want to use pcode in the opp-supply-range-name property. But its fine
> > if you want to enable/disable some OPPs based on that as well :)
> 
> I'm not seeing how this can be achieved with 1 node.
> 
> I guess you mean one node per frequency?

Within an OPP table, OPP-nodes must have unique frequencies. i.e.
two nodes can't have same frequency.

In simple terms (mapping to your case) it is going to be like:
opp-table will have this:
opp-supply-range-names = "avs1", "avs2", ... , "avsn";

Each OPP node will have
opp-microvolt = <AVS1-volt>, <AVS2-volt>, <AVS3-volt> ... <AVSN-volt>;

The platform with tell opp core to use avsX and OPP core will take
care of rest.

> > Not really. So this is the logic (I perhaps need to write the
> > paragraph in the bindings in a better way):
> > 1. A regulator's voltage can be supplied as <target> or <target min max> now.
> 
> Understood.  I don't think we'll be using that, but if it's useful to
> others, then fine.

Bindings for this are already present in kernel, so this wasn't new.

> > 2. For each regulator we need to have an array of size mentioned above.
> 
> Using 2 properties to index in a 2D array like this look scarily like
> it'll be prone to all sorts of fumbling errors.
> 
> The complexity of all this will reduce massively by having a separate
> node per <regulator>-supply.  Using the same nodes for this is
> squeezing too much into a single node.  I was put off as soon as I saw
> you using 2D arrays in DT.

So for the pcode thing, probably a separate entry like:
opp-microvolt-pcode0 can be added to make things easy. opp-microvolts
bindings are already added to support multiple regulators, and I don't
really want to touch that again :)

> > Now this is what I call as ONE entry.
> > 
> > For each opp-supply-range-name string, we need a copy of this..
> 
> Fortunately for us we'll only have single celled opp-microvolt
> properties.

Haha. FWIW, you can't use voltage-tolerance with OPP-v2 bindings as
the triplets have replaced it. Just in case you were planning to use
that :)

> So I think our offering would look like this:
> 
> cpus {
> 	cpu@0 {
> 		compatible = "arm,cortex-a7";
> 		vcc-supply = <&cpu_supply0>;
> 		operating-points-v2 = <&cpu0_opp_table>;
> 	};
> };
> 
> cpu0_opp_table: opp_table0 {
> 	compatible = "operating-points-v2";
> 	opp-microvolt-names = "1", "2",  "3",  "4",  "5",  "6",  "7",  "8"
> 			      "9", "10", "11", "12", "13", "14", "15", "16";
> 
> 	opp0 {
> 		/*                  Major       Minor       Substrate */
> 		/*                  all         all         all       */
> 		opp-supported-hw = <0xffffffff  0xffffffff  0xffffffff>
> 		opp-hz           = <1000000000>;
> 		opp-microvolt    = <900000>, <915000>, <915000>, <925000>,
> 				   <925000>, <925000>, <935000>, <945000>,
> 				   <945000>, <945000>, <945000>, <955000>,
> 				   <956000>, <975000>, <975000>, <975000>,
> 	};

So this is based of the solution I proposed. But if we were to choose
the one you gave, it will be:

                opp-microvolt-1 = <900000>;
                opp-microvolt-2 = <915000>;
                opp-microvolt-3 = <915000>;
                opp-microvolt-4 = <925000>;
                opp-microvolt-5 = <925000>;
                opp-microvolt-6 = <925000>;
                opp-microvolt-7 = <935000>;
                opp-microvolt-8 = <945000>;
                opp-microvolt-9 = <945000>;
                opp-microvolt-10 = <945000>;
                opp-microvolt-11 = <945000>;
                opp-microvolt-12 = <955000>;
                opp-microvolt-13 = <956000>;
                opp-microvolt-14 = <975000>;
                opp-microvolt-15 = <975000>;
                opp-microvolt-16 = <975000>;

> 	opp1 {
> 		/*                  Major  Minor  Substrate */
> 		/*                  2      1 & 2  all       */
> 		opp-supported-hw = <0x2    0x3    0xffffffff>
> 		opp-hz           = <1100000000>;
> 		opp-microvolt    = <900000>, <915000>, <915000>, <925000>,
> 				   <925000>, <925000>, <935000>, <945000>,
> 				   <945000>, <945000>, <945000>, <955000>,
> 				   <956000>, <975000>, <975000>, <975000>,
> 	};
> 
> 	opp2 {
> 		/*                  Major  Minor  Substrate */
> 		/*                  2      5      4 & 5 & 6 */
> 		opp-supported-hw = <0x2    0x10   0x38>
> 		opp-hz           = <1200000000>;
> 		opp-microvolt    = <900000>, <915000>, <915000>, <925000>,
> 				   <925000>, <925000>, <935000>, <945000>,
> 				   <945000>, <945000>, <945000>, <955000>,
> 				   <956000>, <975000>, <975000>, <975000>,
> 	};
> };
> 
> Or have I got the wrong end of the stick?
> 
> NB: Note the suggested new property names.

Yeah, all looks fine to me.

-- 
viresh
