From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 04/12] PM / OPP: Take reference of the OPP table while
 adding/removing OPPs
Date: Mon, 9 Jan 2017 15:38:43 -0800
Message-ID: <20170109233843.GW17126@codeaurora.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <dad4f39fe50bd499dcc541c3b2622408158a9cba.1481106919.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51302 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756246AbdAIXip (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 18:38:45 -0500
Content-Disposition: inline
In-Reply-To: <dad4f39fe50bd499dcc541c3b2622408158a9cba.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/07, Viresh Kumar wrote:
> Take reference of the OPP table while adding and removing OPPs, that
> helps us remove special checks in _remove_opp_table().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
