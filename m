From: Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH] kernel/power/suspend: use CONFIG_HAVE_SET_MEMORY for include condition
Date: Sat,  3 Jun 2017 20:52:32 +1000
Message-ID: <20170603105232.6436-1-bsingharora@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33984 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdFCKwr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jun 2017 06:52:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Balbir Singh <bsingharora@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Laura Abbott <labbott@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

Kbuild reported a build failure when CONFIG_STRICT_KERNEL_RWX was
enabled on powerpc. We don't yet have ARCH_HAS_SET_MEMORY and ppc32
saw a build failure.

fixes(50327dd kernel/power/snapshot.c: use set_memory.h header)

I've only done a basic compile test with a config that has
hibernation enabled.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 kernel/power/snapshot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index fa46606..71730d6 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -36,13 +36,13 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/io.h>
-#ifdef CONFIG_STRICT_KERNEL_RWX
+#ifdef CONFIG_ARCH_HAS_SET_MEMORY
 #include <asm/set_memory.h>
 #endif
 
 #include "power.h"
 
-#ifdef CONFIG_STRICT_KERNEL_RWX
+#if defined(CONFIG_STRICT_KERNEL_RWX) && defined(CONFIG_ARCH_HAS_SET_MEMORY)
 static bool hibernate_restore_protection;
 static bool hibernate_restore_protection_active;
 
@@ -77,7 +77,7 @@ static inline void hibernate_restore_protection_begin(void) {}
 static inline void hibernate_restore_protection_end(void) {}
 static inline void hibernate_restore_protect_page(void *page_address) {}
 static inline void hibernate_restore_unprotect_page(void *page_address) {}
-#endif /* CONFIG_STRICT_KERNEL_RWX */
+#endif /* CONFIG_STRICT_KERNEL_RWX  && CONFIG_ARCH_HAS_SET_MEMORY */
 
 static int swsusp_page_is_free(struct page *);
 static void swsusp_set_page_forbidden(struct page *);
-- 
2.9.3
