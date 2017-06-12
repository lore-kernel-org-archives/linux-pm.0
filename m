From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/2] cpuidle: dt: Add missing 'of_node_put()'
Date: Mon, 12 Jun 2017 17:42:40 +0100
Message-ID: <20170612164240.GA32131@red-moon>
References: <20170612155441.GE2261@mai>
 <1497282910-19085-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497282910-19085-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, Christophe Jaillet <christophe.jaillet@wanadoo.fr>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 12, 2017 at 05:55:09PM +0200, Daniel Lezcano wrote:
> From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
> 
> 'of_node_put()' should be called on pointer returned by
> 'of_parse_phandle()' when done. In this function this is done in all path
> except this 'continue', so add it.
> 
> Fixes: 97735da074fd ("drivers: cpuidle: Add status property to ARM idle states")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> ---
>  drivers/cpuidle/dt_idle_states.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
> index ffca4fc..ae8eb03 100644
> --- a/drivers/cpuidle/dt_idle_states.c
> +++ b/drivers/cpuidle/dt_idle_states.c
> @@ -180,8 +180,10 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
>  		if (!state_node)
>  			break;
>  
> -		if (!of_device_is_available(state_node))
> +		if (!of_device_is_available(state_node)) {
> +			of_node_put(state_node);
>  			continue;
> +		}
>  
>  		if (!idle_state_valid(state_node, i, cpumask)) {
>  			pr_warn("%s idle state not valid, bailing out\n",
> -- 
> 2.7.4
> 
