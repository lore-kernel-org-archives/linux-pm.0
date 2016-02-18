From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/3] ARM: dts: Don't overheat the Odroid XU3-Lite on
 high load
Date: Thu, 18 Feb 2016 11:52:24 +0530
Message-ID: <20160218062224.GU2610@vireshk-i7>
References: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
 <1455772383-20598-3-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455772383-20598-3-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 18-02-16, 14:13, Krzysztof Kozlowski wrote:
> After adding cpufreq-dt support to Exynos542x, the Odroid XU3-Lite can
> be easily overheated when launching eight CPU-intensive tasks:
> 	thermal thermal_zone3: critical temperature reached(121 C),shutting down
> 
> This seems to be specific to Odroid XU3-Lite board which officially
> supports lower frequencies than regular XU3 or XU4. When working at
> maximum CPU speed (1800 MHz big and 1300 MHz LITTLE) in warmer place for
> longer time, the fan fails to cool down the board and it reaches
> critical temperature.
> 
> Add CPU cooling to Exynos5422/5800 to fix this issue. When reaching last
> interrupt-driven trip-point (70 degrees of Celsius) start passive
> cooling in polling mode (slowing CPU by 2 steps). When reaching 85
> degrees of Celsius, start slowing even more, down to 600 MHz.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
> ---
> 
> Changes since v1:
> 1. Use polling mode for passive cooling (number of configurable trip
>    points in TMU exceeded).
> 
> 2. Adjust the values (temperature and cooling levels).
> ---
>  arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi | 46 ++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
