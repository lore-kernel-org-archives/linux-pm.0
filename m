From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/5] PM: Clean up Kconfig dependencies
Date: Tue, 8 Feb 2011 22:23:37 +0100
Message-ID: <201102082223.37975.rjw__16640.5498203405$1297201709$gmane$org@sisk.pl>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110208122159.GA8284@elte.hu> <201102082218.28015.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102082218.28015.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <len.brown@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-embedded@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

CONFIG_PM_SLEEP_ADVANCED_DEBUG should depend on CONFIG_PM_SLEEP
and CONFIG_CAN_PM_TRACE need not depend on EXPERIMENTAL.  Modify
kernel/power/Kconfig along those lines.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/kernel/power/Kconfig
===================================================================
--- linux-2.6.orig/kernel/power/Kconfig
+++ linux-2.6/kernel/power/Kconfig
@@ -142,7 +142,7 @@ config PM_ADVANCED_DEBUG
 
 config PM_SLEEP_ADVANCED_DEBUG
 	bool
-	depends on PM_ADVANCED_DEBUG
+	depends on PM_ADVANCED_DEBUG && PM_SLEEP
 	default n
 
 config PM_TEST_SUSPEND
@@ -158,7 +158,7 @@ config PM_TEST_SUSPEND
 
 config CAN_PM_TRACE
 	def_bool y
-	depends on PM_DEBUG && PM_SLEEP && EXPERIMENTAL
+	depends on PM_DEBUG && PM_SLEEP
 
 config PM_TRACE
 	bool
