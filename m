Return-Path: <SRS0=OdXI=5Z=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1F6C2BA2B
	for <linux-pm@archiver.kernel.org>; Thu,  9 Apr 2020 11:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5061320757
	for <linux-pm@archiver.kernel.org>; Thu,  9 Apr 2020 11:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDIL2K (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:28:10 -0400
Received: from foss.arm.com ([217.140.110.172]:48898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgDIL2K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Apr 2020 07:28:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3614031B;
        Thu,  9 Apr 2020 04:28:08 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A21003F73D;
        Thu,  9 Apr 2020 04:28:06 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Revert "cpu/hotplug: Ignore pm_wakeup_pending() for disable_nonboot_cpus()"
Date:   Thu,  9 Apr 2020 12:27:40 +0100
Message-Id: <20200409112742.3581-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This issue was fixed already by:

commit d66b16f5df4b ("arm64: Don't use disable_nonboot_cpus()")
commit dddf3578e0d4 ("ARM: Don't use disable_nonboot_cpus()")

The only caller of disable_nonboot_cpus() is x86, which is in a proper
suspend/resume path and due to the reverted patch lost its ability to
early abort due to a pending wakeup.

The fix that is being reverted is arguably a better one to backport to
stable trees. But it highlights the confusion about using
disable_nonboot_cpus() API.

This is a preparation to remove disable_nonboot_cpus() in favor of
freeze_secondary_cpus().

This reverts commit e98eac6ff1b45e4e73f2e6031b37c256ccb5d36b.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Len Brown <len.brown@intel.com>
CC: Pavel Machek <pavel@ucw.cz>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
CC: Todd E Brandt <todd.e.brandt@linux.intel.com>
CC: linux-pm@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 include/linux/cpu.h | 12 +++---------
 kernel/cpu.c        |  4 ++--
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index beaed2dc269e..9ead281157d3 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -144,18 +144,12 @@ static inline void get_online_cpus(void) { cpus_read_lock(); }
 static inline void put_online_cpus(void) { cpus_read_unlock(); }
 
 #ifdef CONFIG_PM_SLEEP_SMP
-int __freeze_secondary_cpus(int primary, bool suspend);
-static inline int freeze_secondary_cpus(int primary)
-{
-	return __freeze_secondary_cpus(primary, true);
-}
-
+extern int freeze_secondary_cpus(int primary);
 static inline int disable_nonboot_cpus(void)
 {
-	return __freeze_secondary_cpus(0, false);
+	return freeze_secondary_cpus(0);
 }
-
-void enable_nonboot_cpus(void);
+extern void enable_nonboot_cpus(void);
 
 static inline int suspend_disable_secondary_cpus(void)
 {
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 12ae636e9cb6..30848496cbc7 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1327,7 +1327,7 @@ void bringup_nonboot_cpus(unsigned int setup_max_cpus)
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
 
-int __freeze_secondary_cpus(int primary, bool suspend)
+int freeze_secondary_cpus(int primary)
 {
 	int cpu, error = 0;
 
@@ -1352,7 +1352,7 @@ int __freeze_secondary_cpus(int primary, bool suspend)
 		if (cpu == primary)
 			continue;
 
-		if (suspend && pm_wakeup_pending()) {
+		if (pm_wakeup_pending()) {
 			pr_info("Wakeup pending. Abort CPU freeze\n");
 			error = -EBUSY;
 			break;
-- 
2.17.1

