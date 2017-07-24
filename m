From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v5 0/3] some fixups for MediaTek cpufreq driver
Date: Mon, 24 Jul 2017 22:56:28 +0200
Message-ID: <1941970.gMtimJUdWe@aspire.rjw.lan>
References: <cover.1500355954.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1500355954.git.sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 18, 2017 02:01:42 PM sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> Changes since v4:
> - add back the missing Acked-by from v3
> 
> Changes since v3:
> - remove the redundant line depends on ARM || ARM64 || COMPILE_TEST
> since the whole Kconfig.arm file depends on ARM || ARM64.
> - renaming from mtk-cpufreq.c to mediatek-cpufreq.c avoiding
> collide and cause confusion at some point in time.
> 
> Changes since v2:
> - correct the typo in the binding document
> 
> Changes since v1:
> - drop those patches already accepted
> - refine the commit messages and Kconfig dependency
> - Kconfig menu entry and file name itself are updated with more
> generic name to drop "MT8173" since this driver actually supports
> all MediaTek SoCs.
> - generate patchset again with git format-patch -C -M --thread=shallow
> - fix binding examples by replacing '@' with '-' as the OPP nodes will
> never have a "reg" property.
> 
> Hi,
> 
> The purpose of the series is
> - (patch 1 to 3) to fix up current Mediatek cpufreq driver
> can't work with the latest tree since one required CPU clock muxer missing
> would cause the driver getting the resource fails when driver probe gets
> called.
> - (patch 4) to enable cpufreq feature on MT2701/MT7623 platform.
> - (patch 5 to 6) to update the binding document to reflect
> latest driver logic and add more examples guiding people how to apply for
> Mediatek cpufreq driver.
> 
> Sean Wang (3):
>   cpufreq: mediatek: Add support of cpufreq to MT2701/MT7623 SoC
>   dt-bindings: cpufreq: move MediaTek cpufreq dt-bindings document to
>     proper place
>   dt-bindings: cpufreq: enhance MediaTek cpufreq dt-binding document

Series applied, thanks!

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
