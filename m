From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v8 11/13] clk: qcom: gdsc: Use PM clocks to control gdsc
 clocks
Date: Tue, 1 Dec 2015 00:59:09 -0800
Message-ID: <20151201085909.GA4139@codeaurora.org>
References: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
 <1438857474-20262-12-git-send-email-rnayak@codeaurora.org>
 <20150811065224.GA2839@codeaurora.org>
 <f45f0e47a6917b8bd4a223bea46c93c1.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57231 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbbLAI7L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2015 03:59:11 -0500
Content-Disposition: inline
In-Reply-To: <f45f0e47a6917b8bd4a223bea46c93c1.squirrel@www.codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org

On 11/27, Rajendra Nayak wrote:
> >
> > I'm lost. I was hoping we could just make up a clkspec on the
> > stack and pass it over to of_clk_get_from_provider() without
> > having to go through the np of the client device. The point being
> > to avoid forcing this code from knowing about the consumer
> > binding or connection name choice for each device. Instead, it
> > assumes that it's a #clock-cells=<1> binding and gets the clocks
> > by passing the 1 cell data without calling
> > of_parse_phandle_with_args().
> >
> > Now, one downside of that approach is that it's DT centric (also
> > of_clk_get_from_provider() is not an exported symbol yet). So I'm
> > really starting to lean towards exposing __clk_create_clk() (or
> > some better named "provider" function) that will allow clk
> > providers to turn their clk_hw structure into a struct clk
> > pointer. That avoids the DT centric design, and avoids binding
> > the provider to the connection ids too.
> 
> Stephen, I started to relook at these patches, avoiding the DT centric
> design and implementing a clk helper API as you suggested above.
> 
> While this would work for GDSCs with just one device, its hard to scale
> if we ever run into GDSCs with multiple devices (In which case you
> need to know which device within the GDSC needs which clocks)

Why? The GDSC should know which clocks it's forcing on and off
and it shouldn't need to care which devices are consuming those
clocks. The GDSC structure would have a bunch of clk_hw pointers
that it could convert into struct clk pointer to do clk consumer
API things as needed.

Maybe I'm missing something? If we're trying to take away clock
control from our device drivers and hide that in SoC glue code
(something we almost have to do so that the ordering of clocks
vs. GDSC enable isn't wrong), then that isn't a GDSC, but some
linux genpd concept. I imagine it would be a genpd per hw block
(or device driver really) and then those genpds would be children
of a larger GDSC genpd. For example, two hw blocks could have
separate genpds for their clock control so that we can hide the
clock on/off from the drivers, and then those are children of a
single GDSC backed genpd for the physical domain they both reside
in. If the GDSC domain and the sw domain need to control the same
clocks, everything will work because we reference count
appropriately.

The downside of this all is that we're putting a bunch of
knowledge about which drivers are using which clocks into the SoC
clock driver. But I don't know where else we would put this if we
want to hide these details from the driver authors. The only
other option is to do it with DT, and the whole DT ABI there
scares me enough to want to try and make it work in the SoC clock
driver for now.

> 
> Do you think its a fair limitation (one device per gdsc) to live with?
> because I can't seem to figure how a non DT centric design would otherwise
> work.

No. The SMMU use case on a-family has SMMU and the hw block
(video, gpu, display) that uses it within the same GDSC power
domain.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
