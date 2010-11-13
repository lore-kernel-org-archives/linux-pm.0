From: Tracey Dent <tdent48227@gmail.com>
Subject: [PATCH] kernel/power/: Changed Makefile to use proper
	ccflag flag
Date: Sat, 13 Nov 2010 18:28:34 -0500
Message-ID: <1289690914-3752-1-git-send-email-tdent48227__25926.2867192321$1289837554$gmane$org@gmail.com>
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
To: len.brown@intel.com
Cc: Tracey Dent <tdent48227@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Use the ccflags-$ flag instead of EXTRA_CFLAGS because EXTRA_CFLAGS is
deprecated and should now be switched. According to (documentation/kbuild/makefiles.txt).

Signed-off-by: Tracey Dent <tdent48227@gmail.com>
---
 kernel/power/Makefile |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index f9063c6..b755972 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -1,7 +1,4 @@
-
-ifeq ($(CONFIG_PM_DEBUG),y)
-EXTRA_CFLAGS	+=	-DDEBUG
-endif
+ccflags-$(CONFIG_PM_DEBUG)	:=	-DDEBUG
 
 obj-$(CONFIG_PM)		+= main.o
 obj-$(CONFIG_PM_SLEEP)		+= console.o
-- 
1.7.3.2.164.g6f10c
