From: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v5 0/3] Dynamic power model from device tree
Date: Tue, 17 Nov 2015 12:06:20 +0000
Message-ID: <1447761983-12415-1-git-send-email-punit.agrawal@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, javi.merino-5wv7dgnIgG8@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

This patchset adds support to build a single-coefficient dynamic power
model for a CPU. The model is used by the CPU cooling device to
provide an estimate of power consumption and also translate allocated
power to performance cap.

Changes from previous posting -
v4 -> v5
Updated tags across the patches
arm_big_little: Do not register cooling devices when in IKS

v3 -> v4:
arm_big_little: Migrated to using static arrays
arm_big_little: Updated Kconfig to support building thermal as module

Patch 1 extends the CPU nodes binding to provide an optional dynamic
power coefficient which can be used to create a dynamic power model
for the CPUs. This model is used to constrain device power consumption
(using power_allocator governor) when the system is thermally
constrained.

Patches 2-3 extends the cpufreq-dt and arm_big_little driver to
register cpu cooling devices with the dynamic coefficient when
provided.

The patches were previously posted at [0][1][2][3]. Mediatek platform
8173 builds on these bindings to build a power model.

Thanks,
Punit

[0] http://thread.gmane.org/gmane.linux.kernel/2002152
[1] http://thread.gmane.org/gmane.linux.kernel/2011466
[2] http://marc.info/?l=linux-kernel&m=144709020014884&w=2
[3] http://marc.info/?l=linux-pm&m=144770224915315&w=2

Punit Agrawal (3):
  devicetree: bindings: Add optional dynamic-power-coefficient property
  cpufreq-dt: Supply power coefficient when registering cooling devices
  cpufreq: arm_big_little: Add support to register a cpufreq cooling
    device

 Documentation/devicetree/bindings/arm/cpus.txt | 17 +++++++++++
 drivers/cpufreq/Kconfig.arm                    |  2 ++
 drivers/cpufreq/arm_big_little.c               | 41 ++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt.c                   |  9 ++++--
 4 files changed, 67 insertions(+), 2 deletions(-)

-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
