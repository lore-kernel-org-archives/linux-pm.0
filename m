From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 1/2] PM / OPP: introduce an OPP power estimation helper
Date: Wed, 10 Jan 2018 10:36:03 +0000
Message-ID: <20180110103602.GB25543@e108498-lin.cambridge.arm.com>
References: <20180109110252.13557-1-quentin.perret@arm.com>
 <20180109110252.13557-2-quentin.perret@arm.com>
 <20180110043625.GD3335@vireshk-i7>
 <20180110102044.GA25543@e108498-lin.cambridge.arm.com>
 <20180110102552.GD3626@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753635AbeAJKgH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jan 2018 05:36:07 -0500
Content-Disposition: inline
In-Reply-To: <20180110102552.GD3626@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com

On Wednesday 10 Jan 2018 at 15:55:52 (+0530), Viresh Kumar wrote:
> On 10-01-18, 10:20, Quentin Perret wrote:
> > So that was actually my first idea as well but I struggled to come up
> > with a clean implementation TBH ...
> > 
> > My concern was mainly to get the dynamic-power-coefficient cleanly. With
> > the approach you proposed, there are cases (for platforms using
> > dev_pm_opp_add() such as Juno for ex) where I don't see how we can avoid
> > to re-read the capacitance from the DT for each and every OPP that's being
> > added. Or we have to rely on the driver to give it to us but that's against
> > changes that you pushed recently I think.
> > 
> > Do you think reading the "dynamic-power-coefficient" value from the DT
> > directly in dev_pm_add_opp() (and other places to support the v2 bindings)
> > would be acceptable ? Did you have something different in mind ?
> 
> I think you can read it from within _of_init_opp_table() only once and then just
> use it everywhere. Will that work ?

Yes, that should definitely do the trick :) I'll do change in the v2.

Thank you very much,
Quentin
