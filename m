From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 14/19] PM: Remove device_type suspend()/resume()
Date: Thu, 11 Jun 2009 21:59:24 +0000 (UTC)
Message-ID: <S4AoGnG.A.D7H.mZXMKB__26432.2678828195$1244757564$gmane$org@chimera>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Date: Thu Jun 11 23:25:58 CEST 2009
In-Reply-To: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM List <linux-pm@lists.linux-foundation.org>
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, Ingo Molnar <mingo@elte.hu>, Wu Fengguang <fengguang.wu@intel.com>, Jaswinder Singh Rajput <jaswinder@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch removes the legacy callbacks ->suspend() and
->resume() from struct device_type. These callbacks seem
unused, and new code should instead make use of struct
dev_pm_ops.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |    7 -------
 include/linux/device.h    |    3 ---
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 68f9f3c..fae7254 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -399,9 +399,6 @@ static int device_resume(struct device *dev, pm_message_t state)
 		if (dev->type->pm) {
 			pm_dev_dbg(dev, state, "type ");
 			error = pm_op(dev, dev->type->pm, state);
-		} else if (dev->type->resume) {
-			pm_dev_dbg(dev, state, "legacy type ");
-			error = dev->type->resume(dev);
 		}
 		if (error)
 			goto End;
@@ -641,10 +638,6 @@ static int device_suspend(struct device *dev, pm_message_t state)
 		if (dev->type->pm) {
 			pm_dev_dbg(dev, state, "type ");
 			error = pm_op(dev, dev->type->pm, state);
-		} else if (dev->type->suspend) {
-			pm_dev_dbg(dev, state, "legacy type ");
-			error = dev->type->suspend(dev, state);
-			suspend_report_result(dev->type->suspend, error);
 		}
 		if (error)
 			goto End;
diff --git a/include/linux/device.h b/include/linux/device.h
index 84d79cd..a4a7b10 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -289,9 +289,6 @@ struct device_type {
 	int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
 	void (*release)(struct device *dev);
 
-	int (*suspend)(struct device *dev, pm_message_t state);
-	int (*resume)(struct device *dev);
-
 	struct dev_pm_ops *pm;
 };
 
-- 
1.5.2.4
