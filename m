From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: cpufreq: add bmips-cpufreq.c
Date: Fri, 17 Feb 2017 11:24:56 -0800
Message-ID: <c7a1f607-6619-445a-db35-902f11569dad@gmail.com>
References: <20170217183050.31889-1-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170217183050.31889-1-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <code@mmayer.net>, Ralf Baechle <ralf@linux-mips.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02/17/2017 10:30 AM, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Add maintainer information for bmips-cpufreq.c.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

Looks great, thanks for adding this, one nit below:

> ---
> 
> This is based on PM's linux-next from today (February 17).
> 
> This patch could be squashed into patch 3/4 of the original series if that
> is acceptable (see [1]) or it can remain separate.
> 
> [1] https://lkml.org/lkml/2017/2/7/775
> 
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 107c10e..db251c0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2692,6 +2692,12 @@ F:	drivers/irqchip/irq-brcmstb*
>  F:	include/linux/bcm963xx_nvram.h
>  F:	include/linux/bcm963xx_tag.h
>  
> +BROADCOM BMIPS CPUFREQ DRIVER
> +M:	Markus Mayer <mmayer@broadcom.com>
> +L:	linux-pm@vger.kernel.org

Please also include bcm-kernel-feedback-list@broadcom.com here

With that:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
