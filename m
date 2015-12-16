From: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v6 0/3] thermal: mediatek: Add cpu dynamic power cooling model.
Date: Wed, 16 Dec 2015 21:29:13 +0800
Message-ID: <1450272556-29770-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Use Intelligent Power Allocation (IPA) technical to add dynamic power model
for binding CPU thermal zone. The power allocator governor allocates power
budget to control CPU temperature.

Power Allocator governor is able to keep SOC temperature within a defined
temperature range to avoid SOC overheat and keep it's performance.
mt8173-cpufreq.c need to register its' own power model with power allocator
thermal governor, so that power allocator governor can allocates suitable
power budget to control CPU temperature.

Binding document is refer to this patchset
https://lkml.org/lkml/2015/11/30/239

Change since V5:
1. Remove thermal sensor ID from phandles

Change since V4:
1. Remove unnecessary error-checking for mt8173-cpufreq.c
2. Initializing variable capacitance with 0

Change since V3:
1. Remove static power model
2. Split V3's device tree in two for thermal zones and dynamic power models respectively

Change since V2:
1. Move dynamic/static power model in device tree

Change since V1:
1. Include mt8171.h and sort header file for mt8173.dtsi

Dawei Chien (3):
  thermal: mediatek: Add cpu dynamic power cooling model.
  arm64: dts: mt8173: Add thermal zone node.
  arm64: dts: mt8173: Add dynamic power node.

 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   47 ++++++++++++++++++++++++++++++
 drivers/cpufreq/mt8173-cpufreq.c         |   12 ++++++--
 2 files changed, 57 insertions(+), 2 deletions(-)

--
1.7.9.5
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
