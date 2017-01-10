From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 10/12] PM / OPP: Simplify _opp_set_availability()
Date: Mon, 9 Jan 2017 16:00:29 -0800
Message-ID: <20170110000029.GB17126@codeaurora.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <8ca1aa7a452c7ffe8d54ebac93c3139ad692f185.1481106919.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59366 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753325AbdAJAAa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 19:00:30 -0500
Content-Disposition: inline
In-Reply-To: <8ca1aa7a452c7ffe8d54ebac93c3139ad692f185.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/07, Viresh Kumar wrote:
> As we don't use RCU locking anymore, there is no need to replace an
> earlier OPP node with a new one. Just update the existing one.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
