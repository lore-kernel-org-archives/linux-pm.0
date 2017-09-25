From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: SPEAr: pr_err() strings should end with newlines
Date: Mon, 25 Sep 2017 16:12:00 -0700
Message-ID: <20170925231200.GC3053@ubuntu>
References: <511e2c0f9a2dd23aceb8c0fc39184bfaca1f98c9.1506334381.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <511e2c0f9a2dd23aceb8c0fc39184bfaca1f98c9.1506334381.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 25-09-17, 15:43, Arvind Yadav wrote:
> pr_err() messages should terminated with a new-line to avoid
> other messages being concatenated onto the end.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/cpufreq/spear-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
> index 4894924..195f27f 100644
> --- a/drivers/cpufreq/spear-cpufreq.c
> +++ b/drivers/cpufreq/spear-cpufreq.c
> @@ -177,7 +177,7 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
>  
>  	np = of_cpu_device_node_get(0);
>  	if (!np) {
> -		pr_err("No cpu node found");
> +		pr_err("No cpu node found\n");
>  		return -ENODEV;
>  	}
>  
> @@ -187,7 +187,7 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
>  
>  	prop = of_find_property(np, "cpufreq_tbl", NULL);
>  	if (!prop || !prop->value) {
> -		pr_err("Invalid cpufreq_tbl");
> +		pr_err("Invalid cpufreq_tbl\n");
>  		ret = -ENODEV;
>  		goto out_put_node;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
