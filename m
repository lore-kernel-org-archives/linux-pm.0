From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 01/10] PM / OPP: Fix memory leak while adding
 duplicate OPPs
Date: Wed, 21 Dec 2016 16:39:43 -0800
Message-ID: <20161222003943.GA8288@codeaurora.org>
References: <cover.1481085478.git.viresh.kumar@linaro.org>
 <c4517fb2db294f2da5f6e306091c230210f51a75.1481085478.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47562 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754167AbcLVAjo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Dec 2016 19:39:44 -0500
Content-Disposition: inline
In-Reply-To: <c4517fb2db294f2da5f6e306091c230210f51a75.1481085478.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/07, Viresh Kumar wrote:
> There are two types of duplicate OPPs that get different behavior from
> the core:
> A). An earlier OPP is marked 'available' and has same freq/voltages as

perhaps just "A)" instead of "A)."

>     the new one.
> B). An earlier OPP with same frequency, but is marked 'unavailable' OR
>     doesn't have same voltages as the new one.
> 
> The OPP core returns 0 for the first one, but -EEXIST for the second.
> 
> While the OPP core returns 0 for the first case, its callers don't free
> the newly allocated OPP structure which isn't used anymore. Fix that by
> returning -EBUSY instead of 0, but make the callers return 0 eventually.
> 
> As this isn't a critical fix, its not getting marked for stable kernel.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
