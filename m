From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 6/7] devfreq: add missing of_node_put after calling
 of_parse_phandle
Date: Fri, 1 Jul 2016 17:42:00 +0800
Message-ID: <1467366121-14120-7-git-send-email-peter.chen@nxp.com>
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
Cc: Peter Chen <peter.chen@nxp.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/devfreq/devfreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1d6c803..3f2142f 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -706,10 +706,12 @@ struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
 		if (devfreq->dev.parent
 			&& devfreq->dev.parent->of_node == node) {
 			mutex_unlock(&devfreq_list_lock);
+			of_node_put(node);
 			return devfreq;
 		}
 	}
 	mutex_unlock(&devfreq_list_lock);
+	of_node_put(node);
 
 	return ERR_PTR(-EPROBE_DEFER);
 }
-- 
1.9.1
