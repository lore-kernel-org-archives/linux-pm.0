From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 0/2] thermal, OPP: move the CPU power estimation to the
 OPP library
Date: Tue, 16 Jan 2018 09:16:52 +0000
Message-ID: <20180116091652.GB17183@e108498-lin.cambridge.arm.com>
References: <20180109110252.13557-1-quentin.perret@arm.com>
 <20180110193431.GE3837@localhost.localdomain>
 <20180111094257.GA6603@e108498-lin.cambridge.arm.com>
 <20180112172410.GA10243@localhost.localdomain>
 <20180115042617.GB22978@vireshk-i7>
 <20180115174602.GA4366@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbeAPJQ5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jan 2018 04:16:57 -0500
Content-Disposition: inline
In-Reply-To: <20180115174602.GA4366@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com

Hi Eduardo,

On Monday 15 Jan 2018 at 09:46:04 (-0800), Eduardo Valentin wrote:
> On Mon, Jan 15, 2018 at 09:56:17AM +0530, Viresh Kumar wrote:
> > On 12-01-18, 09:24, Eduardo Valentin wrote:
> > > I would rather see a single series showing all users of the new API
> > > instead. If you want to split the series and add a link to the users
> > > of the new API into the series that takes it out of thermal subsystem,
> > > I am also fine, as long as I see the other users. Otherwise, this is a
> > > light nack, reason: no real new users of the new API, even though I
> > > can surely see how the scheduler could use it. But if you do not really
> > > present the code of the new users, this is just speculation.
> > > 
> > > Presenting the entire code of the new API + all its users can help us to
> > > judge if: (1) a new API is really needed, (2) where it should be place.
> > 
> > So the idea will be to wait until the scheduler maintainers are ready to apply
> > those patches and then only apply the thermal/OPP patches ?
> 
> Yes.
> 
> > 
> > I am asking because it normally takes *ages* for anything to get accepted in the
> > scheduler and what gets merged eventually can be very much different than what
> > was proposed.
> 
> Well, if the only other user of the new API is not ready to accept the
> changes, it means, the API is not really ready to be changed, right?

The scheduler will probably be the only new client per-se of the power model,
but there is another use case where the OPP library can help today, namely
SCMI. You cannot fetch voltage information for the OPPs with SCMI so the
whole P=CV^2f approach doesn't work IIUC. However, SCMI gives you a power
value for each OPP directly. Hence, having a dev_pm_opp_get_power() function
behind which we can hide the DT-or-SCMI business might be useful. The
thermal subsystem already relies on the OPP library to provide the
platform abstraction (dev_pm_opp_get_voltage() returns values read from
the DT or coming from SCPI) so putting the SCMI abstraction here again kind
of makes sense.

This posting doesn't implement the SCMI abstraction or the energy-awareness
in the scheduler, but it contains the common denominator between the two, and
that's another reason why I though this could fly on its own.

I hope that's useful.

Thanks,
Quentin
