From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v2 1/2] PM / OPP: introduce an OPP power estimation helper
Date: Wed, 17 Jan 2018 10:59:50 +0000
Message-ID: <20180117105950.GG23988@e108498-lin.cambridge.arm.com>
References: <20180116165119.15168-1-quentin.perret@arm.com>
 <20180116165119.15168-2-quentin.perret@arm.com>
 <20180117053724.GL22978@vireshk-i7>
 <20180117102746.GE23988@e108498-lin.cambridge.arm.com>
 <20180117104103.GC3012@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752452AbeAQK7z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jan 2018 05:59:55 -0500
Content-Disposition: inline
In-Reply-To: <20180117104103.GC3012@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com, joelaf@google.com, tkjos@google.com

On Wednesday 17 Jan 2018 at 16:11:03 (+0530), Viresh Kumar wrote:
> On 17-01-18, 10:27, Quentin Perret wrote:
> > What I suggest is to call __cpufreq_cooling_register() with
> > has_power=true in of_cpufreq_cooling_register() and bail out from
> > update_freq_table() cleanly whenever dev_pm_opp_get_power() returns 0
> > (and in this case we fallback on the has_power=false path). Does that
> > make sense ?
> 
> Maybe just remove the has_power thing completely and always call
> update_freq_table() and let it update power to 0 ? Its anyway a one time
> initialization thing, wouldn't matter much.

Hmmm I just need to make sure to fallback on the right cooling_ops if
update_freq_table() updated the power to 0, but yes, that should work.
I'll do the change in v3.

Cheers,
Quentin
