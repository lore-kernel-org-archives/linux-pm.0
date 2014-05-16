From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v6 4/6] driver: cpuidle: cpuidle-big-little: init driver for
 Exynos5420
Date: Fri, 16 May 2014 13:33:56 +0530
Message-ID: <1400227438-27155-5-git-send-email-chander.kashyap@linaro.org>
References: <CANuQgHGSA+R__raSa_tzrgpceqLD2SZw+s0XQUHGF4wscgh6Kg@mail.gmail.com>
 <1400227438-27155-1-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400227438-27155-1-git-send-email-chander.kashyap@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Chander Kashyap <k.chander@samsung.com>, lorenzo.pieralisi@arm.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net, tomasz.figa@gmail.com, Chander Kashyap <chander.kashyap@linaro.org>, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add "samsung,exynos5420" compatible string to initialize generic
big-little cpuidle driver for Exynos5420.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Chander Kashyap <k.chander@samsung.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Changes in v5: None
Changes in v4: None
Changes in v3:
	1. Add compatible string to of_device_id table insted comparing directoly
Changes in v2: none

 drivers/cpuidle/cpuidle-big_little.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index 4cd02bd..344d79fa 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -165,6 +165,7 @@ static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int cpu_id)
 
 static const struct of_device_id compatible_machine_match[] = {
 	{ .compatible = "arm,vexpress,v2p-ca15_a7" },
+	{ .compatible = "samsung,exynos5420" },
 	{},
 };
 
-- 
1.7.9.5
