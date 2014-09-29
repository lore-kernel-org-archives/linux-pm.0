From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v1 0/4] ARM: keystone: pm: switch to use generic pm domains
Date: Mon, 29 Sep 2014 17:38:15 +0300
Message-ID: <1412001499-19369-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: santosh.shilimkar-l0cyMroinI0@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Santosh, Kevin,

This series switches Keystone 2 PM code to use Generic PM domains
instead of PM clock domains because of the lack of DT support
for the last.
It will finally allow to enable Runtime PM for Keystone 2.

Patch 1 was reused from [1].
Patch 4 is added to illustrate Keystone 2 PM domains configuration in DT.

RFC version of patches can be found at [2].

[1] "[PATCH/RFC 0/4] of: Register clocks for Runtime PM with PM core"
  https://lkml.org/lkml/2014/4/24/1118

[2] "[RFC PATCH 0/4] ARM: keystone: pm: switch to use generic pm domains"
  https://lkml.org/lkml/2014/9/25/364

Geert Uytterhoeven (1):
  PM / clock_ops: Add pm_clk_add_clk()

Grygorii Strashko (3):
  ARM: keystone: pm: switch to use generic pm domains
  ARM: dts: keystone: add generic pm controller node
  ARM: dts: k2hk-evm: attach net, qmss and knav_dmas to keystone-gpc

 .../devicetree/bindings/power/ti,keystone-gpc.txt  |  31 ++++++
 arch/arm/boot/dts/k2hk-evm.dts                     |   7 ++
 arch/arm/boot/dts/keystone.dtsi                    |   6 ++
 arch/arm/mach-keystone/Kconfig                     |   1 +
 arch/arm/mach-keystone/pm_domain.c                 | 115 ++++++++++++++-------
 drivers/base/power/clock_ops.c                     |  41 ++++++--
 include/linux/pm_clock.h                           |   8 ++
 7 files changed, 162 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/ti,keystone-gpc.txt

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
