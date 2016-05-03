From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 3/7] PM / OPP: Add dev_pm_opp_get_sharing_cpus()
Date: Mon, 2 May 2016 17:46:16 -0700
Message-ID: <20160503004616.GN3492@codeaurora.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
 <f8c698d839cadcfce1f01048ade655e039ee0c53.1461727086.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f8c698d839cadcfce1f01048ade655e039ee0c53.1461727086.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/27, Viresh Kumar wrote:
> OPP core allows a platform to mark OPP table as shared, when the
> platform isn't using operating-points-v2 bindings.
> 
> And, so there should be a non DT way of finding out if the OPP table is
> shared or not.
> 
> This patch adds dev_pm_opp_get_sharing_cpus(), which first tries to get
> OPP sharing information from the opp-table (in case it is already marked
> as shared), otherwise it uses the existing DT way of finding sharing
> information.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
