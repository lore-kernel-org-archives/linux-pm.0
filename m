From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 3/3] PM / AVS: rockchip-cpu-avs: add driver handling
 Rockchip cpu avs
Date: Fri, 19 Aug 2016 08:36:36 -0500
Message-ID: <20160819133636.GA26913@rob-hp-laptop>
References: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com>
 <1471315139-28285-4-git-send-email-finley.xiao@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1471315139-28285-4-git-send-email-finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Finlye Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, tim.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org, ulysses.huang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, lin.huang-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 16, 2016 at 10:38:59AM +0800, Finlye Xiao wrote:
> From: Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> 
> This patch supports adjusting opp's voltage according to leakage
> 
> Signed-off-by: Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>  .../devicetree/bindings/power/rockchip-cpu-avs.txt |  37 +++
>  drivers/power/avs/Kconfig                          |   8 +
>  drivers/power/avs/Makefile                         |   1 +
>  drivers/power/avs/rockchip-cpu-avs.c               | 314 +++++++++++++++++++++
>  4 files changed, 360 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt
>  create mode 100644 drivers/power/avs/rockchip-cpu-avs.c
> 
> diff --git a/Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt b/Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt
> new file mode 100644
> index 0000000..90f6b08
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt
> @@ -0,0 +1,37 @@
> +Rockchip cpu avs device tree bindings
> +-------------------------------------
> +
> +Under the same frequency, the operating voltage tends to decrease with
> +increasing leakage. so it is necessary to adjust opp's voltage according
> +to leakage for power.
> +
> +
> +Required properties:
> +- compatible: Should be one of the following.
> +  - "rockchip,rk3399-cpu-avs" - for RK3399 SoCs.
> +- leakage-volt-<name>: Named leakage-volt property. At runtime, the
> +  platform can find a cpu's cluster_id according to it's cpu_id and match
> +  leakage-volt-<name> property. The property is an array of 3-tuples
> +  items, and each item consists of leakage and voltage like
> +  <min-leakage-mA max-leakage-mA vol-uV>.
> +	min-leakage: minimum leakage in mA.
> +	max-leakage: maximum leakage in mA.
> +	vol: voltage in microvolt.

How do you determine these values? When do they vary?

> +
> +Example:
> +
> +	cpu_avs: cpu-avs {
> +		compatible = "rockchip,rk3399-cpu-avs";

This isn't really a hardware block. For the same reasons we don't have 
cpufreq nodes. So I don't think this belongs in DT.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
