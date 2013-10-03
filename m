From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 03/11] cpufreq: remove invalid comment from __cpufreq_remove_dev()
Date: Thu, 03 Oct 2013 12:55:10 +0530
Message-ID: <524D1BD6.4040608@linux.vnet.ibm.com>
References: <cover.1380703248.git.viresh.kumar@linaro.org> <0d25692a141042a3d4d6fab310029e96fbe57822.1380703248.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <0d25692a141042a3d4d6fab310029e96fbe57822.1380703248.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10/02/2013 02:13 PM, Viresh Kumar wrote:
> Some section of kerneldoc comment for __cpufreq_remove_dev() is invalid now.
> Remove it.
> 
> Suggested-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

> ---
>  drivers/cpufreq/cpufreq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index ae866b1..d80cbe6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1260,8 +1260,6 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>   * __cpufreq_remove_dev - remove a CPU device
>   *
>   * Removes the cpufreq interface for a CPU device.
> - * Caller should already have policy_rwsem in write mode for this CPU.
> - * This routine frees the rwsem before returning.
>   */
>  static inline int __cpufreq_remove_dev(struct device *dev,
>  				       struct subsys_interface *sif,
> 

