From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 4/6] ARM64: cpuidle: Rename cpu_init_idle to a common
 function name
Date: Fri, 13 Mar 2015 18:22:46 +0000
Message-ID: <20150313182246.GT30671@e104818-lin.cambridge.arm.com>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
 <1425385777-14766-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425385777-14766-5-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 03, 2015 at 01:29:35PM +0100, Daniel Lezcano wrote:
> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> index 0cea244..6ef291c7 100644
> --- a/drivers/cpuidle/cpuidle-arm64.c
> +++ b/drivers/cpuidle/cpuidle-arm64.c
> @@ -110,7 +110,7 @@ static int __init arm64_idle_init(void)
>  	 * idle states suspend back-end specific data
>  	 */
>  	for_each_possible_cpu(cpu) {
> -		ret = cpu_init_idle(cpu);
> +		ret = arm_cpuidle_init(cpu);

Same nitpick here about dropping the arm_ prefix (though here we already
have a cpuidle_init).

-- 
Catalin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
