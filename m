From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] clocksource: sh_cmt: Only perform clocksource suspend/resume if enabled
Date: Tue, 14 Jul 2015 13:41:04 +0200
Message-ID: <1436874064-2729-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:45900 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbbGNLlK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2015 07:41:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Currently the sh_cmt clocksource timer is disabled or enabled
unconditionally on clocksource suspend resp. resume, even if a better
clocksource is present (e.g. arch_sys_counter) and the sh_cmt
clocksource is not enabled.

As sh_cmt is a syscore device when its timer is enabled, this may lead
to a genpd.prepared_count imbalance in the presence of PM Domains, which
may cause a lock-up during reboot after s2ram.

During suspend:
  - pm_genpd_prepare() is called for all non-syscore devices (incl.
    sh_cmt), increasing genpd.prepared_count for each device,
  - clocksource.suspend() is called for all clocksource devices,
  - sh_cmt_clocksource_suspend() calls sh_cmt_stop(), which is a no-op
    as the clocksource was not enabled.

During resume:
  - clocksource.resume() is called for all clocksource devices,
  - sh_cmt_clocksource_resume() calls sh_cmt_start(), which enables the
    clocksource timer, and turns sh_cmt into a syscore device,
  - pm_genpd_complete() is called for all non-syscore devices (excl.
    sh_cmt now!), decreasing genpd.prepared_count for each device but
    sh_cmt.

Now genpd.prepared_count of the PM Domain containing sh_cmt is still 1
instead of zero.  On subsequent suspend/resume cycles, sh_cmt is still a
syscore device, hence it's skipped for pm_genpd_{prepare,complete}(),
keeping the imbalance of genpd.prepared_count at 1.

During reboot:
  - platform_drv_shutdown() is called for any platform device that has
    a driver with a .shutdown() method (only rcar-dmac on R-Car Gen2),
  - platform_drv_shutdown() calls dev_pm_domain_detach(), which
    calls genpd_dev_pm_detach(),
  - genpd_dev_pm_detach() keeps calling pm_genpd_remove_device() until
    it doesn't return -EAGAIN[*],
  - If the device is part of the same PM Domain as sh_cmt,
    pm_genpd_remove_device() always fails with -EAGAIN due to
    genpd.prepared_count > 0.
  - Infinite loop in genpd_dev_pm_detach()[*].

[*] Commit 93af5e9354432828 ("PM / Domains: Avoid infinite loops in
    attach/detach code") already limited the number of loop iterations,
    avoiding the lock-up.

To fix this, only disable or enable the clocksource timer on clocksource
suspend resp. resume if the clocksource was enabled.

This was tested on r8a7791/koelsch with the CPG Clock Domain:
  - using arch_sys_counter as the clocksource, which is the default, and
    which showed the problem,
  - using sh_cmt as a clocksource ("echo ffca0000.timer > \
    /sys/devices/system/clocksource/clocksource0/current_clocksource"),
    which behaves the same as before.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v1 was part of "[PATCH 0/2] PM / Domains: Infinite loop during reboot"
(https://lkml.org/lkml/2015/6/18/212). The other part has been applied
already (commit 93af5e9354432828).

v2:
  - Add Acked-by,
  - Add a reference to the commit that fixed the infinite loop in the
    core PM Domain code.
---
 drivers/clocksource/sh_cmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index d56d4e0e3fb3956d..ef799532a7a7963e 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -661,6 +661,9 @@ static void sh_cmt_clocksource_suspend(struct clocksource *cs)
 {
 	struct sh_cmt_channel *ch = cs_to_sh_cmt(cs);
 
+	if (!ch->cs_enabled)
+		return;
+
 	sh_cmt_stop(ch, FLAG_CLOCKSOURCE);
 	pm_genpd_syscore_poweroff(&ch->cmt->pdev->dev);
 }
@@ -669,6 +672,9 @@ static void sh_cmt_clocksource_resume(struct clocksource *cs)
 {
 	struct sh_cmt_channel *ch = cs_to_sh_cmt(cs);
 
+	if (!ch->cs_enabled)
+		return;
+
 	pm_genpd_syscore_poweron(&ch->cmt->pdev->dev);
 	sh_cmt_start(ch, FLAG_CLOCKSOURCE);
 }
-- 
1.9.1

