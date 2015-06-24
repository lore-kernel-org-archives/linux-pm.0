From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH] PM / hibernate: re-enable nonboot cpus on disable_nonboot_cpus() failure
Date: Wed, 24 Jun 2015 16:02:06 +0200
Message-ID: <1435154526-9023-1-git-send-email-vkuznets@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45758 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039AbbFXOCK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Jun 2015 10:02:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>

When disable_nonboot_cpus() fails on some cpu it doesn't bring back all
cpus it managed to offline, a consequent call to enable_nonboot_cpus() is
expected. In hibernation_platform_enter() we don't call
enable_nonboot_cpus() on error so cpus stay offlined.

create_image() and resume_target_kernel() functions handle
disable_nonboot_cpus() faults correctly, hibernation_platform_enter()
is the only one which is doing it wrong.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 kernel/power/hibernate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2329daa..690f78f 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -552,7 +552,7 @@ int hibernation_platform_enter(void)
 
 	error = disable_nonboot_cpus();
 	if (error)
-		goto Platform_finish;
+		goto Enable_cpus;
 
 	local_irq_disable();
 	syscore_suspend();
@@ -568,6 +568,8 @@ int hibernation_platform_enter(void)
  Power_up:
 	syscore_resume();
 	local_irq_enable();
+
+ Enable_cpus:
 	enable_nonboot_cpus();
 
  Platform_finish:
-- 
2.4.2

