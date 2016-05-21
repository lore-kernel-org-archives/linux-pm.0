From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0273/1529] Fix typo
Date: Sat, 21 May 2016 14:13:02 +0200
Message-ID: <20160521121302.14523-1-andrea.gelmini@gelma.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32788 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbcEUMNL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 May 2016 08:13:11 -0400
Received: by mail-lf0-f68.google.com with SMTP id z203so649885lfd.0
        for <linux-pm@vger.kernel.org>; Sat, 21 May 2016 05:13:10 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/x86/kernel/acpi/sleep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index adb3eaf..b3aff1a 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -30,7 +30,7 @@ static char temp_stack[4096];
  * x86_acpi_enter_sleep_state - enter sleep state
  * @state: Sleep state to enter.
  *
- * Wrapper around acpi_enter_sleep_state() to be called by assmebly.
+ * Wrapper around acpi_enter_sleep_state() to be called by assembly.
  */
 acpi_status asmlinkage __visible x86_acpi_enter_sleep_state(u8 state)
 {
-- 
2.8.2.534.g1f66975

