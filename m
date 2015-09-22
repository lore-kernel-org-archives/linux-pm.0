From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/5] OPP: Allow notifiers to call
 dev_pm_opp_get_{voltage,freq} RCU-free
Date: Tue, 22 Sep 2015 10:10:31 -0700
Message-ID: <20150922171031.GH24314@linux>
References: <1442623929-4507-1-git-send-email-sboyd@codeaurora.org>
 <1442623929-4507-4-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442623929-4507-4-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 18-09-15, 17:52, Stephen Boyd wrote:
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
>  drivers/base/power/opp.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 35b66c46dcb7..1d8c45e53245 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -146,9 +146,10 @@ static LIST_HEAD(dev_opp_list);
>  /* Lock to allow exclusive modification to the device and opp lists */
>  static DEFINE_MUTEX(dev_opp_list_lock);
>  
> -#define opp_rcu_lockdep_assert()					\
> +#define opp_rcu_lockdep_assert(s)					\
>  do {									\
>  	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
> +				!(s && srcu_read_lock_held(s)) &&	\
>  				!lockdep_is_held(&dev_opp_list_lock),	\
>  			   "Missing rcu_read_lock() or "		\
>  			   "dev_opp_list_lock protection");		\
> @@ -236,9 +237,10 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
>  	struct dev_pm_opp *tmp_opp;
>  	unsigned long v = 0;
>  
> -	opp_rcu_lockdep_assert();
> +	opp_rcu_lockdep_assert(&opp->dev_opp->srcu_head.srcu);
>  
> -	tmp_opp = rcu_dereference(opp);
> +	tmp_opp = srcu_dereference_check(opp, &opp->dev_opp->srcu_head.srcu,
> +					 rcu_read_lock_held());
>  	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available)
>  		pr_err("%s: Invalid parameters\n", __func__);
>  	else
> @@ -268,9 +270,10 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
>  	struct dev_pm_opp *tmp_opp;
>  	unsigned long f = 0;
>  
> -	opp_rcu_lockdep_assert();
> +	opp_rcu_lockdep_assert(&opp->dev_opp->srcu_head.srcu);
>  
> -	tmp_opp = rcu_dereference(opp);
> +	tmp_opp = srcu_dereference_check(opp, &opp->dev_opp->srcu_head.srcu,
> +					 rcu_read_lock_held());
>  	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available)
>  		pr_err("%s: Invalid parameters\n", __func__);
>  	else
> @@ -437,7 +440,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
>  	struct device_opp *dev_opp;
>  	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
>  
> -	opp_rcu_lockdep_assert();
> +	opp_rcu_lockdep_assert(NULL);
>  
>  	dev_opp = _find_device_opp(dev);
>  	if (IS_ERR(dev_opp)) {
> @@ -485,7 +488,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
>  	struct device_opp *dev_opp;
>  	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
>  
> -	opp_rcu_lockdep_assert();
> +	opp_rcu_lockdep_assert(NULL);
>  
>  	if (!dev || !freq) {
>  		dev_err(dev, "%s: Invalid argument freq=%p\n", __func__, freq);
> @@ -535,7 +538,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
>  	struct device_opp *dev_opp;
>  	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
>  
> -	opp_rcu_lockdep_assert();
> +	opp_rcu_lockdep_assert(NULL);
>  
>  	if (!dev || !freq) {
>  		dev_err(dev, "%s: Invalid argument freq=%p\n", __func__, freq);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
