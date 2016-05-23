From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/2] powercap/rapl: add support for skx
Date: Mon, 23 May 2016 09:45:42 -0700
Message-ID: <1464021943-14915-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1464021943-14915-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464021943-14915-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Prarit Bhargava <prarit@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

SKX RAPL interface is similar to HSX/BDX.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 470bb62..a417e68 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1096,6 +1096,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(0x4E, rapl_defaults_core),/* Skylake */
 	RAPL_CPU(0x4C, rapl_defaults_cht),/* Braswell/Cherryview */
 	RAPL_CPU(0x4A, rapl_defaults_tng),/* Tangier */
+	RAPL_CPU(0x55, rapl_defaults_hsw_server),/* Skylake server */
 	RAPL_CPU(0x56, rapl_defaults_core),/* Future Xeon */
 	RAPL_CPU(0x5A, rapl_defaults_ann),/* Annidale */
 	RAPL_CPU(0X5C, rapl_defaults_core),/* Broxton */
-- 
1.9.1
