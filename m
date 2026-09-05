Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8073E308F3C;
	Sat,  5 Sep 2026 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788622108; cv=none; b=K6OKGMmd4+yoDlDNQ8DhgJqkuDKX731AjCYHWqsayUNyHaJqrzcMfDzAFiXgQNJNlf2deYedPK70ryxU2ZkTgrnMzwCGKVOZAnquBCybP7pxGUeTY+47BcxUiyYh3WKbVMICc6tnVIXh8LeR84lcxwt62AYJd2qELO9hGRDV118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788622108; c=relaxed/simple;
	bh=21oJQRptMENRZuUZmexVQ+gWTGcDjbnKzzfRNDMXibQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=BRJ54STiSLcvF531UbXmC61OIHjq2tDdu9rQ47hUNih2UMpPwjhlJKQLLkVSnhyw+MMeqAp7iQ5t3VPfhOBtG8OXlOaE+xO6yaCXIpBfkxvp3xjlTwp7JnZg9YnONPumi0BFl1jrWVOcPpeA860SMIgq6ZUh73NkUett7vhArW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=OZuRYJfB; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="OZuRYJfB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1788622094; bh=5aMJrkMTz3jHWrYt/87UGN6IlGuZj6u75bboj0AZyvw=;
	h=From:To:Cc:Subject:Date;
	b=OZuRYJfBuzMi8Ifk7ZB7f8B7AMKNTKV4KZW/iJc7J37QWB5Ghwa439J6ivCYRnAdL
	 ZxXjeA6thR/laL9V1vlJCzWOrnvjpZXDnwtIXaDCrQfOJQ1CdwbehGMxwYS7eGUS1V
	 jzDMUkIS+QFNZqMPY9G9EjXqWqCDES0/AmNOC/Ok=
Received: from xgyy.localdomain ([2408:8352:603:550:7498:ece5:3e9a:a20e])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 6F8AAE65; Sat, 05 Sep 2026 23:27:56 +0800
X-QQ-mid: xmsmtpt1788622076thuzxais1
Message-ID: <tencent_EB4BC71944911E53F173CF6B5D92EB1AA908@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuUC+7w6S+ptkaDcQvZL/mryoUACkxr1mFy09Uuj+C6YMs1L5Mxg
	 bnbs8w25A28YA4MJSzxeodK/yvI/X8tgmq02ysZeFTLucw1eVVjFzt8l1FxK8xGb4LJSiwyDvkHN
	 B3NB2T7v01/h0HtmZodk09WoqE/wAutFUGNPJIZj2sIt5Ozt58AuyX0Ql1T9IdKgWKyUhHfUA3ex
	 Q+/sg90Ga5PiXWYg6PnEOPpVAV5OBu3qNWt9YJkH22IDuAJVleWhvr9IuWT1oS7DurBEwcuSM0kD
	 +dK2rn8ia6/KTNMRGNPlgEJLE1JZm0LcjHXMs2SeYF+sjvml63nz4TgkRGlzgH1WZLv6I6GkkfGF
	 45GIxT3TenAY9+ACNi3TuKkPUdt0c9M/0Eh+2TvPy1MZVouS9DsGD8vPu9xZhAMfw7wHbQ9Hfjjs
	 cAOHMb8RzzW9EHy51axD4DMF18H4UQk1fcn4saDlNiAFolDari8fXhf7YurUPRlcZ/6wKJyX8kWH
	 lrysTC2qibPrIWb6w1o04D2LZxNS1fjX5uV8dYCoOlebIebyG9ylG5Uxd50E2Cy8Yo2/IJNSCoWS
	 o//DKnmGYutOzEDb+QugO9LugQauh+AUa/ZLmoSJYD6XOyjcMaj1GApfJtbpnMPGVk7ApcQQqwxH
	 0RgEke0r18BE4jffuOS43RBgN8H2HTytG4KL+nF6JFs5O+xlExkOu6t96SnRo9l558kfokRi51S5
	 +dL4spzpjROtEn9SSwwvt2KYeSMu2nIxlRhE7vot8eEAoUEK59kDl1pjX+P9SRlKQVcAY+1NaEVR
	 YirY3rA0TzWxfp3/p/FSlq8NmaTTtYDLsZEX/hHsh3x7wE0Lb/w2ElF8sSH8kF5edjbUWg2HqO3z
	 21kzTYPqUulWoiEjF33YLLebsDSbKx10Xe36Htl39SYMA5DU00PFMbwaCse9ziSuk1qx5uTU1Nz3
	 7PONtyHf8kSRNOBuCQQzOg5cHiVGxrZFGgPGnvXT7ur5GfWZZiYI/Ss5SF/G18GOJZNVAP3hg2fd
	 mbrc//0LWmU3mBl1/JyYohLQCRSj6nVB8RBuGlz6EWg/hraoEakjZ5fd7qI60g8Oq+FCeh8ZvaYl
	 5PsrntmRX/Nr4z89VL2Ri9uAOG+6+ZEiKMXraEzw4UoLerDF0=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Zhu Ling <zhuling0805@qq.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Zhu Ling <zhuling0805@qq.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH] genirq/PM: Re-enable chained interrupts after hibernation
Date: Sat,  5 Sep 2026 23:27:51 +0800
X-OQ-MSGID: <20260905152752.50126-1-zhuling0805@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Chained interrupts remain enabled across suspend because they can be part
of a wakeup path. Consequently, suspend_device_irq() does not set
IRQS_SUSPENDED for them, and they do not have IRQF_FORCE_RESUME accounting.

After restoring a hibernation image, the interrupt controller can have a
chained parent interrupt masked while the restored descriptor still marks
it started and enabled. For example, the restore kernel may initialize the
controller without probing the driver that installs the chained handler.
resume_irq() skips the parent in this state, leaving interrupts from the
devices below it blocked.

