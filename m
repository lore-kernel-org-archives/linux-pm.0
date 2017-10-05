From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: Rename dev_pm_opp_register_put_opp_helper()
Date: Thu, 5 Oct 2017 10:30:34 -0700
Message-ID: <20171005173034.GE457@codeaurora.org>
References: <0d69b3a1e8b565815c1f5a77f5622b524f6f7d35.1507204552.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0d69b3a1e8b565815c1f5a77f5622b524f6f7d35.1507204552.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/05, Viresh Kumar wrote:
> The routine is named incorrectly since the first attempt as there is
> nothing like a put_opp() helper. We wanted to unregister the set_opp()
> helper here and so it should rather be named as
> dev_pm_opp_unregister_set_opp_helper().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
