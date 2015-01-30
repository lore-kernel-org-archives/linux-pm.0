From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] PM / OPP: Assert RCU lock in exported functions
Date: Fri, 30 Jan 2015 01:16:33 +0100
Message-ID: <2257225.Zj8XFux8qJ@vostro.rjw.lan>
References: <1420792078-14132-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57398 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752422AbbA2Xxp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 18:53:45 -0500
In-Reply-To: <1420792078-14132-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, January 09, 2015 09:27:57 AM Krzysztof Kozlowski wrote:
> Add lockdep asserts for holding the RCU lock when calling
> dev_pm_opp_get_freq() and dev_pm_opp_get_voltage() to aid in detecting
> RCU misuses.
> 
> These are called often after dev_pm_opp_find_freq_ceil/exact() which
> already asserts for RCU lock. However one could make an error by
> releasing lock too early - just after dev_pm_opp_find_freq_ceil().
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Queued up for 3.20, thanks!

> ---
>  drivers/base/power/opp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 106c69359306..842d31e24eee 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -169,6 +169,8 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
>  	struct dev_pm_opp *tmp_opp;
>  	unsigned long v = 0;
>  
> +	opp_rcu_lockdep_assert();
> +
>  	tmp_opp = rcu_dereference(opp);
>  	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
>  		pr_err("%s: Invalid parameters\n", __func__);
> @@ -199,6 +201,8 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
>  	struct dev_pm_opp *tmp_opp;
>  	unsigned long f = 0;
>  
> +	opp_rcu_lockdep_assert();
> +
>  	tmp_opp = rcu_dereference(opp);
>  	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
>  		pr_err("%s: Invalid parameters\n", __func__);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
