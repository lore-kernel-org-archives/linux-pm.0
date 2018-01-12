From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 0/8] GICv3 Save and Restore
Date: Fri, 12 Jan 2018 13:24:14 -0800
Message-ID: <20180112212422.148625-1-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, briannorris@chromium.org, marc.zyngier@arm.com, Derek Basehore <dbasehore@chromium.org>
List-Id: linux-pm@vger.kernel.org

This patch set adds saving and restoring the GIC on v3
implementations through a devicetree flag.

The new CPU_PM state was the cleanest way to synchronize the save and
restore (that I figured out) with other PM operations since this isn't
going into any PSCI implementations (at least not in
ARM-Trusted-Firmware).

I've verified these patches on a Rockchip RK3399 platform (some
devicetree changes needed). This included turning off the power rail
for the GIC during suspend.

Derek Basehore (8):
  cpu_pm: add syscore_suspend error handling
  lib/iomap_copy: add __ioread64_copy()
  cpu_pm: Add SYSTEM_PM state
  irqchip/gic-v3: add ability to save/restore GIC/ITS state
  DT/arm,gic-v3: add save-suspend-state property
  irqchip/gic-v3-its: add ability to resend MAPC on resume
  DT/arm,gic-v3: add resend-mapc-on-resume property
  irqchip/gic-v3: add power down/up sequence

 .../bindings/interrupt-controller/arm,gic-v3.txt   |  43 +++
 drivers/irqchip/irq-gic-v3-its.c                   | 136 +++++--
 drivers/irqchip/irq-gic-v3.c                       | 391 ++++++++++++++++++++-
 include/linux/cpu_pm.h                             |  14 +
 include/linux/io.h                                 |   1 +
 include/linux/irqchip/arm-gic-v3.h                 |  26 ++
 kernel/cpu_pm.c                                    |  75 ++--
 lib/iomap_copy.c                                   |  26 ++
 8 files changed, 640 insertions(+), 72 deletions(-)

-- 
2.16.0.rc1.238.g530d649a79-goog
