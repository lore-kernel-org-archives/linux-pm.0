From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] PM / OPP: introduce an OPP power estimation helper
Date: Wed, 10 Jan 2018 15:55:52 +0530
Message-ID: <20180110102552.GD3626@vireshk-i7>
References: <20180109110252.13557-1-quentin.perret@arm.com>
 <20180109110252.13557-2-quentin.perret@arm.com>
 <20180110043625.GD3335@vireshk-i7>
 <20180110102044.GA25543@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f48.google.com ([209.85.160.48]:36519 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbeAJKZz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jan 2018 05:25:55 -0500
Received: by mail-pl0-f48.google.com with SMTP id b12so7019356plm.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2018 02:25:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180110102044.GA25543@e108498-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com

On 10-01-18, 10:20, Quentin Perret wrote:
> So that was actually my first idea as well but I struggled to come up
> with a clean implementation TBH ...
> 
> My concern was mainly to get the dynamic-power-coefficient cleanly. With
> the approach you proposed, there are cases (for platforms using
> dev_pm_opp_add() such as Juno for ex) where I don't see how we can avoid
> to re-read the capacitance from the DT for each and every OPP that's being
> added. Or we have to rely on the driver to give it to us but that's against
> changes that you pushed recently I think.
> 
> Do you think reading the "dynamic-power-coefficient" value from the DT
> directly in dev_pm_add_opp() (and other places to support the v2 bindings)
> would be acceptable ? Did you have something different in mind ?

I think you can read it from within _of_init_opp_table() only once and then just
use it everywhere. Will that work ?

-- 
viresh
