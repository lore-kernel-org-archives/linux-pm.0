From: Joe Perches <joe@perches.com>
Subject: [PATCH] MAINTAINERS - Remove include/asm-*/suspend* file
	patterns
Date: Tue, 14 Apr 2009 11:19:47 -0700
Message-ID: <1239733187.7994.5.camel__24234.1714133092$1239733521$gmane$org@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

There are no more arches with suspend support using these directories.
    
Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 0cb20d8..5b4f1dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2490,7 +2490,6 @@ F:	kernel/power/
 F:	include/linux/suspend.h
 F:	include/linux/freezer.h
 F:	include/linux/pm.h
-F:	include/asm-*/suspend*.h
 F:	arch/*/include/asm/suspend*.h
 
 HID CORE LAYER
@@ -5334,7 +5333,6 @@ F:	kernel/power/
 F:	include/linux/suspend.h
 F:	include/linux/freezer.h
 F:	include/linux/pm.h
-F:	include/asm-*/suspend.h
 
 SVGA HANDLING
 P:	Martin Mares
