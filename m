From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 1/3] cpufreq: mediatek: Add support of cpufreq to
 MT2701/MT7623 SoC
Date: Tue, 11 Jul 2017 10:49:46 +0800
Message-ID: <1499741386.12408.11.camel@mtksdaap41>
References: <cover.1499692967.git.sean.wang@mediatek.com>
         <feabcfd53899954198c6620e9d9b68f4a3c55201.1499692967.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <feabcfd53899954198c6620e9d9b68f4a3c55201.1499692967.git.sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Sean,

On Mon, 2017-07-10 at 22:23 +0800, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> MT2701/MT7623 is a 32-bit ARMv7 based quad-core (4 * Cortex-A7) with
> single cluster and this hardware is also compatible with the existing
> driver through enabling CPU frequency feature with operating-points-v2
> bindings. Also, this driver actually supports all MediaTek SoCs, the
> Kconfig menu entry and file name itself should be updated with more
> generic name to drop "MT8173"
> 
> Signed-off-by: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/cpufreq/Kconfig.arm                              | 7 +++----
>  drivers/cpufreq/Makefile                                 | 2 +-
>  drivers/cpufreq/{mt8173-cpufreq.c => mediatek-cpufreq.c} | 2 ++
>  3 files changed, 6 insertions(+), 5 deletions(-)
>  rename drivers/cpufreq/{mt8173-cpufreq.c => mediatek-cpufreq.c} (99%)
> 

As Viresh mentioned, there are already many drivers use "mtk" as
filename prefix or postfix.To align with those files, I suggest use
mtk-cpufreq.c.I think there are not too many values to change all "mtk-"
to "mediatek-", but it is worth to have the same naming rule for
mediatek upstream driver.

Regards,
Eddie. 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
