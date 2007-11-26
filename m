From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/6] Hibernation: Move extern definition to
	header file
Date: Tue, 27 Nov 2007 00:33:04 +0100
Message-ID: <200711270033.04999.rjw__11576.41122486$1196119533$gmane$org@sisk.pl>
References: <200711270025.08128.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711270025.08128.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Move the extern definition of resume_file[] from kernel/power/swap.c
to kernel/power/power.h .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/power.h |    2 ++
 kernel/power/swap.c  |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/kernel/power/power.h
===================================================================
--- linux-2.6.orig/kernel/power/power.h
+++ linux-2.6/kernel/power/power.h
@@ -207,3 +207,5 @@ enum {
 #define TEST_MAX	(__TEST_AFTER_LAST - 1)
 
 extern int pm_test_level;
+
+extern char resume_file[];
Index: linux-2.6/kernel/power/swap.c
===================================================================
--- linux-2.6.orig/kernel/power/swap.c
+++ linux-2.6/kernel/power/swap.c
@@ -28,8 +28,6 @@
 
 #include "power.h"
 
-extern char resume_file[];
-
 #define SWSUSP_SIG	"S1SUSPEND"
 
 struct swsusp_header {
