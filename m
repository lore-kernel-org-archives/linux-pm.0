From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 29 Jul 2015 15:15:26 -0700
Message-ID: <20150729221526.GE3159@codeaurora.org>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <1438010430-5802-2-git-send-email-lee.jones@linaro.org>
 <20150728022936.GB1229@linux>
 <20150728225510.GB3159@codeaurora.org>
 <20150729081403.GH2284@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42532 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbG2WP2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 18:15:28 -0400
Content-Disposition: inline
In-Reply-To: <20150729081403.GH2284@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, rob.herring@linaro.org, nm@ti.com, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, sre@kernel.org, dbaryshkov@gmail.com

On 07/29, Lee Jones wrote:
> On Tue, 28 Jul 2015, Stephen Boyd wrote:
> 
> > On 07/28, Viresh Kumar wrote:
> > > Cc'ing few people (whom I cc'd last time as well :)).
> > > 
> > > On 27-07-15, 16:20, Lee Jones wrote:
> > > > + - opp-hz		: CPU frequency [Hz] for this OPP [See: ./opp.txt]
> > > > + - st,avs		: List of available voltages [uV] indexed by process code
> > > > + - st,cuts		: Cut version this OPP is suitable for [0xFF means ALL]
> > > > + - st,substrate		: Substrate version this OPP is suitable for [0xFF means ALL]
[...]
> > > > +cpu0-opp-list {
> > > > +	compatible	= "operating-points-v2-sti";
> > > > +	st,syscfg	= <&syscfg [major_offset]>;
> > > > +	st,syscfg-eng   = <&syscfg_eng [pcode_offset] [minor_offset]>;
> > > > +
> > > > +	opp0 {
> > > > +		opp-hz		= <1200000000>;
> > > > +		st,avs		= <1110 1150 1100 1080 1040 1020 980 930>;
> > > > +		st,substrate	= <0xff>;
> > > > +		st,cuts		= <0xff>;
> > > > +	};
> > > > +	opp1 {
> > > > +		opp-hz		= <1500000000>;
> > > > +		st,avs		= <1200 1200 1200 1200 1170 1140 1100 1070>;
> > > > +		st,substrate	= <0xff>;
> > > > +		st,cuts		= <0x2>;
> > > > +	};
> > > > +};
> > > 
> > > I don't see more problems here, unless we can move some of this to the
> > > generic bindings.
> > > 
> > > @Rob/Stephen: Please respond before it is late :)
> > 
> > It's interesting to have vendor specific properties like avs,
> > cuts, and substrate. That could replace our planned usage of the
> > opp-names property where we encode similar information (speed
> > bin, revision, etc.) into a string that we look for.
> > 
> > So I wonder why the avs/cut/substrate information can't be
> > encoded into the opp name? That would make these properties
> > obsolete, given that all they're used for is to pick out the
> > correct OPP?
> 
> You could hack the substrate and cut version into a string, but that's
> exactly what it would be, a hack.  I'm struggling how you would do the
> same for 'st,avs', which is an array of u32s.
> 


(I don't understand the st,avs property to begin with, so feel
free to ignore the rest of this mail.)

For qcom platforms we have the pvs bin and speed bin, and
sometimes a revision number. Each one of these properties
corresponds to a different set of OPPs (opp table). So we might
have speed1-pvs2-v0 for speed bin 1, pvs bin 2 and version 0. We
fill out an opp table for this and then point the opps property
at the table and have a corresponding opp-name "speed1-pvs2-v0"
in the "consumer" node.

	operating-points-v2 = <&speed1_pvs2_v0>;
	operating-points-names = "speed1-pvs2-v0";

We have quite a few of these tables because the values are
always different. If the values were the same then we could use
the same table with different names I suppose, but we're not
doing that.

>From a quick read of the st properties (that I admit I don't
understand), it looks like we're trying to compress the OPP
tables by listing all the voltages that could be used for a
particular frequency depending on which avs is present on the
device? And then limiting the frequency voltage pairs depending
on which cut and substrate is present?

So we'd probably have to expand out the tables to be unique per
avs/cut/substrate parameter. Something like:

avs0-cut2 {
	compatible = "operating-points-v2";

	opp0 {
		opp-hz = <1200000000>;
		opp-microvolt = <1100>;
	};

	opp1 {
		opp-hz = <1500000000>;
		opp-microvolt = <1200>;
	};
};

avs1-cut2 {
	compatible = "operating-points-v2";

	opp0 {
		opp-hz = <1200000000>;
		opp-microvolt = <1150>;
	};

	opp1 {
		opp-hz = <1500000000>;
		opp-microvolt = <1200>;
	};
};

And then another copy of these for the devices without cuts != 2
where the top frequency is gone?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
