From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 1/3] clk: Hi6220: enable stub clock driver for ARCH_HISI
Date: Wed, 31 Aug 2016 16:50:15 +0800
Message-ID: <1472633417-9330-2-git-send-email-leo.yan@linaro.org>
References: <1472633417-9330-1-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1472633417-9330-1-git-send-email-leo.yan@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>, Krzysztof Kozlowski <krzk@kernel.org>, Thierry Reding <treding@nvidia.com>, Riku Voipio <riku.voipio@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Guodong Xu <guodong.xu@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Leo Yan <leo.yan@linaro.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

In current kernel config 'CONFIG_STUB_CLK_HI6220' is disabled by
default, as result stub clock driver has not been registered and
CPUFreq driver cannot work.

This patch is to enable stub clock driver in config for ARCH_HISI.

Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/clk/hisilicon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
index 3f537a0..9e0a95e 100644
--- a/drivers/clk/hisilicon/Kconfig
+++ b/drivers/clk/hisilicon/Kconfig
@@ -23,5 +23,6 @@ config RESET_HISI
 config STUB_CLK_HI6220
 	bool "Hi6220 Stub Clock Driver"
 	depends on COMMON_CLK_HI6220 && MAILBOX
+	default ARCH_HISI
 	help
 	  Build the Hisilicon Hi6220 stub clock driver.
-- 
1.9.1
