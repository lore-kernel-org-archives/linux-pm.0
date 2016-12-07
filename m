From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 05/10] PM / OPP: Add light weight _opp_free() routine
Date: Tue, 6 Dec 2016 17:12:18 -0800
Message-ID: <20161207011218.GI4388@codeaurora.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <ba6524b0b1561cd597ccb98977ad8e496b38fcec.1481015522.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60654 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbcLGBMU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 20:12:20 -0500
Content-Disposition: inline
In-Reply-To: <ba6524b0b1561cd597ccb98977ad8e496b38fcec.1481015522.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/06, Viresh Kumar wrote:
> The OPPs which are never successfully added using _opp_add() are not
> required to be freed with the _opp_remove() routine, as a simple kfree()
> is enough for them.
> 
> Introduce a new light weight routine _opp_free(), which will do that.
> 
> That also helps us removing the 'notify' parameter to _opp_remove(),
> which isn't required anymore.
> 
> Note that _opp_free() contains a call to _remove_opp_table() as the OPP
> table might have been added for this very OPP only. The
> _remove_opp_table() routine returns quickly if there are more OPPs in
> the table. This will be simplified in later patches though.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
