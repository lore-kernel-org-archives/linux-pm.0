From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 06/12] PM / OPP: Add 'struct kref' to struct dev_pm_opp
Date: Fri, 13 Jan 2017 14:26:39 +0530
Message-ID: <20170113085639.GE9953@vireshk-i7>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <1d5f61440dbfb640c330f77c9090e2ac23482ebc.1481106919.git.viresh.kumar@linaro.org>
 <20170109234427.GY17126@codeaurora.org>
 <20170110042632.GC6332@vireshk-i7>
 <20170113085259.GS17126@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36016 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751218AbdAMI4n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2017 03:56:43 -0500
Received: by mail-pf0-f177.google.com with SMTP id 189so28442287pfu.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2017 00:56:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170113085259.GS17126@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 13-01-17, 00:52, Stephen Boyd wrote:
> What still doesn't make sense is how an individual OPP could go
> away without the table that the OPP lives in also going away.

dev_pm_opp_remove() is one such option, which can remove OPPs
individually. Over that, while remove tables we remove all the OPPs
one by one. So that really does happen.

> If
> an OPP is going away while a driver has a reference to it, then
> the driver using that OPP should probably not be using it.

That is being protected with this patch now and the drivers can use
them freely.

> TL;DR
> letting drivers use OPP pointers outside of the OPP core feels
> racy.

Hmm, we don't update the OPP a lot after creating it today. But that's
a different problem to solve, if we really see a race there.

-- 
viresh
