From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: remove unnecessary unlikely()
Date: Fri, 14 Sep 2018 10:31:14 +0200
Message-ID: <2593189.gyA7ZCrH2V@aspire.rjw.lan>
References: <20180907160955.23291-1-igor.stoppa@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907160955.23291-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Stoppa <igor.stoppa@gmail.com>
Cc: "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Igor Stoppa <igor.stoppa@huawei.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, September 7, 2018 6:09:55 PM CEST Igor Stoppa wrote:
> WARN_ON() already contains an unlikely(), so it's not necessary to wrap it
> into another.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Cc: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index f53fb41efb7b..7aa3dcad2175 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -403,7 +403,7 @@ EXPORT_SYMBOL_GPL(cpufreq_freq_transition_begin);
>  void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
>  		struct cpufreq_freqs *freqs, int transition_failed)
>  {
> -	if (unlikely(WARN_ON(!policy->transition_ongoing)))
> +	if (WARN_ON(!policy->transition_ongoing))
>  		return;
>  
>  	cpufreq_notify_post_transition(policy, freqs, transition_failed);
> 

Applied, thanks!
