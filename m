From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/7] tools/power turbostat: turbostat.8 add missing column definitions
Date: Wed, 12 Apr 2017 20:08:51 -0400
Message-ID: <ab23d1146a8e7bd045507fe8a380827dc03e056d.1492041840.git.len.brown@intel.com>
References: <20170413000853.21648-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170413000853.21648-1-lenb@kernel.org>
In-Reply-To: <22048c5485503749754b3b5daf9d99ef89fcacdc.1492041840.git.len.brown@intel.com>
References: <22048c5485503749754b3b5daf9d99ef89fcacdc.1492041840.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Doug Smythies <doug.smythies@gmail.com>, Doug Smythies <dsmythies@telus.net>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Doug Smythies <doug.smythies@gmail.com>

Add GFX%rc6 and GFXMHz to the column descriptions section
of the turbostat man page.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index fedca3285326..ccf2a69365cc 100644
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
2.11.0.161.g6610af872
