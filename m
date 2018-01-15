From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] thermal, OPP: move the CPU power estimation to the
 OPP library
Date: Mon, 15 Jan 2018 09:56:17 +0530
Message-ID: <20180115042617.GB22978@vireshk-i7>
References: <20180109110252.13557-1-quentin.perret@arm.com>
 <20180110193431.GE3837@localhost.localdomain>
 <20180111094257.GA6603@e108498-lin.cambridge.arm.com>
 <20180112172410.GA10243@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35605 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932083AbeAOE0V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Jan 2018 23:26:21 -0500
Received: by mail-pg0-f65.google.com with SMTP id d6so7416551pgv.2
        for <linux-pm@vger.kernel.org>; Sun, 14 Jan 2018 20:26:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180112172410.GA10243@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Quentin Perret <quentin.perret@arm.com>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com

On 12-01-18, 09:24, Eduardo Valentin wrote:
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

So the idea will be to wait until the scheduler maintainers are ready to apply
those patches and then only apply the thermal/OPP patches ?

I am asking because it normally takes *ages* for anything to get accepted in the
scheduler and what gets merged eventually can be very much different than what
was proposed.

-- 
viresh
