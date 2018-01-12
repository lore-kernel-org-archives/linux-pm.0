From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 0/2] thermal, OPP: move the CPU power estimation to the
 OPP library
Date: Fri, 12 Jan 2018 17:44:10 +0000
Message-ID: <20180112174410.GA28012@e108498-lin.cambridge.arm.com>
References: <20180109110252.13557-1-quentin.perret@arm.com>
 <20180110193431.GE3837@localhost.localdomain>
 <20180111094257.GA6603@e108498-lin.cambridge.arm.com>
 <20180112172410.GA10243@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932859AbeALRoT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Jan 2018 12:44:19 -0500
Content-Disposition: inline
In-Reply-To: <20180112172410.GA10243@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com

On Friday 12 Jan 2018 at 09:24:12 (-0800), Eduardo Valentin wrote:
> I would rather see a single series showing all users of the new API
> instead. If you want to split the series and add a link to the users
> of the new API into the series that takes it out of thermal subsystem,
> I am also fine, as long as I see the other users. Otherwise, this is a
> light nack, reason: no real new users of the new API, even though I
> can surely see how the scheduler could use it. But if you do not really
> present the code of the new users, this is just speculation.
> 
> Presenting the entire code of the new API + all its users can help us to
> judge if: (1) a new API is really needed, (2) where it should be place.
> 

Understood. I will still send a v2 next week with the changes requested
by Viresh and I'll mark my upcoming scheduler patches as depending on this
series.

Cheers,
Quentin
