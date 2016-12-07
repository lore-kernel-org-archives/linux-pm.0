From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 09/10] PM / OPP: Don't expose srcu_head to register
 notifiers
Date: Tue, 6 Dec 2016 17:22:51 -0800
Message-ID: <20161207012251.GM4388@codeaurora.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <5ebbb7e9ed838f27aa26c943247f8c4d1c997f14.1481015522.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37178 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbcLGBef (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 20:34:35 -0500
Content-Disposition: inline
In-Reply-To: <5ebbb7e9ed838f27aa26c943247f8c4d1c997f14.1481015522.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/06, Viresh Kumar wrote:
> Let the OPP core provide helpers to register notifiers for any device,
> instead of exposing srcu_head outside of the core.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
