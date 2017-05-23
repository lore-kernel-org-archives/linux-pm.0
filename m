From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/4] PM / OPP: Don't create copy of regulators
 unnecessarily
Date: Mon, 22 May 2017 18:10:18 -0700
Message-ID: <20170523011018.GJ20170@codeaurora.org>
References: <cover.1494995911.git.viresh.kumar@linaro.org>
 <7e185f9780252587f58efdff9b1d3079120a4246.1494995911.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7e185f9780252587f58efdff9b1d3079120a4246.1494995911.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 05/17, Viresh Kumar wrote:
> This code was required while the OPP core was managed with help of RCUs,
> but not anymore. Get rid of unnecessary alloc/memcpy operations.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
