From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] MAINTAINERS: cpufreq: add bmips-cpufreq.c
Date: Mon, 20 Feb 2017 08:59:11 +0530
Message-ID: <20170220032911.GM21911@vireshk-i7>
References: <20170217202704.33596-1-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35612 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdBTD3T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Feb 2017 22:29:19 -0500
Received: by mail-pg0-f51.google.com with SMTP id b129so13093529pgc.2
        for <linux-pm@vger.kernel.org>; Sun, 19 Feb 2017 19:29:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170217202704.33596-1-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 17-02-17, 12:27, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Add maintainer information for bmips-cpufreq.c.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> 
> This is based on PM's linux-next from today (February 17).
> 
> This patch could be squashed into patch 3/4 of the original series if that
> is acceptable (see [1]) or it can remain separate.
> 
> [1] https://lkml.org/lkml/2017/2/7/775
> 
> Changes in v2:
>   - added bcm-kernel-feedback-list@broadcom.com
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 107c10e..d4ac248 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2692,6 +2692,13 @@ F:	drivers/irqchip/irq-brcmstb*
>  F:	include/linux/bcm963xx_nvram.h
>  F:	include/linux/bcm963xx_tag.h
>  
> +BROADCOM BMIPS CPUFREQ DRIVER
> +M:	Markus Mayer <mmayer@broadcom.com>
> +M:	bcm-kernel-feedback-list@broadcom.com

Isn't this a list as well? Shouldn't this be L: ?

> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/cpufreq/bmips-cpufreq.c
> +
>  BROADCOM TG3 GIGABIT ETHERNET DRIVER
>  M:	Siva Reddy Kallam <siva.kallam@broadcom.com>
>  M:	Prashant Sreedharan <prashant@broadcom.com>

-- 
viresh
