From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] MAINTAINERS: cpufreq: add bmips-cpufreq.c
Date: Sat, 18 Feb 2017 02:37:36 +0100
Message-ID: <3581335.dhZe3gFEt9@aspire.rjw.lan>
References: <20170217183050.31889-1-code@mmayer.net> <2370147.zGx6MqB346@aspire.rjw.lan> <3d7ecb19-f181-fe32-908e-b69906bea941@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45263 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752573AbdBRBmg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2017 20:42:36 -0500
In-Reply-To: <3d7ecb19-f181-fe32-908e-b69906bea941@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Markus Mayer <code@mmayer.net>, Ralf Baechle <ralf@linux-mips.org>, Viresh Kumar <viresh.kumar@linaro.org>, Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Friday, February 17, 2017 05:26:59 PM Florian Fainelli wrote:
> 
> On 02/17/2017 05:20 PM, Rafael J. Wysocki wrote:
> > On Friday, February 17, 2017 11:24:56 AM Florian Fainelli wrote:
> >> On 02/17/2017 10:30 AM, Markus Mayer wrote:
> >>> From: Markus Mayer <mmayer@broadcom.com>
> >>>
> >>> Add maintainer information for bmips-cpufreq.c.
> >>>
> >>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> >>
> >> Looks great, thanks for adding this, one nit below:
> >>
> >>> ---
> >>>
> >>> This is based on PM's linux-next from today (February 17).
> >>>
> >>> This patch could be squashed into patch 3/4 of the original series if that
> >>> is acceptable (see [1]) or it can remain separate.
> >>>
> >>> [1] https://lkml.org/lkml/2017/2/7/775
> >>>
> >>>  MAINTAINERS | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 107c10e..db251c0 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -2692,6 +2692,12 @@ F:	drivers/irqchip/irq-brcmstb*
> >>>  F:	include/linux/bcm963xx_nvram.h
> >>>  F:	include/linux/bcm963xx_tag.h
> >>>  
> >>> +BROADCOM BMIPS CPUFREQ DRIVER
> >>> +M:	Markus Mayer <mmayer@broadcom.com>
> >>> +L:	linux-pm@vger.kernel.org
> >>
> >> Please also include bcm-kernel-feedback-list@broadcom.com here
> >>
> >> With that:
> >>
> >> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> >>
> > 
> > Patch applied.
> 
> There was a v2 submitted shortly after.

I took the v2 actually, sorry for the confusion.

Thanks,
Rafael
