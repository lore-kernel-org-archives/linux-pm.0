From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 11/16] cpufreq: dt: Pass regulator name to the OPP core
Date: Tue, 9 Feb 2016 11:07:17 -0800
Message-ID: <20160209190717.GC30978@codeaurora.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
 <ad55cd1a03e712e2c0c49701e87a37199cb8376e.1454992187.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ad55cd1a03e712e2c0c49701e87a37199cb8376e.1454992187.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02/09, Viresh Kumar wrote:
> OPP core can handle the regulators by itself, and but it needs to know
> the name of the regulator to fetch. Add support for that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
