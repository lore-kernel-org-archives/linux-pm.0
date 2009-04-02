From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 2/9] hp_accel: remove unused #include <version.h>
Date: Thu,  2 Apr 2009 23:30:12 +0800
Message-ID: <1238686212-3920-1-git-send-email-weiyi.huang@gmail.com>
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
To: pavel@ucw.cz
Cc: linux-pm@lists.linux-foundation.org, Huang Weiyi <weiyi.huang@gmail.com>
List-Id: linux-pm@vger.kernel.org

Remove unused #include <version.h> in drivers/hwmon/hp_accel.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 drivers/hwmon/hp_accel.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/hp_accel.c b/drivers/hwmon/hp_accel.c
index 55d3dc5..abca7e9 100644
--- a/drivers/hwmon/hp_accel.c
+++ b/drivers/hwmon/hp_accel.c
@@ -34,7 +34,6 @@
 #include <linux/wait.h>
 #include <linux/poll.h>
 #include <linux/freezer.h>
-#include <linux/version.h>
 #include <linux/uaccess.h>
 #include <linux/leds.h>
 #include <acpi/acpi_drivers.h>
-- 
1.6.0.4
