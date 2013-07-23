From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 1/1 v2] x86, acpi: Fix wrong checking condition in acpi_register_lapic().
Date: Tue, 23 Jul 2013 16:00:19 +0800
Message-ID: <1374566419-21120-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:11623 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753914Ab3GWH5g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Jul 2013 03:57:36 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

We wanted to check if the acpi id is out of range. It should be:
	if (id >= MAX_LOCAL_APIC).

v1 -> v2:
Remove the superfluous parentheses around MAX_LOCAL_APIC.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/boot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index d81a972..256479d 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -199,7 +199,7 @@ static void __cpuinit acpi_register_lapic(int id, u8 enabled)
 {
 	unsigned int ver = 0;
 
-	if (id >= (MAX_LOCAL_APIC-1)) {
+	if (id >= MAX_LOCAL_APIC) {
 		printk(KERN_INFO PREFIX "skipped apicid that is too big\n");
 		return;
 	}
-- 
1.7.10.1

