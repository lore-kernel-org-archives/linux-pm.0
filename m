From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 1/7] extcon: add missing of_node_put after calling
 of_parse_phandle
Date: Fri, 1 Jul 2016 17:41:55 +0800
Message-ID: <1467366121-14120-2-git-send-email-peter.chen@nxp.com>
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Peter Chen <peter.chen@nxp.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/extcon/extcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 21a123c..86ea14d 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1107,10 +1107,12 @@ struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
 	list_for_each_entry(edev, &extcon_dev_list, entry) {
 		if (edev->dev.parent && edev->dev.parent->of_node == node) {
 			mutex_unlock(&extcon_dev_list_lock);
+			of_node_put(node);
 			return edev;
 		}
 	}
 	mutex_unlock(&extcon_dev_list_lock);
+	of_node_put(node);
 
 	return ERR_PTR(-EPROBE_DEFER);
 }
-- 
1.9.1
