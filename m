From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/5] cpufreq: don't break string in print statements
Date: Thu, 12 Sep 2013 13:41:13 +0530
Message-ID: <52317721.9050407@linux.vnet.ibm.com>
References: <cover.1378963070.git.viresh.kumar@linaro.org> <e086b55f2ec5c7a67fa28a21f23c088b67e5191e.1378963070.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:46846 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755573Ab3ILIPL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2013 04:15:11 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 12 Sep 2013 13:35:32 +0530
In-Reply-To: <e086b55f2ec5c7a67fa28a21f23c088b67e5191e.1378963070.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, swarren@wwwdotorg.org, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/12/2013 10:55 AM, Viresh Kumar wrote:
> As a rule its better not to break string (quoted inside "") in a print statement
> even if it crosses 80 column boundary as that may introduce unwanted bugs and so
> this patch rewrites one of the print statements..
> 

Ok, if that is the convention, then so be it.

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 28477eb..31f7845 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1192,8 +1192,8 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
>  			unlock_policy_rwsem_write(cpu);
> 
>  			if (!frozen) {
> -				pr_debug("%s: policy Kobject moved to cpu: %d "
> -					 "from: %d\n",__func__, new_cpu, cpu);
> +				pr_debug("%s: policy Kobject moved to cpu: %d from: %d\n",
> +						__func__, new_cpu, cpu);
>  			}
>  		}
>  	}
> 

