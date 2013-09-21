From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: check cpufreq driver is valid and cpufreq isn't
 disabled in cpufreq_get()
Date: Sat, 21 Sep 2013 11:21:14 +0530
Message-ID: <523D33D2.4050602@linux.vnet.ibm.com>
References: <389fbc3c8ad7c339cd2d9572d73c355b7b967823.1379669625.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <389fbc3c8ad7c339cd2d9572d73c355b7b967823.1379669625.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org

On 09/20/2013 10:37 PM, Viresh Kumar wrote:
> cpufreq_get() can be called from external drivers which might not be aware if
> cpufreq driver is registered or not. And so we should actually check if cpufreq
> driver is registered or not and also if cpufreq is active or disabled, at the
> beginning of cpufreq_get().
> 
> Otherwise call to lock_policy_rwsem_read() might hit BUG_ON(!policy).
> 
> Reported-and-Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

> 
> For 3.12.
> 
>  drivers/cpufreq/cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 82ecbe3..db004a8 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1460,6 +1460,9 @@ unsigned int cpufreq_get(unsigned int cpu)
>  {
>  	unsigned int ret_freq = 0;
> 
> +	if (cpufreq_disabled() || !cpufreq_driver)
> +		return -ENOENT;
> +
>  	if (!down_read_trylock(&cpufreq_rwsem))
>  		return 0;
> 

