From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: Add missing of_node_put(np)
Date: Wed, 4 Oct 2017 09:42:05 -0700
Message-ID: <a3dd282e-220d-5a10-7a0e-10c1acaee737@codeaurora.org>
References: <3a82b2d3311e16f0f638de18bf0ee803540014a3.1507096875.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56944 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdJDQmI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2017 12:42:08 -0400
In-Reply-To: <3a82b2d3311e16f0f638de18bf0ee803540014a3.1507096875.git.viresh.kumar@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, Tobias Jordan <Tobias.Jordan@elektrobit.com>, "4 . 3+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org

On 10/03/2017 11:05 PM, Viresh Kumar wrote:
> From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
>
> The for_each_available_child_of_node() loop in _of_add_opp_table_v2()
> doesn't drop the reference to "np" on errors. Fix that.
>
> Fixes: 274659029c9d ("PM / OPP: Add support to parse "operating-points-v2" bindings")
> Cc: 4.3+ <stable@vger.kernel.org> # 4.3+
> Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> [ VK: Improved commit log. ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Looks like that opp_table->np = opp_np assignment in this function needs
to do an of_node_get() because the caller of this function puts the
pointer unconditionally.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
