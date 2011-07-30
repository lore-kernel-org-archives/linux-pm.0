From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH -next] x86/platform: mrst/pmu.c needs module.h
Date: Fri, 29 Jul 2011 21:14:59 -0700
Message-ID: <20110729211459.148eb8cc.rdunlap__49997.338144067$1311999393$gmane$org@xenotime.net>
References: <20110729173827.716f57ff6e00095a3efc6449@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110729173827.716f57ff6e00095a3efc6449@canb.auug.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org
Cc: platform-driver-x86@vger.kernel.org, akpm <akpm@linux-foundation.org>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

mrst/pmu.c uses interfaces from linux/module.h, so it should
include that file.  This fixes build errors.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/x86/platform/mrst/pmu.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20110729.orig/arch/x86/platform/mrst/pmu.c
+++ linux-next-20110729/arch/x86/platform/mrst/pmu.c
@@ -21,6 +21,7 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/seq_file.h>
 #include <linux/sfi.h>
