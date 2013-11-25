From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [REPOST PATCH V2] irq: enable all irqs unconditionally in irq_resume
Date: Mon, 25 Nov 2013 19:39:47 +0530
Message-ID: <1385388587-16442-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, ian.campbell@citrix.com, rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, heiko@sntech.de, pavel@ucw.cz, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pm@vger.kernel.org

When system enters into suspend, it disable all irqs in single
function call. This disables EARLY_RESUME irqs also along with
normal irqs.

The EARLY_RESUME irqs get enabled in sys_core_ops->resume and
non-EARLY_RESUME irqs get enabled in normal system resume path.

When suspend_noirq failed or suspend is aborted for any reason,
the EARLY_RESUME irqs do not get enabled as sys_core_ops->resume()
call did not happen. It only enables the non-EARLY_RESUME irqs in normal
disable for remaining life of system.

Enable all irqs unconditionally in normal irq_resume() regardless of
EARLY_RESUME irqs have been already enabled or not.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Acked-by-and-tested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Pavel Machek <pavel@ucw.cz>

---
Creating this patch based on disucssion on patch
 [PATCH] irq: enable suspended EARLY_RESUME irqs forcefully if not resumed

Making simple change as susggested by Thomas.

Reposting it with ack and review.

 kernel/irq/pm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index cb228bf..abcd6ca 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -50,7 +50,7 @@ static void resume_irqs(bool want_early)
 		bool is_early = desc->action &&
 			desc->action->flags & IRQF_EARLY_RESUME;
 
-		if (is_early != want_early)
+		if (!is_early && want_early)
 			continue;
 
 		raw_spin_lock_irqsave(&desc->lock, flags);
-- 
1.7.1.1
