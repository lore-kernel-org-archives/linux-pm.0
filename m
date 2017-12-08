From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH 3/9] power: remove unneeded kallsyms include
Date: Fri,  8 Dec 2017 11:56:10 +0900
Message-ID: <20171208025616.16267-4-sergey.senozhatsky@gmail.com>
References: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Vlastimil Babka <vbabka@suse.cz>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Fengguang Wu <fengguang.wu@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-pm@vger.kernel.org

The file was converted from print_fn_descriptor_symbol()
to %pF some time ago (c80cfb0406c01bb "vsprintf: use new
vsprintf symbolic function pointer format"). kallsyms does
not seem to be needed anymore.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
---
 drivers/base/power/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 5bc2cf1f812c..e2539d8423f7 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -18,7 +18,6 @@
  */
 
 #include <linux/device.h>
-#include <linux/kallsyms.h>
 #include <linux/export.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
-- 
2.15.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
