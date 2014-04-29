From: "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH v2 2/4] powercap/rapl: add new cpu ids
Date: Tue, 29 Apr 2014 15:33:07 -0700
Message-ID: <1398810789-2301-3-git-send-email-david.e.box@linux.intel.com>
References: <1398693880-13428-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1398810789-2301-1-git-send-email-david.e.box@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398810789-2301-1-git-send-email-david.e.box@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: david.e.box@linux.intel.com, jacob.jun.pan@linux.intel.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, hpa@linux.intel.com
Cc: alan@linux.intel.com, durgadoss.r@intel.com, kristen.c.accardi@intel.com
List-Id: linux-pm@vger.kernel.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Adding support for Broadwell model 0x3d and HSW model (0x3c)

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 1c987d2..b1cda6f 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -951,7 +951,9 @@ static const struct x86_cpu_id rapl_ids[] = {
 	{ X86_VENDOR_INTEL, 6, 0x2d},/* Sandy Bridge EP */
 	{ X86_VENDOR_INTEL, 6, 0x37},/* Valleyview */
 	{ X86_VENDOR_INTEL, 6, 0x3a},/* Ivy Bridge */
-	{ X86_VENDOR_INTEL, 6, 0x45},/* Haswell */
+	{ X86_VENDOR_INTEL, 6, 0x3c},/* Haswell */
+	{ X86_VENDOR_INTEL, 6, 0x3d},/* Broadwell */
+	{ X86_VENDOR_INTEL, 6, 0x45},/* Haswell ULT */
 	/* TODO: Add more CPU IDs after testing */
 	{}
 };
-- 
1.7.10.4
