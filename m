From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2] PM / OPP: introduce an OPP power estimation helper
Date: Wed, 17 Jan 2018 16:11:03 +0530
Message-ID: <20180117104103.GC3012@vireshk-i7>
References: <20180116165119.15168-1-quentin.perret@arm.com>
 <20180116165119.15168-2-quentin.perret@arm.com>
 <20180117053724.GL22978@vireshk-i7>
 <20180117102746.GE23988@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:39864 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeAQKlG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jan 2018 05:41:06 -0500
Received: by mail-pf0-f179.google.com with SMTP id e11so11310830pff.6
        for <linux-pm@vger.kernel.org>; Wed, 17 Jan 2018 02:41:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180117102746.GE23988@e108498-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com, joelaf@google.com, tkjos@google.com

On 17-01-18, 10:27, Quentin Perret wrote:
> What I suggest is to call __cpufreq_cooling_register() with
> has_power=true in of_cpufreq_cooling_register() and bail out from
> update_freq_table() cleanly whenever dev_pm_opp_get_power() returns 0
> (and in this case we fallback on the has_power=false path). Does that
> make sense ?

Maybe just remove the has_power thing completely and always call
update_freq_table() and let it update power to 0 ? Its anyway a one time
initialization thing, wouldn't matter much.

-- 
viresh
