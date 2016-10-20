From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] PM / OPP: fix debug/error messages in
 dev_pm_opp_of_get_sharing_cpus()
Date: Thu, 20 Oct 2016 12:30:56 +0530
Message-ID: <20161020070056.GM11766@vireshk-i7>
References: <1476946796-27698-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36816 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbcJTHBA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2016 03:01:00 -0400
Received: by mail-pf0-f174.google.com with SMTP id e6so30831315pfk.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2016 00:01:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1476946796-27698-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

On 20-10-16, 15:59, Masahiro Yamada wrote:
> These log messages are wrong because _of_get_opp_desc_node() returns
> an operating-points-v2 node.
> 
> Commit a6eed752f5fb ("PM / OPP: passing NULL to PTR_ERR()") fixed
> static checker warnings, and reworded the messages at the same time
> (but the latter was not mentioned in the git-log).
> 
> Restore the correct messages, dropping __func__.  We can grep the
> message string, so the function name would not carry much value.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Reword git-log slightly
>      comments -> log messages
> 
>  drivers/base/power/opp/of.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
> index 6480137..92e6d53 100644
> --- a/drivers/base/power/opp/of.c
> +++ b/drivers/base/power/opp/of.c
> @@ -562,7 +562,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>  	/* Get OPP descriptor node */
>  	np = _of_get_opp_desc_node(cpu_dev);
>  	if (!np) {
> -		dev_dbg(cpu_dev, "%s: Couldn't find cpu_dev node.\n", __func__);
> +		dev_dbg(cpu_dev, "Couldn't find opp node.\n");
>  		return -ENOENT;
>  	}
>  
> @@ -587,8 +587,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>  		/* Get OPP descriptor node */
>  		tmp_np = _of_get_opp_desc_node(tcpu_dev);
>  		if (!tmp_np) {
> -			dev_err(tcpu_dev, "%s: Couldn't find tcpu_dev node.\n",
> -				__func__);
> +			dev_err(tcpu_dev, "Couldn't find opp node.\n");

The error messages are very generic and it can get tricky to grep for them in
the source code..

I would prefer keeping function name in the print message.

-- 
viresh
