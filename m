From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 03/10] PM / OPP: Rename _allocate_opp() to _opp_allocate()
Date: Tue, 6 Dec 2016 17:10:18 -0800
Message-ID: <20161207011018.GH4388@codeaurora.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <14d9cb590de6a19b9382b014e77d374420f3e5f5.1481015522.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60066 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751592AbcLGBLQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 20:11:16 -0500
Content-Disposition: inline
In-Reply-To: <14d9cb590de6a19b9382b014e77d374420f3e5f5.1481015522.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/06, Viresh Kumar wrote:
> Make the naming consistent with how other routines are named.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
