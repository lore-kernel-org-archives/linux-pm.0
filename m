From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v4.9] PM / OPP: Add missing of_node_put(np)
Date: Tue, 28 Nov 2017 09:44:15 +0100
Message-ID: <20171128084415.GH9413@kroah.com>
References: <ae2651dc6a3e347122f4736eb3a682185508cbc7.1511851887.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ae2651dc6a3e347122f4736eb3a682185508cbc7.1511851887.git.viresh.kumar@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: stable@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 28, 2017 at 12:21:38PM +0530, Viresh Kumar wrote:
> From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> 
> commit 7978db344719dab1e56d05e6fc04aaaddcde0a5e upstream.
> 
> The for_each_available_child_of_node() loop in _of_add_opp_table_v2()
> doesn't drop the reference to "np" on errors. Fix that.
> 
> Fixes: 274659029c9d (PM / OPP: Add support to parse "operating-points-v2" bindings)
> Cc: 4.9 <stable@vger.kernel.org> # 4.9
> Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> [ VK: Improved commit log. ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/opp/of.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks, now applied.

greg k-h
