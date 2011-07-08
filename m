From: "Liu, ShuoX" <shuox.liu@intel.com>
Subject: [PATCH] runtime-pm: consistent utilization of
	deferred_resume
Date: Fri, 8 Jul 2011 12:57:07 +0800
Message-ID: <6E3BC7F7C9A4BF4286DD4C043110F30B59E040012A__12353.8588210524$1310146910$gmane$org@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>, "gregkh@suse.de" <gregkh@suse.de>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>From 10bb3c851a0a9c9ca4d552743a371e3cfda81075 Mon Sep 17 00:00:00 2001
From: ShuoX Liu <shuox.liu@intel.com>
Date: Thu, 7 Jul 2011 15:59:06 +0800
Subject: [PATCH] runtime-pm: consistent utilization of deferred_resume

dev->power.deferred_resume is used as a bool typically, so change
one assignment to false from 0, like other places.

Signed-off-by: ShuoX Liu <shuox.liu@intel.com>
---
 drivers/base/power/runtime.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 0d4587b..af3d1a5 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -388,7 +388,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	retval = rpm_callback(callback, dev);
 	if (retval) {
 		__update_runtime_status(dev, RPM_ACTIVE);
-		dev->power.deferred_resume = 0;
+		dev->power.deferred_resume = false;
 		if (retval == -EAGAIN || retval == -EBUSY)
 			dev->power.runtime_error = 0;
 		else
-- 
1.7.1
