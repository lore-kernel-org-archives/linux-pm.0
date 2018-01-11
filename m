From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] thermal, OPP: move the CPU power estimation to the
 OPP library
Date: Thu, 11 Jan 2018 15:12:01 +0530
Message-ID: <20180111094201.GH3626@vireshk-i7>
References: <20180109110252.13557-1-quentin.perret@arm.com>
 <20180110193431.GE3837@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44132 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753600AbeAKJmE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jan 2018 04:42:04 -0500
Received: by mail-pf0-f194.google.com with SMTP id m26so1258192pfj.11
        for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2018 01:42:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180110193431.GE3837@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Quentin Perret <quentin.perret@arm.com>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com

On 10-01-18, 11:34, Eduardo Valentin wrote:
> To be quite frank, I am happy to see this leaving thermal subsystem.

:)

> However, a few concerns with the patch set as it is. First, I am not
> convinced PM OPP is the right place to put this,

I had the very same doubt in the beginning as I wasn't sure if we
should read the dynamic power coefficient from within the OPP core as
it isn't part of the OPP table in the first place.

But then I thought a bit more on where exactly should we keep per
frequency power (or per OPP power) and nothing is better than the OPP
core for that, even if we don't have any more users and so I didn't
object to the series.

> nor I see a good
> explanation put in the patch set why it must be part of PM OPP.
> Second, looks like we are following ARM "good" practice of fixing

:)

> problems of the future. I would only really sign off for this series
> when we see real "other future users", otherwise we end up with the
> infamous static power scenario in 2-3 years down the row. If we
> currently do not have users of this IN MAINLINE KERNEL, then the series
> is not for upstream.

Well we are currently using the dynamic power numbers using the
thermal callbacks for cpu_cooling driver, so it isn't that bad :)

-- 
viresh
