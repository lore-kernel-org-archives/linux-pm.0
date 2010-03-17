From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [RFC/PATCH] platform_bus: allow custom extensions to
	system PM methods
Date: Wed, 17 Mar 2010 16:18:15 -0700
Message-ID: <1268867896-7616-1-git-send-email-khilman__11444.9111781598$1268868070$gmane$org@deeprootsystems.com>
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
To: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Dmitry Torokhov <dtor@mail.ru>, Magnus Damm <damm@opensource.se>, Greg Kroah-Hartman <gregkh@suse.de>, Eric Miao <eric.y.miao@gmail.com>
List-Id: linux-pm@vger.kernel.org

When runtime PM for platform_bus was added, it allowed for platforms
to customize the runtime PM methods since they are defined as weak
symbols.

This patch allows platforms to also extend the system PM methods with
custom hooks so runtime PM and system PM extensions can be managed
together by custom platform-specific code.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/base/platform.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1ba9d61..93d37d0 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -729,7 +729,7 @@ static void platform_pm_complete(struct device *dev)
 
 #ifdef CONFIG_SUSPEND
 
-static int platform_pm_suspend(struct device *dev)
+int __weak platform_pm_suspend(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
 	int ret = 0;
@@ -747,7 +747,7 @@ static int platform_pm_suspend(struct device *dev)
 	return ret;
 }
 
-static int platform_pm_suspend_noirq(struct device *dev)
+int __weak platform_pm_suspend_noirq(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
 	int ret = 0;
@@ -763,7 +763,7 @@ static int platform_pm_suspend_noirq(struct device *dev)
 	return ret;
 }
 
-static int platform_pm_resume(struct device *dev)
+int __weak platform_pm_resume(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
 	int ret = 0;
@@ -781,7 +781,7 @@ static int platform_pm_resume(struct device *dev)
 	return ret;
 }
 
-static int platform_pm_resume_noirq(struct device *dev)
+int __weak platform_pm_resume_noirq(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
 	int ret = 0;
-- 
1.7.0.2
