From: <yuantian.tang@nxp.com>
Subject: [PATCH 1/2 v3] cpufreq: qoriq: added arm64 socs support
Date: Thu, 9 Feb 2017 10:33:01 +0800
Message-ID: <1486607582-18367-1-git-send-email-yuantian.tang@nxp.com>
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
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com, Tang Yuantian <yuantian.tang@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Tang Yuantian <Yuantian.Tang@nxp.com>

Add arm64 config to Kconfig to enable cpu frequency feature on
nxp arm64 socs.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
v3: no change
v2: no change

 drivers/cpufreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 15adef4..3964383 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -324,7 +324,7 @@ endif
 
 config QORIQ_CPUFREQ
 	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
-	depends on OF && COMMON_CLK && (PPC_E500MC || ARM)
+	depends on OF && COMMON_CLK && (PPC_E500MC || ARM || ARM64)
 	depends on !CPU_THERMAL || THERMAL
 	select CLK_QORIQ
 	help
-- 
2.1.0.27.g96db324
