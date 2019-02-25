From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 10/12] cpufreq: ap806: add missing of_node_put after
 of_device_is_available
Date: Mon, 25 Feb 2019 09:59:41 +0530
Message-ID: <20190225042941.wypmh4kikcgmebn3@vireshk-i7>
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
 <1550928043-14889-11-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550928043-14889-11-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jason Cooper <jason@lakedaemon.net>, kernel-janitors@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23-02-19, 14:20, Julia Lawall wrote:
> Add an of_node_put when a tested device node is not available.
> 
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> identifier f;
> local idexpression e;
> expression x;
> @@
> 
> e = f(...);
> ... when != of_node_put(e)
>     when != x = e
>     when != e = x
>     when any
> if (<+...of_device_is_available(e)...+>) {
>   ... when != of_node_put(e)
> (
>   return e;
> |
> + of_node_put(e);
>   return ...;
> )
> }
> // </smpl>
> 
> Fixes: f525a670533d9 ("cpufreq: ap806: add cpufreq driver for Armada 8K")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/cpufreq/armada-8k-cpufreq.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff -u -p a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
> --- a/drivers/cpufreq/armada-8k-cpufreq.c
> +++ b/drivers/cpufreq/armada-8k-cpufreq.c
> @@ -128,8 +128,10 @@ static int __init armada_8k_cpufreq_init
>  	struct cpumask cpus;
>  
>  	node = of_find_compatible_node(NULL, NULL, "marvell,ap806-cpu-clock");
> -	if (!node || !of_device_is_available(node))
> +	if (!node || !of_device_is_available(node)) {
> +		of_node_put(node);
>  		return -ENODEV;
> +	}
>  
>  	nb_cpus = num_possible_cpus();
>  	freq_tables = kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);

Applied. Thanks.

-- 
viresh