Pass the hibernation restore context from dpm_resume_noirq() to the IRQ PM
code and force active chained interrupts through the existing force-resume
path. Set the disabled and masked state before enabling the interrupt so
that cached descriptor state cannot suppress the irqchip callback. Calling
irq_startup() alone on an already started and enabled interrupt can skip
the hardware access when the descriptor also records it as unmasked.

Leave disabled and unstarted chained interrupts alone. Keep the existing
behavior for ordinary resume, hibernation thaw and recovery, and the early
syscore resume pass.

Fixes: 0a0c5168df27 ("PM: Introduce functions for suspending and resuming device interrupts")
Assisted-by: LLM
Signed-off-by: Zhu Ling <zhuling0805@qq.com>
---
Found by inspection and reproduced with a fake irq_chip in UML KUnit.
The reproducer installs a chained handler, runs the IRQ suspend path, and
sets the simulated hardware mask without changing the descriptor. On the
unpatched kernel, resume leaves the hardware masked with no enable/unmask
callback and no interrupt delivery. With the fix, delivery resumes.

Validation:
  - UML KUnit: 24 cases passed; the same suite failed 6 cases without the
    fix. Covers irq_enable and irq_unmask callbacks, disabled depth,
    shutdown, existing force-resume behavior and pending interrupt resend.
  - x86_64 defconfig (GCC 13.3) and arm64 defconfig (Clang 18.1):
    kernel/irq/pm.o and drivers/base/power/main.o built with W=1.
  - x86_64 tinyconfig (PM disabled): kernel/irq/chip.o built with W=1.
  - checkpatch.pl --strict and git apply --check passed.

No physical-board hibernation test has been performed. Sparse was attempted
but rejected by checker-valid.sh because the installed sparse 0.6.4 lacks
__typeof_unqual__ support.

AI assistance: an LLM inspected the supplied patch and local IRQ/PM code,
prepared the fix and changelog, and wrote and ran the fake-irqchip tests.

 drivers/base/power/main.c |  2 +-
 include/linux/interrupt.h |  2 +-
 kernel/irq/pm.c           | 29 ++++++++++++++++++++---------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e130da428141..370ce28fb7b3 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -952,7 +952,7 @@ void dpm_resume_noirq(pm_message_t state)
 {
 	dpm_noirq_resume_devices(state);
 
-	resume_device_irqs();
+	resume_device_irqs(state.event == PM_EVENT_RESTORE);
 	device_wakeup_disarm_wake_irqs();
 }
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3bf969ad8fe0..1cf8808adf7f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -253,7 +253,7 @@ extern int irq_inject_interrupt(unsigned int irq);
 
 /* The following three functions are for the core kernel use only. */
 extern void suspend_device_irqs(void);
-extern void resume_device_irqs(void);
+void resume_device_irqs(bool restore);
 extern void rearm_wake_irq(unsigned int irq);
 
 /**
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 99ff65466d87..325b5dd4495e 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -141,7 +141,7 @@ void suspend_device_irqs(void)
 	}
 }
 
-static void resume_irq(struct irq_desc *desc)
+static void resume_irq(struct irq_desc *desc, bool restore)
 {
 	struct irq_data *irqd = &desc->irq_data;
 
@@ -160,9 +160,18 @@ static void resume_irq(struct irq_desc *desc)
 	if (desc->istate & IRQS_SUSPENDED)
 		goto resume;
 
-	/* Force resume the interrupt? */
-	if (!desc->force_resume_depth)
+	if (restore && irq_desc_is_chained(desc)) {
+		/*
+		 * Chained interrupts are not suspended to preserve wakeup paths.
+		 * After restoring a hibernation image, the controller may have
+		 * them disabled despite the restored descriptor state. Force
+		 * active chained interrupts through the hardware enable path.
+		 */
+		if (!irqd_is_started(irqd) || irqd_irq_disabled(irqd))
+			return;
+	} else if (!desc->force_resume_depth) {
 		return;
+	}
 
 	/* Pretend that it got disabled ! */
 	desc->depth++;
@@ -173,7 +182,7 @@ static void resume_irq(struct irq_desc *desc)
 	__enable_irq(desc);
 }
 
-static void resume_irqs(bool want_early)
+static void resume_irqs(bool want_early, bool restore)
 {
 	struct irq_desc *desc;
 	int irq;
@@ -187,7 +196,7 @@ static void resume_irqs(bool want_early)
 			continue;
 
 		guard(raw_spinlock_irqsave)(&desc->lock);
-		resume_irq(desc);
+		resume_irq(desc, restore);
 	}
 }
 
@@ -217,7 +226,7 @@ void rearm_wake_irq(unsigned int irq)
  */
 static void irq_pm_syscore_resume(void *data)
 {
-	resume_irqs(true);
+	resume_irqs(true, false);
 }
 
 static const struct syscore_ops irq_pm_syscore_ops = {
@@ -238,12 +247,14 @@ device_initcall(irq_pm_init_ops);
 
 /**
  * resume_device_irqs - enable interrupt lines disabled by suspend_device_irqs()
+ * @restore: Whether memory has been restored from a hibernation image
  *
  * Enable all non-%IRQF_EARLY_RESUME interrupt lines previously
  * disabled by suspend_device_irqs() that have the IRQS_SUSPENDED flag
- * set as well as those with %IRQF_FORCE_RESUME.
+ * set as well as those with %IRQF_FORCE_RESUME. Also re-enable active chained
+ * interrupts when restoring a hibernation image.
  */
-void resume_device_irqs(void)
+void resume_device_irqs(bool restore)
 {
-	resume_irqs(false);
+	resume_irqs(false, restore);
 }

base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
-- 
2.43.0

