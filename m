From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V1 Resend 02/10] PM / OPP: Drop unlikely before IS_ERR(_OR_NULL)
Date: Fri, 28 Aug 2015 16:17:56 +0200
Message-ID: <4143341.O8kzUSgY49@vostro.rjw.lan>
References: <cover.1439375087.git.viresh.kumar@linaro.org> <455a29a594b92b9ba06b14249d8f61a7ffbbecc1.1439375087.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43500 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752473AbbH1NuW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2015 09:50:22 -0400
In-Reply-To: <455a29a594b92b9ba06b14249d8f61a7ffbbecc1.1439375087.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: trivial@kernel.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>

On Wednesday, August 12, 2015 03:59:39 PM Viresh Kumar wrote:
> IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
> is no need to do that again from its callers. Drop it.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Did that go anywhere or should I apply it?

> ---
>  drivers/base/power/opp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 51b220e615d3..97c31170437d 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -204,7 +204,7 @@ static struct device_opp *_find_device_opp(struct device *dev)
>  {
>  	struct device_opp *dev_opp;
>  
> -	if (unlikely(IS_ERR_OR_NULL(dev))) {
> +	if (IS_ERR_OR_NULL(dev)) {
>  		pr_err("%s: Invalid parameters\n", __func__);
>  		return ERR_PTR(-EINVAL);
>  	}
> @@ -239,7 +239,7 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
>  	opp_rcu_lockdep_assert();
>  
>  	tmp_opp = rcu_dereference(opp);
> -	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
> +	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available)
>  		pr_err("%s: Invalid parameters\n", __func__);
>  	else
>  		v = tmp_opp->u_volt;
> @@ -271,7 +271,7 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
>  	opp_rcu_lockdep_assert();
>  
>  	tmp_opp = rcu_dereference(opp);
> -	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
> +	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available)
>  		pr_err("%s: Invalid parameters\n", __func__);
>  	else
>  		f = tmp_opp->rate;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
