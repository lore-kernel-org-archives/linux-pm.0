From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] PM / hibernate: Add missing braces in __register_nosave_region()
Date: Wed, 06 Jul 2016 23:44:31 +0200
Message-ID: <10569352.sLrsX6jVCn@vostro.rjw.lan>
References: <20396026.uktHd5ozkC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61310 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755480AbcGFVkE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2016 17:40:04 -0400
In-Reply-To: <20396026.uktHd5ozkC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

One branch of an if/else statement in __register_nosave_region() is
formatted against the kernel coding style which causes the code to
look slightly odd.  To fix that, add missing braces to it.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/snapshot.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/kernel/power/snapshot.c
===================================================================
--- linux-pm.orig/kernel/power/snapshot.c
+++ linux-pm/kernel/power/snapshot.c
@@ -945,9 +945,10 @@ void __init __register_nosave_region(uns
 		/* During init, this shouldn't fail */
 		region = kmalloc(sizeof(struct nosave_region), GFP_KERNEL);
 		BUG_ON(!region);
-	} else
+	} else {
 		/* This allocation cannot fail */
 		region = memblock_virt_alloc(sizeof(struct nosave_region), 0);
+	}
 	region->start_pfn = start_pfn;
 	region->end_pfn = end_pfn;
 	list_add_tail(&region->list, &nosave_regions);

