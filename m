From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 01/12] PM / OPP: Add per OPP table mutex
Date: Mon, 9 Jan 2017 15:11:39 -0800
Message-ID: <20170109231139.GT17126@codeaurora.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <ff7f66786879636d5a7347af93c044013ff66976.1481106919.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ff7f66786879636d5a7347af93c044013ff66976.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 12/07, Viresh Kumar wrote:
> Add per OPP table lock to protect opp_table->opp_list.
> 
> Note that at few places opp_list is used under the rcu_read_lock() and
> so a mutex can't be added there for now. This will be fixed by a later
> patch.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
