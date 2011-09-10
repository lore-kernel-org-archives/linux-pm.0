From: tom.leiming@gmail.com
Subject: [PATCH 1/2] PM/runtime: update document about callbacks
Date: Sat, 10 Sep 2011 22:37:21 +0800
Message-ID: <1315665442-4194-1-git-send-email-tom.leiming__6080.59814335338$1315665526$gmane$org@gmail.com>
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
To: rjw@sisk.pl, stern@rowland.harvard.edu
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Ming Lei <tom.leiming@gmail.com>

Support for device power domains has been introduced in
commit 9659cc0678b954f187290c6e8b247a673c5d37e1 (PM: Make
system-wide PM and runtime PM treat subsystems consistently),
also power domain callbacks will take precedence over subsystem ones
from commit 4d27e9dcff00a6425d779b065ec8892e4f391661(PM: Make
power domain callbacks take precedence over subsystem ones).

So update part of "Device Runtime PM Callbacks" in
Documentation/power/runtime_pm.txt.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 Documentation/power/runtime_pm.txt |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 1f05404..0e85608 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -43,13 +43,18 @@ struct dev_pm_ops {
 	...
 };
 
-The ->runtime_suspend(), ->runtime_resume() and ->runtime_idle() callbacks are
-executed by the PM core for either the device type, or the class (if the device
-type's struct dev_pm_ops object does not exist), or the bus type (if the
-device type's and class' struct dev_pm_ops objects do not exist) of the given
-device (this allows device types to override callbacks provided by bus types or
-classes if necessary).  The bus type, device type and class callbacks are
-referred to as subsystem-level callbacks in what follows.
+The ->runtime_suspend(), ->runtime_resume() and ->runtime_idle() callbacks
+are executed by the PM core for either the power domain, or the device type
+(if the device power domain's struct dev_pm_ops does not exist), or the class
+(if the device power domain's and type's struct dev_pm_ops object does not
+exist), or the bus type (if the device power domain's, type's and class'
+struct dev_pm_ops objects do not exist) of the given device, so the priority
+order of callbacks from high to low is that power domain callbacks, device
+type callbacks, class callbacks and bus type callbacks, and the high priority
+one will take precedence over low priority one. The bus type, device type and
+class callbacks are referred to as subsystem-level callbacks in what follows,
+and generally speaking, the power domain callbacks are used for representing
+power domains within a SoC.
 
 By default, the callbacks are always invoked in process context with interrupts
 enabled.  However, subsystems can use the pm_runtime_irq_safe() helper function
-- 
1.7.4.1
