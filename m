From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Fri, 31 Jul 2015 09:37:15 -0700
Message-ID: <20150731163715.GV3159@codeaurora.org>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <1438010430-5802-2-git-send-email-lee.jones@linaro.org>
 <20150728022936.GB1229@linux>
 <20150728225510.GB3159@codeaurora.org>
 <20150729081403.GH2284@x1>
 <20150729221526.GE3159@codeaurora.org>
 <20150730084634.GD9319@x1>
 <CAL_JsqKQLQ15qSt95zBZykzzPhcUrtZzhk29a76n+r_3719AiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39305 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbbGaQhS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 12:37:18 -0400
Content-Disposition: inline
In-Reply-To: <CAL_JsqKQLQ15qSt95zBZykzzPhcUrtZzhk29a76n+r_3719AiA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 07/30, Rob Herring wrote:
> On Thu, Jul 30, 2015 at 3:46 AM, Lee Jones <lee.jones@linaro.org> wrote:
> >
> > There is nothing stopping us from representing the data in this way.
> > On the plus side, it would mean that we wouldn't need any vendor
> > specific properties.  However, far outweighing the positives are the
> > fact that, even in our very simple example provided, where we only
> > have 2 frequencies, differ between only 1 cut and support all
> > substrates, we would still need 16 OPP tables.  When any one of those
> > variables increase (and they will), we would then have a large number
> > of permutations and subsequently and unruly amount of OPP tables.
> >
> > (... and we haven't even provided the body-biasing information yet.)
> >
> > The way we've chosen to represent our circumstance is the least
> > intrusive and the most succinct way we can think of.  Which IMHO
> > outweighs the fact that we have to introduce a couple of vendor
> > properties by a country mile.
> 
> Regardless of which is better or worse, you are both doing essentially
> the same thing. You are selecting OPPs based on some Si parameters. We
> should not really be doing this 2 different ways. I'd be fine with 2
> ways if it was 2 for all SOCs, but right now it is 2 for 2 SOCs.
> Really, I'd like to see most if not all the selection or fixup of OPPs
> be done in the bootloader and the kernel just deals with the correct
> OPP table.
> 
> Where are you storing the data that gets selected to fill into these
> properties? Is it just look-up tables or is there some kind of
> algorithm to generate the values? If the former, then DT is as good a
> data struct as any to store the tables. There is a lot of duplication
> though with only a single property varying in each set. If you both
> have that problem, then perhaps we can come up with a generic way to
> list all possible values more concisely.

For qcom platforms, the frequency is almost always constant.
There may be some tables where we have a couple higher
frequencies than others because the speed bin is different.
Otherwise the voltage/current is changing based on the silicon
characteristics. So the biggest duplication is the frequency
property.

As far as I know there isn't any algorithm to generate the
voltage values. It's all hand tuned tables based on the silicon
characterization, so we're left to store these tables in DT and
pick the right one at runtime. With regards to the table
explosion, on qcom platforms we haven't worried that we have ~40
tables, but I'm not opposed to expressing it in a smaller set of
nodes, tables, etc. if that's what's desired.

Do we need vendor specific properties for that though? Or do we
need some sort of extended frequency/voltage properties that are
arrays of values that we can index into based on some silicon
characteristics? I like the name based approach because it's
simple. Use this OPP table because it's called
x-y-z-characteristics and be done. Cramming the tables into less
lines may save us some typing and dtb space, but I'm not sure
what else it does.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
