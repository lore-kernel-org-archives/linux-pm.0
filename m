From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: pmac64: add of_node_put()
Date: Mon, 26 Nov 2018 11:32:26 +0530
Message-ID: <20181126060226.wsludir4g7bao4lk@vireshk-i7>
References: <20181123133340.26849-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181123133340.26849-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: rjw@rjwysocki.net, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23-11-18, 08:33, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> g5_neo2_cpufreq_init() doesn't do that, so fix it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Changes in v2:
> -update changelog
> ---
>  drivers/cpufreq/pmac64-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
> index be623dd7b9f2..1d32a863332d 100644
> --- a/drivers/cpufreq/pmac64-cpufreq.c
> +++ b/drivers/cpufreq/pmac64-cpufreq.c
> @@ -411,6 +411,7 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
>  		pfunc_set_vdnap0 = pmf_find_function(root, "set-vdnap0");
>  		pfunc_vdnap0_complete =
>  			pmf_find_function(root, "slewing-done");
> +		of_node_put(root);
>  		if (pfunc_set_vdnap0 == NULL ||
>  		    pfunc_vdnap0_complete == NULL) {
>  			pr_err("Can't find required platform function\n");

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
