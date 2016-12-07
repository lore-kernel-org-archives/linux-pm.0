From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 04/10] PM / OPP: Error out on failing to add static OPPs
 for v1 bindings
Date: Wed, 7 Dec 2016 08:55:55 +0530
Message-ID: <20161207032555.GE31255@vireshk-i7>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <1f876a6d176784f9ab901aea7ff521d53522682d.1481015522.git.viresh.kumar@linaro.org>
 <20161207011722.GJ4388@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34162 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbcLGD0G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 22:26:06 -0500
Received: by mail-pg0-f47.google.com with SMTP id x23so156542974pgx.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2016 19:25:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161207011722.GJ4388@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 06-12-16, 17:17, Stephen Boyd wrote:
> On 12/06, Viresh Kumar wrote:
> > The code adding static OPPs for V2 bindings already does so. Make the V1
> > bindings specific code behave the same.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> It looks like that goes back to the original DT OPP binding
> support written by Shawn Guo. Any idea why we kept trying to add
> more OPPs if it failed to add one? Best effort or something?

Not sure, maybe for handling duplicate OPPs.

-- 
viresh
