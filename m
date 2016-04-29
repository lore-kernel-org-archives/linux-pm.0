From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2][UPDATE] PM / OPP: add non-OF versions of
 dev_pm_opp_{cpumask_,}remove_table
Date: Fri, 29 Apr 2016 14:58:25 +0530
Message-ID: <20160429092825.GA17472@vireshk-i7>
References: <1461863237-12928-1-git-send-email-sudeep.holla@arm.com>
 <1461921756-15109-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36400 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbcD2J23 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Apr 2016 05:28:29 -0400
Received: by mail-pf0-f180.google.com with SMTP id c189so46403478pfb.3
        for <linux-pm@vger.kernel.org>; Fri, 29 Apr 2016 02:28:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461921756-15109-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

This isn't V2, but V3

On 29-04-16, 10:22, Sudeep Holla wrote:
> Functions dev_pm_opp_of_{cpumask_,}remove_table removes/frees all the
> static OPP entries associated with the device and/or all cpus(in case
> of cpumask) that are created from DT.
> 
> However the OPP entries are populated reading from the firmware or some
> different method using dev_pm_opp_add are marked dynamic and can't be
> removed using above functions.
> 
> This patch adds non DT/OF versions of dev_pm_opp_{cpumask_,}remove_table
> to support the above mentioned usecase.
> 
> This is in preparation to make use of the same in scpi-cpufreq.c
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> CC: Stephen Boyd <sboyd@codeaurora.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/power/opp/core.c | 56 ++++++++++++++++++++++++++++++----------
>  drivers/base/power/opp/cpu.c  | 59 ++++++++++++++++++++++++++++++++-----------
>  include/linux/pm_opp.h        | 10 ++++++++
>  3 files changed, 96 insertions(+), 29 deletions(-)
> 
> v1->v2:
> 	- Instead of renaming OF versions, created non-OF versions of
> 	  dev_pm_opp_{cpumask_,}remove_table as suggested by Viresh
> 

You should have added v2->v3 here

> This version also updates all the errors in documentation and changes
> to use remove_all rather than remove_dyn.

But all that isn't going to be part of the history, so it should be fine :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
