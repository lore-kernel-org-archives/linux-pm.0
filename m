From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/6] PM / OPP: restructure _of_init_opp_table_v2()
Date: Tue, 11 Aug 2015 14:07:44 +0530
Message-ID: <20150811083744.GF5509@linux>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <804c420eb23e70448c3c2c93f867a0eab3536bfd.1439187821.git.viresh.kumar@linaro.org>
 <20150810192336.GC9678@codeaurora.org>
 <20150811002342.GD5766@linux>
 <55C9425B.4060207@codeaurora.org>
 <20150811022546.GL5766@linux>
 <20150811060855.GH9678@codeaurora.org>
 <20150811065738.GE5147@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34052 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbbHKIhu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 04:37:50 -0400
Received: by pawu10 with SMTP id u10so159599973paw.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 01:37:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150811065738.GE5147@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 11-08-15, 12:27, Viresh Kumar wrote:
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 1daaa1a418a2..be3356a3a452 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -1292,14 +1292,18 @@ static int _of_init_opp_table_v2(struct device *dev,
>  	}
>  
>  	/* There should be one of more OPP defined */
> -	if (WARN_ON(!count))
> +	if (WARN_ON(!count)) {
> +		ret = -ENOENT;
>  		goto out;
> +	}
>  
>  	if (!ret) {
>  		if (!dev_opp) {
>  			dev_opp = _find_device_opp(dev);
> -			if (WARN_ON(!dev_opp))
> +			if (WARN_ON(!dev_opp)) {

Dan also reported that !dev_opp isn't enough as we need to use IS_ERR
here.

We have got enough updates here, let me resend the series again to get
more reviews on proper patches.

-- 
viresh
