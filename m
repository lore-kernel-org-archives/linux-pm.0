From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq drivers
Date: Mon,  1 Dec 2014 17:11:21 +0530
Message-ID: <cover.1417433163.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:48190 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbaLALlt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 06:41:49 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so10657096pdb.22
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2014 03:41:48 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org, santosh shilimkar <santosh.shilimkar@oracle.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, k.chander@samsung.com, olof@lixom.net, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Guys,

DT based cpufreq drivers doesn't require much support from platform code now a
days as most of the stuff is moved behind generic APIs. Like clk APIs for
changing clock rates, regulator APIs for changing voltages, etc.

One of the bottleneck still left was how to select which cpufreq driver to probe
for a given platform as there might be multiple drivers available.

Traditionally, we used to create platform devices from machine specific code
which binds with a cpufreq driver. And while we moved towards DT based device
creation, these devices stayed as is.

The problem is getting worse now as we have architectures now with Zero platform
specific code. Forcefully these platforms have to create a new file in
drivers/cpufreq/ to just add these platform devices in order to use the generic
drivers like cpufreq-dt.c.

This has been discussed again and again, but with no solution yet. Last it was
discussed here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/256154.html

This patch is an attempt towards getting the bindings.

We only need to have cpufreq drivers name string present in "compatible"
property for the root node.. If a cpufreq driver with DT support exists with
that name, then cpufreq core will create a platform device for that.

The first patch presents the new binding, second one creates another file
responsible for creating platform devices for all DT based cpufreq drivers.

And later patches update platforms to migrate to it one by one.

A BLACKLIST of platforms already supported by these drivers is also created for
backward compatibility of newer kernels with older DTs. And so for such
platforms DT files aren't updated.

An initial RFC that presented the idea was discussed here:
https://www.mail-archive.com/devicetree@vger.kernel.org/msg52509.html

Tested-ON: Exynos5250. (The last patch for exynos depends on some commits to be
upstreamed in 3.19, presented here just for testing).

Viresh Kumar (8):
  cpufreq: Reuse "compatible" binding to probe cpufreq drivers
  cpufreq: Create cpufreq platform-device based on "compatible" from DT
  cpufreq: imx: reuse dt_device.c to create cpufreq platform device
  cpufreq: mvebu: reuse dt_device.c to create cpufreq platform device
  cpufreq: shmobile: reuse dt_device.c to create cpufreq platform device
  cpufreq: zynq: reuse dt_device.c to create cpufreq platform device
  cpufreq: calxeda: reuse dt_device.c to create cpufreq platform device
  cpufreq: exynos: reuse dt_device.c to create cpufreq platform device

 .../devicetree/bindings/cpufreq/drivers.txt        | 46 +++++++++++++++
 arch/arm/mach-exynos/exynos.c                      | 27 +++------
 arch/arm/mach-imx/imx27-dt.c                       |  4 --
 arch/arm/mach-imx/mach-imx51.c                     |  3 -
 arch/arm/mach-mvebu/pmsu.c                         |  1 -
 arch/arm/mach-shmobile/Makefile                    |  1 -
 arch/arm/mach-shmobile/common.h                    |  7 ---
 arch/arm/mach-shmobile/cpufreq.c                   | 17 ------
 arch/arm/mach-zynq/common.c                        |  2 -
 drivers/cpufreq/Makefile                           |  2 +-
 drivers/cpufreq/dt_device.c                        | 68 ++++++++++++++++++++++
 drivers/cpufreq/highbank-cpufreq.c                 |  5 --
 12 files changed, 123 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/drivers.txt
 delete mode 100644 arch/arm/mach-shmobile/cpufreq.c
 create mode 100644 drivers/cpufreq/dt_device.c

-- 
2.0.3.693.g996b0fd

