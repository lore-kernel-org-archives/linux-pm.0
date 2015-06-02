From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC/PATCH 4/6] OPP: Allow notifiers to call
 dev_pm_opp_get_{voltage,freq} RCU-free
Date: Tue, 02 Jun 2015 12:30:49 +0900
Message-ID: <556D2369.2000603@samsung.com>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
 <1433209679-31389-5-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:45245 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880AbbFBDaz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2015 23:30:55 -0400
In-reply-to: <1433209679-31389-5-git-send-email-sboyd@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>

On 02.06.2015 10:47, Stephen Boyd wrote:
> We pass the dev_pm_opp structure to OPP notifiers but the users
> of the notifier need to surround calls to dev_pm_opp_get_*() with
> RCU read locks to avoid lockdep warnings. The notifier is already
> called with the dev_opp's srcu lock held, so it should be safe to
> assume the devm_pm_opp structure is already protected inside the
> notifier. Update the lockdep check for this.
> 
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> This is probably wrong, but it's what I had to hack up
> to be able to use the OPP functions from within the notifier
> to figure out the new values of the OPP without having to take
> an RCU read lock.
> 
>  drivers/base/power/opp.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index b997a7eabcd4..6d75022c6a0e 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -108,9 +108,10 @@ static LIST_HEAD(dev_opp_list);
>  /* Lock to allow exclusive modification to the device and opp lists */
>  static DEFINE_MUTEX(dev_opp_list_lock);
>  
> -#define opp_rcu_lockdep_assert()					\
> +#define opp_rcu_lockdep_assert(s)					\
>  do {									\
>  	rcu_lockdep_assert(rcu_read_lock_held() ||			\
> +				(s && srcu_read_lock_held(s)) || 	\
>  				lockdep_is_held(&dev_opp_list_lock),	\
>  			   "Missing rcu_read_lock() or "		\
>  			   "dev_opp_list_lock protection");		\
> @@ -169,9 +170,10 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
>  	struct dev_pm_opp *tmp_opp;
>  	unsigned long v = 0;
>  
> -	opp_rcu_lockdep_assert();
> +	opp_rcu_lockdep_assert(&opp->dev_opp->srcu_head.srcu);
>  
> -	tmp_opp = rcu_dereference(opp);
> +	tmp_opp = srcu_dereference_check(opp, &opp->dev_opp->srcu_head.srcu,
> +					 rcu_read_lock_held());

It looks strange. The notifier's SRCU is part of device_opp but here we
want to protect the dev_pm_opp.

Because of this difference I am not sure that it is safe having around
this a srcu_read_lock() from notifiers instead of rcu_read_lock().

Best regards,
Krzysztof

