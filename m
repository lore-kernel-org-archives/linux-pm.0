From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 02/19] x86: unify power/cpu_(32|64) headers
Date: Thu, 11 Jun 2009 22:29:53 +0000 (UTC)
Message-ID: <S4AoGnG.A.xE.8UYMKB@chimera>
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

From: Sergio Luis <sergio@larces.uece.br>

First step towards the unification of cpu_32.c and cpu_64.c.
This commit unifies the headers of such files, making both
of them use the same header files. It also remove the uneeded
<module.h>.

Signed-off-by: Sergio Luis <sergio@larces.uece.br>
Signed-off-by: Lauro Salmito <laurosalmito@gmail.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/power/cpu_32.c |    6 +++++-
 arch/x86/power/cpu_64.c |    8 +++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/power/cpu_32.c b/arch/x86/power/cpu_32.c
index ce702c5..12a9c87 100644
--- a/arch/x86/power/cpu_32.c
+++ b/arch/x86/power/cpu_32.c
@@ -7,9 +7,13 @@
  * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
  */
 
-#include <linux/module.h>
 #include <linux/suspend.h>
+#include <linux/smp.h>
+
+#include <asm/pgtable.h>
+#include <asm/proto.h>
 #include <asm/mtrr.h>
+#include <asm/page.h>
 #include <asm/mce.h>
 #include <asm/xcr.h>
 #include <asm/suspend.h>
diff --git a/arch/x86/power/cpu_64.c b/arch/x86/power/cpu_64.c
index 5343540..39b27b7 100644
--- a/arch/x86/power/cpu_64.c
+++ b/arch/x86/power/cpu_64.c
@@ -8,12 +8,14 @@
  * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
  */
 
-#include <linux/smp.h>
 #include <linux/suspend.h>
-#include <asm/proto.h>
-#include <asm/page.h>
+#include <linux/smp.h>
+
 #include <asm/pgtable.h>
+#include <asm/proto.h>
 #include <asm/mtrr.h>
+#include <asm/page.h>
+#include <asm/mce.h>
 #include <asm/xcr.h>
 #include <asm/suspend.h>
 
-- 
1.5.2.4
