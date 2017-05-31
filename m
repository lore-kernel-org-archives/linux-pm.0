From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH v5 2/7] arm: fix return value of parse_cpu_capacity
Date: Wed, 31 May 2017 19:40:02 +0100
Message-ID: <20170531184002.GC27796@n2100.armlinux.org.uk>
References: <20170531165931.6945-1-juri.lelli@arm.com>
 <20170531165931.6945-3-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170531165931.6945-3-juri.lelli-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, May 31, 2017 at 05:59:26PM +0100, Juri Lelli wrote:
> parse_cpu_capacity() has to return 0 on failure, but it currently returns
> 1 instead if raw_capacity kcalloc failed.
> 
> Fix it (by directly returning 0).
> 
> Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

You can drop these Cc's now.  Thanks.

> Reported-by: Morten Rasmussen <morten.rasmussen-5wv7dgnIgG8@public.gmane.org>
> Fixes: 06073ee26775 ('ARM: 8621/3: parse cpu capacity-dmips-mhz from DT')
> Signed-off-by: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
> Acked-by: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
> Acked-by: Vincent Guittot <vincent.guittot-nDFRoQF+wuAdnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/kernel/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index f8a3ab82e77f..1b8ec3054642 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -166,7 +166,7 @@ static int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>  			if (!raw_capacity) {
>  				pr_err("cpu_capacity: failed to allocate memory for raw capacities\n");
>  				cap_parsing_failed = true;
> -				return !ret;
> +				return 0;
>  			}
>  		}
>  		capacity_scale = max(cpu_capacity, capacity_scale);
> -- 
> 2.11.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
