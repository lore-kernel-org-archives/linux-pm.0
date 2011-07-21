From: jhbird.choi@samsung.com
Subject: [PATCH] PM / OPP: Fix dev_opp initial value
Date: Thu, 21 Jul 2011 15:31:48 +0900
Message-ID: <1311229908-6046-1-git-send-email-jhbird.choi__30039.4428814345$1311348297$gmane$org@samsung.com>
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
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Jonghwan Choi <jhbird.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

From: Jonghwan Choi <jhbird.choi@samsung.com>

Dev_opp initial value shoule be ERR_PTR(),
IS_ERR() is used to check error.

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 drivers/base/power/opp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 56a6899..d4ebf80 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -453,7 +453,7 @@ int opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 static int opp_set_availability(struct device *dev, unsigned long freq,
 		bool availability_req)
 {
-	struct device_opp *tmp_dev_opp, *dev_opp = NULL;
+	struct device_opp *tmp_dev_opp, *dev_opp = ERR_PTR(-ENODEV);
 	struct opp *new_opp, *tmp_opp, *opp = ERR_PTR(-ENODEV);
 	int r = 0;
 
-- 
1.7.0
