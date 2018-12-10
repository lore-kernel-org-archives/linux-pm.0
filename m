From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4] cpuidle: big.LITTLE: fix refcount leak
Date: Mon, 10 Dec 2018 18:00:12 +0100
Message-ID: <ee49b2fc-f855-4406-8780-0638d5fe09a0@linaro.org>
References: <20181210162641.21029-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210162641.21029-1-tiny.windzz@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/12/2018 17:26, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> bl_idle_init() doesn't do that, so fix it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> changes in v4:
> -update tile
> -refactor code,suggested by Daniel
> ---
>  drivers/cpuidle/cpuidle-big_little.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> index db2ede565f1a..b44476a1b7ad 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -167,6 +167,7 @@ static int __init bl_idle_init(void)
>  {
>  	int ret;
>  	struct device_node *root = of_find_node_by_path("/");
> +	const struct of_device_id *match_id;
>  
>  	if (!root)
>  		return -ENODEV;
> @@ -174,7 +175,11 @@ static int __init bl_idle_init(void)
>  	/*
>  	 * Initialize the driver just for a compliant set of machines
>  	 */
> -	if (!of_match_node(compatible_machine_match, root))
> +	match_id = of_match_node(compatible_machine_match, root);
> +
> +	of_node_put(root);
> +
> +	if (!match_id)
>  		return -ENODEV;
>  
>  	if (!mcpm_is_available())
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
