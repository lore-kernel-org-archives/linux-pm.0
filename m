From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] PM / Hibernate: Update some comments in core
	hibernate code
Date: Sat, 21 May 2011 14:09:33 +0200
Message-ID: <201105211409.34012.rjw__39355.9896540411$1305980013$gmane$org@sisk.pl>
References: <201105211408.28671.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105211408.28671.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Frank Hofmann <frank.hofmann@tomtom.com>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Some comments in the core hibernate code are outdated, some aren't
necessary any more and at least one of them is plain wrong.  Remove
those comments or update them.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/hibernate.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

Index: linux-2.6/kernel/power/hibernate.c
===================================================================
--- linux-2.6.orig/kernel/power/hibernate.c
+++ linux-2.6/kernel/power/hibernate.c
@@ -248,12 +248,6 @@ static int create_image(int platform_mod
 	if (error)
 		return error;
 
-	/* At this point, dpm_suspend_start() has been called, but *not*
-	 * dpm_suspend_noirq(). We *must* call dpm_suspend_noirq() now.
-	 * Otherwise, drivers for some devices (e.g. interrupt controllers)
-	 * become desynchronized with the actual state of the hardware
-	 * at resume time, and evil weirdness ensues.
-	 */
 	error = dpm_suspend_noirq(PMSG_FREEZE);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down, "
@@ -297,9 +291,6 @@ static int create_image(int platform_mod
 
  Power_up:
 	syscore_resume();
-	/* NOTE:  dpm_resume_noirq() is just a resume() for devices
-	 * that suspended with irqs off ... no overall powerup.
-	 */
 
  Enable_irqs:
 	local_irq_enable();
@@ -416,24 +407,26 @@ static int resume_target_kernel(bool pla
 	if (error)
 		goto Enable_irqs;
 
-	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
 	error = restore_highmem();
 	if (!error) {
 		error = swsusp_arch_resume();
 		/*
 		 * The code below is only ever reached in case of a failure.
-		 * Otherwise execution continues at place where
-		 * swsusp_arch_suspend() was called
+		 * Otherwise, execution continues at the place where
+		 * swsusp_arch_suspend() was called.
 		 */
 		BUG_ON(!error);
-		/* This call to restore_highmem() undos the previous one */
+		/*
+		 * This call to restore_highmem() reverts the changes made by
+		 * the previous one.
+		 */
 		restore_highmem();
 	}
 	/*
 	 * The only reason why swsusp_arch_resume() can fail is memory being
 	 * very tight, so we have to free it as soon as we can to avoid
-	 * subsequent failures
+	 * subsequent failures.
 	 */
 	swsusp_free();
 	restore_processor_state();
