From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Tue, 12 May 2015 10:46:33 +0530
Message-ID: <20150512051633.GB32300@linux>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <554FFFA3.1060801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36782 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbbELFQj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 01:16:39 -0400
Received: by pabsx10 with SMTP id sx10so132395398pab.3
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2015 22:16:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <554FFFA3.1060801@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

Hi Nishanth,

On 10-05-15, 20:02, Nishanth Menon wrote:
> On 04/30/2015 07:07 AM, Viresh Kumar wrote:

> > +the liberty of choosing these. These triplets are called Operating Performance
> 
> I suggest we dont call them as triplets either -> note, we have added
> clk transition latency per OPP, so they are not exactly triplets either.

Sure.

> > +Points aka OPPs. This document defines bindings for these OPPs applicable across
> > +wide range of devices. For illustration purpose, this document uses CPU as a
> > +device.
> > +
> > +
> 
> Would be good to point to operating-points (the legacy document) as
> well. It might be good to state that only one of the properties should
> be used for the device node OPP description.

Hmm, okay.

> > +Optional properties:
> > +- shared-opp: Indicates that device nodes using this OPP descriptor's phandle
> > +  switch their DVFS state together, i.e. they share clock/voltage/current lines.
> > +  Missing property means devices have independent clock/voltage/current lines,
> > +  but they share OPP tables.
> 
> Is'nt this property redundant? by the fact that phandle is reused for
> cpu1 should indicate shared OPP table, correct?

There are two things we can share:
- OPP tables (And not the clock lines themselves). For example,
  consider a quad-core platform with independent clock/voltage lines
  for all CPUs but all the CPUs have same OPP table.

- Clock/voltage rails: This is described by the above property. I
  thought the examples should have made this clear, anything left
  there ?

> > +- turbo-mode: Marks the OPP to be used only for turbo modes.
> 
> Might be great to add some description for what "turbo mode" means here.

Okay.

> That said, flexibility of this approach is awesome, thanks for doing
> this, I believe we did have a discussion about "safe OPP" for thermal
> behavior -> now that we have phandles for OPPs, we  can give phandle
> pointer to the thermal framework. in addition, we can also use phandle
> for marking throttling information in thermal framework instead of
> indices as well. which allows a lot of flexibility.
> 
> in some systems, we'd have need to mark certain OPPs for entry into
> suspend(tegra?) or during shutdown (for example) - do we allow for such
> description as phandle pointer back to the OPP nodes (from cpu0 device)
> OR do we describe them as additional properties?

Haven't thought about it earlier. In case we need them, probably it
should go in the OPP table.

NOTE: Mike T. once told me that we shouldn't over-abuse the bindings
by putting every detail there. And I am not sure at all on how to draw
that line.

> > +- status: Marks the node enabled/disabled.
> 
> One question we'd probably want the new framework to address is the need
> for OPPs based on Efuse options - Am I correct in believing that the
> solution that iMX, and TI SoCs probably need is something similar to
> modifying the status to disabled? or do we have Vendor specfic modifier
> properties that would be allowed?

See PATCH 2/3 for that.
 
> One additional behavior need I noticed in various old threads is a need
> to restrict transition OPPs -> certain SoCs might have constraints on
> next OPP they can transition from certain OPPs in-order to achieve a new
> OPP. again, such behavior could be phandle lists OR properties that link
> the chain up together. Number of such needs did sound less, but still
> just thought to bring it up.

See 0/3 and 3/3 for that. Its present in my solution but Mike T. is
strictly against keeping that in OPP table. And so 3/3 may get Nak'd.

Thanks a lot for your reviews.
