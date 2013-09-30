From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] x86/acpi: fix incorrect placement of __initdata tag
Date: Mon, 30 Sep 2013 17:29:43 +0200
Message-ID: <1834728.TOn9scBO35@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:21569 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445Ab3I3P34 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2013 11:29:56 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>

__initdata tag should not be placed between "struct" and "resource"
because it prevents the variable from being placed in the intended
.init.data section. Fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
v2:
- fixed patch description

 arch/x86/kernel/acpi/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 1f7c074..6c0b43b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -695,7 +695,7 @@ static int __init acpi_parse_sbf(struct acpi_table_header *table)
 #ifdef CONFIG_HPET_TIMER
 #include <asm/hpet.h>
 
-static struct __initdata resource *hpet_res;
+static struct resource *hpet_res __initdata;
 
 static int __init acpi_parse_hpet(struct acpi_table_header *table)
 {
-- 
1.8.2.3


