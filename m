From: Andrew-sh Cheng <andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v1 0/4] add support of cpufreq to mt8173 and mt2712
Date: Fri, 8 Dec 2017 14:07:54 +0800
Message-ID: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew-sh Cheng <andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This series is based on v4.15-rc1 and [1].

Mediatek projects will use mediate-cpufreq.c as cpufreq driver,
so add mediatek related projects into black list of cpufreq_dt.c

mt8173 and mt2712 both support 2 clusters, and the main difference 
is that mt2712 currently only support fixed voltage.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/544072.html

Andrew-sh Cheng (4):
  cpufreq: mediatek: add mt2712 into compatible list
  cpufreq: mediatek: Add mediatek related projects into blacklist
  arm64: dts: mediatek: add mt8173 cpufreq related device nodes
  arm64: dts: mediatek: add mt2712 cpufreq related device nodes

 arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 27 +++++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 57 ++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 ++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 90 +++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c        |  8 +++
 drivers/cpufreq/mediatek-cpufreq.c          |  1 +
 6 files changed, 201 insertions(+)

-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
