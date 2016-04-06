From: Nisha Aram <nisha.aram@intel.com>
Subject: [PATCH] Added DPTF Policy UUID's
Date: Tue,  5 Apr 2016 17:31:03 -0700
Message-ID: <1459902663-7336-1-git-send-email-nisha.aram@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61025 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760026AbcDFAbT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Apr 2016 20:31:19 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Nisha Aram <nisha.aram@intel.com>

Added AdaptivePerformance, EmergencyCallMode,
PassivePolicy2, PowerBoss, VirtualSensor
Policy UUID's

Signed-off-by: Nisha Aram <nisha.aram@intel.com>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index 5836e55..1b4b229 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -20,6 +20,11 @@ enum int3400_thermal_uuid {
 	INT3400_THERMAL_PASSIVE_1,
 	INT3400_THERMAL_ACTIVE,
 	INT3400_THERMAL_CRITICAL,
+	INT3400_THERMAL_ADAPTIVE_PERFORMANCE,
+	INT3400_THERMAL_EMERGENCY_CALL_MODE,
+	INT3400_THERMAL_PASSIVE_2,
+	INT3400_THERMAL_POWER_BOSS,
+	INT3400_THERMAL_VIRTUAL_SENSOR,
 	INT3400_THERMAL_MAXIMUM_UUID,
 };
 
@@ -27,6 +32,11 @@ static u8 *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] = {
 	"42A441D6-AE6A-462b-A84B-4A8CE79027D3",
 	"3A95C389-E4B8-4629-A526-C52C88626BAE",
 	"97C68AE7-15FA-499c-B8C9-5DA81D606E0A",
+	"63BE270F-1C11-48FD-A6F7-3AF253FF3E2D",
+	"5349962F-71E6-431D-9AE8-0A635B710AEE",
+	"9E04115A-AE87-4D1C-9500-0F3E340BFE75",
+	"F5A35014-C209-46A4-993A-EB56DE7530A1",
+	"6ED722A7-9240-48A5-B479-31EEF723D7CF",
 };
 
 struct int3400_thermal_priv {
-- 
1.9.1

