From: Ranganath Krishnan <ranganath@ti.com>
Subject: [PATCH 1/3] thermal: ti-soc-thermal: Initialize counter_delay field for TI DRA752 sensors
Date: Fri, 23 Aug 2013 11:08:21 -0500
Message-ID: <1377274103-27770-1-git-send-email-ranganath@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60281 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754190Ab3HWQIp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 23 Aug 2013 12:08:45 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id r7NG8iKi016068
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2013 11:08:44 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id r7NG8il3017360
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2013 11:08:44 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Praneeth Bajjuri <praneeth@ti.com>, Ranganath Krishnan <ranganath@ti.com>

Initialize MPU, GPU, CORE, DSPEVE and IVA thermal sensors of DRA752 bandgap
with the counter delay mask.

Signed-off-by: Ranganath Krishnan <ranganath@ti.com>
---
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
index e5d8326..a492927 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
@@ -42,6 +42,7 @@ dra752_core_temp_sensor_registers = {
 	.mask_hot_mask = DRA752_BANDGAP_CTRL_1_MASK_HOT_CORE_MASK,
 	.mask_cold_mask = DRA752_BANDGAP_CTRL_1_MASK_COLD_CORE_MASK,
 	.mask_sidlemode_mask = DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
+	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_1_FREEZE_CORE_MASK,
 	.mask_clear_mask = DRA752_BANDGAP_CTRL_1_CLEAR_CORE_MASK,
 	.mask_clear_accum_mask = DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_CORE_MASK,
@@ -77,6 +78,7 @@ dra752_iva_temp_sensor_registers = {
 	.mask_hot_mask = DRA752_BANDGAP_CTRL_2_MASK_HOT_IVA_MASK,
 	.mask_cold_mask = DRA752_BANDGAP_CTRL_2_MASK_COLD_IVA_MASK,
 	.mask_sidlemode_mask = DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
+	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_2_FREEZE_IVA_MASK,
 	.mask_clear_mask = DRA752_BANDGAP_CTRL_2_CLEAR_IVA_MASK,
 	.mask_clear_accum_mask = DRA752_BANDGAP_CTRL_2_CLEAR_ACCUM_IVA_MASK,
@@ -112,6 +114,7 @@ dra752_mpu_temp_sensor_registers = {
 	.mask_hot_mask = DRA752_BANDGAP_CTRL_1_MASK_HOT_MPU_MASK,
 	.mask_cold_mask = DRA752_BANDGAP_CTRL_1_MASK_COLD_MPU_MASK,
 	.mask_sidlemode_mask = DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
+	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_1_FREEZE_MPU_MASK,
 	.mask_clear_mask = DRA752_BANDGAP_CTRL_1_CLEAR_MPU_MASK,
 	.mask_clear_accum_mask = DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_MPU_MASK,
@@ -147,6 +150,7 @@ dra752_dspeve_temp_sensor_registers = {
 	.mask_hot_mask = DRA752_BANDGAP_CTRL_2_MASK_HOT_DSPEVE_MASK,
 	.mask_cold_mask = DRA752_BANDGAP_CTRL_2_MASK_COLD_DSPEVE_MASK,
 	.mask_sidlemode_mask = DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
+	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_2_FREEZE_DSPEVE_MASK,
 	.mask_clear_mask = DRA752_BANDGAP_CTRL_2_CLEAR_DSPEVE_MASK,
 	.mask_clear_accum_mask = DRA752_BANDGAP_CTRL_2_CLEAR_ACCUM_DSPEVE_MASK,
@@ -182,6 +186,7 @@ dra752_gpu_temp_sensor_registers = {
 	.mask_hot_mask = DRA752_BANDGAP_CTRL_1_MASK_HOT_GPU_MASK,
 	.mask_cold_mask = DRA752_BANDGAP_CTRL_1_MASK_COLD_GPU_MASK,
 	.mask_sidlemode_mask = DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
+	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_1_FREEZE_GPU_MASK,
 	.mask_clear_mask = DRA752_BANDGAP_CTRL_1_CLEAR_GPU_MASK,
 	.mask_clear_accum_mask = DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_GPU_MASK,
-- 
1.7.9.5

