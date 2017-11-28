From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v4.4] PM / OPP: Add missing of_node_put(np)
Date: Tue, 28 Nov 2017 09:43:22 +0100
Message-ID: <20171128084322.GG9413@kroah.com>
References: <3b71eca9ceb96a3525f4bb08bd1225536d691638.1511851763.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59833 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751133AbdK1InR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Nov 2017 03:43:17 -0500
Content-Disposition: inline
In-Reply-To: <3b71eca9ceb96a3525f4bb08bd1225536d691638.1511851763.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: stable@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Nov 28, 2017 at 12:20:41PM +0530, Viresh Kumar wrote:
> From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> 
> commit 7978db344719dab1e56d05e6fc04aaaddcde0a5e upstream.
> 
> The for_each_available_child_of_node() loop in _of_add_opp_table_v2()
> doesn't drop the reference to "np" on errors. Fix that.
> 
> Fixes: 274659029c9d (PM / OPP: Add support to parse "operating-points-v2" bindings)
> Cc: 4.4 <stable@vger.kernel.org> # 4.4
> Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> [ VK: Improved commit log. ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/opp/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index b8e76f75073b..0b4190a1efaa 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -1199,6 +1199,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
>  		if (ret) {
>  			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
>  				ret);
> ++			of_node_put(np);

I don't think you test-built this patch :(
