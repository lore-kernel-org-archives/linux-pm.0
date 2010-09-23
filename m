From: matt mooney <mfm@muteddisk.com>
Subject: [PATCH 01/20] kernel: change to new flag variable
Date: Wed, 22 Sep 2010 23:49:45 -0700
Message-ID: <1285224585-29457-1-git-send-email-mfm__23873.4965133064$1285273369$gmane$org@muteddisk.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Replace EXTRA_CFLAGS with ccflags-y.

Signed-off-by: matt mooney <mfm@muteddisk.com>
---
 kernel/gcov/Makefile  |    2 +-
 kernel/power/Makefile |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
index 3f76100..e97ca59 100644
--- a/kernel/gcov/Makefile
+++ b/kernel/gcov/Makefile
@@ -1,3 +1,3 @@
-EXTRA_CFLAGS := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
+ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
 
 obj-$(CONFIG_GCOV_KERNEL) := base.o fs.o gcc_3_4.o
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index f9063c6..0f98685 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -1,7 +1,5 @@
 
-ifeq ($(CONFIG_PM_DEBUG),y)
-EXTRA_CFLAGS	+=	-DDEBUG
-endif
+ccflags-$(CONFIG_PM_DEBUG)	:= -DDEBUG
 
 obj-$(CONFIG_PM)		+= main.o
 obj-$(CONFIG_PM_SLEEP)		+= console.o
-- 
1.7.2.1
