From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/5] PM: Add debug printouts to async suspend and
	resume code paths
Date: Sun, 13 Dec 2009 23:40:57 +0100
Message-ID: <200912132340.57200.rjw__48887.1168731295$1260744221$gmane$org@sisk.pl>
References: <200912132338.30921.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912132338.30921.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Add pm_dev_dbg() to asynchronous suspend and resume code paths to
make the debugging of async suspend/resume easier.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -510,6 +510,7 @@ static void async_resume(void *data, asy
 	struct device *dev = (struct device *)data;
 	int error;
 
+	pm_dev_dbg(dev, pm_transition, "async ");
 	error = __device_resume(dev, pm_transition, true);
 	if (error)
 		pm_dev_err(dev, pm_transition, " async", error);
@@ -791,6 +792,7 @@ static void async_suspend(void *data, as
 	struct device *dev = (struct device *)data;
 	int error;
 
+	pm_dev_dbg(dev, pm_transition, "async ");
 	error = __device_suspend(dev, pm_transition, true);
 	if (error) {
 		pm_dev_err(dev, pm_transition, " async", error);
