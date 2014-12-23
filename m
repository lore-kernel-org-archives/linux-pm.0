From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH 0/4] devfreq: Add generic exynos memory-bus frequency driver
Date: Tue, 23 Dec 2014 20:44:33 +0900
Message-ID: <1419335077-31020-1-git-send-email-cw00.choi@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

These patch-set adds the generic exynos bus frequency driver for memory bus
with DEVFREQ framework. The Samsung Exynos SoCs have the common architecture
for memory bus between DRAM memory and MMC/sub IP in SoC. This driver can
support the memory bus frequency driver for Exynos SoCs.

Each memory bus block has a clock for memory bus speed and frequency
table which is changed according to the utilization of memory bus on runtime.
And then each memory bus group has the one more memory bus blocks and
OPP table (including frequency and voltage), regulator, devfreq-event
devices.

There are a little difference about the number of memory bus because each Exynos
SoC have the different sub-IP and different memory bus speed. In spite of this
difference among Exynos SoCs, we can support almost Exynos SoC by adding
unique data of memory bus to devicetree file.

Chanwoo Choi (4):
  devfreq: exynos: Add generic exynos memory bus frequency driver
  devfreq: exynos: Add documentation for generic exynos memory bus frequency driver
  ARM: dts: Add memory bus node for Exynos3250
  ARM: dts: Add memory bus node for Exynos3250-based Rinato board

 .../devicetree/bindings/devfreq/exynos-busfreq.txt | 184 +++++++
 arch/arm/boot/dts/exynos3250-rinato.dts            |  12 +
 arch/arm/boot/dts/exynos3250.dtsi                  | 137 +++++
 drivers/devfreq/Kconfig                            |  15 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/exynos-busfreq.c                   | 586 +++++++++++++++++++++
 6 files changed, 935 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos-busfreq.txt
 create mode 100644 drivers/devfreq/exynos-busfreq.c

-- 
1.8.5.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
