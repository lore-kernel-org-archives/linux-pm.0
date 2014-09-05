From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [RFC PATCH 0/5] devfreq: Add devfreq-event class to provide raw data
 for devfreq device
Date: Fri, 05 Sep 2014 13:30:14 +0900
Message-ID: <1409891419-28560-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:35504 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbaIEEaY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Sep 2014 00:30:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, linux-pm@vger.kernel.org
Cc: kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, a.kesavan@samsung.com, kgene.kim@samsung.com, tomasz.figa@gmail.com, b.zolnierkie@samsung.com, nm@ti.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chanwoo Choi <cw00.choi@samsung.com>

This patchset add new devfreq_event class to provide raw data to determine
current utilization of device  which is used for devfreq governor.
But, This patchset is just initial version and must need more implementaion
and updates.

Although this patchset has not enough feature to support devfreq-event class,
I send this RFC patchset to share current implementation. Please feel free to
give comment and advice.

[Description of devfreq-event class]
This patchset add new devfreq_event class for devfreq_event device which provide
raw data (e.g., memory bus utilization/GPU utilization). This raw data from
devfreq_event data would be used for the governor of devfreq subsystem.
- devfreq_event device : Provide raw data for governor of existing devfreq device
- devfreq device       : Monitor device state and change frequency/voltage of device
                         using the raw data from devfreq_event device

The devfreq subsystem support generic DVFS(Dynamic Voltage/Frequency Scaling)
for Non-CPU Devices. The devfreq device would dertermine current device state
using various governor (e.g., ondemand, performance, powersave). After completed
determination of system state, devfreq device would change the frequency/voltage
of devfreq device according to the result of governor.

But, devfreq governor must need basic data which indicates current device state.
Existing devfreq subsystem only consider devfreq device which check current system
state and determine proper system state using basic data. There is no subsystem
for device providing basic data to devfreq device.

The devfreq subsystem must need devfreq_event device(data-provider device) for
existing devfreq device. So, this patch add new devfreq_event class for
devfreq_event device which read various basic data(e.g, memory bus utilization,
GPU utilization) and provide measured data to existing devfreq device through
standard APIs of devfreq_event class.

The following description explains the feature of two kind of devfreq class:
- devfreq class (existing)
 : devfreq consumer device use raw data from devfreq_event device for
   determining proper current system state and change voltage/frequency
   dynamically using various governors.
- devfreq_event class (new)
 : Provide measured raw data to devfreq device for governor

[For example]
If board dts includes PPMU_DMC0/DMC1/CPU event node,
would show following sysfs entry. Also devfreq driver(e.g., exynos4_bus.c)
can get the instance of devfreq-event device by using provided API and then
get raw data which reflect the current utilization of device.

-sh-3.2# pwd
/sys/class/devfreq_event
-sh-3.2# ls -al
total 0
drwxr-xr-x  2 root root 0 Jan  1 21:06 .
drwxr-xr-x 45 root root 0 Jan  1 21:06 ..
lrwxrwxrwx  1 root root 0 Jan  1 21:06 event.0 -> ../../devices/soc/106a0000.ppmu_dmc0/devfreq_event/event.0
lrwxrwxrwx  1 root root 0 Jan  1 21:06 event.1 -> ../../devices/soc/106b0000.ppmu_dmc1/devfreq_event/event.1
lrwxrwxrwx  1 root root 0 Jan  1 21:06 event.2 -> ../../devices/soc/106c0000.ppmu_cpu/devfreq_event/event.2

Chanwoo Choi (5):
  devfreq: Add new devfreq_event class to provide basic data for devfreq governor
  devfreq: event: Add exynos-ppmu devfreq evnet driver
  ARM: dts: Add PPMU dt node for Exynos3250
  ARM: dts: Add PPMU dt node for Exynos4 SoC
  ARM: dts: Add dt node fo PPMU_CPU/DMC0/DMC1 for exynos4412-trats2

 arch/arm/boot/dts/exynos3250.dtsi       |  66 +++++
 arch/arm/boot/dts/exynos4.dtsi          |  96 ++++++++
 arch/arm/boot/dts/exynos4210.dtsi       |   8 +
 arch/arm/boot/dts/exynos4412-trats2.dts |  29 +++
 drivers/devfreq/Kconfig                 |  12 +
 drivers/devfreq/Makefile                |   5 +-
 drivers/devfreq/devfreq-event.c         | 251 +++++++++++++++++++
 drivers/devfreq/event/Makefile          |   2 +
 drivers/devfreq/event/exynos-ppmu.c     | 410 ++++++++++++++++++++++++++++++++
 include/linux/devfreq.h                 |  97 ++++++++
 10 files changed, 975 insertions(+), 1 deletion(-)
 create mode 100644 drivers/devfreq/devfreq-event.c
 create mode 100644 drivers/devfreq/event/Makefile
 create mode 100644 drivers/devfreq/event/exynos-ppmu.c

-- 
1.8.0

