From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 8/8] dt: cpufreq: st: Provide bindings for ST's CPUFreq
 implementation
Date: Tue, 23 Jun 2015 13:25:09 +0530
Message-ID: <20150623075509.GF16776@linux>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-9-git-send-email-lee.jones@linaro.org>
 <20150623023458.GC16776@linux>
 <20150623070651.GA3245@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34463 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbbFWHzO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 03:55:14 -0400
Received: by pabvl15 with SMTP id vl15so1819749pab.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 00:55:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150623070651.GA3245@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: robh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

On 23-06-15, 08:06, Lee Jones wrote:
> > [Adding Rob]
> 
> Rob is not the only DT Maintainer, there are many of them.  The DT
> list was CC'ed, which they are all part of.  Adding them all
> separately is not required IMO.

I didn't Cc him because you missed him, but because we have been
discussing opp-v2 bindings recently and this was somehow related to
that. :)

> > On 22-06-15, 16:43, Lee Jones wrote:
> > 
> > At least some description was required here on why you need additional
> > bindings are what are they.
> 
> Sure, I can do that.
> 
> > Over that, this patch should have been present before any other
> > patches using these bindings.
> 
> I've never heard that one before, but it's easy to re-order the set.

I don't know, but it seems obvious to me: Bindings first and then the
code.

> > > +Required properties:
> > > +-------------------
> > > +- compatible		: Supported values are:
> > > +				"st,stih407-cpufreq"
> > 
> > Nodes for virtual devices aren't allowed in DT.
> 
> Then why do Exynos, Spear, HREF and Snowball have CPUFreq nodes?
> 
> One rule for one ... ?

Not really, but I got a bit confused now with your reply.

So, what I meant when I wrote: "Nodes for virtual devices aren't
allowed in DT", was that we aren't supposed to do something like:

cpufreq {
 ...
}

in DT as cpufreq isn't a device here. A CPU is a device and that can
contain whatever property we feel is reasonable.

What SPEAr and Exyons did was putting something in the cpu-node. Not a
node for cpufreq device itself. Couldn't find HREF and snowball's
bindings though..

-- 
viresh
