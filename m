From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] x86/power/64: Use __pa() for physical address computation
Date: Sun, 14 Aug 2016 04:07:32 +0200
Message-ID: <5387760.qC5CG883jv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The value of temp_level4_pgt is the physical address of the
top-level page directory, so use __pa() to compute it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/power/hibernate_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/arch/x86/power/hibernate_64.c
===================================================================
--- linux-pm.orig/arch/x86/power/hibernate_64.c
+++ linux-pm/arch/x86/power/hibernate_64.c
@@ -113,7 +113,7 @@ static int set_up_temporary_mappings(voi
 			return result;
 	}
 
-	temp_level4_pgt = (unsigned long)pgd - __PAGE_OFFSET;
+	temp_level4_pgt = __pa(pgd);
 	return 0;
 }
 
