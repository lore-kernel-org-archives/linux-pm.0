From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH] tools/power turbostat: turbostat.8 add missing column definitions
Date: Sat,  4 Mar 2017 14:48:49 -0800
Message-ID: <1488667729-26281-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33593 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbdCDWtF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Mar 2017 17:49:05 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: len.brown@intel.com
Cc: dsmythies@telus.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Add GFX%rc6 and GFXMHz to the column descriptions section
of the turbostat man page.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 tools/power/x86/turbostat/turbostat.8 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index fedca32..ccf2a69 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -100,6 +100,8 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 \fBCPU%c1, CPU%c3, CPU%c6, CPU%c7\fP show the percentage residency in hardware core idle states.  These numbers are from hardware residency counters.
 \fBCoreTmp\fP Degrees Celsius reported by the per-core Digital Thermal Sensor.
 \fBPkgTtmp\fP Degrees Celsius reported by the per-package Package Thermal Monitor.
+\fBGFX%rc6\fP The percentage of time the GPU is in the "render C6" state, rc6, during the measurement interval. From /sys/class/drm/card0/power/rc6_residency_ms.
+\fBGFXMHz\fP Instantaneous snapshot of what sysfs presents at the end of the measurement interval. From /sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz.
 \fBPkg%pc2, Pkg%pc3, Pkg%pc6, Pkg%pc7\fP percentage residency in hardware package idle states.  These numbers are from hardware residency counters.
 \fBPkgWatt\fP Watts consumed by the whole package.
 \fBCorWatt\fP Watts consumed by the core part of the package.
-- 
2.7.4
