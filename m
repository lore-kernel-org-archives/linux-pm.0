From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V8 3/3] OPP: Allow "opp-hz" and "opp-microvolt" to
 contain magic values
Date: Tue, 9 Jan 2018 18:54:54 -0800
Message-ID: <20180110025454.GG21040@codeaurora.org>
References: <cover.1513591822.git.viresh.kumar@linaro.org>
 <476d7ae69184d787ccc6d99f8df6069007fd0a91.1513591822.git.viresh.kumar@linaro.org>
 <20171226202955.32j7gzonrixtwdpt@rob-hp-laptop>
 <20171227085645.GF8312@vireshk-i7>
 <CAL_JsqJzMfNhHK=6Wt4dzBRS9BVGMZ-f7uk3OnUupudTfwuyUA@mail.gmail.com>
 <20171228043725.GB8652@vireshk-i7>
 <20171229003253.GD7997@codeaurora.org>
 <20171229045854.GE8652@vireshk-i7>
 <20180105221954.GC21040@codeaurora.org>
 <20180108041643.GC4003@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60684 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755211AbeAJCy5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jan 2018 21:54:57 -0500
Content-Disposition: inline
In-Reply-To: <20180108041643.GC4003@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 01/08, Viresh Kumar wrote:
> On 05-01-18, 14:19, Stephen Boyd wrote:
> > On 12/29, Viresh Kumar wrote:
> 
> > Could you please point to Kevin's comments and also include the
> 
> https://lkml.kernel.org/r/m2r30i4w35.fsf@baylibre.com

Ok. That thread was months ago. Shocked I can't remember!

My read of Kevin's comments lead me to think he's saying that a
generic 'domain-performance-state' property is worse than putting
the numbers directly inside of the opp table with a comment above
it. Now that's all fine, but now that we have required-opps
binding we sort of have the domain-performance-state property
again, but it's a phandle instead of a raw state number.

So we have

	required-opps = <&perf_state>;

but what was proposed before was

	domain-performance-state = <1>;

or Kevin's 

	opp-table = <100000 1>;

>From what I can tell, the domain-performance-state proposal was
at the same abstraction level as the OPP itself, but now that's
moved to be inside of the power domain OPPs. So now we're talking
about describing some power domains performance levels with the
OPP binding, for a power domain, not describing a performance
state for some unknown power domain that's associated with a
device's OPP table.

The power domain is not running at any sort of frequency for us.
It's using some particular voltage, but we may or may not know
what that voltage is depending on the platform. This makes me see
it as 

	power_domain_opp {

	    low: point0 {
		opp-microvolt = <950000>
	    };

	    medium: point1 {
		opp-microvolt = <975000>
	    };

	    high: point2 {
		opp-microvolt = <1000000>
	    };
	};

for some sort of power domain that deals with voltages. This
makes perfect sense. The power domain needs to be at some voltage
and the binding says that. Honestly, the whole required-opps
thing works great here and it's all wonderful, and it looks like
can even be used for other OPP linking in the future, like
connecting frequencies between CPUs and caches.

Where it starts to break down is when the voltage isn't known to
the user, just some number that we've agreed means "low",
"medium", "high" or whatever. Again, the binding looks similar:


	power_domain_opp {
	    low: point0 {
	    	qcom,corner = <0>;
	    };

	    medium: point1 {
	    	qcom,corner = <10>;
	    };

	    high: point2 {
	    	qcom,corner = <250>;
	    };
	};

but now the number is only meaningful to the power domain driver.
What we really care about is associating some firmware specific
information via the phandle to some frequency that a device is
using. Behind the scenes of the firmware, that number is really
being translated into some voltage, like opp-microvolt =
<950000>, but we don't know what that is and it could vary at
runtime.

It all feels really close, and it totally works for the non-magic
value parts that we have to deal with, but I'm not convinced that
we should stick the firmware specific information into some
generic OPP property just so we don't have to review the binding
again. Hopefully there's some other reason why we shouldn't come
up with a firmware specific binding for this piece of
information.

> > >          * If we choose to use platform-specific bindings instead of opp-hz,
> > >          * then only this routine requires to change to read the DT and provide
> > >          * the value from platform specific binding.
> > 
> > If we wanted to change this function to do a platform specific
> > thing, will we somehow get a way to access the DT node of the opp
> > passed into this function?
> 
> Yes, we can do that. The OPP core already stores pointer to the node
> in the OPP structure, we will just need another API to expose that.

Great!

> 
> > Also, I don't see how the foo_get_performance function will use
> > the genpd pointer passed here. Maybe that's never used?
> 
> It depends actually and I think its better to pass it anyway. What if
> a single driver is handling multiple genpds and wants to do things
> differently for them? It should know which genpd it is called for,
> looks like  basic requirement to me.

Ok, fair enough.

> 
> > Finally, I would think that a "getter" like this function would
> > be informing the framework about what the current performance
> > state is, not translating an OPP into a performance state. So the
> > whole thing looks like a misnomer, and probably should be called
> > something like xlate_opp_performance.
> 
> Sure, I can name it anything.

Alright. Sounds like my read of the code is correct.

> 
> So the question still stands, are we all okay for using magic values
> or we want platform specific properties ?
> 

Kevin?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
