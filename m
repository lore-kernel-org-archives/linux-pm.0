From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/8] x86 idle floppy: deprecate disable_hlt()
Date: Sun, 29 May 2011 05:41:47 -0400
Message-ID: <3b70b2e5fcf6315eb833a1bcc2b810bdc75484ff.1306662035.git.len.brown@intel.com>
References: <1306662110-29954-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1306662110-29954-1-git-send-email-lenb@kernel.org>
In-reply-to: <7467571f4480b273007517b26297c07154c73924.1306662035.git.len.brown@intel.com>
References: <7467571f4480b273007517b26297c07154c73924.1306662035.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, x86@kernel.org, stable@kernel.org.#.39.x
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Plan to remove floppy_disable_hlt in 2012, an ancient
workaround with comments that it should be removed.

This allows us to remove clutter and a run-time branch
from the idle code.

WARN_ONCE() on invocation until it is removed.

cc: x86@kernel.org
cc: stable@kernel.org # .39.x
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/feature-removal-schedule.txt |    8 ++++++++
 drivers/block/floppy.c                     |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index b3f35e5..5540615 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -6,6 +6,14 @@ be removed from this file.
 
 ---------------------------
 
+What:	x86 floppy disable_hlt
+When:	2012
+Why:	ancient workaround of dubious utility clutters the
+	code used by everybody else.
+Who:	Len Brown <len.brown@intel.com>
+
+---------------------------
+
 What:	PRISM54
 When:	2.6.34
 
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 77fc76f..20aea9b 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1038,6 +1038,7 @@ static void floppy_disable_hlt(void)
 {
 	unsigned long flags;
 
+	WARN_ONCE(1, "floppy_disable_hlt() scheduled for removal in 2012");
 	spin_lock_irqsave(&floppy_hlt_lock, flags);
 	if (!hlt_disabled) {
 		hlt_disabled = 1;
-- 
1.7.5.3.367.ga9930.dirty
