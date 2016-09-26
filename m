From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH] PM / OPP: Don't support OPP if it provides
 supported-hw but platform does not
Date: Mon, 26 Sep 2016 10:47:59 +0530
Message-ID: <20160926051759.GK17336@vireshk-i7>
References: <20160923200747.3948-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33133 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbcIZFSE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2016 01:18:04 -0400
Received: by mail-pa0-f54.google.com with SMTP id hm5so58937757pac.0
        for <linux-pm@vger.kernel.org>; Sun, 25 Sep 2016 22:18:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160923200747.3948-1-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Lee Jones <lee.jones@linaro.org>

On 23-09-16, 15:07, Dave Gerlach wrote:
> The OPP framework allows each OPP to set a opp-supported-hw property
> which provides values that are matched against supported_hw values
> provided by the platform to limit support for certain OPPs on specific
> hardware. Currently, if the platform does not set supported_hw values,
> all OPPs are interpreted as supported, even if they have provided their
> own opp-supported-hw values.
> 
> If an OPP has provided opp-supported-hw, it is indicating that there is
> some specific hardware configuration it is supported by. These constraints
> should be honored, and if no supported_hw has been provided by the
> platform, there is no way to determine if that OPP is actually supported,
> so it should be marked as not supported.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  drivers/base/power/opp/of.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
> index 1dfd3dd92624..ccccaf9f8968 100644
> --- a/drivers/base/power/opp/of.c
> +++ b/drivers/base/power/opp/of.c
> @@ -71,8 +71,18 @@ static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
>  	u32 version;
>  	int ret;
>  
> -	if (!opp_table->supported_hw)
> -		return true;
> +	if (!opp_table->supported_hw) {
> +		/*
> +		 * In the case that no supported_hw has been set by the
> +		 * platform but there is an opp-supported-hw value set for
> +		 * an OPP then the OPP should not be enabled as there is
> +		 * no way to see if the hardware supports it.
> +		 */
> +		if (of_find_property(np, "opp-supported-hw", NULL))
> +			return false;
> +		else
> +			return true;
> +	}
>  
>  	while (count--) {
>  		ret = of_property_read_u32_index(np, "opp-supported-hw", count,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
