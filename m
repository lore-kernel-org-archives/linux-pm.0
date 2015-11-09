From: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 0/3] Dynamic power model from device tree
Date: Mon,  9 Nov 2015 17:29:20 +0000
Message-ID: <1447090163-13700-1-git-send-email-punit.agrawal@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

This patchset adds support to build a single-coefficient dynamic power
model for a CPU. The model is used by the CPU cooling device to
provide an estimate of power consumption and also translate allocated
power to performance cap.

Patch 1 extends the CPU nodes binding to provide an optional dynamic
power coefficient which can be used to create a dynamic power model
for the CPUs. This model is used to constrain device power consumption
(using power_allocator governor) when the system is thermally
constrained.

Patches 2-3 extends the cpufreq-dt and arm_big_little driver to
register cpu cooling devices with the dynamic coefficient when
provided.

The patches were previously posted as part of [0][1]. Since the last
posting Mediatek platform 8173 is also building on these bindings to
build the power model.

Feedback on the bindings would be particularly appreciated.

Thanks,
Punit

[0] http://thread.gmane.org/gmane.linux.kernel/2002152
[1] http://thread.gmane.org/gmane.linux.kernel/2011466

Punit Agrawal (3):
  devicetree: bindings: Add optional dynamic-power-coefficient property
  cpufreq-dt: Supply power coefficient when registering cooling devices
  cpufreq: arm_big_little: Add support to register a cpufreq cooling
    device

 Documentation/devicetree/bindings/arm/cpus.txt | 17 +++++++++
 drivers/cpufreq/arm_big_little.c               | 52 +++++++++++++++++++++++++-
 drivers/cpufreq/cpufreq-dt.c                   |  9 ++++-
 3 files changed, 74 insertions(+), 4 deletions(-)

-- 
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
