From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] PM: Remove unnecessary goto from
	device_resume_noirq()
Date: Sun, 13 Dec 2009 23:08:36 +0100
Message-ID: <200912132308.36538.rjw__12818.3432425887$1260742242$gmane$org@sisk.pl>
References: <200912132306.57741.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912132306.57741.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

In device_resume_noirq() there is the 'End' label and the associated
goto statement that aren't strictly necessary, so rework the code to
get rid of them.  Also modify device_suspend_noirq() so that it looks
completely analogous to device_resume_noirq().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -372,14 +372,11 @@ static int device_resume_noirq(struct de
 	TRACE_DEVICE(dev);
 	TRACE_RESUME(0);
 
-	if (!dev->bus)
-		goto End;
-
-	if (dev->bus->pm) {
+	if (dev->bus && dev->bus->pm) {
 		pm_dev_dbg(dev, state, "EARLY ");
 		error = pm_noirq_op(dev, dev->bus->pm, state);
 	}
- End:
+
 	TRACE_RESUME(error);
 	return error;
 }
@@ -615,10 +612,7 @@ static int device_suspend_noirq(struct d
 {
 	int error = 0;
 
-	if (!dev->bus)
-		return 0;
-
-	if (dev->bus->pm) {
+	if (dev->bus && dev->bus->pm) {
 		pm_dev_dbg(dev, state, "LATE ");
 		error = pm_noirq_op(dev, dev->bus->pm, state);
 	}
