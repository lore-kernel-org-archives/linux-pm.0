From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: Protect updates to list_dev with mutex
Date: Wed, 4 Nov 2015 14:11:25 -0800
Message-ID: <20151104221125.GU19782@codeaurora.org>
References: <5f8fac4ad84716ef68fc50ab0b78e11ad2837524.1446205160.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5f8fac4ad84716ef68fc50ab0b78e11ad2837524.1446205160.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, mturquette@baylibre.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 10/30, Viresh Kumar wrote:
> dev_opp_list_lock is used everywhere to protect device and OPP lists,
> but dev_pm_opp_set_sharing_cpus() is missed somehow. And instead we used
> rcu-lock, which wouldn't help here as we are adding a new list_dev.
> 
> This also fixes a problem where we have called kzalloc(..., GFP_KERNEL)
> from within rcu-lock, which isn't allowed as kzalloc can sleep when
> called with GFP_KERNEL.
> 
> With CONFIG_DEBUG_ATOMIC_SLEEP set, we will see the caller vomiting.
> 
> Fixes: 8d4d4e98acd6 ("PM / OPP: Add helpers for initializing CPU OPPs")
> Reported-by: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

I assume some other patch will come to fix the comment and/or add
the lockdep check.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
