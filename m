From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: [PATCH 5/6] PM / QoS: Fix a typo in file description
Date: Wed, 6 Mar 2019 13:25:25 +0000
Message-ID: <1551878302-8146-6-git-send-email-aisheng.dong@nxp.com>
References: <1551878302-8146-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551878302-8146-1-git-send-email-aisheng.dong@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Fix a typo in file description

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/base/power/qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 3382542..f80e402 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -22,7 +22,7 @@
  * per-device constraint data struct.
  *
  * Note about the per-device constraint data struct allocation:
- * . The per-device constraints data struct ptr is tored into the device
+ * . The per-device constraints data struct ptr is stored into the device
  *    dev_pm_info.
  * . To minimize the data usage by the per-device constraints, the data struct
  *   is only allocated at the first call to dev_pm_qos_add_request.
-- 
2.7.4
