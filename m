From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/7] tools/power turbostat: bugfix: GFXMHz column not changing
Date: Wed, 12 Apr 2017 20:08:47 -0400
Message-ID: <22048c5485503749754b3b5daf9d99ef89fcacdc.1492041840.git.len.brown@intel.com>
References: <20170413000853.21648-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170413000853.21648-1-lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

turbostat displays a GFXMHz column, which comes from reading
/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz

But GFXMHz was not changing, even when a manual
cat /sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz
showed a new value.

It turns out that a rewind() on the open file is not sufficient,
fflush() (or a close/open) is needed to read fresh values.

Reported-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 828dccd3f01e..d7fb6bcb2744 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2485,8 +2485,10 @@ int snapshot_gfx_mhz(void)
 
 	if (fp == NULL)
 		fp = fopen_or_die("/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz", "r");
-	else
+	else {
 		rewind(fp);
+		fflush(fp);
+	}
 
 	retval = fscanf(fp, "%d", &gfx_cur_mhz);
 	if (retval != 1)
-- 
2.11.0.161.g6610af872
