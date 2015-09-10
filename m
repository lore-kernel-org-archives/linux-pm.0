From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 9 Sep 2015 17:57:22 -0700
Message-ID: <20150910005722.GA15099@codeaurora.org>
References: <20150826120628.GZ19409@x1>
 <20150902080639.GA26744@linux>
 <CAL_JsqKMGp+3Z+oO6E0YYzjTCb=-R_QM=YF=B33NWayWmV057A@mail.gmail.com>
 <20150909062722.GA5266@linux>
 <20150909075930.GB3260@x1>
 <20150909083031.GB5266@linux>
 <20150909133930.GE3260@x1>
 <20150909160212.GJ5266@linux>
 <20150909163620.GF3260@x1>
 <55F0C5AB.5060609@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51105 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbbIJA5Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 20:57:25 -0400
Content-Disposition: inline
In-Reply-To: <55F0C5AB.5060609@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 09/09, Rob Herring wrote:
> On 09/09/2015 11:36 AM, Lee Jones wrote:
> >>> Or have I got the wrong end of the stick?
> >>>
> >>> NB: Note the suggested new property names.
> >>
> >> Yeah, all looks fine to me.
> > 
> > I think these names are better:
> > 
> >   opp-supply-range-name => opp-microvolt-names
> >   opp-cuts              => opp-supported-hw
> > 
> > Apart from that, the binding is starting to come together.
> > 
> > Let's see what Rob and Stephen have to say about it.
> 
> Seems reasonable to me.

I think it will work for qcom use cases. We can collapse the
tables down to one node and have speed bin and version as the
opp-supported-hw property. The opp-microvolt-names property would
be where we put the different voltage bins. What about the other
properties like opp-microamp or opp-suspend? Will all of those
also get *-names properties to index into them based on some
string? I don't actually need those for my devices, but I'm just
pointing it out in case someone else wants to compress tables but
they have different microamps or clock latencies, etc.

Finally, does this mean we will get rid of operating-points-names?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
