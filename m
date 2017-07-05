From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/3] some fixups for MediaTek cpufreq driver
Date: Wed, 5 Jul 2017 09:52:34 +0530
Message-ID: <20170705042234.GL3532@vireshk-i7>
References: <cover.1499194061.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1499194061.git.sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 05-07-17, 02:55, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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

Just a minor comment on 3/3.

Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
