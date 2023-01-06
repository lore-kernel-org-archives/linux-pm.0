Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18DDC3DA7A
	for <linux-pm@archiver.kernel.org>; Fri,  6 Jan 2023 04:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjAFEDu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 5 Jan 2023 23:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjAFEDt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jan 2023 23:03:49 -0500
Received: from njjs-sys-mailin01.njjs.baidu.com (mx316.baidu.com [180.101.52.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26CC53E84C
        for <linux-pm@vger.kernel.org>; Thu,  5 Jan 2023 20:03:44 -0800 (PST)
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 2C5E07F00049;
        Fri,  6 Jan 2023 12:03:42 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     linux-pm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        rafael@kernel.org, peterz@infradead.org
Subject: [PATCH][v3] cpuidle-haltpoll: Replace default_idle with arch_cpu_idle
Date:   Fri,  6 Jan 2023 12:03:42 +0800
Message-Id: <20230106040342.46570-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When KVM guest has MWAIT and mwait_idle is used as default idle function,
but once cpuidle-haltpoll is loaded, default_idle in default_enter_idle is
used, which is using HLT, and maybe cause a performance regression, as the
commit aebef63cf7ff ("x86: Remove vendor checks from prefer_mwait_c1_over_halt")
explains that mwait is preferred

so replace default_idle with arch_cpu_idle which can using MWAIT
optimization.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
v3: using EXPORT_SYMBOL_GPL
v2: not disable haltpoll, using arch_cpu_idle when guest has mwait

 arch/x86/kernel/process.c          | 1 +
 drivers/cpuidle/cpuidle-haltpoll.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 40d156a..00a831d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -721,6 +721,7 @@ void arch_cpu_idle(void)
 {
 	x86_idle();
 }
+EXPORT_SYMBOL_GPL(arch_cpu_idle);
 
 /*
  * We use this if we don't have any better idle routine..
diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index 3a39a7f..e66df22 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -32,7 +32,7 @@ static int default_enter_idle(struct cpuidle_device *dev,
 		local_irq_enable();
 		return index;
 	}
-	default_idle();
+	arch_cpu_idle();
 	return index;
 }
 
-- 
2.9.4

