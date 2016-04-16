From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / clk: ensure we don't allocate a -ve size of count
 clks
Date: Sat, 16 Apr 2016 14:52:35 +0200
Message-ID: <20160416125235.GB31772@amd>
References: <1460811003-31806-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37578 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbcDPMwj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 16 Apr 2016 08:52:39 -0400
Content-Disposition: inline
In-Reply-To: <1460811003-31806-1-git-send-email-colin.king@canonical.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat 2016-04-16 13:50:03, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> It is entirely possible for of_count_phandle_wit_args to
> return a -ve error return value so we need to check for this
> otherwise we end up allocating a negative number of clk objects.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Pavel Machek <pavel@ucw.cz>


> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 0e64a1b..3657ac1 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -159,7 +159,7 @@ int of_pm_clk_add_clks(struct device *dev)
>  
>  	count = of_count_phandle_with_args(dev->of_node, "clocks",
>  					   "#clock-cells");
> -	if (count == 0)
> +	if (count <= 0)
>  		return -ENODEV;

Would it make sense to propagate the error value?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
