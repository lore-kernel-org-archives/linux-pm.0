From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] x86/power/64: Avoid memory corruption in 64-bit swsusp_arch_resume()
Date: Sat, 18 Jun 2016 01:33:47 +0200
Message-ID: <2755592.YNNOVbNgS2@vostro.rjw.lan>
References: <3006711.q9ei2E2zzf@vostro.rjw.lan> <tip-70595b479ce173425dd5cb347dc6c8b1060dfb2c@git.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61900 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751690AbcFQX3f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 19:29:35 -0400
In-Reply-To: <tip-70595b479ce173425dd5cb347dc6c8b1060dfb2c@git.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mingo@kernel.org
Cc: sds@tycho.nsa.gov, logang@deltatee.com, keescook@chromium.org, tglx@linutronix.de, luto@kernel.org, peterz@infradead.org, hpa@zytor.com, torvalds@linux-foundation.org, bp@alien8.de, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, brgerst@gmail.com, dvlasenk@redhat.com, linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 70595b479ce1 (x86/power/64: Fix crash whan the hibernation
code passes control to the image kernel) forgot to update the last
argument of memcpy() in swsusp_arch_resume() to reflect the other
changes made by it and that may lead to memory corruption if the
core_restore_code code happens to be located at the end of a page,
so fix it.

Fixes: 70595b479ce1 (x86/power/64: Fix crash whan the hibernation code passes control to the image kernel)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Commit 70595b479ce1 is in tip and linux-next now.

---
 arch/x86/power/hibernate_64.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-pm/arch/x86/power/hibernate_64.c
===================================================================
--- linux-pm.orig/arch/x86/power/hibernate_64.c
+++ linux-pm/arch/x86/power/hibernate_64.c
@@ -142,8 +142,7 @@ int swsusp_arch_resume(void)
 	relocated_restore_code = (void *)get_safe_page(GFP_ATOMIC);
 	if (!relocated_restore_code)
 		return -ENOMEM;
-	memcpy(relocated_restore_code, &core_restore_code,
-	       &restore_registers - &core_restore_code);
+	memcpy(relocated_restore_code, &core_restore_code, PAGE_SIZE);
 
 	restore_image();
 	return 0;

