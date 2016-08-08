From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/2] x86, ACPI: Fix the wrong assignment when Handle apic/x2apic entries
Date: Tue,  9 Aug 2016 07:01:51 +0800
Message-ID: <1470697311-1292-2-git-send-email-bhe@redhat.com>
References: <1470697311-1292-1-git-send-email-bhe@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52590 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143AbcHHXCC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Aug 2016 19:02:02 -0400
In-Reply-To: <1470697311-1292-1-git-send-email-bhe@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Baoquan He <bhe@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org

It won't impact the result, we still should fix the code bug.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
---
 arch/x86/kernel/acpi/boot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 90d84c3..2b25d3f 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1031,8 +1031,8 @@ static int __init acpi_parse_madt_lapic_entries(void)
 			return ret;
 		}
 
-		x2count = madt_proc[0].count;
-		count = madt_proc[1].count;
+		count = madt_proc[0].count;
+		x2count = madt_proc[1].count;
 	}
 	if (!count && !x2count) {
 		printk(KERN_ERR PREFIX "No LAPIC entries present\n");
-- 
2.5.5

