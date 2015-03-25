From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH] powercap / RAPL: mark rapl_ids array as __initconst
Date: Wed, 25 Mar 2015 22:15:52 +0100
Message-ID: <1427318152-21800-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:36834 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbbCYVQE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 17:16:04 -0400
Received: by wgra20 with SMTP id a20so42233020wgr.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2015 14:16:03 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org, Mathias Krause <minipli@googlemail.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The RAPL ids are only tested in rapl_init() which is itself an __init
function. For the MODULE_DEVICE_TABLE() file2alias doesn't care about
the section, just about the symbol name. Therefore it's safe to mark the
rapl_ids[] array as __initconst so its memory can be released after
initialization is done.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 drivers/powercap/intel_rapl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 63d4033eb683..62f9b322fde0 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1054,7 +1054,7 @@ static const struct rapl_defaults rapl_defaults_atom = {
 		.driver_data = (kernel_ulong_t)&_ops,	\
 		}
 
-static const struct x86_cpu_id rapl_ids[] = {
+static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(0x2a, rapl_defaults_core),/* Sandy Bridge */
 	RAPL_CPU(0x2d, rapl_defaults_core),/* Sandy Bridge EP */
 	RAPL_CPU(0x37, rapl_defaults_atom),/* Valleyview */
-- 
1.7.10.4

