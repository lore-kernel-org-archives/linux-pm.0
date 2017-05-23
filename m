From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 3/4] PM / OPP: opp-microvolt is not optional if
 regulators are set
Date: Tue, 23 May 2017 14:01:35 -0700
Message-ID: <20170523210135.GO20170@codeaurora.org>
References: <cover.1495511998.git.viresh.kumar@linaro.org>
 <dcb9872771568fec4c7d8d11ba4939cd8da279c0.1495511998.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dcb9872771568fec4c7d8d11ba4939cd8da279c0.1495511998.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 05/23, Viresh Kumar wrote:
> If dev_pm_opp_set_regulators() is called for a device and its regulators
> are set in the OPP core, the OPP nodes for the device must contain the
> "opp-microvolt" property, otherwise there is something wrong and we
> better error out.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
