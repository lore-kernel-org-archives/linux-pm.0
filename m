From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v2 0/2]  cpufreq: Sort Kconfig and Makefile
Date: Sun, 17 Dec 2017 19:10:35 +0100
Message-ID: <1827128.RRgnfOOfuH@aspire.rjw.lan>
References: <20171213170536.28238-1-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171213170536.28238-1-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?ISO-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hua Jing <jinghua-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Neta Zur Hershkovits <neta-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Evan Wang <xswang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Andre Heider <a.heider-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 13, 2017 6:05:34 PM CET Gregory CLEMENT wrote:
> Hi,
> 
> The patch of this series was originally part of the series "Add CPU
> Frequency scaling support on Armada 37xx" [1].
> 
> As requested by Rafael J. Wysocki, these 2 patches are extracted in a
> independent series, in the meantime, Viresh Kumar gave his acked-by
> that I added to the patches.
> 
> In this second version only the 1st patch had been modified, see the
> changelog for the details.
> 
> Thanks,
> 
> Gregory
> 
> [1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/546709.html
> 
> Changelog:
> v1 -> v2:
> 
>  - Fixed tab vs space issue in KConfig, suggested by Randy Dunlap
>  - Removed unneeded "default n" in KConfig, suggested by Randy Dunlap
> 
> Gregory CLEMENT (2):
>   cpufreq: ARM: sort the Kconfig menu
>   cpufreq: sort the drivers in ARM part
> 
>  drivers/cpufreq/Kconfig.arm | 81 ++++++++++++++++++++++-----------------------
>  drivers/cpufreq/Makefile    |  8 ++---
>  2 files changed, 44 insertions(+), 45 deletions(-)
> 
> 

Both applied, thanks!


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
