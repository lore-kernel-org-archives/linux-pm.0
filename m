From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 2/4] thermal: power_allocator: change k_pu_ratio/k_po_ratio as percentage
Date: Wed,  6 Jan 2016 16:53:46 +0800
Message-ID: <1452070428-2567-3-git-send-email-leo.yan@linaro.org>
References: <1452070428-2567-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452070428-2567-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

Change k_pu_ratio/k_po_ratio as percentage value, so can set these
values from sys file nodes with high resolution.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/power_allocator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 76d2b47..c5f36fa 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -156,10 +156,10 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 		return;
 
 	if (!tz->tzp->k_po_ratio || force)
-		tz->tzp->k_po_ratio = 1;
+		tz->tzp->k_po_ratio = 100;
 
 	if (!tz->tzp->k_pu_ratio || force)
-		tz->tzp->k_pu_ratio = 2;
+		tz->tzp->k_pu_ratio = 200;
 
 	if (!tz->tzp->k_i || force)
 		tz->tzp->k_i = int_to_frac(10) / 1000;
@@ -169,9 +169,9 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 	 */
 
 	tz->tzp->k_po = int_to_frac(tz->tzp->k_po_ratio * sustainable_power) /
-				temperature_threshold;
+				temperature_threshold / 100;
 	tz->tzp->k_pu = int_to_frac(tz->tzp->k_pu_ratio * sustainable_power) /
-				temperature_threshold;
+				temperature_threshold / 100;
 }
 
 /**
-- 
1.9.1
