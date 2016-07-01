From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 5/7] bus: vexpress-config: add missing of_node_put after
 calling of_parse_phandle
Date: Fri, 1 Jul 2016 17:41:59 +0800
Message-ID: <1467366121-14120-6-git-send-email-peter.chen@nxp.com>
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
Cc: Peter Chen <peter.chen@nxp.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/bus/vexpress-config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index c3cb76b..9efdf1d 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -178,6 +178,7 @@ static int vexpress_config_populate(struct device_node *node)
 
 	parent = class_find_device(vexpress_config_class, NULL, bridge,
 			vexpress_config_node_match);
+	of_node_put(bridge);
 	if (WARN_ON(!parent))
 		return -ENODEV;
 
-- 
1.9.1
