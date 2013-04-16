From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] cpufreq: cpu0: Put cpu parent node after using it
Date: Tue, 16 Apr 2013 16:40:15 +0800
Message-ID: <20130416084013.GB11245@S2101-09.ap.freescale.net>
References: <377acb684be024176e1c64f7ca5b1937c3a23878.1366009701.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <377acb684be024176e1c64f7ca5b1937c3a23878.1366009701.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, linaro-kernel@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 15, 2013 at 12:39:37PM +0530, Viresh Kumar wrote:
> Parent node must be put after using it to balance its usage count. This was
> missing in cpufreq-cpu0 driver. Fix it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/cpufreq/cpufreq-cpu0.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index 31282fc..3ab8294 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -257,6 +257,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  	}
>  
>  	of_node_put(np);
> +	of_node_put(parent);
>  	return 0;
>  
>  out_free_table:
> -- 
> 1.7.12.rc2.18.g61b472e
> 
