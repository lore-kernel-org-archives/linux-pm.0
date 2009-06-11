From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 19/19] PM: Add empty suspend/resume device irq
	functions
Date: Thu, 11 Jun 2009 22:50:15 +0000 (UTC)
Message-ID: <S4AoGnG.A.AI.ZjYMKB@chimera>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Date: Thu Jun 11 23:25:58 CEST 2009
In-Reply-To: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM List <linux-pm@lists.linux-foundation.org>
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, Ingo Molnar <mingo@elte.hu>, Wu Fengguang <fengguang.wu@intel.com>, Jaswinder Singh Rajput <jaswinder@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

git commit 0a0c5168 "PM: Introduce functions for suspending and resuming
device interrupts" introduced some helper functions. However these
functions are only available for architectures which support
GENERIC_HARDIRQS.

Other architectures will see this build error:

drivers/built-in.o: In function `sysdev_suspend':
(.text+0x15138): undefined reference to `check_wakeup_irqs'
drivers/built-in.o: In function `device_power_up':
(.text+0x1cb66): undefined reference to `resume_device_irqs'
drivers/built-in.o: In function `device_power_down':
(.text+0x1cb92): undefined reference to `suspend_device_irqs'

To fix this add some empty inline functions for !GENERIC_HARDIRQS.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/interrupt.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ff374ce..c41e812 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -183,6 +183,7 @@ extern void disable_irq(unsigned int irq);
 extern void enable_irq(unsigned int irq);
 
 /* The following three functions are for the core kernel use only. */
+#ifdef CONFIG_GENERIC_HARDIRQS
 extern void suspend_device_irqs(void);
 extern void resume_device_irqs(void);
 #ifdef CONFIG_PM_SLEEP
@@ -190,6 +191,11 @@ extern int check_wakeup_irqs(void);
 #else
 static inline int check_wakeup_irqs(void) { return 0; }
 #endif
+#else
+static inline void suspend_device_irqs(void) { };
+static inline void resume_device_irqs(void) { };
+static inline int check_wakeup_irqs(void) { return 0; }
+#endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_HARDIRQS)
 
-- 
1.5.2.4
