From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V3] cpufreq: qoriq: Register cooling device based on device tree
Date: Fri, 18 Dec 2015 23:32:33 +0100
Message-ID: <3550740.QzZi28fbXg@wuerfel>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com> <1697588.dLcbZBRWO4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1697588.dLcbZBRWO4-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Jia Hongtao <hongtao.jia-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 15 December 2015 00:58:26 Rafael J. Wysocki wrote:
> On Thursday, November 26, 2015 05:21:11 PM Jia Hongtao wrote:
> > Register the qoriq cpufreq driver as a cooling device, based on the
> > thermal device tree framework. When temperature crosses the passive trip
> > point cpufreq is used to throttle CPUs.
> > 
> > Signed-off-by: Jia Hongtao <hongtao.jia-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Reviewed-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Applied, thanks!
> 

I got a randconfig build error today:

drivers/built-in.o: In function `qoriq_cpufreq_ready':
debugfs.c:(.text+0x1f4688): undefined reference to `of_cpufreq_cooling_register'

CONFIG_OF=y
CONFIG_QORIQ_CPUFREQ=y
CONFIG_THERMAL=m
CONFIG_THERMAL_OF=y

I think you need a 'depends on THERMAL' to prevent the driver from
being built-in when THERMAL=m.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
