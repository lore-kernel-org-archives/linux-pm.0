From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v4 0/5] GICv3 Save and Restore
Date: Fri,  2 Feb 2018 17:24:45 -0800
Message-ID: <20180203012450.18378-1-dbasehore@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44831 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeBCBYz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Feb 2018 20:24:55 -0500
Received: by mail-pg0-f66.google.com with SMTP id m20so14836468pgc.11
        for <linux-pm@vger.kernel.org>; Fri, 02 Feb 2018 17:24:55 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, briannorris@chromium.org, marc.zyngier@arm.com, Derek Basehore <dbasehore@chromium.org>

A lot of changes in v2. The distributor and redistributor saving and
restoring is left to the PSCI/firmware implementation after
discussions with ARM. This reduces the line changes by a lot and
removes now unneeded patches.

Patches are verified on an RK3399 platform with pending patches in the
ARM-Trusted-Firmware project.

Just a couple minor changes in v3 to formatting.

Fixed a false ITS wedged detection due to the cmd_write and creadr
offsets not matching up on reset in v4. Also minor formatting changes.

Derek Basehore (5):
  cpu_pm: add syscore_suspend error handling
  irqchip/gic-v3-its: add ability to save/restore ITS state
  DT/arm,gic-v3-its: add reset-on-suspend property
  irqchip/gic-v3-its: add ability to resend MAPC on resume
  DT/arm,gic-v3: add collections-reset-on-suspend property

 .../bindings/interrupt-controller/arm,gic-v3.txt   |   7 +
 arch/arm64/Kconfig                                 |  10 +
 drivers/irqchip/irq-gic-v3-its.c                   | 202 +++++++++++++++++----
 kernel/cpu_pm.c                                    |   3 +
 4 files changed, 184 insertions(+), 38 deletions(-)

-- 
2.16.0.rc1.238.g530d649a79-goog
