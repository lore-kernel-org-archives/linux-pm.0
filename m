From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V7 2/3] OPP: Allow multiple OPP tables to be passed via DT
Date: Fri, 19 Jun 2015 11:44:03 -0700
Message-ID: <20150619184403.GC22132@codeaurora.org>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
 <263c128844f5a3c9280c8be71f6c9eb1869a5188.1433434659.git.viresh.kumar@linaro.org>
 <CAL_Jsq+EOOeQw42wZi+H82ovLn8LcQUuK9HGT+FvewdhTf7Q1w@mail.gmail.com>
 <20150617133314.GB15153@linux>
 <CAL_Jsq+SdgAf7=Yq7Jk_1d9jTpAOLCEuEDCZvD=-h=2MWsNfFw@mail.gmail.com>
 <55821F30.2090802@codeaurora.org>
 <20150618022543.GA28820@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43425 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbbFSSoG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 14:44:06 -0400
Content-Disposition: inline
In-Reply-To: <20150618022543.GA28820@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Nishanth Menon <nm@ti.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mike.turquette@linaro.org>, Grant Likely <grant.likely@linaro.org>, Olof Johansson <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, Santosh

On 06/18, Viresh Kumar wrote:
> On 17-06-15, 18:30, Stephen Boyd wrote:
> > An operating-point(s?)-names property seems ok... but doesn't that mean
> > that every CPU that uses the OPP has to have the same list of
> > operating-point-names?
> 
> Why do you think so? For me the operating-points-v2-names property
> will be present in CPU node (as there is no OPP node which can have
> it) and so every CPU is free to choose what it wants to.

Yes.

> 
> > It would make sense to me if the operating points
> > were called something different depending on *which* CPU is using them,
> > but in this case the only name for the operating point is "slow" or
> > "fast", etc.
> 
> I am completely confused now. :)
> 

As am I.

> The problem you stated now was there with the current state of
> bindings. The name is embedded into the OPP table node and so is fixed
> for all the CPUs. Moving it to the CPU node will give all CPUs a
> chance to name it whatever they want to. And the same list has to be
> replicated to all CPUs sharing the clock rails.
> 

Yes I don't see how the name will be different for any CPU, hence
my complaint/question about duplicate names in each CPU. I guess
it isn't any worse than clock-names though so I'm fine with it.

> > In reality we've assigned them names like speedX-binY-vZ so that we know
> > which speed bin, voltage bin, and version they're part of. Maybe OPP
> > node properties like qcom,speed-bin = <u32>, qcom,pvs-bin = <u32>, etc.
> > would be better?
> 
> Lets see, only if we can't get the generic stuff for this.
> 
> > At the least, operating-points-names will be required on qcom platforms.
> > A fixed ordering known to the platform would mean that we know exactly
> > how many voltage bins and speed bins and how many voltage bins per speed
> > bin are used for a particular SoC, which we've avoided knowing so far.
> 
> What are we referring to fixed ordering? If we have both a list of
> phandles to OPP tables and a list of names, they can be rearranged in
> whatever fashion we want. Isn't it?
> 

This is a reply to Rob's question about fixed ordering without a
names property. That's unlikely to work out for qcom chips.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
