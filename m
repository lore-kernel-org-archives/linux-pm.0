From: <yuantian.tang@nxp.com>
Subject: [PATCH] cpufreq: qoriq: clean up unused code
Date: Tue, 21 Feb 2017 14:51:24 +0800
Message-ID: <1487659884-29040-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@rjwysocki.net
Cc: Tang Yuantian <yuantian.tang@nxp.com>, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Tang Yuantian <Yuantian.Tang@nxp.com>

This snip code is not needed anymore since its user
get_hard_smp_processor_id() has been removed.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
 drivers/cpufreq/qoriq-cpufreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 53d8c3f..02031a3 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -22,10 +22,6 @@
 #include <linux/slab.h>
 #include <linux/smp.h>
 
-#if !defined(CONFIG_ARM)
-#include <asm/smp.h>	/* for get_hard_smp_processor_id() in UP configs */
-#endif
-
 /**
  * struct cpu_data
  * @pclk: the parent clock of cpu
-- 
2.1.0.27.g96db324
