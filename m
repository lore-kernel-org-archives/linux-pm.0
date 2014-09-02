From: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/9] Zynq PM updates
Date: Tue,  2 Sep 2014 14:19:05 -0700
Message-ID: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi all,

here is v2 of this series. It's mostly the same and most changes are
related to reformatting comments. The only functional change is in 'ARM=
:
zynq: PM: Enable DDR clock stop' which does no longer enable
self-refresh too. It seems self-refresh is inflicting a non-negligible
amount of latency that degrades memory performance if enabled throughou=
t
the whole run time.

	Thanks,
	S=C3=B6ren

Daniel Lezcano (2):
  ARM: zynq: Remove invalidate cache for cpu die
  ARM: zynq: cpuidle: Remove pointless code

Soren Brinkmann (7):
  ARM: zynq: PM: Enable A9 internal clock gating feature
  Documentation: devicetree: Add binding for Synopsys DDR controller
  ARM: zynq: DT: Add DDRC node
  ARM: zynq: PM: Enable DDR clock stop
  ARM: zynq: Synchronise zynq_cpu_die/kill
  ARM: zynq: Remove hotplug.c
  ARM: zynq: Rename 'zynq_platform_cpu_die'

 .../bindings/memory-controllers/synopsys.txt       | 11 +++
 arch/arm/boot/dts/zynq-7000.dtsi                   |  5 ++
 arch/arm/mach-zynq/Makefile                        |  3 +-
 arch/arm/mach-zynq/common.c                        |  7 ++
 arch/arm/mach-zynq/common.h                        | 16 ++++-
 arch/arm/mach-zynq/hotplug.c                       | 47 +-----------
 arch/arm/mach-zynq/platsmp.c                       | 41 ++++++++++-
 arch/arm/mach-zynq/pm.c                            | 83 ++++++++++++++=
++++++++
 arch/arm/mach-zynq/slcr.c                          | 43 ++++++++++-
 drivers/cpuidle/cpuidle-zynq.c                     | 10 +--
 10 files changed, 205 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controller=
s/synopsys.txt
 create mode 100644 arch/arm/mach-zynq/pm.c

--=20
2.1.0.1.g27b9230

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
