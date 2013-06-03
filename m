From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PM / Hibernate: print physical addresses consistently with
 other parts of kernel
Date: Mon, 03 Jun 2013 12:20:29 -0600
Message-ID: <20130603182029.16063.60343.stgit@bhelgaas-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:65100 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759319Ab3FCSUc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2013 14:20:32 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so9744374ied.28
        for <linux-pm@vger.kernel.org>; Mon, 03 Jun 2013 11:20:31 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org

Print physical address info in a style consistent with the %pR style used
elsewhere in the kernel.

69f1d475cc did this for a similar printk in this file, but I must have
missed this one.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 kernel/power/snapshot.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 0de2857..7872a35 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -642,8 +642,9 @@ __register_nosave_region(unsigned long start_pfn, unsigned long end_pfn,
 	region->end_pfn = end_pfn;
 	list_add_tail(&region->list, &nosave_regions);
  Report:
-	printk(KERN_INFO "PM: Registered nosave memory: %016lx - %016lx\n",
-		start_pfn << PAGE_SHIFT, end_pfn << PAGE_SHIFT);
+	printk(KERN_INFO "PM: Registered nosave memory: [mem %#010llx-%#010llx]\n",
+		(unsigned long long) start_pfn << PAGE_SHIFT,
+		((unsigned long long) end_pfn << PAGE_SHIFT) - 1);
 }
 
 /*

