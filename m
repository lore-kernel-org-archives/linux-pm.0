From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 0/2] thermal, OPP: move the CPU power estimation to the
 OPP library
Date: Mon, 15 Jan 2018 09:46:04 -0800
Message-ID: <20180115174602.GA4366@localhost.localdomain>
References: <20180109110252.13557-1-quentin.perret@arm.com>
 <20180110193431.GE3837@localhost.localdomain>
 <20180111094257.GA6603@e108498-lin.cambridge.arm.com>
 <20180112172410.GA10243@localhost.localdomain>
 <20180115042617.GB22978@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40379 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934428AbeAORqI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jan 2018 12:46:08 -0500
Received: by mail-pl0-f66.google.com with SMTP id 62so4206272pld.7
        for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2018 09:46:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180115042617.GB22978@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Quentin Perret <quentin.perret@arm.com>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com

On Mon, Jan 15, 2018 at 09:56:17AM +0530, Viresh Kumar wrote:
> On 12-01-18, 09:24, Eduardo Valentin wrote:
> > I would rather see a single series showing all users of the new API
> > instead. If you want to split the series and add a link to the users
> > of the new API into the series that takes it out of thermal subsystem,
> > I am also fine, as long as I see the other users. Otherwise, this is a
> > light nack, reason: no real new users of the new API, even though I
> > can surely see how the scheduler could use it. But if you do not really
> > present the code of the new users, this is just speculation.
> > 
> > Presenting the entire code of the new API + all its users can help us to
> > judge if: (1) a new API is really needed, (2) where it should be place.
> 
> So the idea will be to wait until the scheduler maintainers are ready to apply
> those patches and then only apply the thermal/OPP patches ?

Yes.

> 
> I am asking because it normally takes *ages* for anything to get accepted in the
> scheduler and what gets merged eventually can be very much different than what
> was proposed.

Well, if the only other user of the new API is not ready to accept the
changes, it means, the API is not really ready to be changed, right?

> 
> -- 
> viresh
