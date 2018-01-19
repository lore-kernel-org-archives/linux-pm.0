From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/7] PM /Domain/OPP: Add support to get performance state
 from DT
Date: Fri, 19 Jan 2018 11:12:37 +0530
Message-ID: <20180119054237.GL3012@vireshk-i7>
References: <cover.1513926033.git.viresh.kumar@linaro.org>
 <20180118063404.GD3012@vireshk-i7>
 <1708603.ZsSVZozH3j@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:45556 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbeASFmk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jan 2018 00:42:40 -0500
Received: by mail-pg0-f50.google.com with SMTP id c194so625427pga.12
        for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2018 21:42:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1708603.ZsSVZozH3j@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org

On 18-01-18, 20:24, Rafael J. Wysocki wrote:
> On Thursday, January 18, 2018 7:34:04 AM CET Viresh Kumar wrote:
> > On 22-12-17, 12:56, Viresh Kumar wrote:
> > > Hi,
> > > 
> > > Now that the DT bindings [1] are already Reviewed/Acked by respective
> > > maintainers, here is the code to start using them.
> > > 
> > > The first two patches provide helpers in the OPP core, [3-5]/7 update
> > > the PM domain core to start supporting domain OPP tables, etc, 6/7
> > > updates the OPP core to use the new callback provided by the PM domains
> > > to get performance state and the last one removes the unused helpers
> > > now.
> > > 
> > > This is tested on Hikey620 and works just fine.
> > 
> > Ping !
> 
> Well, whom are you pinging exactly and why?

Ulf and Kevin as its been almost a month since this series is posted
and has received no comments at all.

-- 
viresh
