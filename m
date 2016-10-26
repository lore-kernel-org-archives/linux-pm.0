From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 4/8] PM / OPP: Pass struct dev_pm_opp_supply to
 _set_opp_voltage()
Date: Wed, 26 Oct 2016 09:04:35 +0530
Message-ID: <20161026033435.GH9162@vireshk-i7>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <5f5f81da4b9773854fba72359cb911d2660e2957.1476952750.git.viresh.kumar@linaro.org>
 <20161024231453.GS26139@codeaurora.org>
 <20161025034554.GB9162@vireshk-i7>
 <20161025202600.GX26139@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36505 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbcJZDel (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2016 23:34:41 -0400
Received: by mail-pf0-f171.google.com with SMTP id e6so130741858pfk.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2016 20:34:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161025202600.GX26139@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org

On 25-10-16, 13:26, Stephen Boyd wrote:
> For things like AVS we'll probably want to do that, although it's
> sort of funny because replacing RCU with rw-locks is the opposite
> direction most people go.

Yes, that would be very funny :)

> With AVS we would be updating the
> voltage(s) in use for the current OPP, and we would want that
> update to block any OPP transition until the voltage is adjusted.
> I don't know how we would do that with RCU very well. Plus, RCU
> is for reader heavy things, but we mostly have one or two
> readers.

Not just that, think of opp_disable() function. What guarantees currently that
an OPP being disabled isn't already used right now? Or is on the way of getting
used?

I strongly feel RCU is not the best fit for OPP core at least.

> I guess it's ok for now to do all this copying, but it feels like
> we'll need to undo a large portion of it later with things like
> AVS.

Yes.

> Or at least we'll be doing copies for almost no reason
> because we'll want to hold the read lock across the whole OPP
> transition. I was going to suggest we pass around information
> about what we want to grab from the RCU protected data
> structures, think index of regulator, etc. and then have small
> RCU read-side critical sections to grab that info during the OPP
> transition but I'm not sure that's any better. It might be worse
> because the OPP could change during the OPP transition and we
> could be using half of the old and half of the new data.

The problem is that this code is getting harder to read for everybody. If we are
finding it difficult to understand, what about newbies..

-- 
viresh
