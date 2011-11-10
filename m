From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH] Devfreq/core: remove compiler error after irq.h
	update
Date: Thu, 10 Nov 2011 15:19:18 +0900
Message-ID: <CAJ0PZbQxL3urqi06xefcYwvAn=P2FDMR3YW0LVRySmnchQ+UUQ@mail.gmail.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Cc: "Hilman, Kevin" <khilman@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

Added <linux/module.h> and <linux/stat.h> to avoid a compiler error
because linux/irq.h no longer includes linux/module.h after Linux 3.2.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/devfreq/devfreq.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2355543..7b9d4b5 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -15,7 +15,9 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/stat.h>
 #include <linux/opp.h>
 #include <linux/devfreq.h>
 #include <linux/workqueue.h>
-- 
1.7.4.1
