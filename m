From: Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v3 0/5] GICv3 Save and Restore
Date: Mon, 29 Jan 2018 17:00:02 -0800
Message-ID: <20180130010007.256564-1-dbasehore@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Soby.Mathew-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

A lot of changes in v2. The distributor and redistributor saving and
restoring is left to the PSCI/firmware implementation after
discussions with ARM. This reduces the line changes by a lot and
removes now unneeded patches.

Patches are verified on an RK3399 platform with pending patches in the
ARM-Trusted-Firmware project.

Just a couple minor changes in v3 to formatting.

Derek Basehore (5):
  cpu_pm: add syscore_suspend error handling
  irqchip/gic-v3-its: add ability to save/restore ITS state
  DT/arm,gic-v3-its: add reset-on-suspend property
  irqchip/gic-v3-its: add ability to resend MAPC on resume
  DT/arm,gic-v3: add collections-reset-on-suspend property

 .../bindings/interrupt-controller/arm,gic-v3.txt   |   7 +
 arch/arm64/Kconfig                                 |  10 ++
 drivers/irqchip/irq-gic-v3-its.c                   | 187 ++++++++++++++++-----
 kernel/cpu_pm.c                                    |   3 +
 4 files changed, 169 insertions(+), 38 deletions(-)

-- 
2.16.0.rc1.238.g530d649a79-goog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
